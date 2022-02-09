Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E25C433FE
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 09:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiBIJgL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:36:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbiBIJb4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 04:31:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5327E050454
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 01:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644399006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+f49HYfvOq4pp++V+cmR2umoJ7/kaI9zIXcwqJCA6qM=;
        b=AjlRUkoFvWBwHd+tJsFYlpSqTAZo3fRWwfQNgQyUhGuYU7kwv2pxuH5diLh3faeaXdvK2T
        AsiXvChmc7DBEjmg+2Hghp/xkNqadYxY9C7mJef504ga3KuYVwOMDy0pttcgo5rTo+90KK
        NWaiqBGWitX6GlkrkM1fa5AJzaF44No=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-Xc813yjfPK6BA3nUfaTzmQ-1; Wed, 09 Feb 2022 04:15:32 -0500
X-MC-Unique: Xc813yjfPK6BA3nUfaTzmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1EA1835B4C;
        Wed,  9 Feb 2022 09:15:30 +0000 (UTC)
Received: from localhost (ovpn-8-35.pek2.redhat.com [10.72.8.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB8A428570;
        Wed,  9 Feb 2022 09:15:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 6/7] block: don't try to throttle split bio if iops limit isn't set
Date:   Wed,  9 Feb 2022 17:14:28 +0800
Message-Id: <20220209091429.1929728-7-ming.lei@redhat.com>
In-Reply-To: <20220209091429.1929728-1-ming.lei@redhat.com>
References: <20220209091429.1929728-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
index 6f2a8e7801fe..7969d9a29830 100644
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

