Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v8] blk-mq: Rework blk-mq timeout handling again
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>, Jianchao Wang <jianchao.w.wang@oracle.com>,
 Ming Lei <ming.lei@redhat.com>, Sebastian Ott <sebott@linux.ibm.com>,
 Sagi Grimberg <sagi@grimberg.me>, Israel Rukshin <israelr@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>
References: <20180511210849.12743-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <54bfda3e-2881-76e3-6d51-2ffee23e6070@kernel.dk>
Date: Fri, 11 May 2018 15:21:26 -0600
MIME-Version: 1.0
In-Reply-To: <20180511210849.12743-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/11/18 3:08 PM, Bart Van Assche wrote:
blk_mq_rq_update_aborted_gstate(rq, gstate);
> +	union blk_deadline_and_state das = READ_ONCE(rq->das);
> +	unsigned long now = jiffies;
> +	int32_t diff_jiffies = das.deadline - now;
> +	int32_t diff_next = das.deadline - data->next;
> +	enum mq_rq_state rq_state = das.state;

Why the int32_t types? Just use an int/unsigned int?

> @@ -103,37 +97,119 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
>  
>  void blk_mq_release(struct request_queue *q);
>  
> +#if defined(CONFIG_ARC) ||						\
> +    defined(CONFIG_ARM) && defined(CONFIG_CPU_THUMBONLY) ||		\
> +    defined(CONFIG_C6x) || defined(CONFIG_H8300) ||			\
> +    defined(CONFIG_HEXAGON) || defined(CONFIG_MICROBLAZE) ||		\
> +    defined(CONFIG_MIPS) && !defined(CONFIG_64BIT) ||			\
> +    defined(CONFIG_NDS32) || defined(CONFIG_NIOS) ||			\
> +    defined(CONFIG_OPENRISC) || defined(CONFIG_PPC32) ||		\
> +    defined(CONFIG_SUPERH) || defined(CONFIG_UML) || defined(CONFIG_UNICORE32)
> +#undef CONFIG_ARCH_HAS_CMPXCHG64
> +#else
> +#define CONFIG_ARCH_HAS_CMPXCHG64
> +#endif

I think the encapsulation of blk_mq_set_rq_state() in terms of lock vs
cmpxchg64 is fine, but this does not belong in the block layer.

> +	/* Only used if CONFIG_ARCH_HAS_CMPXCHG64 is not defined. */
> +	spinlock_t das_lock;

Let's put it under an if defined() then.

-- 
Jens Axboe
