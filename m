Return-Path: <hch@lst.de>
Date: Mon, 23 Jul 2018 09:28:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: martin.petersen@oracle.com, linux-block@vger.kernel.org,
	axboe@kernel.dk, keith.busch@intel.com,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Subject: Re: [PATCH 1/2] block: move dif_prepare/dif_complete functions to
	block layer
Message-ID: <20180723072854.GA18365@lst.de>
References: <1532252998-2375-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1532252998-2375-1-git-send-email-maxg@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

>  #include <linux/blkdev.h>
> +#include <linux/t10-pi.h>

Sounds like the new functions should move to block/10-pi.c given
that they are specific to the T10 defined formats.

> +/*
> + * The virtual start sector is the one that was originally submitted
> + * by the block layer.	Due to partitioning, MD/DM cloning, etc. the
> + * actual physical start sector is likely to be different.  Remap
> + * protection information to match the physical LBA.
> + *
> + * From a protocol perspective there's a slight difference between
> + * Type 1 and 2.  The latter uses command's 32-byte exclusively, and the
> + * reference tag is seeded in the command.  This gives us the potential to
> + * avoid virt->phys remapping during write.  However, at read time we
> + * don't know whether the virt sector is the same as when we wrote it
> + * (we could be reading from real disk as opposed to MD/DM device.  So
> + * we always remap Type 2 making it identical to Type 1.
> + *
> + * Type 3 does not have a reference tag so no remapping is required.
> + */

Maybe add proper kerneldoc comments given that these are exported
functions?

The 32-byte CDB comment doesn't really make sense here as it is SCSI
specific, so we'll need to drop it or find a good place for it in the
SCSI code.

> +void blk_integrity_dif_prepare(struct request *rq, u8 protection_type,
> +			       u32 ref_tag)
> +{

Maybe call this blk_t10_pi_prepare?

> +	const int tuple_sz = sizeof(struct t10_pi_tuple);
> +	struct bio *bio;
> +	struct t10_pi_tuple *pi;
> +	u32 phys, virt;
> +
> +	if (protection_type == T10_PI_TYPE3_PROTECTION)
> +		return;
> +
> +	phys = ref_tag;

Seems like we could just use the ref_tag variable later instead of
duplicating it.

> +
> +	__rq_for_each_bio(bio, rq) {
> +		struct bio_integrity_payload *bip = bio_integrity(bio);
> +		struct bio_vec iv;
> +		struct bvec_iter iter;
> +		unsigned int j;
> +
> +		/* Already remapped? */
> +		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
> +			break;
> +
> +		virt = bip_get_seed(bip) & 0xffffffff;

Looks like we could keep the virt variable inside the loop and assign
it where declared, e.g.:

		u32 virt = bip_get_seed(bip) & 0xffffffff;

at the beginning of this block.

> +		bip_for_each_vec(iv, bip, iter) {
> +			pi = kmap_atomic(iv.bv_page) + iv.bv_offset;

Pi can have local scope here, too.

> +			for (j = 0; j < iv.bv_len; j += tuple_sz, pi++) {
> +
> +				if (be32_to_cpu(pi->ref_tag) == virt)
> +					pi->ref_tag = cpu_to_be32(phys);
> +
> +				virt++;
> +				phys++;
> +			}

No need for the empty lines inside this loop.

> +/*
> + * Remap physical sector values in the reference tag to the virtual
> + * values expected by the block layer.
> + */
> +void blk_integrity_dif_complete(struct request *rq, u8 protection_type,
> +				u32 ref_tag, unsigned int intervals)

And pretty much all the  comments apply to this function as well.

> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 9421d9877730..4186bf027c59 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1119,7 +1119,9 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
>  		SCpnt->cmnd[0] = WRITE_6;
>  
>  		if (blk_integrity_rq(rq))
> -			sd_dif_prepare(SCpnt);
> +			blk_integrity_dif_prepare(SCpnt->request,
> +						  sdkp->protection_type,
> +						  scsi_prot_ref_tag(SCpnt));

scsi_prot_ref_tag could be move to the block layer as it only uses
the sector in the eequest and the sector size, which we can get
from the gendisk as well.  We then don't need to pass it to the function.

We could also move the protection type to the gendisk, although I'm not
sure it's going to be worth it.
