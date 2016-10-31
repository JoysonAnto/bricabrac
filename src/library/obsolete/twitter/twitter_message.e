note
	description: "Summary description for {TWITTER_MESSAGE}."
	author: "Jocelyn Fiat"
	date: "$Date: 2009-03-18 12:43:03 +0100 (Wed, 18 Mar 2009) $"
	revision: "$Revision: 16 $"

class
	TWITTER_MESSAGE

feature -- Access

	id: INTEGER
			-- a permanent unique id referencing an object, such as user or status
			-- Examples: 1145445329 (status)

	sender_id: INTEGER
			-- unique id of the user that sent a direct message (see id)
			-- Example: 6633812

	text: detachable STRING
			-- escaped and HTML encoded status body
			-- Examples: I am eating oatmeal, The first tag is always <html>	

	recipient_id: INTEGER
			-- unique id of the user that received a direct message (see id)
			-- Example: 1401881

	created_at: detachable STRING
			-- Description: timestamp of element creation, either status or user
			-- Example: Sat Jan 24 22:14:29 +0000 2009

	sender_screen_name: detachable STRING
			-- display name of the user that sent a direct message (see screen_name)
			-- Examples: tweetybird, johnd

	recipient_screen_name: detachable STRING
			-- display name of the user that sent a direct message (see screen_name)
			-- Examples: tweetybird, johnd	

	sender: detachable TWITTER_USER
--	    id
--	    name
--	    screen_name
--	    location
--	    description
--	    profile_image_url
--	    url
--	    protected
--	    followers_count

	recipient: detachable TWITTER_USER
--	    id
--	    name
--	    screen_name
--	    location
--	    description
--	    profile_image_url
--	    url
--	    protected
--	    followers_count

feature -- Element change

	set_id (a_id: like id)
			-- Set `id' to `a_id'
		do
			id := a_id
		end

	set_sender_id (a_sender_id: like sender_id)
			-- Set `sender_id' to `a_sender_id'
		do
			sender_id := a_sender_id
		end

	set_text (a_text: like text)
			-- Set `text' to `a_text'
		do
			text := a_text
		end

	set_recipient_id (a_recipient_id: like recipient_id)
			-- Set `recipient_id' to `a_recipient_id'
		do
			recipient_id := a_recipient_id
		end

	set_created_at (a_created_at: like created_at)
			-- Set `created_at' to `a_created_at'
		do
			created_at := a_created_at
		end

	set_sender_screen_name (a_sender_screen_name: like sender_screen_name)
			-- Set `sender_screen_name' to `a_sender_screen_name'
		do
			sender_screen_name := a_sender_screen_name
		end

	set_recipient_screen_name (a_recipient_screen_name: like recipient_screen_name)
			-- Set `recipient_screen_name' to `a_recipient_screen_name'
		do
			recipient_screen_name := a_recipient_screen_name
		end

	set_sender (a_sender: like sender)
			-- Set `sender' to `a_sender'
		do
			sender := a_sender
		end

	set_recipient (a_recipient: like recipient)
			-- Set `recipient' to `a_recipient'
		do
			recipient := a_recipient
		end

feature -- Access

	short_out: STRING
			-- <Precursor>
		do
			create Result.make_from_string ("MESSAGE: ")

			Result.append_string ("id=")
			Result.append_integer (id)

			Result.append_string (" recipient=")
			if attached recipient_screen_name as l_recipient_screen_name then
				Result.append_string (l_recipient_screen_name)
			end
			if recipient_id > 0 then
				Result.append_string ("(#")
				Result.append_integer (recipient_id)
				Result.append_string (")")
			end

			Result.append_string (" sender=")
			if attached sender_screen_name as l_sender_screen_name then
				Result.append_string (l_sender_screen_name)
			end
			if sender_id > 0 then
				Result.append_string ("(#")
				Result.append_integer (sender_id)
				Result.append_string (")")
			end

			if attached created_at as l_created_at then
				Result.append_string (" created_at=")
				Result.append_string (l_created_at)
			end
		end

	full_out: STRING
			-- <Precursor>
		local
			l_offset: STRING
		do
			l_offset := "  "

			create Result.make_from_string (short_out)
			Result.append_string ("%N")

			if attached text as l_text then
				Result.append_string (l_offset)
				Result.append_string ("text=")
				Result.append_string (l_text)
				Result.append_string ("%N")
			end
			if attached sender as l_sender then
				Result.append_string (l_offset)
				Result.append_string ("sender=")
				Result.append_string (l_sender.short_out)
				Result.append_string ("%N")
			end
			if attached recipient as l_recipient then
				Result.append_string (l_offset)
				Result.append_string ("recipient=")
				Result.append_string (l_recipient.short_out)
				Result.append_string ("%N")
			end
		end

note
	copyright: "Copyright (c) 2003-2009, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
