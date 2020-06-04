Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1C9C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 11:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE63206E6
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 11:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWEnyTiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgFDL0f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 07:26:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55456 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgFDL0e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 07:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591269991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPWS+UtP47C4ALN3uPjM5A67Vzk2WPgiT6vScl99CKc=;
        b=GWEnyTiJem1zkOf4txe57yetPyOTV4z8XOSblRh5WOzlKNU7Fif+yqRN8nEvXqyKRtxqdE
        nvHkcyMA/Qzia528CjhK8cRHa7use9GgqF8sYfAwtBqLEpPyeoEoVx2Vxf0HlD398mB9VT
        gLbyRRxfRdsQXLZp1GK4eSI/fiMQSZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-MrknvYw3MJWZkvbBkSIg2w-1; Thu, 04 Jun 2020 07:26:28 -0400
X-MC-Unique: MrknvYw3MJWZkvbBkSIg2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ECBC1883600;
        Thu,  4 Jun 2020 11:26:27 +0000 (UTC)
Received: from T590 (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3C187CCC4;
        Thu,  4 Jun 2020 11:26:20 +0000 (UTC)
Date:   Thu, 4 Jun 2020 19:26:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
Message-ID: <20200604112615.GA2336493@T590>
References: <20200603105128.2147139-1-ming.lei@redhat.com>
 <20200603115347.GA8653@lst.de>
 <20200603133608.GA2149752@T590>
 <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
 <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com>
 <b37b1f30-722b-4767-0627-103b94c7421c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b37b1f30-722b-4767-0627-103b94c7421c@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 04, 2020 at 11:24:29AM +0100, John Garry wrote:
> > > > > 
> > > > > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > > > > index 96a39d0724a29..cded7fdcad8ef 100644
> > > > > --- a/block/blk-mq-tag.c
> > > > > +++ b/block/blk-mq-tag.c
> > > > > @@ -191,6 +191,33 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
> > > > >        return tag + tag_offset;
> > > > >    }
> > > > >    +bool __blk_mq_get_driver_tag(struct request *rq)
> > > > > +{
> > > > > +    struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
> > > > > +    unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
> > > > > +    bool shared = blk_mq_tag_busy(rq->mq_hctx);
> > > > 
> > > > Not necessary to add 'shared' which is just used once.
> > > > 
> > > > > +    int tag;
> > > > > +
> > > > > +    if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
> > > > > +        bt = &rq->mq_hctx->tags->breserved_tags;
> > > > 
> > > > Too many rq->mq_hctx->tags, you can add one local variable to store it.
> > > > 
> > > > Otherwise, looks fine:
> > > > 
> > > > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
> Unfortunately this looks to still have problems. So, for a start, this
> stackframe is pumped out a lot (which I removed, for below):
> 
> [  697.464058] Workqueue: kblockd blk_mq_run_work_fn
> [  697.468749] Call trace:
> [  697.471184]  dump_backtrace+0x0/0x1c0
> [  697.474833]  show_stack+0x18/0x28
> [  697.478136]  dump_stack+0xc8/0x114
> [  697.481524]  __blk_mq_run_hw_queue+0x124/0x130
> [  697.485954]  blk_mq_run_work_fn+0x20/0x30
> [  697.489951]  process_one_work+0x1e8/0x360
> [  697.493947]  worker_thread+0x238/0x478
> [  697.497683]  kthread+0x150/0x158
> [  697.500898]  ret_from_fork+0x10/0x1c
> [  697.504480] run queue from wrong CPU 32, hctx active
> [  697.509444] CPU: 32 PID: 1477 Comm: kworker/21:2H Not tainted 5.7.0-
> 
> And then other time I get SCSI timeouts:
> 
> [95.170616] psci: CPU21 killed (polled 0 ms)
> [95.419832] CPU22: shutdown
> [95.422630] psci: CPU22 killed (polled 0 ms)
> [95.683772] irq_shutdown irq1384MiB/s,w=0KiB/s][r=380k,w=0 IOPS][eta
> 00m:50s]
> [95.687013] CPU23: shutdown
> [95.689829] psci: CPU23 killed (polled 0 ms)
> [96.379817] CPU24: shutdown
> [96.382617] psci: CPU24 killed (polled 0 ms)
> [96.703823] CPU25: shutdown=1902MiB/s,w=0KiB/s][r=487k,w=0 IOPS][eta
> 00m:49s]
> [96.706667] psci: CPU25 killed (polled 0 ms)
> [97.299845] CPU26: shutdown
> [97.302647] psci: CPU26 killed (polled 0 ms)
> [97.331737] irq_shutdown irq139
> [97.334969] CPU27: shutdown
> [97.337774] psci: CPU27 killed (polled 0 ms)
> [  102.308329] CPU28: shutdown=1954MiB/s,w=0KiB/s][r=500k,w=0 IOPS][eta
> 00m:44s]
> [  102.311137] psci: CPU28 killed (polled 0 ms)
> [  102.663877] CPU29: shutdown=1755MiB/s,w=0KiB/s][r=449k,w=0 IOPS][eta
> 00m:43s]
> [  102.666679] psci: CPU29 killed (polled 0 ms)
> [  104.459867] CPU30: shutdown=1552MiB/s,w=0KiB/s][r=397k,w=0 IOPS][eta
> 00m:42s]
> [  104.462668] psci: CPU30 killed (polled 0 ms)
> [  106.259909] IRQ 43: no longer affine to CPU31s][r=414k,w=0 IOPS][eta
> 00m:40s]
> [  106.264273] IRQ 114: no longer affine to CPU31
> [  106.268707] IRQ 118: no longer affine to CPU31
> [  106.273141] IRQ 123: no longer affine to CPU31
> [  106.277579] irq_shutdown irq140
> [  106.280757] IRQ 332: no longer affine to CPU31
> [  106.285190] IRQ 336: no longer affine to CPU31
> [  106.289623] IRQ 338: no longer affine to CPU31
> [  106.294056] IRQ 340: no longer affine to CPU31
> [  106.298489] IRQ 344: no longer affine to CPU31
> [  106.302922] IRQ 348: no longer affine to CPU31
> [  106.307450] CPU31: shutdown
> [  106.310251] psci: CPU31 killed (polled 0 ms)
> [  108.367884] CPU32: shutdown=1693MiB/s,w=0KiB/s][r=434k,w=0 IOPS][eta
> 00m:38s]
> [  108.370683] psci: CPU32 killed (polled 0 ms)
> [  110.808471] CPU33: shutdown=1747MiB/s,w=0KiB/s][r=447k,w=0 IOPS][eta
> 00m:35s]
> [  110.811269] psci: CPU33 killed (polled 0 ms)
> [  110.871804] CPU34: shutdown
> [  110.874598] psci: CPU34 killed (polled 0 ms)
> [  111.767879] irq_shutdown irq1412MiB/s,w=0KiB/s][r=418k,w=0 IOPS][eta
> 00m:34s]
> [  111.771171] CPU35: shutdown
> [  111.773975] psci: CPU35 killed (polled 0 ms)
> [  113.167866] CPU36: shutdown=1680MiB/s,w=0KiB/s][r=430k,w=0 IOPS][eta
> 00m:33s]
> [  113.170673] psci: CPU36 killed (polled 0 ms)
> [  115.783879] CPU37: shutdown=1839MiB/s,w=0KiB/s][r=471k,w=0 IOPS][eta
> 00m:30s]
> [  115.786675] psci: CPU37 killed (polled 0 ms)
> [  117.111877] CPU38: shutdown=2032MiB/s,w=0KiB/s][r=520k,w=0 IOPS][eta
> 00m:29s]
> [  117.114670] psci: CPU38 killed (polled 0 ms)
> [  121.263701] irq_shutdown irq1423MiB/s,w=0KiB/s][r=428k,w=0 IOPS][eta
> 00m:25s]
> [  121.266996] CPU39: shutdown
> [  121.269797] psci: CPU39 killed (polled 0 ms)
> [  121.364122] CPU40: shutdown
> [  121.366918] psci: CPU40 killed (polled 0 ms)
> [  121.448256] CPU41: shutdown
> [  121.451058] psci: CPU41 killed (polled 0 ms)
> [  121.515785] CPU42: shutdown=1711MiB/s,w=0KiB/s][r=438k,w=0 IOPS][eta
> 00m:24s]
> [  121.518586] psci: CPU42 killed (polled 0 ms)
> [  121.563659] irq_shutdown irq143
> [  121.566922] CPU43: shutdown
> [  121.569732] psci: CPU43 killed (polled 0 ms)
> [  122.619423] scsi_times_out req=0xffff001faf906900=371k,w=0 IOPS][eta
> 00m:23s]
> [  122.624131] scsi_times_out req=0xffff001faf90ed00
> [  122.628842] scsi_times_out req=0xffff001faf90fc00
> [  122.633547] scsi_times_out req=0xffff001faf906000
> [  122.638259] scsi_times_out req=0xffff001faf906300
> [  122.642969] scsi_times_out req=0xffff001faf906600
> [  122.647676] scsi_times_out req=0xffff001faf906c00
> [  122.652381] scsi_times_out req=0xffff001faf906f00
> [  122.657086] scsi_times_out req=0xffff001faf907200
> [  122.661791] scsi_times_out req=0xffff001faf907500
> [  122.666498] scsi_times_out req=0xffff001faf907800
> [  122.671203] scsi_times_out req=0xffff001faf907b00
> [  122.675909] scsi_times_out req=0xffff001faf907e00
> [  122.680615] scsi_times_out req=0xffff001faf908100
> [  122.685319] scsi_times_out req=0xffff001faf908400
> [  122.690025] scsi_times_out req=0xffff001faf908700
> [  122.694731] scsi_times_out req=0xffff001faf908a00
> [  122.699439] scsi_times_out req=0xffff001faf908d00
> [  122.704145] scsi_times_out req=0xffff001faf909000
> [  122.708849] scsi_times_out req=0xffff001faf909300
> 
> 
> And another:
> 
> 51.336698] CPU53: shutdown
> [  251.336737] run queue from wrong CPU 0, hctx active
> [  251.339545] run queue from wrong CPU 0, hctx active
> [  251.344695] psci: CPU53 killed (polled 0 ms)
> [  251.349302] run queue from wrong CPU 0, hctx active
> [  251.358447] run queue from wrong CPU 0, hctx active
> [  251.363336] run queue from wrong CPU 0, hctx active
> [  251.368222] run queue from wrong CPU 0, hctx active
> [  251.373108] run queue from wrong CPU 0, hctx active
> [  252.488831] CPU54: shutdown=1094MiB/s,w=0KiB/s][r=280k,w=0 IOPS][eta
> 00m:04s]
> [  252.491629] psci: CPU54 killed (polled 0 ms)
> [  252.536533] irq_shutdown irq146
> [  252.540007] CPU55: shutdown
> [  252.543273] psci: CPU55 killed (polled 0 ms)
> [  252.656656] CPU56: shutdown
> [  252.659446] psci: CPU56 killed (polled 0 ms)
> [  252.704576] CPU57: shutdown=947MiB/s,w=0KiB/s][r=242k,w=0 IOPS][eta
> 00m:02s]
> [  252.707369] psci: CPU57 killed (polled 0 ms)
> [  254.352646] CPU58: shutdown=677MiB/s,w=0KiB/s][r=173k,w=0 IOPS][eta
> 00m:02s]
> [  254.355442] psci: CPU58 killed (polled 0 ms)
> long sleep 1
> [  279.288227] scsi_times_out req=0xffff041fa10b6600[r=0,w=0 IOPS][eta
> 04m:37s]
> [  279.320281] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
> [  279.326144] sas: trying to find task 0x00000000e8dca422
> [  279.331379] sas: sas_scsi_find_task: aborting task 0x00000000e8dca422
> 
> none scheduler seems ok.

Can you reproduce it by just applying the patch of 'blk-mq: don't fail driver tag
allocation because of inactive hctx'?

If yes, can you collect debugfs log after the timeout is triggered?


Thanks,
Ming

