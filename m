Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C22C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 06:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243692AbiCOGLy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 02:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbiCOGLx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 02:11:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C01D049FA9
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 23:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647324640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qYZPhjOXzmAdEzQgqhquFgAkAbg5n3v5TRFMKwkCfjk=;
        b=IAwgo2MRj9FLrbrCL3/TK+Rh935vl1qXuAll/YIgGrxoLytUUN1zllpvCbpJkxK2gn1Fmo
        7IWRdJRioInIe5t6mPDr4uVCOnHeAYWbnOO90U9yaXEEVIo1s+gBIcA5xuGepUDT6oVwly
        31+qE6J1EbocQrkj8kg0HSkYyu1l9I8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-yW1hA47XPn6tEgBBVTGgSQ-1; Tue, 15 Mar 2022 02:10:36 -0400
X-MC-Unique: yW1hA47XPn6tEgBBVTGgSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 135BB80159B;
        Tue, 15 Mar 2022 06:10:36 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C94E140EBFE;
        Tue, 15 Mar 2022 06:10:31 +0000 (UTC)
Date:   Tue, 15 Mar 2022 14:10:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Message-ID: <YjAt0adsedXWldSI@T590>
References: <20220310091649.zypaem5lkyfadymg@shindev>
 <YinMWPiuUluinom8@T590>
 <20220310124023.tkax52chul265bus@shindev>
 <a6d6b858-4bee-10da-884c-20b16e4ad0de@kernel.dk>
 <20220311062441.vsa54rie5fxhjtps@shindev>
 <YisblCKgf6xC0/ai@T590>
 <20220314052434.zud5zb5wqrjljk4b@shindev>
 <Yi7n9mgblKcC7msM@T590>
 <20220315052431.zhj6d7srkhjudiua@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315052431.zhj6d7srkhjudiua@shindev>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 15, 2022 at 05:24:32AM +0000, Shinichiro Kawasaki wrote:
> On Mar 14, 2022 / 15:00, Ming Lei wrote:
> > On Mon, Mar 14, 2022 at 05:24:34AM +0000, Shinichiro Kawasaki wrote:
> > > On Mar 11, 2022 / 17:51, Ming Lei wrote:
> > > > On Fri, Mar 11, 2022 at 06:24:41AM +0000, Shinichiro Kawasaki wrote:
> > > > > On Mar 10, 2022 / 05:47, Jens Axboe wrote:
> > > > > > On 3/10/22 5:40 AM, Shinichiro Kawasaki wrote:
> > > > > > > On Mar 10, 2022 / 18:00, Ming Lei wrote:
> > > > > > >> On Thu, Mar 10, 2022 at 09:16:50AM +0000, Shinichiro Kawasaki wrote:
> > > > > > >>> This issue does not look critical, but let me share it to ask comments for fix.
> > > > > > >>>
> > > > > > >>> When fio command with 40 jobs [1] is run for a null_blk device with memory
> > > > > > >>> backing and mq-deadline scheduler, kernel reports a BUG message [2]. The
> > > > > > >>> workqueue watchdog reports that kblockd blk_mq_run_work_fn keeps on running
> > > > > > >>> more than 30 seconds and other work can not run. The 40 fio jobs keep on
> > > > > > >>> creating many read requests to a single null_blk device, then the every time
> > > > > > >>> the mq_run task calls __blk_mq_do_dispatch_sched(), it returns ret == 1 which
> > > > > > >>> means more than one request was dispatched. Hence, the while loop in
> > > > > > >>> blk_mq_do_dispatch_sched() does not break.
> > > > > > >>>
> > > > > > >>> static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > > >>> {
> > > > > > >>>         int ret;
> > > > > > >>>
> > > > > > >>>         do {
> > > > > > >>>                ret = __blk_mq_do_dispatch_sched(hctx);
> > > > > > >>>         } while (ret == 1);
> > > > > > >>>
> > > > > > >>>         return ret;
> > > > > > >>> }
> > > > > > >>>
> > > > > > >>> The BUG message was observed when I ran blktests block/005 with various
> > > > > > >>> conditions on a system with 40 CPUs. It was observed with kernel version
> > > > > > >>> v5.16-rc1 through v5.17-rc7. The trigger commit was 0a593fbbc245 ("null_blk:
> > > > > > >>> poll queue support"). This commit added blk_mq_ops.map_queues callback. I
> > > > > > >>> guess it changed dispatch behavior for null_blk devices and triggered the
> > > > > > >>> BUG message.
> > > > > > >>
> > > > > > >> It is one blk-mq soft lockup issue in dispatch side, and shouldn't be related
> > > > > > >> with 0a593fbbc245.
> > > > > > >>
> > > > > > >> If queueing requests is faster than dispatching, the issue will be triggered
> > > > > > >> sooner or later, especially easy to trigger in SQ device. I am sure it can
> > > > > > >> be triggered on scsi debug, even saw such report on ahci.
> > > > > > > 
> > > > > > > Thank you for the comments. Then this is the real problem.
> > > > > > > 
> > > > > > >>
> > > > > > >>>
> > > > > > >>> I'm not so sure if we really need to fix this issue. It does not seem the real
> > > > > > >>> world problem since it is observed only with null_blk. The real block devices
> > > > > > >>> have slower IO operation then the dispatch should stop sooner when the hardware
> > > > > > >>> queue gets full. Also the 40 jobs for single device is not realistic workload.
> > > > > > >>>
> > > > > > >>> Having said that, it does not feel right that other works are pended during
> > > > > > >>> dispatch for null_blk devices. To avoid the BUG message, I can think of two
> > > > > > >>> fix approaches. First one is to break the while loop in blk_mq_do_dispatch_sched
> > > > > > >>> using a loop counter [3] (or jiffies timeout check).
> > > > > > >>
> > > > > > >> This way could work, but the queue need to be re-run after breaking
> > > > > > >> caused by max dispatch number. cond_resched() might be the simplest way,
> > > > > > >> but it can't be used here because of rcu/srcu read lock.
> > > > > > > 
> > > > > > > As far as I understand, blk_mq_run_work_fn() should return after the loop break
> > > > > > > to yield the worker to other works. How about to call
> > > > > > > blk_mq_delay_run_hw_queue() at the loop break? Does this re-run the dispatch?
> > > > > > > 
> > > > > > > 
> > > > > > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > > > > > index 55488ba978232..faa29448a72a0 100644
> > > > > > > --- a/block/blk-mq-sched.c
> > > > > > > +++ b/block/blk-mq-sched.c
> > > > > > > @@ -178,13 +178,19 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > > >  	return !!dispatched;
> > > > > > >  }
> > > > > > >  
> > > > > > > +#define MQ_DISPATCH_MAX 0x10000
> > > > > > > +
> > > > > > >  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > > >  {
> > > > > > >  	int ret;
> > > > > > > +	unsigned int count = MQ_DISPATCH_MAX;
> > > > > > >  
> > > > > > >  	do {
> > > > > > >  		ret = __blk_mq_do_dispatch_sched(hctx);
> > > > > > > -	} while (ret == 1);
> > > > > > > +	} while (ret == 1 && count--);
> > > > > > > +
> > > > > > > +	if (ret == 1 && !count)
> > > > > > > +		blk_mq_delay_run_hw_queue(hctx, 0);
> > > > > > >  
> > > > > > >  	return ret;
> > > > > > >  }
> > > > > > 
> > > > > > Why not just gate it on needing to reschedule, rather than some random
> > > > > > value?
> > > > > > 
> > > > > > static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > > > > {
> > > > > > 	int ret;
> > > > > > 
> > > > > > 	do {
> > > > > > 		ret = __blk_mq_do_dispatch_sched(hctx);
> > > > > > 	} while (ret == 1 && !need_resched());
> > > > > > 
> > > > > > 	if (ret == 1 && need_resched())
> > > > > > 		blk_mq_delay_run_hw_queue(hctx, 0);
> > > > > > 
> > > > > > 	return ret;
> > > > > > }
> > > > > > 
> > > > > > or something like that.
> > > > > 
> > > > > Jens, thanks for the idea, but need_resched() check does not look working here.
> > > > > I tried the code above but still the BUG message is observed. My guess is that
> > > > > in the call stack below, every __blk_mq_do_dispatch_sched() call results in
> > > > > might_sleep_if() call, then need_resched() does not work as expected, probably.
> > > > > 
> > > > > __blk_mq_do_dispatch_sched
> > > > >   blk_mq_dispatch_rq_list
> > > > >     q->mq_ops->queue_rq
> > > > >       null_queue_rq
> > > > >         might_sleep_if
> > > > > 
> > > > > Now I'm trying to find similar way as need_resched() to avoid the random number.
> > > > > So far I haven't found good idea yet.
> > > > 
> > > > Jens patch using need_resched() looks improving the situation, also the
> > > > scsi_debug case won't set BLOCKING:
> > > > 
> > > > 1) without the patch, it can be easy to trigger lockup with the
> > > > following test.
> > > > 
> > > > - modprobe scsi_debug virtual_gb=128 delay=0 dev_size_mb=2048
> > > > - fio --bs=512k --ioengine=sync --iodepth=128 --numjobs=4 --rw=randrw \
> > > > 	--name=sdc-sync-randrw-512k --filename=/dev/sdc --direct=1 --size=60G --runtime=120
> > > > 
> > > > #sdc is the created scsi_debug disk
> > > 
> > > Thanks. I tried the work load above and observed the lockup BUG message on my
> > > system. So, I reconfirmed that the problem happens with both BLOCKING and
> > > non-BLOCKING drivers.
> > > 
> > > Regarding the solution, I can not think of any good one. I tried to remove the
> > > WQ_HIGHPRI flag from kblockd_workqueue, but it did not look affecting
> > > need_resched() behavior. I walked through workqueue API, but was not able
> > > to find anything useful.
> > > 
> > > As far as I understand, it is assumed and expected the each work item gets
> > > completed within decent time. Then this blk_mq_run_work_fn must stop within
> > > decent time by breaking the loop at some point. As the loop break conditions
> > > other than need_resched(), I can think of 1) loop count, 2) number of requests
> > > dispatched or 3) time spent in the loop. All of the three require a magic random
> > > number as the limit... Is there any other better way?
> > > 
> > > If we need to choose one of the 3 options, I think '3) time spent in the loop'
> > > is better than others, since workqueue watchdog monitors _time_ to check lockup
> > > and report the BUG message.
> > 
> > BTW, just tried 3), then the lockup issue can't be reproduced any more:
> > 
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index e6ad8f761474..b4de5a7ec606 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -181,10 +181,14 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >  {
> >         int ret;
> > +       unsigned long start = jiffies;
> >  
> >         do {
> >                 ret = __blk_mq_do_dispatch_sched(hctx);
> > -       } while (ret == 1);
> > +       } while (ret == 1 && !need_resched() && (jiffies - start) < HZ);
> > +
> > +       if (ret == 1 && (need_resched() || jiffies - start >= HZ))
> > +                blk_mq_delay_run_hw_queue(hctx, 0);
> >  
> >         return ret;
> >  }
> 
> It sounds a good idea to check both need_resched() and 3) time spent in the
> loop. I also confirmed that this fix avoids the BUG message on the scsi_debug
> workload as well as null_blk with memory backing. Looks good. For this
> confirmation, I modified the hunk above to avoid duplicated checks [1].
> 
> As for the loop break limit, I think HZ = 1 second is appropriate. The workqueue
> watchdog checks lockup with duration 'wq_watchdog_thresh' defined in
> kernel/workqueue.c. In the worst case, its number is 1, meaning 1 second. Then,
> 1 second loop break in blk_mq_do_dispatch_sched() should avoid the BUG message.
> 
> To reduce influence on the performance, it would be good to make this number
> larger. One idea was to refer the wq_watchdog_thresh as the limit for the loop
> break. However, the variable is static and defined only when CONFIG_WQ_WATCHDOG
> is enabled. So, I don't think block layer can refer it.
> 
> Assuming this fix approach is ok, I would like to have a formal patch. Ming,
> would your mind to create it? Or if you want, I'm willing to do that.
> 
> [1]
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 55488ba978232..64941615befc6 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -181,9 +181,15 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  {
>  	int ret;
> +	unsigned long end = jiffies + HZ;
>  
>  	do {
>  		ret = __blk_mq_do_dispatch_sched(hctx);
> +		if (ret == 1 &&
> +		    (need_resched() || time_is_after_jiffies(end))) {
> +			blk_mq_delay_run_hw_queue(hctx, 0);
> +			break;
> +		}
>  	} while (ret == 1);

I am fine with this patch, so please prepare one formal patch and see
if Jens and guys are fine with it.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

