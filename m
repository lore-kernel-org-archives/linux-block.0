Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724F8C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 03:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiBODdE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 22:33:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiBODdE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 22:33:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1C8510D7
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 19:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644895974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZtF+r8S7Hh3Pn4qleBKAT5X5XE9E8ZOi6DYxapO2M0c=;
        b=FE8pGjhpt8eA26309Ap1JWA9E/P/PDVEa94nIdPGMb8wv7FJEkc4D+0qSnij5kMZ7xm7lS
        4m4d2BFt+Y5BvAkmUf4NOb4HxYrxjgnAQBJQySJBc/W37kZB+UXYy91VnxcBEYSvFABA/K
        DpxoKSZKRPUwG6P1+zjx9/Kt11XbH1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-_Vl1PM-tP8KwknyZlFaJpQ-1; Mon, 14 Feb 2022 22:32:51 -0500
X-MC-Unique: _Vl1PM-tP8KwknyZlFaJpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67D2A801B26;
        Tue, 15 Feb 2022 03:32:50 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E060E2FF;
        Tue, 15 Feb 2022 03:32:40 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 3/8] block: don't declare submit_bio_checks in local header
Date:   Tue, 15 Feb 2022 11:30:45 +0800
Message-Id: <20220215033050.2730533-4-ming.lei@redhat.com>
In-Reply-To: <20220215033050.2730533-1-ming.lei@redhat.com>
References: <20220215033050.2730533-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

submit_bio_checks() won't be called outside of block/blk-core.c any more
since commit 9d497e2941c3 ("block: don't protect submit_bio_checks by
q_usage_counter"), so mark it as one local helper.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 2 +-
 block/blk.h      | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f03fff1fa391..5248b94d276b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -676,7 +676,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
-noinline_for_stack bool submit_bio_checks(struct bio *bio)
+static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 {
 	struct block_device *bdev = bio->bi_bdev;
 	struct request_queue *q = bdev_get_queue(bdev);
diff --git a/block/blk.h b/block/blk.h
index abb663a2a147..b2516cb4f98e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -46,7 +46,6 @@ void blk_freeze_queue(struct request_queue *q);
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
-bool submit_bio_checks(struct bio *bio);
 
 static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
 {
-- 
2.31.1

