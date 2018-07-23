Return-Path: <keith.busch@linux.intel.com>
Date: Mon, 23 Jul 2018 08:02:33 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: martin.petersen@oracle.com, linux-block@vger.kernel.org,
	axboe@kernel.dk, keith.busch@intel.com,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Subject: Re: [PATCH 1/2] block: move dif_prepare/dif_complete functions to
 block layer
Message-ID: <20180723140233.GA10750@localhost.localdomain>
References: <1532252998-2375-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1532252998-2375-1-git-send-email-maxg@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Jul 22, 2018 at 12:49:57PM +0300, Max Gurtovoy wrote:
> +void blk_integrity_dif_prepare(struct request *rq, u8 protection_type,
> +			       u32 ref_tag)
> +{
> +	const int tuple_sz = sizeof(struct t10_pi_tuple);
> +	struct bio *bio;
> +	struct t10_pi_tuple *pi;
> +	u32 phys, virt;
> +
> +	if (protection_type == T10_PI_TYPE3_PROTECTION)
> +		return;
> +
> +	phys = ref_tag;
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
> +
> +		bip_for_each_vec(iv, bip, iter) {
> +			pi = kmap_atomic(iv.bv_page) + iv.bv_offset;
> +
> +			for (j = 0; j < iv.bv_len; j += tuple_sz, pi++) {

nvme's data integrity buffer can actually have more space between each
PI field, so we just need to account for that when iterating instead of
assuming each element is the size of a T10 PI tuple.

Otherwise, great idea.
