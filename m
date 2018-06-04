Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block changes for 4.18-rc
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block <linux-block@vger.kernel.org>, NeilBrown <neilb@suse.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk>
 <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk>
Date: Mon, 4 Jun 2018 09:54:16 -0600
MIME-Version: 1.0
In-Reply-To: <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/4/18 9:51 AM, Linus Torvalds wrote:
> On Sun, Jun 3, 2018 at 5:42 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>>  drivers/md/md.c                                 |  61 +--
>>  drivers/md/md.h                                 |   4 +-
> 
> So I've pulled this, but I get a new warning:
> 
>   drivers/md/md.c: In function ‘mddev_put’:
>   drivers/md/md.c:543:1: warning: the frame size of 2112 bytes is
> larger than 2048 bytes [-Wframe-larger-than=]
> 
> which seems to be due to commit afeee514ce7f ("md: convert to
> bioset_init()/mempool_init()").
> 
> As of that commit, mddev_put() now allocates *two* "struct bio_set"
> structures on the stack, and those really aren't small. Yes, part of
> it is that I do my test-builds with all that debug stuff, but those
> structures have several embedded mempool_t members, and they really
> are pretty sizable.
> 
> And I _really_ do not think it's acceptable to have that kind of stack
> usage in there. I'm not sure you can trigger mddev_put() in the IO
> paths, but even without that I don't think it's acceptable.
> 
> Also, the code simply looks like complete and utter garbage. It does
> 
>                 bs = mddev->bio_set;
>                 sync_bs = mddev->sync_set;
> 
> to _copy_ those structures, and then does bioset_exit() on them. WTF?
> 
> Why the hell doesn't it just do biset_exit() on the originals instead,
> before freeing the mddev?
> 
> I've pulled this, but this needs to be fixed. That is just broken
> garbage right now. No way in hell is it acceptable to waste 2kB of
> stack space on something idiotic like this.

Works is already underway to get this fixed up. I agree that the
excessive stack usage isn't great, but the code in that function
is pretty miserable, as you say. That's not new with the patch,
the conversion just carried that forward.

CC'ing Neil to get his input on how best to clean that up, I'd
be much more comfortable with that logic improved rather than
just catering to the stack usage issue. Also include Arnd, as
he had a test patch for it.

-- 
Jens Axboe
