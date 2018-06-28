Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <20180627012421.80B8F24E094@nmr-admin> <2157764.1gpVE8K9i5@merkaba>
 <CAOmrzkLZCE7jPHVP0Et7L7=8UAAG80v7gpYrKpZVJADQz6PeaA@mail.gmail.com>
 <3488210.nMeMqUQulA@merkaba> <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
In-Reply-To: <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 28 Jun 2018 08:45:42 +0200
Message-ID: <CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Martin Steigerwald <martin@lichtvoll.de>, Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Michael,

On Thu, Jun 28, 2018 at 6:59 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 28.06.2018 um 09:20 schrieb Martin Steigerwald:
> >>> And as stated in my other reply to the patch:
> >>> partition needs 64 bit disk device support in AmigaOS or AmigaOS
> >>> like
> >>> operating systems (NSD64, TD64 or SCSI direct)
> >>
> >> I'd probably leave it at 'disk needs 64 bit disk device support on
> >> native OS', and only print that warning once.
> >
> > This is fine with me.
>
> OK, I'll go with that.

Do we really need the warning?
Once the parsing is fixed doing 64-bit math, it does not matter for Linux
anymore.

Won't it make more sense to have the warning in the tool that created the
partition table in the first place?

> > I would not name the kernel option "eat_my_rdb", but use a less
> > dramatizing name.
> >
> > Maybe just: "allow_64bit_rdb" or something like that.
>
> I don't expect to get away with that :-)

I still fail to see what's the added value of the kernel option...
Either the partition is usable, or not.

> > How does the user come to know about this kernel option? Will you print
> > its name in kernel log?
>
> Depends on how easy we want to make it for users. If I put a BUG() trap
> with the check, the resulting log section will point to a specific line
> in block/partitions/amiga.c, from which the override option will be
> obvious. But that might be a little too opaque for some...

Please don't use BUG(), unless your goal is to attract attention (from
Linus, who dislikes BUG()!).

Using BUG() would be a nice way to DoS someones machine by plugging in
a USB stick with a malformed RDB.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
