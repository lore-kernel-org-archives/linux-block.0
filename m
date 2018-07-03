Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <20180627012421.80B8F24E094@nmr-admin> <1530509350-25410-1-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdXgYyQxuBru_oFeBdYaCMSg9fpYaXDpUrNy08Qps5HM-w@mail.gmail.com> <CAOmrzkK5M9Gjpd9K5Hccu-bYK758UVxei5FtO2veY2FVy1kO_A@mail.gmail.com>
In-Reply-To: <CAOmrzkK5M9Gjpd9K5Hccu-bYK758UVxei5FtO2veY2FVy1kO_A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 3 Jul 2018 09:22:07 +0200
Message-ID: <CAMuHMdUHnx41fooeSdvJDGVHkZrWeY9TYqubARo8XwFRdMwCAg@mail.gmail.com>
Subject: Re: [PATCH] block: fix Amiga partition support for disks >= 1 TB
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-block@vger.kernel.org, "Linux/m68k" <linux-m68k@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>,
	Martin Steigerwald <martin@lichtvoll.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Michael,

On Tue, Jul 3, 2018 at 1:58 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On Mon, Jul 2, 2018 at 8:29 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> +
> >> +               /* Warn user if start_sect or nr_sects overflow u32 */
> >> +               if ((nr_sects > UINT_MAX || start_sect > UINT_MAX ||
> >> +                   (start_sect + nr_sects) > UINT_MAX) && !did_warn) {
> >
> > I guess "start_sect + nr_sects > UINT_MAX" is sufficient?
>
> No, we need to catch any partition address overflowing. nr_sects >
> UINT_MAX may be redundant though.

The three tests may have been needed when both variables were 32-bit,
but when using unsigned 64-bit arithmetic, it shouldn't matter: if any of the
two values doesn't fit in 32-bit, the sum also doesn't.
Or is this also used to catch 64-bit add overflow? In that case, please use
check_add_overflow().

> > I would remove the did_warn check, as multiple partitions may be affected.
>
> Any partition overflowing means danger lurks (in AmigaDOS of
> sufficient vintage, that is)

Yes, that's what I meant: dropping the did_warn check means always printing
the warning, not just for the first "unusable" partition.

> > Also, RDB doesn't enforce partition ordering, IIRC, so e.g. partitions 1
> > and 3 could be outside the 2 TiB area, while 2 could be within.
>
> The first partition (partly) outside 2 TB will warn. But the point
> about partition ordering later is well taken.
> >
> >> +                       pr_err("Dev %s: partition 32 bit overflow! ",
> >
> > pr_warn()
>
> OK.
>
> >
> >> +                               bdevname(state->bdev, b));
> >> +                       pr_cont("start_sect 0x%llX, nr_sects 0x%llx\n",
> >> +                                start_sect, nr_sects);
> >
> > No need for pr_cont(), just merge the two statements.
>
> Checkpatch catch-22 (thou shalt not exceed 80 cols, thou shalt not
> split string consts over multiple lines, and thou shalt not use
> pr_cont() without good cause). I'll ignore the 80 cols error then.

That's the sane thing to do: single pr_warn() statement, and ignoring the 80
columns error if it would mean splitting the string, so people can easily
grep for it when they see the message on their consoles.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
