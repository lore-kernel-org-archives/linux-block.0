Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FF3C433E3
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 09:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74CBE20789
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 09:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DupGzWTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgHRJHs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:07:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgHRJHr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 05:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597741665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=90aytXshNzFlEjZu5hoUoVWjo6ncKLCk5+Ku2CJoPIQ=;
        b=DupGzWTraogKIWLnb7dKDP78FWp6OlIIqojHHLgSN58S2E8DQOPbAze7QduHvD/0EsvzzI
        zgfLglmQzgMF9LoXPI8zx20tj/aeUxHRQnWZqN47sam2q2ok1B/vkj8Zsx87v7IFmqRwIc
        Moc2VraNmPzVvvfmJ92Lv2SJ79+KGXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-Jk1ROl42MXSRjzbmw39EbA-1; Tue, 18 Aug 2020 05:07:44 -0400
X-MC-Unique: Jk1ROl42MXSRjzbmw39EbA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D885381F022;
        Tue, 18 Aug 2020 09:07:42 +0000 (UTC)
Received: from localhost (ovpn-13-119.pek2.redhat.com [10.72.13.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26BD610098AE;
        Tue, 18 Aug 2020 09:07:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH RESEND] blk-mq: insert request not through ->queue_rq into sw/scheduler queue
Date:   Tue, 18 Aug 2020 17:07:28 +0800
Message-Id: <20200818090728.2696802-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

c616cbee97ae ("blk-mq: punt failed direct issue to dispatch list") supposed
to add request which has been through ->queue_rq() to the hw queue dispatch
list, however it adds request running out of budget or driver tag to hw queue
too. This way basically bypasses request merge, and causes too many request
dispatched to LLD, and system% is unnecessary increased.

Fixes this issue by adding request not through ->queue_rq into sw/scheduler
queue, and this way is safe because no ->queue_rq is called on this request
yet.

High %system can be observed on Azure storvsc device, and even soft lock
is observed. This patch reduces %system during heavy sequential IO,
meantime decreases soft lockup risk.

Fixes: c616cbee97ae ("blk-mq: punt failed direct issue to dispatch list")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ac80bfac325..f50c38ccac3c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2039,7 +2039,8 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
 
-	blk_mq_request_bypass_insert(rq, false, run_queue);
+	blk_mq_sched_insert_request(rq, false, run_queue, false);
+
 	return BLK_STS_OK;
 }
 
-- 
2.25.2

