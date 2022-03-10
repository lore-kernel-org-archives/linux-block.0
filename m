Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BBAC433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 10:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiCJKCV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 05:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiCJKCV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 05:02:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5A8013D578
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 02:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646906480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0UPaY2/tHCrOdvsv0aFffLM+jcSR/3Ygze3nVa3wohE=;
        b=i5/10t2Myviv4aSSVeI4uGiPeKamZqJxniOwYzl/IAoFRQnUpGiafNigdASWMT0/YY5IyH
        WLtcxikJKLvQdcedRgn70CYeGXJwf6ZeN5v08paViqByJC5slpOx7gEgQwDFIBi8IHIA7l
        pldpRWB50KJBk3oRScOSC6HxqM4Y+l8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-10ocabzoPySLEeFLWPesDQ-1; Thu, 10 Mar 2022 05:01:14 -0500
X-MC-Unique: 10ocabzoPySLEeFLWPesDQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B8F51091DA0;
        Thu, 10 Mar 2022 10:01:13 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 115D8105958D;
        Thu, 10 Mar 2022 10:01:00 +0000 (UTC)
Date:   Thu, 10 Mar 2022 18:00:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Message-ID: <YinMWPiuUluinom8@T590>
References: <20220310091649.zypaem5lkyfadymg@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310091649.zypaem5lkyfadymg@shindev>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 10, 2022 at 09:16:50AM +0000, Shinichiro Kawasaki wrote:
> This issue does not look critical, but let me share it to ask comments for fix.
> 
> When fio command with 40 jobs [1] is run for a null_blk device with memory
> backing and mq-deadline scheduler, kernel reports a BUG message [2]. The
> workqueue watchdog reports that kblockd blk_mq_run_work_fn keeps on running
> more than 30 seconds and other work can not run. The 40 fio jobs keep on
> creating many read requests to a single null_blk device, then the every time
> the mq_run task calls __blk_mq_do_dispatch_sched(), it returns ret == 1 which
> means more than one request was dispatched. Hence, the while loop in
> blk_mq_do_dispatch_sched() does not break.
> 
> static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> {
>         int ret;
> 
>         do {
>                ret = __blk_mq_do_dispatch_sched(hctx);
>         } while (ret == 1);
> 
>         return ret;
> }
> 
> The BUG message was observed when I ran blktests block/005 with various
> conditions on a system with 40 CPUs. It was observed with kernel version
> v5.16-rc1 through v5.17-rc7. The trigger commit was 0a593fbbc245 ("null_blk:
> poll queue support"). This commit added blk_mq_ops.map_queues callback. I
> guess it changed dispatch behavior for null_blk devices and triggered the
> BUG message.

It is one blk-mq soft lockup issue in dispatch side, and shouldn't be related
with 0a593fbbc245.

If queueing requests is faster than dispatching, the issue will be triggered
sooner or later, especially easy to trigger in SQ device. I am sure it can
be triggered on scsi debug, even saw such report on ahci.

> 
> I'm not so sure if we really need to fix this issue. It does not seem the real
> world problem since it is observed only with null_blk. The real block devices
> have slower IO operation then the dispatch should stop sooner when the hardware
> queue gets full. Also the 40 jobs for single device is not realistic workload.
> 
> Having said that, it does not feel right that other works are pended during
> dispatch for null_blk devices. To avoid the BUG message, I can think of two
> fix approaches. First one is to break the while loop in blk_mq_do_dispatch_sched
> using a loop counter [3] (or jiffies timeout check).

This way could work, but the queue need to be re-run after breaking
caused by max dispatch number. cond_resched() might be the simplest way,
but it can't be used here because of rcu/srcu read lock.



Thanks,
Ming

