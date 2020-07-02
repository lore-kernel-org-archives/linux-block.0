Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E621C433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 11:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42FDA20780
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 11:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQjuaLwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgGBLtH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:49:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36061 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726343AbgGBLtH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 07:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593690545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q9M1TLKMtvlPDldlAVmJHCPDZs8WYYDndt+r12pUPNw=;
        b=TQjuaLwZ27rJX39rCgam3Knrnz349tUfVO2CgQI5qNtS+8Yw+yf6WPa3RPA73/xK1To2qa
        wmiGRqScm1LbzMJ8JGbLista3ehU5meZK9FWuqWjuHlVG2n7RX47gkdyhYIamZo0pNhMMt
        Rh32VvYBW+chVXZHW3+Nf8hd+9+yj6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-I7aiXS95O6ubWE0We5xHgg-1; Thu, 02 Jul 2020 07:49:01 -0400
X-MC-Unique: I7aiXS95O6ubWE0We5xHgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B9E31940921;
        Thu,  2 Jul 2020 11:48:59 +0000 (UTC)
Received: from T590 (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 094EA7788F;
        Thu,  2 Jul 2020 11:48:52 +0000 (UTC)
Date:   Thu, 2 Jul 2020 19:48:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] blk-mq: put driver tag when this request is completed
Message-ID: <20200702114848.GE2452799@T590>
References: <20200629094759.2002708-1-ming.lei@redhat.com>
 <CGME20200701130104eucas1p1f8dcce58bf704b726aee1e89980fe19e@eucas1p1.samsung.com>
 <57fb09b1-54ba-f3aa-f82c-d709b0e6b281@samsung.com>
 <20200701134512.GA2443512@T590>
 <2fcd389f-b341-7cd1-692b-8c9d1918198a@samsung.com>
 <20200702012231.GA2452799@T590>
 <1dd1fc85-fa46-29fd-5aaa-06f29440e8f4@samsung.com>
 <20200702092320.GD2452799@T590>
 <5acf69fb-04b2-8649-1fc4-2cfe8aa8b9c7@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5acf69fb-04b2-8649-1fc4-2cfe8aa8b9c7@samsung.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 02, 2020 at 12:19:08PM +0200, Marek Szyprowski wrote:
> On 02.07.2020 11:23, Ming Lei wrote:
> > On Thu, Jul 02, 2020 at 10:04:38AM +0200, Marek Szyprowski wrote:
> >> On 02.07.2020 03:22, Ming Lei wrote:
> >>> On Wed, Jul 01, 2020 at 04:16:32PM +0200, Marek Szyprowski wrote:
> >>>> On 01.07.2020 15:45, Ming Lei wrote:
> >>>>> On Wed, Jul 01, 2020 at 03:01:03PM +0200, Marek Szyprowski wrote:
> >>>>>> On 29.06.2020 11:47, Ming Lei wrote:
> >>>>>>> It is natural to release driver tag when this request is completed by
> >>>>>>> LLD or device since its purpose is for LLD use.
> >>>>>>>
> >>>>>>> One big benefit is that the released tag can be re-used quicker since
> >>>>>>> bio_endio() may take too long.
> >>>>>>>
> >>>>>>> Meantime we don't need to release driver tag for flush request.
> >>>>>>>
> >>>>>>> Cc: Christoph Hellwig <hch@lst.de>
> >>>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>>>>> This patch landed recently in linux-next as commit 36a3df5a4574. Sadly
> >>>>>> it causes a regression on one of my test systems (ARM 32bit, Samsung
> >>>>>> Exynos5422 SoC based Odroid XU3 board with eMMC). The system boots fine
> >>>>>> and then after a few seconds every executed command hangs. No
> >>>>>> panic/ops/any other message. I will try to provide more information asap
> >>>>>> I find something to share. Simple reverting it in linux-next is not
> >>>>>> possible due to dependencies.
> >>>>> What is the exact eMMC's driver code(include the host driver)?
> >>>> dwmmc-exynos (drivers/mmc/host/dw_mmc-exynos.c)
> >>> Hi,
> >>>
> >>> Just take a quick look at mmc code, there are only two req->tag
> >>> consumers:
> >>>
> >>> 1) cqhci_tag
> >>> cqhci_tag
> >>> 	cqhci_request
> >>> 		host->cqe_ops->cqe_request
> >>> 			mmc_cqe_start_req
> >>> 	cqhci_timeout
> >>>
> >>> 2) mmc_hsq_request
> >>> mmc_hsq_request
> >>> 	host->cqe_ops->cqe_request
> >>> 		mmc_cqe_start_req
> >>>
> >>> mmc_cqe_start_req() is called before issuing this request to hardware,
> >>> so completion won't happen when the tag is used in mmc_cqe_start_req().
> >>>
> >>> cqhci_timeout() may race with normal completion, however looks the
> >>> following code can handle the race correctly:
> >>>
> >>>           spin_lock_irqsave(&cq_host->lock, flags);
> >>>           timed_out = slot->mrq == mrq;
> >>>
> >>> So still no idea why the commit causes the trouble for mmc.
> >>>
> >>> Do you know it is cqhci or mmc_hsh which works for dw_mmc-exynos?
> >>> And can you apply the following patch and see if warning can be
> >>> triggered?
> >>>
> >>> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> >>> index 75934f3c117e..2cb49ecfbf34 100644
> >>> --- a/drivers/mmc/host/cqhci.c
> >>> +++ b/drivers/mmc/host/cqhci.c
> >>> @@ -612,6 +612,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >>>    		goto out_unlock;
> >>>    	}
> >>>    
> >>> +	WARN_ON_ONCE(cq_host->slot[tag].mrq);
> >>>    	cq_host->slot[tag].mrq = mrq;
> >>>    	cq_host->slot[tag].flags = 0;
> >>>    
> >>> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> >>> index a5e05ed0fda3..11a4c1f3a970 100644
> >>> --- a/drivers/mmc/host/mmc_hsq.c
> >>> +++ b/drivers/mmc/host/mmc_hsq.c
> >>> @@ -227,6 +227,7 @@ static int mmc_hsq_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >>>    		return -EBUSY;
> >>>    	}
> >>>    
> >>> +	WARN_ON_ONCE(hsq->slot[tag].mrq);
> >>>    	hsq->slot[tag].mrq = mrq;
> >>>    
> >>>    	/*
> >> None of the above is even compiled for my system (I'm using
> >> arm/exynos_defconfig), so this must be something else.
> > Hello Marek,
> >
> > Or can you boot the system with one workable disk(usb, nand, ...)?
> > then run some IO test on this eMMC, and collect debugfs log via the following
> > command after the hang is triggered:
> >
> > (cd /sys/kernel/debug/block/$MMC && find . -type f -exec grep -aH . {} \;)
> >
> > $MMC is this mmc disk name.
> 
> 
> I hope it helps.

It does help, :-)

Thanks for collecting the log, now I understood the reason: flush
request's driver tag is leaked in case that request isn't done via
blk_mq_complete_request(), such as freed via blk_mq_end_request()
directly.

Please try the following patch, which should have been one two-line
change if the driver tag cleanup patch isn't merged.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ebab8f1044cb..7d62e9e5972e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -532,6 +532,26 @@ void blk_mq_free_request(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_free_request);
 
+static void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
+		struct request *rq)
+{
+	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
+	rq->tag = BLK_MQ_NO_TAG;
+
+	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
+		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
+		atomic_dec(&hctx->nr_active);
+	}
+}
+
+static inline void blk_mq_put_driver_tag(struct request *rq)
+{
+	if (rq->tag == BLK_MQ_NO_TAG || rq->internal_tag == BLK_MQ_NO_TAG)
+		return;
+
+	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
+}
+
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 {
 	u64 now = 0;
@@ -551,6 +571,7 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 
 	if (rq->end_io) {
 		rq_qos_done(rq->q, rq);
+		blk_mq_put_driver_tag(rq);
 		rq->end_io(rq, error);
 	} else {
 		blk_mq_free_request(rq);
@@ -862,26 +883,6 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 	return cpu_online(rq->mq_ctx->cpu);
 }
 
-static void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
-		struct request *rq)
-{
-	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
-	rq->tag = BLK_MQ_NO_TAG;
-
-	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
-		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
-		atomic_dec(&hctx->nr_active);
-	}
-}
-
-static inline void blk_mq_put_driver_tag(struct request *rq)
-{
-	if (rq->tag == BLK_MQ_NO_TAG || rq->internal_tag == BLK_MQ_NO_TAG)
-		return;
-
-	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
-}
-
 bool blk_mq_complete_request_remote(struct request *rq)
 {
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
@@ -1185,9 +1186,10 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	if (blk_mq_req_expired(rq, next))
 		blk_mq_rq_timed_out(rq, reserved);
 
-	if (is_flush_rq(rq, hctx))
+	if (is_flush_rq(rq, hctx)) {
+		blk_mq_put_driver_tag(rq);
 		rq->end_io(rq, 0);
-	else if (refcount_dec_and_test(&rq->ref))
+	} else if (refcount_dec_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
 
 	return true;

Thanks,
Ming

