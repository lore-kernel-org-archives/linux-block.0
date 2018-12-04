Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3849C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEC820672
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEC820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbeLDShf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:37:35 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38360 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeLDSgI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 13:36:08 -0500
Received: by mail-yw1-f68.google.com with SMTP id i20so7397559ywc.5;
        Tue, 04 Dec 2018 10:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vqrnr706mxcuTBSv4fGe89XMxxRx6O2pZFhgxbxRlLY=;
        b=UkSzQiL8h9wa+MLt+yEB+awWsRW6rq2uG1C2zkYHL0eNdcZHoJX54qj3HUvJndKiV0
         RxujzEg2qN0sfUKc6iiMq8O1bgxKktb4WSjlvbujANaBSahlPv1hx95pCanZogEub7aA
         hzJU9sJecycIc5oqo2fae+xRXUMnUj7mAKveETeC6XctKNa3piamjBscNlvfRtHZSfAc
         rD99V2mQs1dyWKzUx+YlSQl4OXNdzZObIt8XBte0WID+plf61QwXU7exSFJlU+O2Ld1i
         rHmRhBoFieIieEPWVB2mbTrCptiHhhUHMNtgj+ym150ObdDnCEUoLam9Emvg486oQ46u
         PGSw==
X-Gm-Message-State: AA+aEWYPVPCjE0dU+1XDH9FgOV9hofblKs6/hQ8r3sYf2uuUhYzE+8wZ
        nP9BjLISmNxn8i4JqicBFis=
X-Google-Smtp-Source: AFSGD/VfGZtF1u65ewUYUg8ie7it6Lvgjl9NHIFPmnsIpK+q4ZF3rcE0fhnbaX/gqC4ojc7rtEPIeA==
X-Received: by 2002:a81:514c:: with SMTP id f73mr21318716ywb.272.1543948566576;
        Tue, 04 Dec 2018 10:36:06 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.135])
        by smtp.gmail.com with ESMTPSA id x82sm4274798ywb.34.2018.12.04.10.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 10:36:05 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 02/14] blkcg: update blkg_lookup_create() to do locking
Date:   Tue,  4 Dec 2018 13:35:48 -0500
Message-Id: <20181204183600.99746-3-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20181204183600.99746-1-dennis@kernel.org>
References: <20181204183600.99746-1-dennis@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To know when to create a blkg, the general pattern is to do a
blkg_lookup() and if that fails, lock and do the lookup again, and if
that fails finally create. It doesn't make much sense for everyone who
wants to do creation to write this themselves.

This changes blkg_lookup_create() to do locking and implement this
pattern. The old blkg_lookup_create() is renamed to
__blkg_lookup_create().  If a call site wants to do its own error
handling or already owns the queue lock, they can use
__blkg_lookup_create(). This will be used in upcoming patches.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 block/blk-cgroup.c         | 28 +++++++++++++++++++++++++---
 block/blk-iolatency.c      |  2 +-
 include/linux/blk-cgroup.h |  4 +++-
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 63d226a084cd..b421a9457e05 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -249,7 +249,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 }
 
 /**
- * blkg_lookup_create - lookup blkg, try to create one if not there
+ * __blkg_lookup_create - lookup blkg, try to create one if not there
  * @blkcg: blkcg of interest
  * @q: request_queue of interest
  *
@@ -262,8 +262,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
  * value on error.  If @q is dead, returns ERR_PTR(-EINVAL).  If @q is not
  * dead and bypassing, returns ERR_PTR(-EBUSY).
  */
-struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
-				    struct request_queue *q)
+struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
+				      struct request_queue *q)
 {
 	struct blkcg_gq *blkg;
 
@@ -293,6 +293,28 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 	}
 }
 
+/**
+ * blkg_lookup_create - find or create a blkg
+ * @blkcg: target block cgroup
+ * @q: target request_queue
+ *
+ * This looks up or creates the blkg representing the unique pair
+ * of the blkcg and the request_queue.
+ */
+struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
+				    struct request_queue *q)
+{
+	struct blkcg_gq *blkg = blkg_lookup(blkcg, q);
+
+	if (unlikely(!blkg)) {
+		spin_lock_irq(&q->queue_lock);
+		blkg = __blkg_lookup_create(blkcg, q);
+		spin_unlock_irq(&q->queue_lock);
+	}
+
+	return blkg;
+}
+
 static void blkg_destroy(struct blkcg_gq *blkg)
 {
 	struct blkcg *blkcg = blkg->blkcg;
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index fe0c4ca312ff..e6f68f15dee9 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -486,7 +486,7 @@ static void blkcg_iolatency_throttle(struct rq_qos *rqos, struct bio *bio)
 	blkg = blkg_lookup(blkcg, q);
 	if (unlikely(!blkg)) {
 		spin_lock_irq(&q->queue_lock);
-		blkg = blkg_lookup_create(blkcg, q);
+		blkg = __blkg_lookup_create(blkcg, q);
 		if (IS_ERR(blkg))
 			blkg = NULL;
 		spin_unlock_irq(&q->queue_lock);
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index f619307171a6..b3b1a8187d23 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -181,6 +181,8 @@ extern struct cgroup_subsys_state * const blkcg_root_css;
 
 struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
 				      struct request_queue *q, bool update_hint);
+struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
+				      struct request_queue *q);
 struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 				    struct request_queue *q);
 int blkcg_init_queue(struct request_queue *q);
@@ -799,7 +801,7 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 	blkg = blkg_lookup(blkcg, q);
 	if (unlikely(!blkg)) {
 		spin_lock_irq(&q->queue_lock);
-		blkg = blkg_lookup_create(blkcg, q);
+		blkg = __blkg_lookup_create(blkcg, q);
 		if (IS_ERR(blkg))
 			blkg = NULL;
 		spin_unlock_irq(&q->queue_lock);
-- 
2.17.1

