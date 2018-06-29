Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <20180627012421.80B8F24E094@nmr-admin> <2157764.1gpVE8K9i5@merkaba>
 <CAOmrzkLZCE7jPHVP0Et7L7=8UAAG80v7gpYrKpZVJADQz6PeaA@mail.gmail.com>
 <3488210.nMeMqUQulA@merkaba> <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
 <CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com> <a5d6cf31-db2f-0db7-d8ef-2b904a614790@gmail.com>
In-Reply-To: <a5d6cf31-db2f-0db7-d8ef-2b904a614790@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Jun 2018 11:10:04 +0200
Message-ID: <CAMuHMdWSwHeijOeoNO6qERgbnPNHxEC43atK0RFr298=cDHGiw@mail.gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Martin Steigerwald <martin@lichtvoll.de>, Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Michael,

On Fri, Jun 29, 2018 at 10:58 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 28.06.18 um 18:45 schrieb Geert Uytterhoeven:
> > On Thu, Jun 28, 2018 at 6:59 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> >> Am 28.06.2018 um 09:20 schrieb Martin Steigerwald:
> >>>>> And as stated in my other reply to the patch:
> >>>>> partition needs 64 bit disk device support in AmigaOS or AmigaOS
> >>>>> like
> >>>>> operating systems (NSD64, TD64 or SCSI direct)
> >>>> I'd probably leave it at 'disk needs 64 bit disk device support on
> >>>> native OS', and only print that warning once.
> >>> This is fine with me.
> >> OK, I'll go with that.
> > Do we really need the warning?
> > Once the parsing is fixed doing 64-bit math, it does not matter for Linux
> > anymore.
> >
> > Won't it make more sense to have the warning in the tool that created the
> > partition table in the first place?
> Sure, but we've seen one case of this in the wild, and the tool
> apparently did not issue a warning.
>
> I agree it's not an issue for Linux. If  you think dropping a warning
> about something not actually relevant to Linux in the log would be
> confusing, or if convention is to limit warnings strictly to behaviour
> relevant to Linux, I can live without the warning. Joanne scared me a
> bit about Amigoids angry at data loss, but I suppose there can't be many
> around my neck of the woods.
>
> >
> >>> I would not name the kernel option "eat_my_rdb", but use a less
> >>> dramatizing name.
> >>>
> >>> Maybe just: "allow_64bit_rdb" or something like that.
> >> I don't expect to get away with that :-)
> > I still fail to see what's the added value of the kernel option...
> > Either the partition is usable, or not.
>
> The question is - can writes to the disk cause any damage to data on the
> disk, as seen by old OS versions? If the answer is no, we won't need the
> option after all.

You mean someone relying on the parameters of his RDB to overflow using
32-bit calculations, and still have valid offsets on the disk so it's usable?
I think that would need hand-crafting an RDB, if possible at all.
And writing to it on AmigaOS 4.0 or any other OS doing proper 64-bit
calculations would write to the wrong locations, too.
IMHO not something to consider.

> >>> How does the user come to know about this kernel option? Will you print
> >>> its name in kernel log?
> >> Depends on how easy we want to make it for users. If I put a BUG() trap
> >> with the check, the resulting log section will point to a specific line
> >> in block/partitions/amiga.c, from which the override option will be
> >> obvious. But that might be a little too opaque for some...
> > Please don't use BUG(), unless your goal is to attract attention (from
> > Linus, who dislikes BUG()!).
> I'd rather not abuse his patience. Thanks for the hint.
> > Using BUG() would be a nice way to DoS someones machine by plugging in
> > a USB stick with a malformed RDB.
> I guess I deserved that. But BUG() doesn't panic now, does it? The ones
> I saw did allow the kernel to happily carry on.

The one in asm-generic does call panic().
The m68k one calls __builtin_trap(), which may cause a trap (and panic?) or
do nothing, depending on gcc version, I think.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
