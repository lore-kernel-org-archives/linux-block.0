Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Aug 2018 12:56:12 -0700
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/3] blkcg: Introduce blkg_root_lookup()
Message-ID: <20180809195612.GE3978217@devbig004.ftw2.facebook.com>
References: <20180809145338.6160-1-bart.vanassche@wdc.com>
 <20180809145338.6160-2-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180809145338.6160-2-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Aug 09, 2018 at 07:53:36AM -0700, Bart Van Assche wrote:
> +/**
> + * blkg_lookup - look up blkg for the specified request queue
> + * @q: request_queue of interest
> + *
> + * Lookup blkg for @q at the root level. See also blkg_lookup().
> + */
> +static inline struct blkcg_gq *blkg_root_lookup(struct request_queue *q)
> +{
> +	struct blkcg_gq *blkg;
> +
> +	rcu_read_lock();
> +	blkg = blkg_lookup(&blkcg_root, q);
> +	rcu_read_unlock();
> +
> +	return blkg;
> +}

So, root blkg is always available as long as the request_queue is
alive.  Sth like the following would be simpler?

static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
{
	return q->root_blkg;
}

-- 
tejun
