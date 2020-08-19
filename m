Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C190C433E1
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 08:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07886206FA
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 08:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tb740Kdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHSI67 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbgHSI66 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 04:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597827537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FmRITmH257tbUw9Gz6jA6YfZV7mLy0QGH/xWvkTSpM8=;
        b=Tb740KdgssN4Fmd7qS32UDFxRi0xAHGd3ru6gGGprCfwOO97jSaRT3/fic1rezP1+SzHuf
        6RaJiC6DO3SBc0rdi0G1RA3U13UKBcB7c1ZqDJOelMB4EIeEcqAKho/QzbjOp9o/pKyUPY
        eoJZEjpTiffiE9Nf04VLFUISQlbjH3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-lAMrHoj9PK2M0U0Oz6-rvg-1; Wed, 19 Aug 2020 04:58:55 -0400
X-MC-Unique: lAMrHoj9PK2M0U0Oz6-rvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62781100CF6F;
        Wed, 19 Aug 2020 08:58:54 +0000 (UTC)
Received: from T590 (ovpn-12-56.pek2.redhat.com [10.72.12.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B8355D9E8;
        Wed, 19 Aug 2020 08:58:47 +0000 (UTC)
Date:   Wed, 19 Aug 2020 16:58:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [REPORT] BUG: KASAN: use-after-free in bt_iter+0x80/0xf8
Message-ID: <20200819085843.GA2730150@T590>
References: <8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com>
 <a68379af-48e7-da2b-812c-ff0fa24a41bb@huawei.com>
 <20200819000009.GB2712797@T590>
 <585bb054-2009-4abc-f1e8-802e494ba49b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <585bb054-2009-4abc-f1e8-802e494ba49b@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 19, 2020 at 08:43:46AM +0100, John Garry wrote:
> On 19/08/2020 01:00, Ming Lei wrote:
> > On Tue, Aug 18, 2020 at 07:19:57PM +0100, John Garry wrote:
> > > On 18/08/2020 13:03, John Garry wrote:
> > > > Hi guys,
> > > > 
> > > > JFYI, While doing some testing on v5.9-rc1, I stumbled across this:
> > > 
> > > I bisected to here (hopefully without mistake):
> > 
> > This one is a long-term problem, see the following discussion:
> > 
> > https://lore.kernel.org/linux-block/1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com/
> > 
> > 
> 
> ah, right. I vaguely remember this. Well, if we didn't have a reliable
> reproducer before, we do now.

OK, that is great, please try the following patch:

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 32d82e23b095..f18632c524e9 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -185,19 +185,19 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
 	struct bt_iter_data *iter_data = data;
 	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
-	struct blk_mq_tags *tags = hctx->tags;
+	struct blk_mq_tags *tags = hctx->sched_tags ?: hctx->tags;
 	bool reserved = iter_data->reserved;
 	struct request *rq;
 
 	if (!reserved)
 		bitnr += tags->nr_reserved_tags;
-	rq = tags->rqs[bitnr];
+	rq = tags->static_rqs[bitnr];
 
 	/*
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assigning ->rqs[].
 	 */
-	if (rq && rq->q == hctx->queue)
+	if (rq && rq->tag >= 0 && rq->q == hctx->queue)
 		return iter_data->fn(hctx, rq, iter_data->data, reserved);
 	return true;
 }
@@ -406,7 +406,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		return;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		struct blk_mq_tags *tags = hctx->tags;
+		struct blk_mq_tags *tags = hctx->sched_tags ?: hctx->tags;
 
 		/*
 		 * If no software queues are currently mapped to this

-- 
Ming

