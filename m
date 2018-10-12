Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <1539304018-11786-1-git-send-email-schmitzmic@gmail.com> <1539304018-11786-2-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1539304018-11786-2-git-send-email-schmitzmic@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Oct 2018 10:59:03 +0200
Message-ID: <CAMuHMdX1vTFipRSvic7cYr-RvzvSaR5zPghbDYW_Tbd2uUmbNQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] block: fix signed int overflow in Amiga partition support
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	"Linux/m68k" <linux-m68k@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Michael,

On Fri, Oct 12, 2018 at 2:27 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> The Amiga partition parser module uses signed int for partition sector
> address and count, which will overflow for disks larger than 1 TB.
>
> Use sector_t as type for sector address and size to allow using disks
> up to 2 TB without LBD support, and disks larger than 2 TB with LBD.
>
> This bug was reported originally in 2012, and the fix was created by
> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
> discussed and reviewed on linux-m68k at that time but never officially
> submitted. This patch differs from Joanne's patch only in its use of
> sector_t instead of unsigned int. No checking for overflows is done
> (see patch 2 of this series for that).
>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Tested-by: Martin Steigerwald <Martin@lichtvoll.de>

Thanks for your patch!

> Changes from v4:
>
> Andreas Schwab:
> - correct cast to sector_t in sector address calculations

Which you only did for the first case...

> --- a/block/partitions/amiga.c
> +++ b/block/partitions/amiga.c

> @@ -100,14 +101,14 @@ int amiga_partition(struct parsed_partitions *state)
>
>                 /* Tell Kernel about it */
>
> -               nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
> -                           be32_to_cpu(pb->pb_Environment[9])) *
> +               nr_sects = ((sector_t) be32_to_cpu(pb->pb_Environment[10])

...here ...

> +                          + 1 - be32_to_cpu(pb->pb_Environment[9])) *
>                            be32_to_cpu(pb->pb_Environment[3]) *
>                            be32_to_cpu(pb->pb_Environment[5]) *
>                            blksize;
>                 if (!nr_sects)
>                         continue;
> -               start_sect = be32_to_cpu(pb->pb_Environment[9]) *
> +               start_sect = (sector_t) be32_to_cpu(pb->pb_Environment[9]) *

... but not here?

>                              be32_to_cpu(pb->pb_Environment[3]) *
>                              be32_to_cpu(pb->pb_Environment[5]) *
>                              blksize;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
