Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <1539304018-11786-1-git-send-email-schmitzmic@gmail.com> <1539304018-11786-3-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1539304018-11786-3-git-send-email-schmitzmic@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Oct 2018 10:54:40 +0200
Message-ID: <CAMuHMdVnmszjPUVDq-hgKAtvFKRMpGY74c+Bo_CHPeRtsZpo5w@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] block: add overflow checks for Amiga partition support
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
> Use u64 as type for sector address and size to allow using disks up to
> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
> format allows to specify disk sizes up to 2^128 bytes (though native
> OS limitations reduce this somewhat, to max 2^68 bytes), so check for
> u64 overflow carefully to protect against overflowing sector_t.
>
> Bail out if sector addresses overflow 32 bits on kernels without LBD
> support.
>
> This bug was reported originally in 2012, and the fix was created by
> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
> discussed and reviewed on linux-m68k at that time but never officially
> submitted (now resubmitted as separate patch).
> This patch adds additional error checking and warning messages.
>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

 Thanks for being persistent!

BTW, there's another possible overflow in "blk *= blksize", but that one
is very unlikely to happen, as most (all?) partitioners store partition
blocks close to the beginning of the disk.

> --- a/block/partitions/amiga.c
> +++ b/block/partitions/amiga.c

> @@ -32,9 +40,12 @@ int amiga_partition(struct parsed_partitions *state)
>         unsigned char *data;
>         struct RigidDiskBlock *rdb;
>         struct PartitionBlock *pb;
> -       sector_t start_sect, nr_sects;
> +       u64 start_sect, nr_sects;
> +       sector_t end_sect;
> +       u32 cylblk;             /* rdb_CylBlocks = nr_heads*sect_per_track */
> +       u32 nr_hd, nr_sect, lo_cyl, hi_cyl;
>         int blk, part, res = 0;
> -       int blksize = 1;        /* Multiplier for disk block size */
> +       unsigned int blksize = 1;       /* Multiplier for disk block size */
>         int slot = 1;
>         char b[BDEVNAME_SIZE];
>
> @@ -99,19 +110,70 @@ int amiga_partition(struct parsed_partitions *state)
>                 if (checksum_block((__be32 *)pb, be32_to_cpu(pb->pb_SummedLongs) & 0x7F) != 0 )
>                         continue;
>
> -               /* Tell Kernel about it */
> +               /* RDB gives us more than enough rope to hang ourselves with,
> +                * many times over (2^128 bytes if all fields max out).
> +                * Some careful checks are in order, so check for potential
> +                * overflows.
> +                * We are multiplying four 32 bit numbers to one sector_t!
> +                */
> +
> +               nr_hd   = be32_to_cpu(pb->pb_Environment[NR_HD]);
> +               nr_sect = be32_to_cpu(pb->pb_Environment[NR_SECT]);
> +
> +               /* CylBlocks is total number of blocks per cylinder */
> +               if (check_mul_overflow(nr_hd, nr_sect, &cylblk)) {
> +                       pr_err("Dev %s: heads*sects %u overflows u32, skipping partition!\n",
> +                               bdevname(state->bdev, b), cylblk);
> +                       continue;
> +               }
> +
> +               /* check for consistency with RDB defined CylBlocks */
> +               if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {
> +                       pr_warn("Dev %s: cylblk %u > rdb_CylBlocks %u!\n",
> +                               bdevname(state->bdev, b), cylblk,
> +                               be32_to_cpu(rdb->rdb_CylBlocks));
> +               }
> +
> +               /* RDB allows for variable logical block size -
> +                * normalize to 512 byte blocks and check result.
> +                */
> +
> +               if (check_mul_overflow(cylblk, blksize, &cylblk)) {
> +                       pr_err("Dev %s: partition %u bytes per cyl. overflows u32, skipping partition!\n",
> +                               bdevname(state->bdev, b), part);

Unlike the comparison with 32-bit rdb_CylBlocks above, this is an
artificial limitation, right?
You can relax it by using 64-bit arithmetic, but that would complicate the
calculation of start_sect and nr_sects below, as they may overflow 64-bit.

> +                       continue;
> +               }
> +
> +               /* Calculate partition start and end. Limit of 32 bit on cylblk
> +                * guarantees no overflow occurs if LBD support is enabled.
> +                */
> +
> +               lo_cyl = be32_to_cpu(pb->pb_Environment[LO_CYL]);
> +               start_sect = (u64) (lo_cyl * cylblk);

As lo_cyl and cylblk are both u32, the multiplication will be done using
32-bit arithmetic, and may overflow.  Hence you should cast one of the
multiplicands, instead of the result:

    start_sect = ((u64)lo_cyl * cylblk);


> +
> +               hi_cyl = be32_to_cpu(pb->pb_Environment[HI_CYL]);
> +               nr_sects = (u64) ((hi_cyl - lo_cyl + 1) * cylblk);

Likewise.

>
> -               nr_sects = ((sector_t) be32_to_cpu(pb->pb_Environment[10])
> -                          + 1 - be32_to_cpu(pb->pb_Environment[9])) *
> -                          be32_to_cpu(pb->pb_Environment[3]) *
> -                          be32_to_cpu(pb->pb_Environment[5]) *
> -                          blksize;
>                 if (!nr_sects)
>                         continue;
> -               start_sect = (sector_t) be32_to_cpu(pb->pb_Environment[9]) *
> -                            be32_to_cpu(pb->pb_Environment[3]) *
> -                            be32_to_cpu(pb->pb_Environment[5]) *
> -                            blksize;
> +
> +               /* Warn user if partition end overflows u32 (AmigaDOS limit) */
> +
> +               if ((start_sect + nr_sects) > UINT_MAX) {
> +                       pr_warn("Dev %s: partition %u (%llu-%llu) needs 64 bit device support!\n",
> +                               bdevname(state->bdev, b), part,
> +                               start_sect, start_sect + nr_sects);
> +               }
> +
> +               if (check_add_overflow(start_sect, nr_sects, &end_sect)) {
> +                       pr_err("Dev %s: partition %u (%llu-%llu) needs LBD device support, skipping partition!\n",
> +                               bdevname(state->bdev, b), part,
> +                               start_sect, (u64) end_sect);

The cast to u64 is not needed.

> +                       continue;
> +               }
> +
> +               /* Tell Kernel about it */
> +
>                 put_partition(state,slot++,start_sect,nr_sects);
>                 {
>                         /* Be even more informative to aid mounting */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
