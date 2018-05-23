Return-Path: <keith.busch@intel.com>
Date: Wed, 23 May 2018 08:24:27 -0600
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>, Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Rafael David Tinoco <rafael.tinoco@canonical.com>,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 13/14] blk-mq: Remove generation seqeunce
Message-ID: <20180523142426.GB10852@localhost.localdomain>
References: <20180523121941.8632-1-hch@lst.de>
 <20180523121941.8632-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180523121941.8632-14-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 23, 2018 at 02:19:40PM +0200, Christoph Hellwig wrote:
> -static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
> -	__releases(hctx->srcu)
> -{
> -	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
> -		rcu_read_unlock();
> -	else
> -		srcu_read_unlock(hctx->srcu, srcu_idx);
> -}
> -
> -static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
> -	__acquires(hctx->srcu)
> -{
> -	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> -		/* shut up gcc false positive */
> -		*srcu_idx = 0;
> -		rcu_read_lock();
> -	} else
> -		*srcu_idx = srcu_read_lock(hctx->srcu);
> -}

I may have too ambitious on removing hctx_lock. That's actually nothing
to do with the completion issues, but it is necessary for quiesce to
work reliably. Otherwise, I still think there is some promise to the
reset of the approach.
