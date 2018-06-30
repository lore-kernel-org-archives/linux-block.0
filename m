Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <20180627012421.80B8F24E094@nmr-admin> <CAMuHMdUOGdF-bm8j59Om8JNV0mFqK0yixGifgLAjxGwOGLoyqQ@mail.gmail.com>
 <ab97678c-ad67-8020-73d4-c0a5eed2f9f7@gmail.com>
In-Reply-To: <ab97678c-ad67-8020-73d4-c0a5eed2f9f7@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 30 Jun 2018 23:10:44 +0200
Message-ID: <CAMuHMdV035mVe1g6sm0wA8LCG7Z9cdnRXrHNtVTCr97tu-yo0Q@mail.gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, geert@linux-m68k.org-r, jdow <jdow@earthlink.net>,
	Martin Steigerwald <martin@lichtvoll.de>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Michael,

On Fri, Jun 29, 2018 at 11:12 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 28.06.18 um 01:30 schrieb Geert Uytterhoeven:
> > On Wed, Jun 27, 2018 at 4:47 AM <schmitzmic@gmail.com> wrote:
> >> From 5299e0e64dfb33ac3a1f3137b42178734ce20087 Mon Sep 17 00:00:00 2001
> > ??
> >
> >> The Amiga RDB partition parser module uses int for partition sector
> >> address and count, which will overflow for disks 2 TB and larger.
> >>
> >> Use sector_t as type for sector address and size (as expected by
> >> put_partition) to allow using such disks without danger of data
> >> corruption.
> > Note that sector_t is not guaranteed to be 64-bit:
> >
> >     #ifdef CONFIG_LBDAF
> >     typedef u64 sector_t;
> >     typedef u64 blkcnt_t;
> >     #else
> >     typedef unsigned long sector_t;
> >     typedef unsigned long blkcnt_t;
> >     #endif
> >
> > And it seems CONFIG_LBDAF can still be disabled on 32-bit...
> >
>
> What are the ramifications of using a 2 TB disk on a kernel without
> CONFIG_LBDAF? Are there any safeguards after the partition scan stage
> that would prevent the kernel from using partitions on such a disk?
>
> Trying to decide whether we absolutely have to bail if sector_t is 32
> bit ...

Sorry, I don't know.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
