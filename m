Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Mon, 4 Jun 2018 17:21:00 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-block <linux-block@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Shaohua Li <shli@kernel.org>
Subject: Re: [GIT PULL] Block changes for 4.18-rc
Message-ID: <20180604212100.GB30325@kmo-pixel>
References: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk>
 <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com>
 <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk>
 <87efhmp7zw.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87efhmp7zw.fsf@notabene.neil.brown.name>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 05, 2018 at 07:16:51AM +1000, NeilBrown wrote:
> I really should get back to BIOSET_NEED_RESCUER and see if I can discard
> it completely.
> Kent - the only remaining user is bcache, and the main reason I haven't
> removed it is that I cannot follow the code (or at least, I couldn't
> last time I tried).  Are you able to see if it is still needed?

Oh man, rescueurs make my head hurt. I remember you changed something so that
they weren't needed most of the time, but I can't remember what you did - can
you remind me what that was and whatever else you can remember offhand?
