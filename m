Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84682C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 09:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243194AbiCKJwn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 04:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiCKJwl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 04:52:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B251E1B989A
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 01:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646992297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJfiPB8jcXsTP9jc0nOlmmXl3DyLOSv9JVOPI4wfoAE=;
        b=IjuUdWfOmo+STA6in7Cj+AIFHRVhSTxMAWbFgTD120Dvcg/hNv/020kZNJoj02Pn2KUxIN
        y5pj9DeffjLysyrEs4slI4+FpUICGLbNwhiFigMwGYnK5SoI5kmSOZljvdM5UYzuZ/CzdD
        l6pImbRgpRynnVpWwUpRurftqziwLlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-SHx3ul8FOcO2EIGU8G3Hqg-1; Fri, 11 Mar 2022 04:51:34 -0500
X-MC-Unique: SHx3ul8FOcO2EIGU8G3Hqg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3337F1091DA2;
        Fri, 11 Mar 2022 09:51:33 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C720D1057F35;
        Fri, 11 Mar 2022 09:51:21 +0000 (UTC)
Date:   Fri, 11 Mar 2022 17:51:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Message-ID: <YisblCKgf6xC0/ai@T590>
References: <20220310091649.zypaem5lkyfadymg@shindev>
 <YinMWPiuUluinom8@T590>
 <20220310124023.tkax52chul265bus@shindev>
 <a6d6b858-4bee-10da-884c-20b16e4ad0de@kernel.dk>
 <20220311062441.vsa54rie5fxhjtps@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311062441.vsa54rie5fxhjtps@shindev>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 11, 2022 at 06:24:41AM +0000, Shinichiro Kawasaki wrote:
> On Mar 10, 2022 / 05:47, Jens Axboe wrote:
> > On 3/10/22 5:40 AM, Shinichiro Kawasaki wrote:
> > > On Mar 10, 2022 / 18:00, Ming Lei wrote:
> > >> On Thu, Mar 10, 2022 at 09:16:50AM +0000, Shinichiro Kawasaki wrote:
> > >>> This issue does not look critical, but let me share it to ask comments for fix.
> > >>>
> > >>> When fio command with 40 jobs [1] is run for a null_blk device with memory
> > >>> backing and mq-deadline scheduler, kernel reports a BUG message [2]. The
> > >>> workqueue watchdog reports that kblockd blk_mq_run_work_fn keeps on running
> > >>> more than 30 seconds and other work can not run. The 40 fio jobs keep on
> > >>> creating many read requests to a single null_blk device, then the every time
> > >>> the mq_run task calls __blk_mq_do_dispatch_sched(), it returns ret == 1 which
> > >>> means more than one request was dispatched. Hence, the while loop in
> > >>> blk_mq_do_dispatch_sched() does not break.
> > >>>
> > >>> static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > >>> {
> > >>>         int ret;
> > >>>
> > >>>         do {
> > >>>                ret = __blk_mq_do_dispatch_sched(hctx);
> > >>>         } while (ret == 1);
> > >>>
> > >>>         return ret;
> > >>> }
> > >>>
> > >>> The BUG message was observed when I ran blktests block/005 with various
> > >>> conditions on a system with 40 CPUs. It was observed with kernel version
> > >>> v5.16-rc1 through v5.17-rc7. The trigger commit was 0a593fbbc245 ("null_blk:
> > >>> poll queue support"). This commit added blk_mq_ops.map_queues callback. I
> > >>> guess it changed dispatch behavior for null_blk devices and triggered the
> > >>> BUG message.
> > >>
> > >> It is one blk-mq soft lockup issue in dispatch side, and shouldn't be related
> > >> with 0a593fbbc245.
> > >>
> > >> If queueing requests is faster than dispatching, the issue will be triggered
> > >> sooner or later, especially easy to trigger in SQ device. I am sure it can
> > >> be triggered on scsi debug, even saw such report on ahci.
> > > 
> > > Thank you for the comments. Then this is the real problem.
> > > 
> > >>
> > >>>
> > >>> I'm not so sure if we really need to fix this issue. It does not seem the real
> > >>> world problem since it is observed only with null_blk. The real block devices
> > >>> have slower IO operation then the dispatch should stop sooner when the hardware
> > >>> queue gets full. Also the 40 jobs for single device is not realistic workload.
> > >>>
> > >>> Having said that, it does not feel right that other works are pended during
> > >>> dispatch for null_blk devices. To avoid the BUG message, I can think of two
> > >>> fix approaches. First one is to break the while loop in blk_mq_do_dispatch_sched
> > >>> using a loop counter [3] (or jiffies timeout check).
> > >>
> > >> This way could work, but the queue need to be re-run after breaking
> > >> caused by max dispatch number. cond_resched() might be the simplest way,
> > >> but it can't be used here because of rcu/srcu read lock.
> > > 
> > > As far as I understand, blk_mq_run_work_fn() should return after the loop break
> > > to yield the worker to other works. How about to call
> > > blk_mq_delay_run_hw_queue() at the loop break? Does this re-run the dispatch?
> > > 
> > > 
> > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > index 55488ba978232..faa29448a72a0 100644
> > > --- a/block/blk-mq-sched.c
> > > +++ b/block/blk-mq-sched.c
> > > @@ -178,13 +178,19 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > >  	return !!dispatched;
> > >  }
> > >  
> > > +#define MQ_DISPATCH_MAX 0x10000
> > > +
> > >  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > >  {
> > >  	int ret;
> > > +	unsigned int count = MQ_DISPATCH_MAX;
> > >  
> > >  	do {
> > >  		ret = __blk_mq_do_dispatch_sched(hctx);
> > > -	} while (ret == 1);
> > > +	} while (ret == 1 && count--);
> > > +
> > > +	if (ret == 1 && !count)
> > > +		blk_mq_delay_run_hw_queue(hctx, 0);
> > >  
> > >  	return ret;
> > >  }
> > 
> > Why not just gate it on needing to reschedule, rather than some random
> > value?
> > 
> > static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > {
> > 	int ret;
> > 
> > 	do {
> > 		ret = __blk_mq_do_dispatch_sched(hctx);
> > 	} while (ret == 1 && !need_resched());
> > 
> > 	if (ret == 1 && need_resched())
> > 		blk_mq_delay_run_hw_queue(hctx, 0);
> > 
> > 	return ret;
> > }
> > 
> > or something like that.
> 
> Jens, thanks for the idea, but need_resched() check does not look working here.
> I tried the code above but still the BUG message is observed. My guess is that
> in the call stack below, every __blk_mq_do_dispatch_sched() call results in
> might_sleep_if() call, then need_resched() does not work as expected, probably.
> 
> __blk_mq_do_dispatch_sched
>   blk_mq_dispatch_rq_list
>     q->mq_ops->queue_rq
>       null_queue_rq
>         might_sleep_if
> 
> Now I'm trying to find similar way as need_resched() to avoid the random number.
> So far I haven't found good idea yet.

Jens patch using need_resched() looks improving the situation, also the
scsi_debug case won't set BLOCKING:

1) without the patch, it can be easy to trigger lockup with the
following test.

- modprobe scsi_debug virtual_gb=128 delay=0 dev_size_mb=2048
- fio --bs=512k --ioengine=sync --iodepth=128 --numjobs=4 --rw=randrw \
	--name=sdc-sync-randrw-512k --filename=/dev/sdc --direct=1 --size=60G --runtime=120

#sdc is the created scsi_debug disk

2) with the patch, lockup still can be triggered, just not as easy as
before

3) trace need_resched() from kretprobe:__blk_mq_do_dispatch_sched() in
kblockd wq context, I observed that just 20~30 times resched gets set
when running the above script(120sec), so maybe need_resched() isn't set
during heavy IO dispatching.


Thanks,
Ming

