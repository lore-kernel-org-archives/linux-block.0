Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: Change a rcu_read_{lock,unlock}_sched() pair
 into rcu_read_{lock,unlock}()
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.com>,
 Ming Lei <ming.lei@redhat.com>, Johannes Thumshirn <jthumshirn@suse.de>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Martin Steigerwald <martin@lichtvoll.de>, stable@vger.kernel.org
References: <20180319184613.14161-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <45883859-d982-71e2-ffb4-da0a741b8431@kernel.dk>
Date: Mon, 19 Mar 2018 12:50:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180319184613.14161-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/19/18 12:46 PM, Bart Van Assche wrote:
> scsi_device_quiesce() uses synchronize_rcu() to guarantee that the
> effect of blk_set_preempt_only() will be visible for percpu_ref_tryget()
> calls that occur after the queue unfreeze by using the approach
> explained in https://lwn.net/Articles/573497/. The rcu read lock and
> unlock calls in blk_queue_enter() form a pair with the synchronize_rcu()
> call in scsi_device_quiesce(). Both scsi_device_quiesce() and
> blk_queue_enter() must either use regular RCU or RCU-sched.
> Since neither the RCU-protected code in blk_queue_enter() nor
> blk_queue_usage_counter_release() sleeps, regular RCU protection
> is sufficient. Note: scsi_device_quiesce() does not have to be
> modified since it already uses synchronize_rcu().

Applied, thanks.

-- 
Jens Axboe
