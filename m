Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41857C433F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 11:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbiAKL46 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:56:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239321AbiAKL45 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 06:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641902217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQhSQqHFxKMB8HA7vySD8azIrZx1JLQjZxcZY6XwKPY=;
        b=VpTbIIicGMcuij2KkXBZLlrU2/rS+EtN7NMQmbXDqdG4Aex7r6VMh/0EUelEdlfq2PXQma
        8o7YPi3c17NPzx4xmZ1WY7XKmfiRtKwBUZKoGYtSOLrW8IW0MQTMUiA5yr5TfidCIArXci
        pcpk4UKJmaxBPmrb1OvDN8wPBLUF/f0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-7qAJLVwqMOKkWsLSefWwew-1; Tue, 11 Jan 2022 06:56:55 -0500
X-MC-Unique: 7qAJLVwqMOKkWsLSefWwew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8352363A5;
        Tue, 11 Jan 2022 11:56:54 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0EAA7AB70;
        Tue, 11 Jan 2022 11:56:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 6/7] block: don't try to throttle split bio if iops limit isn't set
Date:   Tue, 11 Jan 2022 19:55:31 +0800
Message-Id: <20220111115532.497117-7-ming.lei@redhat.com>
In-Reply-To: <20220111115532.497117-1-ming.lei@redhat.com>
References: <20220111115532.497117-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need to throttle split bio in case of IOPS limit even though the
split bio has been marked as BIO_THROTTLED since block layer
accounts split bio actually.

If only throughput throttle is setup, no need to throttle any more
if BIO_THROTTLED is set since we have accounted & considered the
whole bio bytes already.

Add one flag of THROTL_TG_HAS_IOPS_LIMIT for serving this purpose.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-throttle.c | 21 ++++++++++++++-------
 block/blk-throttle.h | 11 +++++++++++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 67bb39d13751..36c17fcb67ef 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -42,11 +42,6 @@
 /* A workqueue to queue throttle related work */
 static struct workqueue_struct *kthrotld_workqueue;
 
-enum tg_state_flags {
-	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
-	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
-};
-
 #define rb_entry_tg(node)	rb_entry((node), struct throtl_grp, rb_node)
 
 /* We measure latency for request size from <= 4k to >= 1M */
@@ -426,12 +421,24 @@ static void tg_update_has_rules(struct throtl_grp *tg)
 	struct throtl_grp *parent_tg = sq_to_tg(tg->service_queue.parent_sq);
 	struct throtl_data *td = tg->td;
 	int rw;
+	int has_iops_limit = 0;
+
+	for (rw = READ; rw <= WRITE; rw++) {
+		unsigned int iops_limit = tg_iops_limit(tg, rw);
 
-	for (rw = READ; rw <= WRITE; rw++)
 		tg->has_rules[rw] = (parent_tg && parent_tg->has_rules[rw]) ||
 			(td->limit_valid[td->limit_index] &&
 			 (tg_bps_limit(tg, rw) != U64_MAX ||
-			  tg_iops_limit(tg, rw) != UINT_MAX));
+			  iops_limit != UINT_MAX));
+
+		if (iops_limit != UINT_MAX)
+			has_iops_limit = 1;
+	}
+
+	if (has_iops_limit)
+		tg->flags |= THROTL_TG_HAS_IOPS_LIMIT;
+	else
+		tg->flags &= ~THROTL_TG_HAS_IOPS_LIMIT;
 }
 
 static void throtl_pd_online(struct blkg_policy_data *pd)
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index cb43f4417d6e..c996a15f290e 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -52,6 +52,12 @@ struct throtl_service_queue {
 	struct timer_list	pending_timer;	/* fires on first_pending_disptime */
 };
 
+enum tg_state_flags {
+	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
+	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
+	THROTL_TG_HAS_IOPS_LIMIT = 1 << 2,	/* tg has iops limit */
+};
+
 enum {
 	LIMIT_LOW,
 	LIMIT_MAX,
@@ -170,6 +176,11 @@ static inline bool blk_throtl_bio(struct bio *bio)
 {
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
 
+	/* no need to throttle bps any more if the bio has been throttled */
+	if (bio_flagged(bio, BIO_THROTTLED) &&
+	    !(tg->flags & THROTL_TG_HAS_IOPS_LIMIT))
+		return false;
+
 	if (!tg->has_rules[bio_data_dir(bio)])
 		return false;
 
-- 
2.31.1

