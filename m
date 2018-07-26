Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v2 3/5] block: Serialize queue freezing and
 blk_pre_runtime_suspend()
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>
References: <20180725222607.8854-1-bart.vanassche@wdc.com>
 <20180725222607.8854-4-bart.vanassche@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3593cfaf-06c5-db39-7f93-2cb4e8c7812f@oracle.com>
Date: Thu, 26 Jul 2018 10:45:30 +0800
MIME-Version: 1.0
In-Reply-To: <20180725222607.8854-4-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 07/26/2018 06:26 AM, Bart Van Assche wrote:
> +
> +void blk_pm_runtime_lock(struct request_queue *q)
> +{
> +	spin_lock(&q->rpm_lock);
> +	wait_event_interruptible_locked(q->rpm_wq,
> +			  q->rpm_owner == NULL || q->rpm_owner == current);
> +	if (q->rpm_owner == NULL)
> +		q->rpm_owner = current;
> +	q->rpm_nesting_level++;
> +	spin_unlock(&q->rpm_lock);
> +}

The lock which wait_event_interruptible_locked want to hold is the wq.lock.
Please refer to comment of wait_event_interruptible_locked

 * It must be called with wq.lock being held.  This spinlock is
 * unlocked while sleeping but @condition testing is done while lock
 * is held and when this macro exits the lock is held.

Thanks
Jianchao
