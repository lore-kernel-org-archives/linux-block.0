Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <20180627012421.80B8F24E094@nmr-admin> <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
 <CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com>
 <3681004.ZGfTzPZDUK@merkaba> <CAMuHMdXqzQFTNjWrRrgUrEO5XVy+X_ztnnCEZo3vYXVCJp4n8w@mail.gmail.com>
 <102c5f41-7fa8-267c-973a-176d3c3d4f57@gmail.com> <87po09bw4v.fsf@igel.home>
In-Reply-To: <87po09bw4v.fsf@igel.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 30 Jun 2018 23:21:30 +0200
Message-ID: <CAMuHMdW_sy+Ojs2Rq-7ZVohUkBt550iTpQNPPmMg+3-tm09TbA@mail.gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Martin Steigerwald <martin@lichtvoll.de>,
	Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Andreas,

On Fri, Jun 29, 2018 at 3:26 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Jun 29 2018, Michael Schmitz <schmitzmic@gmail.com> wrote:
> > Would MSDOS recognize the GPT partition as 'probably FAT', and attempt
> > to use it?
>
> GPT has the concept of a protective MBR which should prevent such errors.

Thanks, good to know.

So it looks like GPT and RDSK can coexist on the same disk: an RDSK header
in block 0 (pointing to PART blocks located after the GPT), and GPT in
blocks 1-33.

That means for very large disks, you can have an RDSK describing the
partitions that fit in the first part of the disk that can be accessed by
e.g. AmigaOS 3.0, and a GPT that describes all partitions on the disk,
right?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
