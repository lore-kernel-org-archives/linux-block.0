Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F124C64EC4
	for <linux-block@archiver.kernel.org>; Fri, 10 Mar 2023 01:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjCJBKm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Mar 2023 20:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCJBKm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Mar 2023 20:10:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBBAE6FD9
        for <linux-block@vger.kernel.org>; Thu,  9 Mar 2023 17:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678410601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1LmAQNxfkawZ4Zhhl1CDRfMOHINbxJRAadUkOd0oelI=;
        b=IGTREealuE3DlLsrWvJuz78ilVVtsWfV2LiePTLLm6zVTKpqAZpOIAsHbPkjLo/+VEcyPk
        X0+7fJkrGoSlowaIOakk2Wu6udlN4YIGxogxtYSSXX5elX6d/h5q/sTa31ZQhvmdB3ukBV
        Q23jFqnj8ZrksG2DpveFobgFFKSTLH4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-WquuTt9QOU-qG4bK4rd3Vw-1; Thu, 09 Mar 2023 20:09:59 -0500
X-MC-Unique: WquuTt9QOU-qG4bK4rd3Vw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36B493804064;
        Fri, 10 Mar 2023 01:09:59 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C08E40BC781;
        Fri, 10 Mar 2023 01:09:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Chris Leech <cleech@redhat.com>,
        Marco Patalano <mpatalan@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] blk-mq: fix "bad unlock balance detected" on q->srcu in __blk_mq_run_dispatch_ops
Date:   Fri, 10 Mar 2023 09:09:13 +0800
Message-Id: <20230310010913.1014789-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chris Leech <cleech@redhat.com>

The 'q' parameter of the macro __blk_mq_run_dispatch_ops may not be one
local variable, such as, it is rq->q, then request queue pointed by
this variable could be changed to another queue in case of
BLK_MQ_F_TAG_QUEUE_SHARED after 'dispatch_ops' returns, then
'bad unlock balance' is triggered.

Fixes the issue by adding one local variable for doing srcu lock/unlock.

Fixes: 2a904d00855f ("blk-mq: remove hctx_lock and hctx_unlock")
Cc: Marco Patalano <mpatalan@redhat.com>
Signed-off-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index ef59fee62780..a7482d2cc82e 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -378,12 +378,13 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops)	\
 do {								\
 	if ((q)->tag_set->flags & BLK_MQ_F_BLOCKING) {		\
+		struct blk_mq_tag_set *__tag_set = (q)->tag_set; \
 		int srcu_idx;					\
 								\
 		might_sleep_if(check_sleep);			\
-		srcu_idx = srcu_read_lock((q)->tag_set->srcu);	\
+		srcu_idx = srcu_read_lock(__tag_set->srcu);	\
 		(dispatch_ops);					\
-		srcu_read_unlock((q)->tag_set->srcu, srcu_idx);	\
+		srcu_read_unlock(__tag_set->srcu, srcu_idx);	\
 	} else {						\
 		rcu_read_lock();				\
 		(dispatch_ops);					\
-- 
2.39.2

