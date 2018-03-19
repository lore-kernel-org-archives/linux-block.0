Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 19 Mar 2018 11:22:37 -0700
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Ming Lei <ming.lei@redhat.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Martin Steigerwald <martin@lichtvoll.de>, stable@vger.kernel.org
Subject: Re: [PATCH] block: Change a rcu_read_{lock,unlock}_sched() pair into
 rcu_read_{lock,unlock}()
Message-ID: <20180319182237.GF519464@devbig577.frc2.facebook.com>
References: <20180319180100.7012-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180319180100.7012-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 19, 2018 at 11:01:00AM -0700, Bart Van Assche wrote:
> Since neither the RCU-protected code in blk_queue_enter() nor
> blk_queue_usage_counter_release() sleeps, regular RCU protection
> is sufficient. Note: scsi_device_quiesce() does not have to be
> modified since it already uses synchronize_rcu().
> 
> Reported-by: Tejun Heo <tj@kernel.org>
> Fixes: 3a0a529971ec ("block, scsi: Make SCSI quiesce and resume work reliably")
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
> Cc: Martin Steigerwald <martin@lichtvoll.de>
> Cc: stable@vger.kernel.org # v4.15

Acked-by: Tejun Heo <tj@kernel.org>

It'd be great to add a comment to clarify the pairing.

Thanks.

-- 
tejun
