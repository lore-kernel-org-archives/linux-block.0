Return-Path: <hch@lst.de>
Date: Tue, 24 Jul 2018 15:52:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: keith.busch@intel.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	hch@lst.de, martin.petersen@oracle.com, linux-block@vger.kernel.org,
	axboe@kernel.dk, vladimirk@mellanox.com
Subject: Re: [PATCH 1/3] block: move ref_tag calculation func to the block
	layer
Message-ID: <20180724135257.GA29918@lst.de>
References: <1532439222-5668-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1532439222-5668-1-git-send-email-maxg@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

>  		case NVME_NS_DPS_PI_TYPE2:
>  			control |= NVME_RW_PRINFO_PRCHK_GUARD |
>  					NVME_RW_PRINFO_PRCHK_REF;
> -			cmnd->rw.reftag = cpu_to_le32(
> -					nvme_block_nr(ns, blk_rq_pos(req)));
> +			cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));

Note that this changes behavior for non-512 byte block sizes.  But
I think these changes do the right thing..
