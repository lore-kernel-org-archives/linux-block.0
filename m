Return-Path: <hch@lst.de>
Date: Wed, 25 Jul 2018 13:22:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: keith.busch@intel.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	hch@lst.de, martin.petersen@oracle.com, linux-block@vger.kernel.org,
	axboe@kernel.dk, vladimirk@mellanox.com
Subject: Re: [PATCH v3 2/3] block: move dif_prepare/dif_complete functions
	to block layer
Message-ID: <20180725112247.GA24190@lst.de>
References: <1532508421-2711-1-git-send-email-maxg@mellanox.com> <1532508421-2711-2-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1532508421-2711-2-git-send-email-maxg@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

> +			pmap = kmap_atomic(iv.bv_page) + iv.bv_offset;
> +			p = pmap;

Maybe:

			pmap = p = kmap_atomic(iv.bv_page) + iv.bv_offset;

> +			for (j = 0; j < iv.bv_len; j += tuple_sz) {
> +				pi = (struct t10_pi_tuple *)p;

No need for the cast, also the pi declaration can be moved into the
inner scope:

				struct t10_pi_tuple *pi = p;

> +			pmap = kmap_atomic(iv.bv_page) + iv.bv_offset;
> +			p = pmap;
> +			for (j = 0; j < iv.bv_len; j += tuple_sz) {
> +				if (intervals == 0) {
> +					kunmap_atomic(pmap);
> +					return;
> +				}
> +				pi = (struct t10_pi_tuple *)p;

Same here.

Also the intervals check would make sense in the for loop I think, e.g.:

			pmap = p = kmap_atomic(iv.bv_page) + iv.bv_offset;
			for (j = 0; j < iv.bv_len && intervals; j += tuple_sz) {
				struct t10_pi_tuple *pi = p;
