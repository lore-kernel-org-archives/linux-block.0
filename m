Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <20180627012421.80B8F24E094@nmr-admin> <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
 <CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com>
 <3681004.ZGfTzPZDUK@merkaba> <CAMuHMdXqzQFTNjWrRrgUrEO5XVy+X_ztnnCEZo3vYXVCJp4n8w@mail.gmail.com>
 <102c5f41-7fa8-267c-973a-176d3c3d4f57@gmail.com> <CAMuHMdXqkQLtcUFxxhMYiGxMfLyuYVSxFfOpnu7_qn3+0eOt=w@mail.gmail.com>
 <76bf5b8d-6ee1-8e77-4c2a-e0b5a095992b@gmail.com>
In-Reply-To: <76bf5b8d-6ee1-8e77-4c2a-e0b5a095992b@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Jun 2018 11:12:17 +0200
Message-ID: <CAMuHMdX-YigDa4JeNk164OKB7xOdxTEPARkmgSGWMwJzsAq+Ew@mail.gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Martin Steigerwald <martin@lichtvoll.de>, Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Michael,

On Fri, Jun 29, 2018 at 11:08 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 29.06.18 um 20:51 schrieb Geert Uytterhoeven:
> >> Would MSDOS recognize the GPT partition as 'probably FAT', and attempt
> >> to use it?
> > No idea...
> >
> > Probably some old Windows or MacOS versions will just suggest to
> > format your "new" disk ;-)
>
> Yep, that's what I'd expect. Windows even used to trash the LILO boot
> code in the MBR if you just happened to boot to it by accident. Did we
> complain?

Those days Linux users just knew not to use Windows ;-)

> > But it's up to the person (which is not Linux) formatting the disk to
> > not try to use
> > it on systems that cannot handle it, and may destroy it.
> >
> >>> Let me clarify: what exactly would the kernel option allow? When to use it?
> >> Whether to use it if safe (on Linux). But whatever Linux does (after
> >> this patch), access will go to the right area of the disk (as specified
> >> by the RDB) so Linux won't any longer stomp on anything that would have
> >> mattered to 32 bit disk drivers. So it really should be safe.
> > Personally, I see no reason to depend on a kernel option, if it is safe to use.
> > Just use it.
>
> So to recap - someone partitions a disk on AmigaOS 4.x, taking advantage
> of the large block device support there.
> Using that disk on AmigaOS 3.1, data loss ensues. Whether or not Linux
> (patched) ever touched the disk has no impact on that outcome.
>
> Right?

That's my understanding, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
