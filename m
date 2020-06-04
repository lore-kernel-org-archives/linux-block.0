Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F0BC433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 12:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA27A206E6
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 12:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxHKNGlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgFDMIg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:08:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53187 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728024AbgFDMIf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 08:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591272513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sDqh2aYfOa5VGAO8vBMA4ql1kGqUY2JylfyA9K3Mcz8=;
        b=PxHKNGlKtCta2eBI0p0NULzDhCAZZ/H6stBgglrzz1rgAO/95c2gyg/8kWF4hOTugR5OTB
        RN01z/sBNdErV1jcyBtGPDkZIWwvP3OAzQWgSzZMnVDBRvcKvDYwzYCiUULh6QOEHjH9K6
        1CcKGJxyujvegEJI6DvVLTWAFSRjcm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-mhe-ARdUMjeAFEXGZyYl3Q-1; Thu, 04 Jun 2020 08:08:29 -0400
X-MC-Unique: mhe-ARdUMjeAFEXGZyYl3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 351AC1005510;
        Thu,  4 Jun 2020 12:08:28 +0000 (UTC)
Received: from T590 (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F97F5C6D9;
        Thu,  4 Jun 2020 12:08:20 +0000 (UTC)
Date:   Thu, 4 Jun 2020 20:08:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
Message-ID: <20200604120747.GB2336493@T590>
References: <20200603105128.2147139-1-ming.lei@redhat.com>
 <20200603115347.GA8653@lst.de>
 <20200603133608.GA2149752@T590>
 <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
 <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com>
 <b37b1f30-722b-4767-0627-103b94c7421c@huawei.com>
 <20200604112615.GA2336493@T590>
 <7291fd02-3c2c-f3f9-f3eb-725cd85d5523@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7291fd02-3c2c-f3f9-f3eb-725cd85d5523@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 04, 2020 at 12:50:32PM +0100, John Garry wrote:
> On 04/06/2020 12:26, Ming Lei wrote:
> > > And another:
> > > 
> > > 51.336698] CPU53: shutdown
> > > [  251.336737] run queue from wrong CPU 0, hctx active
> > > [  251.339545] run queue from wrong CPU 0, hctx active
> > > [  251.344695] psci: CPU53 killed (polled 0 ms)
> > > [  251.349302] run queue from wrong CPU 0, hctx active
> > > [  251.358447] run queue from wrong CPU 0, hctx active
> > > [  251.363336] run queue from wrong CPU 0, hctx active
> > > [  251.368222] run queue from wrong CPU 0, hctx active
> > > [  251.373108] run queue from wrong CPU 0, hctx active
> > > [  252.488831] CPU54: shutdown=1094MiB/s,w=0KiB/s][r=280k,w=0 IOPS][eta
> > > 00m:04s]
> > > [  252.491629] psci: CPU54 killed (polled 0 ms)
> > > [  252.536533] irq_shutdown irq146
> > > [  252.540007] CPU55: shutdown
> > > [  252.543273] psci: CPU55 killed (polled 0 ms)
> > > [  252.656656] CPU56: shutdown
> > > [  252.659446] psci: CPU56 killed (polled 0 ms)
> > > [  252.704576] CPU57: shutdown=947MiB/s,w=0KiB/s][r=242k,w=0 IOPS][eta
> > > 00m:02s]
> > > [  252.707369] psci: CPU57 killed (polled 0 ms)
> > > [  254.352646] CPU58: shutdown=677MiB/s,w=0KiB/s][r=173k,w=0 IOPS][eta
> > > 00m:02s]
> > > [  254.355442] psci: CPU58 killed (polled 0 ms)
> > > long sleep 1
> > > [  279.288227] scsi_times_out req=0xffff041fa10b6600[r=0,w=0 IOPS][eta
> > > 04m:37s]
> > > [  279.320281] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
> > > [  279.326144] sas: trying to find task 0x00000000e8dca422
> > > [  279.331379] sas: sas_scsi_find_task: aborting task 0x00000000e8dca422
> > > 
> > > none scheduler seems ok.
> > Can you reproduce it by just applying the patch of 'blk-mq: don't fail driver tag
> > allocation because of inactive hctx'?
> 
> That's your patch - ok, I can try.
> 
> So I added some debug for when using Christoph's:
> 
> static bool blk_mq_hctx_has_requests2(struct blk_mq_hw_ctx *hctx)
> {
> 	struct blk_mq_tags *tags = hctx->tags;
> 	struct rq_iter_data data = {
> 		.hctx	= hctx,
> 	};
> 
> 	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
> 	return data.has_rq;
> }
> 
> 
> static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
> 		struct blk_mq_hw_ctx *hctx)
> {
> @@ -2386,6 +2398,8 @@ static int blk_mq_hctx_notify_offline(unsigned int
> cpu, struct hlist_node *node)
> 	if (percpu_ref_tryget(&hctx->queue->q_usage_counter)) {
> 		while (blk_mq_hctx_has_requests(hctx))
> 			msleep(5);
> +		if (blk_mq_hctx_has_requests2(hctx))
> +			pr_err("%s still has driver tag - but how? hctx->sched_tags=%pS\n",
> __func__, hctx->sched_tags);
> 		percpu_ref_put(&hctx->queue->q_usage_counter);
> 	} else {
> 
> And I get this:
> 
> [  366.839260] CPU46: shutdown
> [  366.842052] psci: CPU46 killed (polled 0 ms)
> [  366.910923] blk_mq_hctx_notify_offline still has driver tag - but how?
> hctx->sched_tags=0xffff041fa59e0d00
> [  366.920870] irq_migrate_all_off_this_cpu: 5 callbacks suppressed
> [  366.920871] IRQ 113: no longer affine to CPU47
> [  366.931299] IRQ 116: no longer affine to CPU47
> [  366.935734] IRQ 119: no longer affine to CPU47
> [  366.940169] IRQ 123: no longer affine to CPU47
> [  366.944607] irq_shutdown irq144
> [  366.947783] IRQ 330: no longer affine to CPU47
> [  366.952217] IRQ 333: no longer affine to CPU47
> [  366.956651] IRQ 336: no longer affine to CPU47
> [  366.961085] IRQ 339: no longer affine to CPU47
> [  366.965519] IRQ 342: no longer affine to CPU47
> [  366.969953] IRQ 345: no longer affine to CPU47
> [  366.974475] CPU47: shutdown
> [  366.977273] psci: CPU47 killed (polled 0 ms)
> [  367.063066] CPU48: shutdown
> [  367.065857] psci: CPU48 killed (polled 0 ms)
> [  367.107071] CPU49: shutdown
> [  367.109858] psci: CPU49 killed (polled 0 ms)
> [  367.147057] CPU50: shutdown
> [  367.149843] psci: CPU50 killed (polled 0 ms)
> [  367.175006] irq_shutdown irq145
> [  367.178272] CPU51: shutdown
> [  367.181070] psci: CPU51 killed (polled 0 ms)
> [  367.223067] CPU52: shutdown
> [  367.225856] psci: CPU52 killed (polled 0 ms)
> [  367.267024] CPU53: shutdown
> [  367.269821] psci: CPU53 killed (polled 0 ms)
> [  367.303004] CPU54: shutdown
> [  367.305792] psci: CPU54 killed (polled 0 ms)
> [  367.342948] irq_shutdown irq146
> [  367.346169] CPU55: shutdown
> [  367.348965] psci: CPU55 killed (polled 0 ms)
> [  367.387004] CPU56: shutdown][16.9%][r=869MiB/s,w=0KiB/s][r=223k,w=0
> IOPS][eta 04m:59s]
> [  367.389791] psci: CPU56 killed (polled 0 ms)
> [  367.419017] CPU57: shutdown
> [  367.421804] psci: CPU57 killed (polled 0 ms)
> [  367.447010] CPU58: shutdown
> [  367.449796] psci: CPU58 killed (polled 0 ms)
> long sleep 2
> [  398.070707] scsi_times_out req=0xffff041fa1a89c00iB/s][r=0,w=0 IOPS][eta
> 04m:29s]
> 
> I thought that if all the sched tags are put, then we should have no driver
> tag for that same hctx, right? That seems to coincide with the timeout (30
> seconds later)

That is weird, if there is driver tag found, that means the request is
in-flight and can't be completed by HW. I assume you have integrated
global host tags patch in your test, and suggest you to double check
hisi_sas's queue mapping which has to be exactly same with blk-mq's
mapping.

> 
> > 
> > If yes, can you collect debugfs log after the timeout is triggered?
> 
> Same limitation as before - once SCSI timeout happens, SCSI error handling
> kicks in and the shost no longer accepts commands, and, since that same
> shost provides rootfs, becomes unresponsive. But I can try.

Just wondering why not install two disks in your test machine, :-)


Thanks,
Ming

