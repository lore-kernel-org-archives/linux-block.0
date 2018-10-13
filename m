Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <1539304018-11786-1-git-send-email-schmitzmic@gmail.com>
 <1539304018-11786-2-git-send-email-schmitzmic@gmail.com> <CAMuHMdX1vTFipRSvic7cYr-RvzvSaR5zPghbDYW_Tbd2uUmbNQ@mail.gmail.com>
 <57de8343-2b9e-79b5-d419-6fc105b8df77@gmail.com>
In-Reply-To: <57de8343-2b9e-79b5-d419-6fc105b8df77@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 13 Oct 2018 09:04:57 +0200
Message-ID: <CAMuHMdUyxxOJ6HtT4rbSrVTD0-Gdd3bSfNG911-L4QvF4yACUw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] block: fix signed int overflow in Amiga partition support
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	"Linux/m68k" <linux-m68k@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Michael,

On Sat, Oct 13, 2018 at 4:46 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 12.10.2018 um 21:59 schrieb Geert Uytterhoeven:
> >> Changes from v4:
> >>
> >> Andreas Schwab:
> >> - correct cast to sector_t in sector address calculations
> >
> > Which you only did for the first case...
> >
> >> --- a/block/partitions/amiga.c
> >> +++ b/block/partitions/amiga.c
> >
> >> @@ -100,14 +101,14 @@ int amiga_partition(struct parsed_partitions *state)
> >>
> >>                 /* Tell Kernel about it */
> >>
> >> -               nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
> >> -                           be32_to_cpu(pb->pb_Environment[9])) *
> >> +               nr_sects = ((sector_t) be32_to_cpu(pb->pb_Environment[10])
> >
> > ...here ...
> >
> >> +                          + 1 - be32_to_cpu(pb->pb_Environment[9])) *
> >>                            be32_to_cpu(pb->pb_Environment[3]) *
> >>                            be32_to_cpu(pb->pb_Environment[5]) *
> >>                            blksize;
> >>                 if (!nr_sects)
> >>                         continue;
> >> -               start_sect = be32_to_cpu(pb->pb_Environment[9]) *
> >> +               start_sect = (sector_t) be32_to_cpu(pb->pb_Environment[9]) *
> >
> > ... but not here?
>
> I meant to cast the first operand to sector_t here?

Silly me.

> But I can add brackets if you think the compiler might get this wrong.

No it's fine as-is.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
