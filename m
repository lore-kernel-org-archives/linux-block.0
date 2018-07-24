Return-Path: <keith.busch@linux.intel.com>
Date: Tue, 24 Jul 2018 14:33:23 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: keith.busch@intel.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	hch@lst.de, martin.petersen@oracle.com, linux-block@vger.kernel.org,
	axboe@kernel.dk, vladimirk@mellanox.com
Subject: Re: [PATCH 2/3] block: move dif_prepare/dif_complete functions to
 block layer
Message-ID: <20180724203323.GA13926@localhost.localdomain>
References: <1532439222-5668-1-git-send-email-maxg@mellanox.com>
 <1532439222-5668-2-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1532439222-5668-2-git-send-email-maxg@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 24, 2018 at 04:33:41PM +0300, Max Gurtovoy wrote:
> +void t10_pi_prepare(struct request *rq, u8 protection_type)
> +{
> +	const int tuple_sz = rq->q->integrity.tuple_size;
> +	u32 ref_tag = t10_pi_ref_tag(rq);
> +	struct bio *bio;
> +
> +	if (protection_type == T10_PI_TYPE3_PROTECTION)
> +		return;
> +
> +	__rq_for_each_bio(bio, rq) {
> +		struct bio_integrity_payload *bip = bio_integrity(bio);
> +		u32 virt = bip_get_seed(bip) & 0xffffffff;
> +		struct bio_vec iv;
> +		struct bvec_iter iter;
> +
> +		/* Already remapped? */
> +		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
> +			break;
> +
> +		bip_for_each_vec(iv, bip, iter) {
> +			struct t10_pi_tuple *pi = kmap_atomic(iv.bv_page) +
> +						iv.bv_offset;
> +			unsigned int j;
> +
> +			for (j = 0; j < iv.bv_len; j += tuple_sz) {
> +				if (be32_to_cpu(pi->ref_tag) == virt)
> +					pi->ref_tag = cpu_to_be32(ref_tag);
> +				virt++;
> +				ref_tag++;
> +				pi += tuple_sz;
> +			}
> +
> +			kunmap_atomic(pi);
> +		}

Since you're incrementing 'pi', you end up unmapping an address that
you didn't map. It does appears harmless in current kunmap_atomic()
implementation, though.

You are also incrementing 'pi' by too many bytes since it is of type
struct t10_pi_tuple. The nvme driver used void* to make the pointer
arithmentic easier.
