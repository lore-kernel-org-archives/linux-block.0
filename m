Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B589DC47084
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AA8613F9
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhEYIKt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 04:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232068AbhEYIJb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 04:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621930081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpQvygM4A4vD4Zy53pCStXst8N61R+JjxoV1ijH7X/4=;
        b=XZoEktfEorA2Xytl4aIPKFAnb4K1y6gpKcrunStVEMh7qpxGgKOVuHqVxQoxBBRVqPo3Zd
        o2AHC13TDy79hv66JJxLFMnqX4PxhlCFzmaEJAa2PJ/c0bSa5colpm+PQFniKWmBpBMzif
        fK/zGvDhanGrzd/Ywtxm1ChwAd3P83I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-TfGiloOrPRqr_9JyCF1HzQ-1; Tue, 25 May 2021 04:04:59 -0400
X-MC-Unique: TfGiloOrPRqr_9JyCF1HzQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8245781871A;
        Tue, 25 May 2021 08:04:58 +0000 (UTC)
Received: from localhost (ovpn-13-203.pek2.redhat.com [10.72.13.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA8236C332;
        Tue, 25 May 2021 08:04:57 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH 1/4] block: split wbt_init() into two parts
Date:   Tue, 25 May 2021 16:04:39 +0800
Message-Id: <20210525080442.1896417-2-ming.lei@redhat.com>
In-Reply-To: <20210525080442.1896417-1-ming.lei@redhat.com>
References: <20210525080442.1896417-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split wbt_init() into wbt_alloc() and wbt_init(), and prepare for
moving wbt allocation into blk_alloc_queue().

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-wbt.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 42aed0160f86..efff1232446f 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -809,7 +809,7 @@ static struct rq_qos_ops wbt_rqos_ops = {
 #endif
 };
 
-int wbt_init(struct request_queue *q)
+static int wbt_alloc(struct request_queue *q)
 {
 	struct rq_wb *rwb;
 	int i;
@@ -832,7 +832,6 @@ int wbt_init(struct request_queue *q)
 	rwb->rqos.q = q;
 	rwb->last_comp = rwb->last_issue = jiffies;
 	rwb->win_nsec = RWB_WINDOW_NSEC;
-	rwb->enable_state = WBT_STATE_ON_DEFAULT;
 	rwb->wc = 1;
 	rwb->rq_depth.default_depth = RWB_DEF_DEPTH;
 
@@ -842,6 +841,19 @@ int wbt_init(struct request_queue *q)
 	rq_qos_add(q, &rwb->rqos);
 	blk_stat_add_callback(q, rwb->cb);
 
+	return 0;
+}
+
+int wbt_init(struct request_queue *q)
+{
+	int ret = wbt_alloc(q);
+	struct rq_wb *rwb;
+
+	if (ret)
+		return ret;
+
+	rwb = RQWB(wbt_rq_qos(q));
+	rwb->enable_state = WBT_STATE_ON_DEFAULT;
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
 
 	wbt_queue_depth_changed(&rwb->rqos);
-- 
2.29.2

