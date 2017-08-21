Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 21 Aug 2017 12:19:09 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Milan Broz <gmazyland@gmail.com>
Cc: linux-block@vger.kernel.org, kzak@redhat.com, axboe@kernel.dk,
	hare@suse.de
Subject: Re: [PATCH] loop: Fix freeze if configured block size is not
 supported
Message-ID: <20170821191909.GC16030@vader.DHCP.thefacebook.com>
References: <20170818130733.11254-1-gmazyland@gmail.com>
 <20170821184752.GB16030@vader.DHCP.thefacebook.com>
 <6c88e833-cb31-0fae-ee2d-8062474554bc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6c88e833-cb31-0fae-ee2d-8062474554bc@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 21, 2017 at 09:11:32PM +0200, Milan Broz wrote:
> On 08/21/2017 08:47 PM, Omar Sandoval wrote:
> > On Fri, Aug 18, 2017 at 03:07:33PM +0200, Milan Broz wrote:
> >> The commit f2c6df7dbf9a60e1cd9941f9fb376d4d9ad1e8dd
> >>
> >>     loop: support 4k physical blocksize
> >>
> >> adds support for loop block size with only specific block sizes.
> >>
> >> If the size is not supported, the code returns -EINVAL keeping
> >> the loop queue frozen. This causes that device could be locked
> >> for a long time by processes trying to scan device (udev).
> >> (And also causing subsequent LOOP_CLR_FD operations noop.)
> >>
> >> Fix it by using goto to proper exit location with queue unfreeze.
> >>
> >> (The same bug is for setting crypt attribute but this code is
> >> probably no more used. Patch fixes it as well though.)
> >>
> >> Signed-off-by: Milan Broz <gmazyland@gmail.com>
> > 
> > Heh, I sent the same patch [1] only hours before :) v2 is here [2] if
> > you want to give it a reviewed-by.
> 
> Yes, and I noticed it 10 seconds after I sent my patch :)
> You can add reviewed by, if it helps anything...

Thanks!

> Actually you fixed another problems there with following patches
> (physical blocks sizes), we discussed this with Karel
> that it need some changes because the original patch caused
> that reported blocks differs between old and new kernel (lsblk -t),
> even if block size was not used.

Yes there was definitely some funkiness there, let me know if I covered
everything or if I need to make more changes.
