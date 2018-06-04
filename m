Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
References: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk>
In-Reply-To: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Jun 2018 08:51:03 -0700
Message-ID: <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block changes for 4.18-rc
To: Jens Axboe <axboe@kernel.dk>, Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sun, Jun 3, 2018 at 5:42 PM Jens Axboe <axboe@kernel.dk> wrote:
>
>  drivers/md/md.c                                 |  61 +--
>  drivers/md/md.h                                 |   4 +-

So I've pulled this, but I get a new warning:

  drivers/md/md.c: In function =E2=80=98mddev_put=E2=80=99:
  drivers/md/md.c:543:1: warning: the frame size of 2112 bytes is
larger than 2048 bytes [-Wframe-larger-than=3D]

which seems to be due to commit afeee514ce7f ("md: convert to
bioset_init()/mempool_init()").

As of that commit, mddev_put() now allocates *two* "struct bio_set"
structures on the stack, and those really aren't small. Yes, part of
it is that I do my test-builds with all that debug stuff, but those
structures have several embedded mempool_t members, and they really
are pretty sizable.

And I _really_ do not think it's acceptable to have that kind of stack
usage in there. I'm not sure you can trigger mddev_put() in the IO
paths, but even without that I don't think it's acceptable.

Also, the code simply looks like complete and utter garbage. It does

                bs =3D mddev->bio_set;
                sync_bs =3D mddev->sync_set;

to _copy_ those structures, and then does bioset_exit() on them. WTF?

Why the hell doesn't it just do biset_exit() on the originals instead,
before freeing the mddev?

I've pulled this, but this needs to be fixed. That is just broken
garbage right now. No way in hell is it acceptable to waste 2kB of
stack space on something idiotic like this.

                 Linus
