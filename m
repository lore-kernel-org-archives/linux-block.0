Return-Path: <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2 2/2] block: Fix a race between the throttling code and
 request queue initialization
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "hch@lst.de" <hch@lst.de>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "keescook@chromium.org" <keescook@chromium.org>
References: <20180131235300.12773-1-bart.vanassche@wdc.com>
 <20180131235300.12773-3-bart.vanassche@wdc.com>
 <1ff1b2fa-ffe1-20f4-6be9-919c6a5b8227@linux.alibaba.com>
 <1517501761.2746.21.camel@wdc.com>
 <26f758cf-430c-aa7f-0d21-75fbad6db260@gmail.com>
 <1517588518.2675.14.camel@wdc.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <63bb4057-d502-69cd-0385-10ae33bd6649@linux.alibaba.com>
Date: Sat, 3 Feb 2018 10:51:31 +0800
MIME-Version: 1.0
In-Reply-To: <1517588518.2675.14.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart,

On 18/2/3 00:21, Bart Van Assche wrote:
> On Fri, 2018-02-02 at 09:02 +0800, Joseph Qi wrote:
>> We triggered this race when using single queue. I'm not sure if it
>> exists in multi-queue.
> 
> Regarding the races between modifying the queue_lock pointer and the code that
> uses that pointer, I think the following construct in blk_cleanup_queue() is
> sufficient to avoid races between the queue_lock pointer assignment and the code
> that executes concurrently with blk_cleanup_queue():
> 
> 	spin_lock_irq(lock);
> 	if (q->queue_lock != &q->__queue_lock)
> 		q->queue_lock = &q->__queue_lock;
> 	spin_unlock_irq(lock);
> 
IMO, the race also exists.

blk_cleanup_queue                   blkcg_print_blkgs
  spin_lock_irq(lock) (1)           spin_lock_irq(blkg->q->queue_lock) (2,5)
    q->queue_lock = &q->__queue_lock (3)
  spin_unlock_irq(lock) (4)
                                    spin_unlock_irq(blkg->q->queue_lock) (6)

(1) take driver lock;
(2) busy loop for driver lock;
(3) override driver lock with internal lock;
(4) unlock driver lock; 
(5) can take driver lock now;
(6) but unlock internal lock.

If we get blkg->q->queue_lock to local first like blk_cleanup_queue,
it indeed can fix the different lock use in lock/unlock. But since
blk_cleanup_queue has overridden queue lock to internal lock now, I'm
afraid we couldn't still use driver lock in blkcg_print_blkgs.

Thanks,
Joseph

> In other words, I think that this patch series should be sufficient to address
> all races between .queue_lock assignments and the code that uses that pointer.
> 
> Thanks,
> 
> Bart.
> 
