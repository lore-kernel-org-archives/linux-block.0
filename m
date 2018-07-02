Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <20180627012421.80B8F24E094@nmr-admin> <1530509350-25410-1-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1530509350-25410-1-git-send-email-schmitzmic@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Jul 2018 10:29:06 +0200
Message-ID: <CAMuHMdXgYyQxuBru_oFeBdYaCMSg9fpYaXDpUrNy08Qps5HM-w@mail.gmail.com>
Subject: Re: [PATCH] block: fix Amiga partition support for disks >= 1 TB
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-block@vger.kernel.org, "Linux/m68k" <linux-m68k@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>,
	Martin Steigerwald <martin@lichtvoll.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Michael,

On Mon, Jul 2, 2018 at 7:30 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
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
> submitted. This patch adds additional error checking and warning messages.
>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=43511
> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Tested-by: Martin Steigerwald <Martin@lichtvoll.de>
>
> Changes from RFC:
>
> - use u64 instead of sector_t, since that may be u32 without LBD support
> - check multiplication overflows each step - 3 u32 values may exceed u64!
> - warn against use on AmigaDOS if partition data overflow u32 sector count.
> - warn if partition CylBlocks larger than what's stored in the RDSK header.
> - bail out if we were to overflow sector_t (32 or 64 bit).

Thanks for your patch!

> --- a/block/partitions/amiga.c
> +++ b/block/partitions/amiga.c
> @@ -11,6 +11,7 @@
>  #define pr_fmt(fmt) fmt
>
>  #include <linux/types.h>
> +#include <linux/log2.h>
>  #include <linux/affs_hardblocks.h>
>
>  #include "check.h"
> @@ -32,7 +33,9 @@ int amiga_partition(struct parsed_partitions *state)
>         unsigned char *data;
>         struct RigidDiskBlock *rdb;
>         struct PartitionBlock *pb;
> -       int start_sect, nr_sects, blk, part, res = 0;
> +       u64 start_sect, nr_sects;
> +       u64 cylblk, cylblk_res; /* rdb_CylBlocks = nr_heads*sect_per_track */
> +       int blk, part, res = 0, blk_shift = 0, did_warn = 0;
>         int blksize = 1;        /* Multiplier for disk block size */
>         int slot = 1;
>         char b[BDEVNAME_SIZE];
> @@ -98,6 +101,79 @@ int amiga_partition(struct parsed_partitions *state)
>                 if (checksum_block((__be32 *)pb, be32_to_cpu(pb->pb_SummedLongs) & 0x7F) != 0 )
>                         continue;
>
> +               /* RDB gives us more than enough rope to hang ourselves with,
> +                * many times over (2^128 bytes if all fields max out).
> +                * Some careful checks are in order.
> +                */
> +
> +               /* CylBlocks is total number of blocks per cylinder */
> +               cylblk = be32_to_cpu(pb->pb_Environment[3]) *
> +                        be32_to_cpu(pb->pb_Environment[5]);

Does the above really do a 32 * 32 = 64 bit multiplication?
be32 is unsigned int, and multiplying it will be done in 32-bit arithmetic:

    unsigned int a = 100000;
    unsigned int b = 100000;
    unsigned long long c = a * b;
    unsigned long long d = (unsigned long long)a * b;
    printf("c = %llu\n", c);
    printf("d = %llu\n", d);

prints:

    c = 1410065408
    d = 10000000000

If it does work for you, what am I missing?

> +
> +               /* check for consistency with RDB defined CylBlocks */
> +               if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {
> +                       pr_err("Dev %s: cylblk 0x%lx > rdb_CylBlocks 0x%x!\n",
> +                               bdevname(state->bdev, b),
> +                               (unsigned long) cylblk,

Why the cast? This will truncate the value on 32-bit platforms.
Just use %llu (IMHO decimal is better suited here).

> +                               be32_to_cpu(rdb->rdb_CylBlocks));
> +               }
> +
> +               /* check for potential overflows - we are going to multiply
> +                * three 32 bit numbers to one 64 bit result later!
> +                * Condition 1: nr_heads * sects_per_track must fit u32!
> +                * NB: This is a HARD limit for AmigaDOS. We don't care much.

So, is condition 1 really needed?

> +                */
> +
> +               if (cylblk > UINT_MAX) {
> +                       pr_err("Dev %s: hds*sects 0x%lx > UINT_MAX!\n",
> +                               bdevname(state->bdev, b),
> +                               (unsigned long) cylblk);

Again, why the cast/truncation?

> +
> +                       /* lop off low 32 bits */
> +                       cylblk_res = cylblk >> 32;
> +
> +                       /* check for further overflow in end result */
> +                       if (be32_to_cpu(pb->pb_Environment[9]) *
> +                               cylblk_res * blksize > UINT_MAX) {
> +                               pr_err("Dev %s: start_sect overflows u64!\n",
> +                                       bdevname(state->bdev, b));
> +                               res = -1;
> +                               goto rdb_done;
> +                       }
> +
> +                       if (be32_to_cpu(pb->pb_Environment[10]) *
> +                          cylblk_res * blksize > UINT_MAX) {
> +                               pr_err("Dev %s: end_sect overflows u64!\n",
> +                                       bdevname(state->bdev, b));
> +                               res = -1;
> +                               goto rdb_done;
> +                       }

No need to reinvent the wheel, #include <linux/overflow.h>, and use
check_mul_overflow(), like array3_size() does.

> +               }
> +
> +               /* Condition 2: even if CylBlocks did not overflow, the end
> +                * result must still fit u64!
> +                */
> +
> +               /* how many bits above 32 in cylblk * blksize ? */
> +               if (cylblk*blksize > (u64) UINT_MAX)
> +                       blk_shift = ilog2(cylblk*blksize) - 32;
> +
> +               if (be32_to_cpu(pb->pb_Environment[9])
> +                       > (u64) UINT_MAX>>blk_shift) {
> +                       pr_err("Dev %s: start_sect overflows u64!\n",
> +                               bdevname(state->bdev, b));
> +                       res = -1;
> +                       goto rdb_done;
> +               }
> +
> +               if (be32_to_cpu(pb->pb_Environment[10])
> +                       > (u64) UINT_MAX>>blk_shift) {
> +                       pr_err("Dev %s: end_sect overflows u64!\n",
> +                               bdevname(state->bdev, b));
> +                       res = -1;
> +                       goto rdb_done;

check_mul_overflow()

> +               }
> +
>                 /* Tell Kernel about it */
>
>                 nr_sects = (be32_to_cpu(pb->pb_Environment[10]) + 1 -
> @@ -111,6 +187,27 @@ int amiga_partition(struct parsed_partitions *state)
>                              be32_to_cpu(pb->pb_Environment[3]) *
>                              be32_to_cpu(pb->pb_Environment[5]) *
>                              blksize;

I'm still not convinced the above is done in 64-bit arithmetic...

> +
> +               /* Warn user if start_sect or nr_sects overflow u32 */
> +               if ((nr_sects > UINT_MAX || start_sect > UINT_MAX ||
> +                   (start_sect + nr_sects) > UINT_MAX) && !did_warn) {

I guess "start_sect + nr_sects > UINT_MAX" is sufficient?
I would remove the did_warn check, as multiple partitions may be affected.
Also, RDB doesn't enforce partition ordering, IIRC, so e.g. partitions 1
and 3 could be outside the 2 TiB area, while 2 could be within.

> +                       pr_err("Dev %s: partition 32 bit overflow! ",

pr_warn()

> +                               bdevname(state->bdev, b));
> +                       pr_cont("start_sect 0x%llX, nr_sects 0x%llx\n",
> +                                start_sect, nr_sects);

No need for pr_cont(), just merge the two statements.

> +                       pr_err("Dev %s: partition may  need 64 bit ",

pr_warn()

Drop the "may"?

> +                               bdevname(state->bdev, b));

I would print the partition index, too.

> +                       pr_cont("device support on native AmigaOS!\n");

Just merge the two statements.

I think it can also be just one line printed instead of 2?

    pr_warn("Dev %s: partition %u (%llu-%llu) needs 64-bit device
support\n", ...

> +                       /* Without LBD support, better bail out */
> +                       if (!IS_ENABLED(CONFIG_LBDAF)) {
> +                               pr_err("Dev %s: no LBD support, aborting!",

    pr_err("Dev %s: no LBD support, skipping partition %u\n", ...)?

> +                                       bdevname(state->bdev, b));
> +                               res = -1;
> +                               goto rdb_done;

Aborting here renders any later partitions within the 2 TiB area unaccessible.
So please continue.

> +                       }
> +                       did_warn++;
> +               }
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
