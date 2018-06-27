Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: schmitzmic@gmail.com
Cc: axboe@kernel.dk, geert@linux-m68k.org, jdow@earthlink.net, linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for disks >= 2 TB
Date: Wed, 27 Jun 2018 10:13:46 +0200
Message-ID: <2906102.Jp2gmY2ce1@merkaba>
In-Reply-To: <20180627012421.80B8F24E094@nmr-admin>
References: <20180627012421.80B8F24E094@nmr-admin>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <linux-block@vger.kernel.org>

schmitzmic@gmail.com - 27.06.18, 03:24:
> From 5299e0e64dfb33ac3a1f3137b42178734ce20087 Mon Sep 17 00:00:00 2001
>=20
> The Amiga RDB partition parser module uses int for partition sector
> address and count, which will overflow for disks 2 TB and larger.
>=20
> Use sector_t as type for sector address and size (as expected by
> put_partition) to allow using such disks without danger of data
> corruption.
>=20
> This bug was reported originally in 2012 by Martin Steigerwald
> <Martin@lichtvoll.de>, and the fix was created by the RDB author,
> Joanne Dow <jdow@earthlink.net>. The patch had been discussed and
> reviewed on linux-m68k at that time but never officially submitted.
>=20
> Following a stern warning by Joanne, a warning is printed if any
> partition is found to overflow the old 32 bit calculations, on the
> grounds that such a partition would be misparses on legacy 32 bit
> systems (other than Linux).
>=20
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D43511
> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> Message-ID: <201206192146.09327.Martin@lichtvoll.de>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Tested-by: Martin Steigerwald <Martin@lichtvoll.de>
> Tested-by: Michael Schmitz <schmitzmic@gmail.com>
> ---
>  block/partitions/amiga.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
> index 5609366..42c3f38 100644
> --- a/block/partitions/amiga.c
> +++ b/block/partitions/amiga.c
> @@ -32,7 +32,8 @@ int amiga_partition(struct parsed_partitions *state)
> unsigned char *data;
>  	struct RigidDiskBlock *rdb;
>  	struct PartitionBlock *pb;
> -	int start_sect, nr_sects, blk, part, res =3D 0;
> +	sector_t start_sect, nr_sects;
> +	int blk, part, res =3D 0;
>  	int blksize =3D 1;	/* Multiplier for disk block size */
>  	int slot =3D 1;
>  	char b[BDEVNAME_SIZE];
> @@ -111,6 +112,16 @@ int amiga_partition(struct parsed_partitions
> *state) be32_to_cpu(pb->pb_Environment[3]) *
>  			     be32_to_cpu(pb->pb_Environment[5]) *
>  			     blksize;
> +		if (start_sect > INT_MAX || nr_sects > INT_MAX
> +			|| (start_sect + nr_sects) > INT_MAX) {
> +			pr_err("%s: Warning: RDB partition overflow!\n",
> +				bdevname(state->bdev, b));
> +			pr_err("%s: start 0x%llX size 0x%llX\n",
> +				bdevname(state->bdev, b), start_sect,
> +				nr_sects);
> +			pr_err("%s: partition incompatible with 32 bit OS\n",
> +				bdevname(state->bdev, b));
> +		}

I do think the wording of that warning is inaccurate, as outlined in my=20
other mails in thread "Re: moving affs + RDB partition support to=20
staging?" just a few minutes ago (see there for a more complete=20
reasoning). I=B4d word it like this:

partition needs 64 bit disk device support in AmigaOS or AmigaOS like=20
operating systems (NSD64, TD64 or SCSI direct)

I think I would not include any more details, and let Amiga people=20
research what they need and since when it is included officially on=20
their own. As there are at least three variants out there: AmigaOS,=20
MorphOS, AROS.

AmigaOS 4 at least can handle disks of 2 TB size or more. I do not think=20
the wording "RDB overflow" is right either.

http://wiki.amigaos.net/wiki/RDB

=46ilesystem size limits are a different matter.

http://www.amigawiki.de/doku.php?id=3Dde:system:filesystems_limits

>  		put_partition(state,slot++,start_sect,nr_sects);
>  		{
>  			/* Be even more informative to aid mounting */

Thanks,
=2D-=20
Martin
