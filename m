Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <20180627012421.80B8F24E094@nmr-admin> <2157764.1gpVE8K9i5@merkaba>
 <CAOmrzkLZCE7jPHVP0Et7L7=8UAAG80v7gpYrKpZVJADQz6PeaA@mail.gmail.com>
 <3488210.nMeMqUQulA@merkaba> <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
 <CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com> <1737d3b4-ca33-8f59-8c01-fbd458bd2a84@earthlink.net>
In-Reply-To: <1737d3b4-ca33-8f59-8c01-fbd458bd2a84@earthlink.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 28 Jun 2018 11:29:43 +0200
Message-ID: <CAMuHMdV0TqogkhrTnMJuSj_vPVkAabDotfu6y3g2r4nNwc735g@mail.gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: jdow <jdow@earthlink.net>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Martin Steigerwald <martin@lichtvoll.de>,
	Jens Axboe <axboe@kernel.dk>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Joanne,

On Thu, Jun 28, 2018 at 11:20 AM jdow <jdow@earthlink.net> wrote:
> On 20180627 23:45, Geert Uytterhoeven wrote:
> > On Thu, Jun 28, 2018 at 6:59 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> >> Am 28.06.2018 um 09:20 schrieb Martin Steigerwald:
> >>>>> And as stated in my other reply to the patch:
> >>>>> partition needs 64 bit disk device support in AmigaOS or AmigaOS
> >>>>> like
> >>>>> operating systems (NSD64, TD64 or SCSI direct)
> >>>>
> >>>> I'd probably leave it at 'disk needs 64 bit disk device support on
> >>>> native OS', and only print that warning once.
> >>>
> >>> This is fine with me.
> >>
> >> OK, I'll go with that.
> >
> > Do we really need the warning?
> > Once the parsing is fixed doing 64-bit math, it does not matter for Linux
> > anymore.
>
> Dual booting.

(Dial/Triple/...) Booting older AmigaOS variants is an issue anyway, with
or without Linux.

It's like _Linux_ printing warnings that you cannot use your disk, created with
Solaris 2, on an old SunOS 4.1 machine ;-)

IMHO (s)he who creates partitions on large disks should make sure (s)he only
uses them on machines that can handle them.  This is not a Linux issue.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
