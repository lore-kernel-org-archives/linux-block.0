Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-block@vger.kernel.org, linux-m68k@vger.kernel.org, axboe@kernel.dk, geert@linux-m68k.org, jdow@earthlink.net, martin@lichtvoll.de
Subject: Re: [PATCH] block: fix Amiga partition support for disks >= 1 TB
Date: Mon, 02 Jul 2018 21:36:11 +0200
Message-ID: <36444957.jaVJxNLq7l@merkaba>
In-Reply-To: <1530509350-25410-1-git-send-email-schmitzmic@gmail.com>
References: <20180627012421.80B8F24E094@nmr-admin> <1530509350-25410-1-git-send-email-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <linux-block@vger.kernel.org>

Hi Michael.

I felt free to Cc my mail address.

Michael Schmitz - 02.07.18, 07:29:
> The Amiga partition parser module uses signed int for partition sector
> address and count, which will overflow for disks larger than 1 TB.
>=20
> Use u64 as type for sector address and size to allow using disks up to
> 2 TB without LBD support, and disks larger than 2 TB with LBD. The RBD
> format allows to specify disk sizes up to 2^128 bytes (though native
> OS limitations reduce this somewhat, to max 2^68 bytes), so check for
> u64 overflow carefully to protect against overflowing sector_t.
>=20
> Bail out if sector addresses overflow 32 bits on kernels without LBD
> support.

=46irst off, I have an reply by AmigaOS developer Olaf Barthel regarding his
recommendations for Linux that I may post here. Quoted part is my question,
unquoted part is his reply.

=2D--------------------------------------------------------------
> Would you, at the current time, given the circumstances you described,=20
> recommend any additional limitations to the Linux RDB parser=20
> implementation? If so, which ones, and why? Note this is just about the=20
> RDB parser for now, not AFFS in Linux and not amiga-fdisk, parted or=20
> what else. I am aware that AFFS in Linux would also need to be checked=20
> for limit handling :).

That's where the restrictions governing RDB and file system diverge. You
can have a perfectly consistent RDB, but the file system may be unable
to make use of it. This is the case, for example, with the default ROM
file system in Kickstart 2.x/3.x which will accept what scsi.device
found in the RDB, but might not work out well at all later because the
ROM file system does not know its own limitations.

Generally, keeping the RDB consistent should be the primary objective.
The question is how you are going to deal with the consequences. If the
AFFS file system can be relied upon to know its limitations then you
might end up with a good pairing with the RDB parser for Linux only. The
problems begin with how an AmigaOS-native file system is expected to
deal with the RDB.

If you want to limit the risk of data loss, then the cautious approach
would be to put limitations into the partitioning software (fdisk), like
we did for HDToolBox/ProdPrep, namely:

1. Do not create new partitions which reach beyond the 4 Gigabyte
   boundary of the storage medium.
2. Do not create new partitions which exceed 2 Gigabytes in size.
3. Do not allow existing partitions to be moved or resized so that
   they reside entirely beyond the 4 Gigabyte boundary, or reach beyond
   that boundary.

These limitations would make it less likely that the AmigaOS 2.x/3.x
default ROM file system would get itself into trouble, and the same goes
for the various mass storage driver RDB parser implementations. Note
that these limitations are just precautions baked into policy and the
user should be able to override and disable them.

I have no idea how this would work within the partitioning framework
used by Linux, though, which I expect is geared towards giving the user
maximum control rather than "training wheels".

Maximum control implies awareness of the consequences of choosing a
partition layout which requires specific file system and mass storage
driver capabilities, so while a warning message "device needs 64 bit
disk device support in native OS" is helpful, it may be better to say
that the layout is not compatible with what the Amiga ROM operating
system version 1.x/2.x/3.x can safely support.
=2D--------------------------------------------------------------

Amiga ROM operating system means the Kickstart ROM. AmigaOS 3.5
and 3.9 patch the Kickstart ROM and replace the default device driver
"scsi.device" while doing so.

Aside from that I=B4d say that this pretty much resembles the result of
our discussion: Be cautious in the partitioning tools, but permissive
in the RDB parser.

I think I ask him about limitations in Amiga Fast Filesystem as well.
Maybe he can give me something to quote about that as well.
=20
> This bug was reported originally in 2012, and the fix was created by
> the RDB author, Joanne Dow <jdow@earthlink.net>. A patch had been
> discussed and reviewed on linux-m68k at that time but never officially
> submitted. This patch adds additional error checking and warning messages.
>=20
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D43511
> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Tested-by: Martin Steigerwald <Martin@lichtvoll.de>
>=20
> Changes from RFC:
>=20
> - use u64 instead of sector_t, since that may be u32 without LBD support
> - check multiplication overflows each step - 3 u32 values may exceed u64!
> - warn against use on AmigaDOS if partition data overflow u32 sector coun=
t.
> - warn if partition CylBlocks larger than what's stored in the RDSK heade=
r.
> - bail out if we were to overflow sector_t (32 or 64 bit).
> ---
>  block/partitions/amiga.c |   99 ++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 98 insertions(+), 1 deletions(-)
>=20
> diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
> index 5609366..6184d83 100644
> --- a/block/partitions/amiga.c
> +++ b/block/partitions/amiga.c
> @@ -11,6 +11,7 @@
>  #define pr_fmt(fmt) fmt
> =20
>  #include <linux/types.h>
> +#include <linux/log2.h>
>  #include <linux/affs_hardblocks.h>
> =20
>  #include "check.h"
> @@ -32,7 +33,9 @@ int amiga_partition(struct parsed_partitions *state)
>  	unsigned char *data;
>  	struct RigidDiskBlock *rdb;
>  	struct PartitionBlock *pb;
> -	int start_sect, nr_sects, blk, part, res =3D 0;
> +	u64 start_sect, nr_sects;
> +	u64 cylblk, cylblk_res;	/* rdb_CylBlocks =3D nr_heads*sect_per_track */
> +	int blk, part, res =3D 0, blk_shift =3D 0, did_warn =3D 0;
>  	int blksize =3D 1;	/* Multiplier for disk block size */
>  	int slot =3D 1;
>  	char b[BDEVNAME_SIZE];
> @@ -98,6 +101,79 @@ int amiga_partition(struct parsed_partitions *state)
>  		if (checksum_block((__be32 *)pb, be32_to_cpu(pb->pb_SummedLongs) & 0x7=
=46) !=3D 0 )
>  			continue;
> =20
> +		/* RDB gives us more than enough rope to hang ourselves with,
> +		 * many times over (2^128 bytes if all fields max out).
> +		 * Some careful checks are in order.
> +		 */
> +
> +		/* CylBlocks is total number of blocks per cylinder */
> +		cylblk =3D be32_to_cpu(pb->pb_Environment[3]) *
> +			 be32_to_cpu(pb->pb_Environment[5]);

I agree Geert about using constants there.

> +
> +		/* check for consistency with RDB defined CylBlocks */
> +		if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {
> +			pr_err("Dev %s: cylblk 0x%lx > rdb_CylBlocks 0x%x!\n",
> +				bdevname(state->bdev, b),
> +				(unsigned long) cylblk,
> +				be32_to_cpu(rdb->rdb_CylBlocks));
> +		}
> +
> +		/* check for potential overflows - we are going to multiply
> +		 * three 32 bit numbers to one 64 bit result later!
> +		 * Condition 1: nr_heads * sects_per_track must fit u32!
> +		 * NB: This is a HARD limit for AmigaDOS. We don't care much.
> +		 */
> +
> +		if (cylblk > UINT_MAX) {
> +			pr_err("Dev %s: hds*sects 0x%lx > UINT_MAX!\n",
> +				bdevname(state->bdev, b),
> +				(unsigned long) cylblk);
> +
> +			/* lop off low 32 bits */
> +			cylblk_res =3D cylblk >> 32;
> +
> +			/* check for further overflow in end result */
> +			if (be32_to_cpu(pb->pb_Environment[9]) *
> +				cylblk_res * blksize > UINT_MAX) {
> +				pr_err("Dev %s: start_sect overflows u64!\n",
> +					bdevname(state->bdev, b));
> +				res =3D -1;
> +				goto rdb_done;
> +			}
> +
> +			if (be32_to_cpu(pb->pb_Environment[10]) *
> +			   cylblk_res * blksize > UINT_MAX) {
> +				pr_err("Dev %s: end_sect overflows u64!\n",
> +					bdevname(state->bdev, b));
> +				res =3D -1;
> +				goto rdb_done;
> +			}
> +		}
> +
> +		/* Condition 2: even if CylBlocks did not overflow, the end
> +		 * result must still fit u64!
> +		 */
> +
> +		/* how many bits above 32 in cylblk * blksize ? */
> +		if (cylblk*blksize > (u64) UINT_MAX)
> +			blk_shift =3D ilog2(cylblk*blksize) - 32;
> +
> +		if (be32_to_cpu(pb->pb_Environment[9])
> +			> (u64) UINT_MAX>>blk_shift) {
> +			pr_err("Dev %s: start_sect overflows u64!\n",
> +				bdevname(state->bdev, b));
> +			res =3D -1;
> +			goto rdb_done;
> +		}
> +
> +		if (be32_to_cpu(pb->pb_Environment[10])
> +			> (u64) UINT_MAX>>blk_shift) {
> +			pr_err("Dev %s: end_sect overflows u64!\n",
> +				bdevname(state->bdev, b));
> +			res =3D -1;
> +			goto rdb_done;
> +		}
> +
>  		/* Tell Kernel about it */
> =20
>  		nr_sects =3D (be32_to_cpu(pb->pb_Environment[10]) + 1 -
> @@ -111,6 +187,27 @@ int amiga_partition(struct parsed_partitions *state)
>  			     be32_to_cpu(pb->pb_Environment[3]) *
>  			     be32_to_cpu(pb->pb_Environment[5]) *
>  			     blksize;
> +
> +		/* Warn user if start_sect or nr_sects overflow u32 */
> +		if ((nr_sects > UINT_MAX || start_sect > UINT_MAX ||
> +		    (start_sect + nr_sects) > UINT_MAX) && !did_warn) {
> +			pr_err("Dev %s: partition 32 bit overflow! ",
> +				bdevname(state->bdev, b));
> +			pr_cont("start_sect 0x%llX, nr_sects 0x%llx\n",
> +				 start_sect, nr_sects);
> +			pr_err("Dev %s: partition may  need 64 bit ",

two spaces between "may" and "need"

> +				bdevname(state->bdev, b));
> +			pr_cont("device support on native AmigaOS!\n");

Well an option would be to use Olaf=B4s wording, like so:

partition not safely supported on Amiga ROM operating system version 1.x/2.=
x/3.x

I wonder about how to shorten this, well maybe:

partition not safely supported on Amiga ROM OS 1.x/2.x/3.x

Or:

partition not safely support on Amiga Kickstart ROM 1.x/2.x/3.x


Albeit you already decided to go with a more generic warning, which in
my point of view is also fine. Cause it is a bit challenging to word it in a
correct way when mentioning version numbers. Well this is what Olaf
suggested.

> +			/* Without LBD support, better bail out */
> +			if (!IS_ENABLED(CONFIG_LBDAF)) {
> +				pr_err("Dev %s: no LBD support, aborting!",
> +					bdevname(state->bdev, b));
> +				res =3D -1;
> +				goto rdb_done;
> +			}
> +			did_warn++;
> +		}
> +
>  		put_partition(state,slot++,start_sect,nr_sects);
>  		{
>  			/* Be even more informative to aid mounting */
>=20

Thanks,
=2D-=20
Martin
