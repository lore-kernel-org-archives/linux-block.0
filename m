Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block/laptop_mode: Convert timers to use timer_setup()
To: Christoph Hellwig <hch@infradead.org>, Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
 Johannes Weiner <hannes@cmpxchg.org>, Nicholas Piggin <npiggin@gmail.com>,
 Vladimir Davydov <vdavydov.dev@gmail.com>,
 Matthew Wilcox <mawilcox@microsoft.com>, Jeff Layton <jlayton@redhat.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <20171005231623.GA109154@beast>
 <20171006082020.GA12192@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6471888d-60a6-bba6-0c3d-a967ff9442c4@kernel.dk>
Date: Fri, 6 Oct 2017 08:28:43 -0600
MIME-Version: 1.0
In-Reply-To: <20171006082020.GA12192@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/06/2017 02:20 AM, Christoph Hellwig wrote:
>> -static void blk_rq_timed_out_timer(unsigned long data)
>> +static void blk_rq_timed_out_timer(struct timer_list *t)
>>  {
>> -	struct request_queue *q = (struct request_queue *)data;
>> +	struct request_queue *q = from_timer(q, t, timeout);
>>  
>>  	kblockd_schedule_work(&q->timeout_work);
>>  }
> 
> This isn't the laptop_mode timer, although the change itself looks fine.
> 
>> +	timer_setup(&q->backing_dev_info->laptop_mode_wb_timer,
>> +		    laptop_mode_timer_fn, 0);
> 
> And I already pointed out to Jens when he did the previous changes
> to this one that it has no business being in the block code, it
> really should move to mm/page-writeback.c with the rest of the
> handling of this timer.  Once that is fixed up your automated script
> should pick it up, so we wouldn't need the manual change.

Looks reasonable to me, one comment:

> @@ -916,6 +950,8 @@ EXPORT_SYMBOL(bdi_register_owner);
>   */
>  static void bdi_remove_from_list(struct backing_dev_info *bdi)
>  {
> +	del_timer_sync(&bdi->laptop_mode_wb_timer);
> +
>  	spin_lock_bh(&bdi_lock);
>  	list_del_rcu(&bdi->bdi_list);
>  	spin_unlock_bh(&bdi_lock);

This should go into bdi_unregister() instead.

The rest is mostly mechanical and looks fine to me.

-- 
Jens Axboe
