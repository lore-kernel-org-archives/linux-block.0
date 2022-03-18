Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45704C433F5
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 13:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbiCRNDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiCRNDo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 09:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD5FE2DC022
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647608544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSKD6TVVLBfElgNGy3gSizYgmiFKMdv8ME14euUYNXE=;
        b=c5Np3/kg25wX8xLRRbAeAALkvucEuA8oaFoWxIltv1e4SX9hGcPbF0jjV5aFYVFBwPtEZs
        DESSBrEXmLxjri3T6WTcz3OSpilfVjfgW5qlscSD1DZ9IZeIlAczMRE69uKvhGE48GrKBs
        ypvvsEHNUdjY1dTebxPVx7sBsJStAxU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-yDAA2dgVPq-IBHYNNRju5Q-1; Fri, 18 Mar 2022 09:02:19 -0400
X-MC-Unique: yDAA2dgVPq-IBHYNNRju5Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17F3F811E76;
        Fri, 18 Mar 2022 13:02:19 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A16257ECEE;
        Fri, 18 Mar 2022 13:02:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] block: avoid use-after-free on throttle data
Date:   Fri, 18 Mar 2022 21:01:42 +0800
Message-Id: <20220318130144.1066064-2-ming.lei@redhat.com>
In-Reply-To: <20220318130144.1066064-1-ming.lei@redhat.com>
References: <20220318130144.1066064-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In throtl_pending_timer_fn(), request queue is retrieved from throttle
data. And tg's pending timer is deleted synchronously when releasing the
associated blkg, at that time, throttle data may have been freed since
commit 1059699f87eb ("block: move blkcg initialization/destroy into disk
allocation/release handler") moves freeing q->td to disk_release() from
blk_release_queue(). So use-after-free on q->td in throtl_pending_timer_fn
can be triggered.

Fixes the issue by:

- do nothing in case that disk is released, when there isn't any bio to
  dispatch

- retrieve request queue from blkg instead of throttle data for
non top-level pending timer.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-throttle.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a3b3ebc72dd4..880701d0106f 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1137,12 +1137,22 @@ static void throtl_pending_timer_fn(struct timer_list *t)
 	struct throtl_service_queue *sq = from_timer(sq, t, pending_timer);
 	struct throtl_grp *tg = sq_to_tg(sq);
 	struct throtl_data *td = sq_to_td(sq);
-	struct request_queue *q = td->queue;
 	struct throtl_service_queue *parent_sq;
+	struct request_queue *q;
 	bool dispatched;
 	int ret;
 
+	/* throtl_data may be gone, so figure out request queue by blkg */
+	if (tg)
+		q = tg->pd.blkg->q;
+	else
+		q = td->queue;
+
 	spin_lock_irq(&q->queue_lock);
+
+	if (!q->root_blkg)
+		goto out_unlock;
+
 	if (throtl_can_upgrade(td, NULL))
 		throtl_upgrade_state(td);
 
-- 
2.31.1

