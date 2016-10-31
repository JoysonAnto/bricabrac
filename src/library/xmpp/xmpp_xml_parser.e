note
	description: "Summary description for {XMPP_XML_PARSER}."
	author: "Jocelyn Fiat"
	date: "$Date: 2008-12-17 18:27:29 +0100 (Wed, 17 Dec 2008) $"
	revision: "$Revision: 7 $"

class
	XMPP_XML_PARSER

inherit
	XML_CALLBACKS

create
	make

feature {NONE} -- Initialization

	make
		do

		end

	initialize
		do
		end

feature -- Access

	start_xml_agent: PROCEDURE [ANY, TUPLE [XMPP_XML_TAG]]

	end_xml_agent: PROCEDURE [ANY, TUPLE [XMPP_XML_TAG]]

feature -- Element change

	reset
		do
			if attached tag_list as lst then
				lst.wipe_out
			end
			last_depth := 0
		end

	set_xml_agents (s: like start_xml_agent; e: like end_xml_agent)
			-- Set xml element call backs
		do
			start_xml_agent := s
			end_xml_agent := e
		end

feature {NONE} -- Document

	on_start
			-- Forward start.
		do
			create tag_list.make (3)
			last_depth := 0
		end

	on_finish
			-- Forward finish.
		do
		end

	on_xml_declaration (a_version: READABLE_STRING_32; an_encoding: READABLE_STRING_32; a_standalone: BOOLEAN)
			-- XML declaration.
		do
		end

feature {NONE} -- Errors

	on_error (a_message: READABLE_STRING_32)
			-- Event producer detected an error.
		do
		end

feature {NONE} -- Meta

	on_processing_instruction (a_name, a_content: READABLE_STRING_32)
			-- Forward PI.
		do
		end

	on_comment (a_content: READABLE_STRING_32)
			-- Forward comment.
		do
		end

feature {NONE} -- Tag

	last_depth: INTEGER

	tag_list: ARRAYED_LIST [like current_tag]

	push_tag (t: like current_tag)
		do
			tag_list.force (t)
		end

	pop_tag: like current_tag
		do
			if attached tag_list as lst and then not lst.is_empty then
				lst.finish
				Result := lst.item
				lst.remove
			end
		end

	current_tag: XMPP_XML_TAG
		do
			if not tag_list.is_empty then
				Result := tag_list.last
			end
		end

	on_start_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- Start of start tag.
		local
			p, t: like current_tag
		do
			p := current_tag
			last_depth := last_depth + 1
			create t.make (a_namespace, a_prefix, a_local_part, last_depth)
			push_tag (t)
			if p /= Void then
				p.childs.force (t)
			end
			if attached start_xml_agent as ag then
				ag.call ([t])
			end
		end

	on_attribute (a_namespace: READABLE_STRING_32; a_prefix: READABLE_STRING_32; a_local_part: READABLE_STRING_32; a_value: READABLE_STRING_32)
			-- Process attribute.
		do
			if attached current_tag as t then
				t.attribs.force (a_value, a_local_part.as_lower)
			end
		end

	on_start_tag_finish
			-- End of start tag.
		do
--			if attached current_tag as t then
--				print (t.name + "%N")
--			end
		end

	on_end_tag (a_namespace: READABLE_STRING_32; a_prefix: READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- End tag.
		do
			last_depth := last_depth - 1
			if attached pop_tag as t then
				if attached end_xml_agent as ag then
					ag.call ([t])
				end
			end
--			if on_end_tag_callback /= Void then
--				on_end_tag_callback.call ([a_namespace, a_prefix, a_local_part])
--			end
		end

feature {NONE} -- Content

	on_content (a_content: READABLE_STRING_32)
			-- Forward content.
		do
			if attached current_tag as t then
				t.content.append (a_content)
			end
		end

note
	copyright: "Copyright (c) 2003-2016, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
