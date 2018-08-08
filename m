Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4 2/2] block: Ensure that a request queue is dissociated
 from the cgroup controller
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 Alexandru Moise <00moses.alexander00@gmail.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, stable@vger.kernel.org
References: <20180730211056.18570-1-bart.vanassche@wdc.com>
 <20180730211056.18570-3-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d04d4403-8b56-27c6-8601-56b5a45da936@kernel.dk>
Date: Wed, 8 Aug 2018 08:41:21 -0600
MIME-Version: 1.0
In-Reply-To: <20180730211056.18570-3-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/30/18 3:10 PM, Bart Van Assche wrote:
> Several block drivers call alloc_disk() followed by put_disk() if
> something fails before device_add_disk() is called without calling
> blk_cleanup_queue(). Make sure that also for this scenario a request
> queue is dissociated from the cgroup controller. This patch avoids
> that loading the parport_pc, paride and pf drivers triggers the
> following kernel crash:
> 
> BUG: KASAN: null-ptr-deref in pi_init+0x42e/0x580 [paride]
> Read of size 4 at addr 0000000000000008 by task modprobe/744
> Call Trace:
> dump_stack+0x9a/0xeb
> kasan_report+0x139/0x350
> pi_init+0x42e/0x580 [paride]
> pf_init+0x2bb/0x1000 [pf]
> do_one_initcall+0x8e/0x405
> do_init_module+0xd9/0x2f2
> load_module+0x3ab4/0x4700
> SYSC_finit_module+0x176/0x1a0
> do_syscall_64+0xee/0x2b0
> entry_SYSCALL_64_after_hwframe+0x42/0xb7
> 
> Reported-by: Alexandru Moise <00moses.alexander00@gmail.com>
> Fixes: a063057d7c73 ("block: Fix a race between request queue removal and the block cgroup controller") # v4.17
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Tested-by: Alexandru Moise <00moses.alexander00@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Alexandru Moise <00moses.alexander00@gmail.com>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: <stable@vger.kernel.org>
> ---
>  block/blk-sysfs.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index ca1984ecbdeb..26275d9babcb 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -802,6 +802,31 @@ static void __blk_release_queue(struct work_struct *work)
>  		blk_stat_remove_callback(q, q->poll_cb);
>  	blk_stat_free_callback(q->poll_cb);
>  
> +	if (!blk_queue_dead(q)) {
> +		/*
> +		 * Last reference was dropped without having called
> +		 * blk_cleanup_queue().
> +		 */
> +		WARN_ONCE(blk_queue_init_done(q),
> +			  "request queue %p has been registered but blk_cleanup_queue() has not been called for that queue\n",
> +			  q);
> +		blk_exit_queue(q);
> +	}
> +
> +#ifdef CONFIG_BLK_CGROUP
> +	{
> +		struct blkcg_gq *blkg;
> +
> +		rcu_read_lock();
> +		blkg = blkg_lookup(&blkcg_root, q);
> +		rcu_read_unlock();
> +
> +		WARN(blkg,
> +		     "request queue %p is being released but it has not yet been removed from the blkcg controller\n",
> +		     q);
> +	}
> +#endif

This last hunk should go in the cgroup code.

-- 
Jens Axboe
