Return-Path: <nix@esperi.org.uk>
From: Nick Alcock <nix@esperi.org.uk>
To: Eric Wheeler <bcache@lists.ewheeler.net>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        dan.carpenter@oracle.com, tasleson@redhat.com,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>, stable@vger.kernel.org,
        "tang.junhui" <tang.junhui@zte.com.cn>,
        Kent Overstreet <kent.overstreet@gmail.com>, Coly Li <colyli@suse.de>,
        Stefan Bader <stefan.bader@canonical.com>,
        Liang Chen <liangchen.linux@gmail.com>
Subject: Re: [PULL] bcache fixes and updates for-4.13
References: <alpine.LRH.2.11.1705251853530.19359@mail.ewheeler.net>
	<alpine.LRH.2.11.1706282258100.17052@mail.ewheeler.net>
	<20170629134510.GA32385@infradead.org>
	<alpine.LRH.2.11.1706292212130.17052@mail.ewheeler.net>
	<alpine.LRH.2.11.1706292222470.17052@mail.ewheeler.net>
Date: Fri, 30 Jun 2017 00:28:48 +0100
In-Reply-To: <alpine.LRH.2.11.1706292222470.17052@mail.ewheeler.net> (Eric
	Wheeler's message of "Thu, 29 Jun 2017 22:25:09 +0000 (UTC)")
Message-ID: <87k23uv0en.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

On 29 Jun 2017, Eric Wheeler verbalised:
> Hmm, I think vger might not be letting them in because the From: header 
> differs from the original sender (ie, I am not @oracle.com) so 
> DNS/SPF/DKIM and such are wrong.
>
> What do you do in these cases?  Should I rewrite the From: header?  
> Somehow the original author should remain.

If these are patches from 'git format-patch', you do it by putting your
name in the email From: and the author you want in the commit as a From
header in the very first line of the email. 'git am' will then ignore
the header line in favour of the first-line override. I believe 'git
send-email' should be doing this automatically if your email address is
not the same as the patch author, but I could be wrong...

See the DISCUSSION section in 'man git-am'.
