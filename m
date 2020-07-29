Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED367C433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 07:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9BA62070B
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 07:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iz2Cuw5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgG2HbM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:31:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37412 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbgG2HbL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 03:31:11 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2020 03:31:11 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596007870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3foE0LkaAlnk0uqfr+bTHhjFNHKvfxTqTgK+wwWji9A=;
        b=iz2Cuw5diK8vGJC7Y10HTTNFFhzASJUjEusdyYyaBle87Ebp2+O0uhM24L+H4S/Nd7MCjy
        r3QyTv998lesrFRk8f67srCOLTb0jv686xDIS5xxC4qatkhG3H5vRquEEgYIQm8Mtcphkb
        zL0AUyKe12AWyUigxg4vlfEWQup9oII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-iPKrqgIzOgG0sfT1uvVuvg-1; Wed, 29 Jul 2020 03:25:00 -0400
X-MC-Unique: iPKrqgIzOgG0sfT1uvVuvg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F6CE106B24C;
        Wed, 29 Jul 2020 07:24:59 +0000 (UTC)
Received: from localhost (ovpn-12-176.pek2.redhat.com [10.72.12.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 308D61B47B;
        Wed, 29 Jul 2020 07:24:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH] blk-mq: insert request not through ->queue_rq into sw/scheduler queue
Date:   Wed, 29 Jul 2020 15:24:49 +0800
Message-Id: <20200729072449.1583785-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Mike Snitzer <snitzer@redhat.com>
Fixes: c616cbee97ae ("blk-mq: punt failed direct issue to dispatch list")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c3856377b961..b356d4d3ca0b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2016,7 +2016,8 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
 
-	blk_mq_request_bypass_insert(rq, false, run_queue);
+	blk_mq_sched_insert_request(rq, false, run_queue, false);
+
 	return BLK_STS_OK;
 }
 
-- 
2.25.2

