Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E01C433EF
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 13:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347317AbiCYNIo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 09:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352493AbiCYNIn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 09:08:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0483CF4B6
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 06:07:08 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nXjek-0006E5-NL; Fri, 25 Mar 2022 14:07:06 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nXjei-000286-P0; Fri, 25 Mar 2022 14:07:04 +0100
Date:   Fri, 25 Mar 2022 14:07:04 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>, kernel@pengutronix.de
Subject: Re: [PATCH v2 4/4] block/mq-deadline: Prioritize high-priority
 requests
Message-ID: <20220325130704.GA27264@pengutronix.de>
References: <20210927220328.1410161-1-bvanassche@acm.org>
 <20210927220328.1410161-5-bvanassche@acm.org>
 <Yj22kLrsw+z7sj7R@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yj22kLrsw+z7sj7R@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:03:04 up 104 days, 21:48, 81 users,  load average: 0.75, 0.40,
 0.22
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-block@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 25, 2022 at 01:33:20PM +0100, Oleksij Rempel wrote:
> Hello Bart,
> 
> I have regression on iMX6 + USB storage device with this patch.
> After plugging USB Flash driver (in my case USB3 Intenso 32GB) and
> running mount /dev/sda1 /mnt, the command will never exit. 
> 
> Reverting this patchs (322cff70d46) on top of v5.17 solves it for me.
> 
> How can I help you to debug this issue?

I hope this can help:
- it seems to be reproducible only with some type of USB storage devices
  (USB3 on top of USB2 host?)
- mount takes long time, but at some point it will manage it
- this backtrace I get from sysrq:

 kernel: Exception stack(0x83a59fb0 to 0x83a59ff8)
 kernel: 9fa0:                                     00000000 00000000 00000000 00000000
 kernel: 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
 kernel: 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 kernel:  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:80147ea0
 kernel:  r4:83a4cec0 r3:8118cd24
 kernel: task:mount           state:D stack:    0 pid:  282 ppid:   275 flags:0x00000000
 kernel: Backtrace: 
 kernel:  __schedule from schedule+0x84/0xc0
 kernel:  r10:82ebdd94 r9:00000102 r8:82ad3600 r7:81203ea4 r6:00000000 r5:00000002
 kernel:  r4:82ad3600
 kernel:  schedule from io_schedule+0x20/0x2c
 kernel:  r5:00000002 r4:00000000
 kernel:  io_schedule from folio_wait_bit_common+0x18c/0x220
 kernel:  r5:00000002 r4:9bc2e580
 kernel:  folio_wait_bit_common from folio_put_wait_locked+0x24/0x28
 kernel:  r10:00000003 r9:825124f0 r8:00000000 r7:825124e0 r6:9bc2e580 r5:82ebdf00
 kernel:  r4:00080001
 kernel:  folio_put_wait_locked from filemap_read+0x4f0/0x824
 kernel:  filemap_read from blkdev_read_iter+0x144/0x19c
 kernel:  r10:00000003 r9:82ad3600 r8:00000000 r7:82ebdee8 r6:82ebdf00 r5:00000040
 kernel:  r4:00000000
 kernel:  blkdev_read_iter from vfs_read+0x138/0x188
 kernel:  r8:00000040 r7:01649af0 r6:82ebdf58 r5:82ddfe40 r4:00000000
 kernel:  vfs_read from ksys_read+0x84/0xd8
 kernel:  r8:00000040 r7:82ebdf64 r6:82ebdf58 r5:01649af0 r4:82ddfe40
 kernel:  ksys_read from sys_read+0x18/0x1c
 kernel:  r8:801002a4 r7:00000003 r6:76fce840 r5:708f0000 r4:01649a00
 kernel:  sys_read from ret_fast_syscall+0x0/0x1c


> Regards,
> Oleksij
> 
> On Mon, Sep 27, 2021 at 03:03:28PM -0700, Bart Van Assche wrote:
> > In addition to reverting commit 7b05bf771084 ("Revert "block/mq-deadline:
> > Prioritize high-priority requests""), this patch uses 'jiffies' instead
> > of ktime_get() in the code for aging lower priority requests.
> > 
> > This patch has been tested as follows:
> > 
> > Measured QD=1/jobs=1 IOPS for nullb with the mq-deadline scheduler.
> > Result without and with this patch: 555 K IOPS.
> > 
> > Measured QD=1/jobs=8 IOPS for nullb with the mq-deadline scheduler.
> > Result without and with this patch: about 380 K IOPS.
> > 
> > Ran the following script:
> > 
> > set -e
> > scriptdir=$(dirname "$0")
> > if [ -e /sys/module/scsi_debug ]; then modprobe -r scsi_debug; fi
> > modprobe scsi_debug ndelay=1000000 max_queue=16
> > sd=''
> > while [ -z "$sd" ]; do
> >   sd=$(basename /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/*)
> > done
> > echo $((100*1000)) > "/sys/block/$sd/queue/iosched/prio_aging_expire"
> > if [ -e /sys/fs/cgroup/io.prio.class ]; then
> >   cd /sys/fs/cgroup
> >   echo restrict-to-be >io.prio.class
> >   echo +io > cgroup.subtree_control
> > else
> >   cd /sys/fs/cgroup/blkio/
> >   echo restrict-to-be >blkio.prio.class
> > fi
> > echo $$ >cgroup.procs
> > mkdir -p hipri
> > cd hipri
> > if [ -e io.prio.class ]; then
> >   echo none-to-rt >io.prio.class
> > else
> >   echo none-to-rt >blkio.prio.class
> > fi
> > { "${scriptdir}/max-iops" -a1 -d32 -j1 -e mq-deadline "/dev/$sd" >& ~/low-pri.txt & }
> > echo $$ >cgroup.procs
> > "${scriptdir}/max-iops" -a1 -d32 -j1 -e mq-deadline "/dev/$sd" >& ~/hi-pri.txt
> > 
> > Result:
> > * 11000 IOPS for the high-priority job
> > *    40 IOPS for the low-priority job
> > 
> > If the prio aging expiry time is changed from 100s into 0, the IOPS results
> > change into 6712 and 6796 IOPS.
> > 
> > The max-iops script is a script that runs fio with the following arguments:
> > --bs=4K --gtod_reduce=1 --ioengine=libaio --ioscheduler=${arg_e} --runtime=60
> > --norandommap --rw=read --thread --buffered=0 --numjobs=${arg_j}
> > --iodepth=${arg_d} --iodepth_batch_submit=${arg_a}
> > --iodepth_batch_complete=$((arg_d / 2)) --name=${positional_argument_1}
> > --filename=${positional_argument_1}
> > 
> > Cc: Damien Le Moal <damien.lemoal@wdc.com>
> > Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
> > Cc: Hannes Reinecke <hare@suse.de>
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > ---
> >  block/mq-deadline.c | 77 ++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 73 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> > index b262f40f32c0..bb723478baf1 100644
> > --- a/block/mq-deadline.c
> > +++ b/block/mq-deadline.c
> > @@ -31,6 +31,11 @@
> >   */
> >  static const int read_expire = HZ / 2;  /* max time before a read is submitted. */
> >  static const int write_expire = 5 * HZ; /* ditto for writes, these limits are SOFT! */
> > +/*
> > + * Time after which to dispatch lower priority requests even if higher
> > + * priority requests are pending.
> > + */
> > +static const int prio_aging_expire = 10 * HZ;
> >  static const int writes_starved = 2;    /* max times reads can starve a write */
> >  static const int fifo_batch = 16;       /* # of sequential requests treated as one
> >  				     by the above parameters. For throughput. */
> > @@ -96,6 +101,7 @@ struct deadline_data {
> >  	int writes_starved;
> >  	int front_merges;
> >  	u32 async_depth;
> > +	int prio_aging_expire;
> >  
> >  	spinlock_t lock;
> >  	spinlock_t zone_lock;
> > @@ -338,12 +344,27 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
> >  	return rq;
> >  }
> >  
> > +/*
> > + * Returns true if and only if @rq started after @latest_start where
> > + * @latest_start is in jiffies.
> > + */
> > +static bool started_after(struct deadline_data *dd, struct request *rq,
> > +			  unsigned long latest_start)
> > +{
> > +	unsigned long start_time = (unsigned long)rq->fifo_time;
> > +
> > +	start_time -= dd->fifo_expire[rq_data_dir(rq)];
> > +
> > +	return time_after(start_time, latest_start);
> > +}
> > +
> >  /*
> >   * deadline_dispatch_requests selects the best request according to
> > - * read/write expire, fifo_batch, etc
> > + * read/write expire, fifo_batch, etc and with a start time <= @latest.
> >   */
> >  static struct request *__dd_dispatch_request(struct deadline_data *dd,
> > -					     struct dd_per_prio *per_prio)
> > +					     struct dd_per_prio *per_prio,
> > +					     unsigned long latest_start)
> >  {
> >  	struct request *rq, *next_rq;
> >  	enum dd_data_dir data_dir;
> > @@ -355,6 +376,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
> >  	if (!list_empty(&per_prio->dispatch)) {
> >  		rq = list_first_entry(&per_prio->dispatch, struct request,
> >  				      queuelist);
> > +		if (started_after(dd, rq, latest_start))
> > +			return NULL;
> >  		list_del_init(&rq->queuelist);
> >  		goto done;
> >  	}
> > @@ -432,6 +455,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
> >  	dd->batching = 0;
> >  
> >  dispatch_request:
> > +	if (started_after(dd, rq, latest_start))
> > +		return NULL;
> > +
> >  	/*
> >  	 * rq is the selected appropriate request.
> >  	 */
> > @@ -449,6 +475,34 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
> >  	return rq;
> >  }
> >  
> > +/*
> > + * Check whether there are any requests with priority other than DD_RT_PRIO
> > + * that were inserted more than prio_aging_expire jiffies ago.
> > + */
> > +static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
> > +						      unsigned long now)
> > +{
> > +	struct request *rq;
> > +	enum dd_prio prio;
> > +	int prio_cnt;
> > +
> > +	lockdep_assert_held(&dd->lock);
> > +
> > +	prio_cnt = !!dd_queued(dd, DD_RT_PRIO) + !!dd_queued(dd, DD_BE_PRIO) +
> > +		   !!dd_queued(dd, DD_IDLE_PRIO);
> > +	if (prio_cnt < 2)
> > +		return NULL;
> > +
> > +	for (prio = DD_BE_PRIO; prio <= DD_PRIO_MAX; prio++) {
> > +		rq = __dd_dispatch_request(dd, &dd->per_prio[prio],
> > +					   now - dd->prio_aging_expire);
> > +		if (rq)
> > +			return rq;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> >  /*
> >   * Called from blk_mq_run_hw_queue() -> __blk_mq_sched_dispatch_requests().
> >   *
> > @@ -460,15 +514,26 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
> >  static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
> >  {
> >  	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
> > +	const unsigned long now = jiffies;
> >  	struct request *rq;
> >  	enum dd_prio prio;
> >  
> >  	spin_lock(&dd->lock);
> > +	rq = dd_dispatch_prio_aged_requests(dd, now);
> > +	if (rq)
> > +		goto unlock;
> > +
> > +	/*
> > +	 * Next, dispatch requests in priority order. Ignore lower priority
> > +	 * requests if any higher priority requests are pending.
> > +	 */
> >  	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
> > -		rq = __dd_dispatch_request(dd, &dd->per_prio[prio]);
> > -		if (rq)
> > +		rq = __dd_dispatch_request(dd, &dd->per_prio[prio], now);
> > +		if (rq || dd_queued(dd, prio))
> >  			break;
> >  	}
> > +
> > +unlock:
> >  	spin_unlock(&dd->lock);
> >  
> >  	return rq;
> > @@ -573,6 +638,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
> >  	dd->front_merges = 1;
> >  	dd->last_dir = DD_WRITE;
> >  	dd->fifo_batch = fifo_batch;
> > +	dd->prio_aging_expire = prio_aging_expire;
> >  	spin_lock_init(&dd->lock);
> >  	spin_lock_init(&dd->zone_lock);
> >  
> > @@ -796,6 +862,7 @@ static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
> >  #define SHOW_JIFFIES(__FUNC, __VAR) SHOW_INT(__FUNC, jiffies_to_msecs(__VAR))
> >  SHOW_JIFFIES(deadline_read_expire_show, dd->fifo_expire[DD_READ]);
> >  SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);
> > +SHOW_JIFFIES(deadline_prio_aging_expire_show, dd->prio_aging_expire);
> >  SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
> >  SHOW_INT(deadline_front_merges_show, dd->front_merges);
> >  SHOW_INT(deadline_async_depth_show, dd->front_merges);
> > @@ -825,6 +892,7 @@ static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)
> >  	STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, msecs_to_jiffies)
> >  STORE_JIFFIES(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0, INT_MAX);
> >  STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MAX);
> > +STORE_JIFFIES(deadline_prio_aging_expire_store, &dd->prio_aging_expire, 0, INT_MAX);
> >  STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
> >  STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
> >  STORE_INT(deadline_async_depth_store, &dd->front_merges, 1, INT_MAX);
> > @@ -843,6 +911,7 @@ static struct elv_fs_entry deadline_attrs[] = {
> >  	DD_ATTR(front_merges),
> >  	DD_ATTR(async_depth),
> >  	DD_ATTR(fifo_batch),
> > +	DD_ATTR(prio_aging_expire),
> >  	__ATTR_NULL
> >  };
> >  
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
