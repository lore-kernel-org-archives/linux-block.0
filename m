Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BEEC32750
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 06:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DCD20663
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 06:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml6oknAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfHMGQl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:16:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46261 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfHMGQl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 02:16:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id q139so2687790pfc.13;
        Mon, 12 Aug 2019 23:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2CMaPmFhgUSczabgn5seFFKFRX7ZBQEwXOP5kflvzo=;
        b=Ml6oknAsiRFd4vCBJ/hwVG6uWWhKFVd8S59qLwviy4Z0UqegjzZw3JmkrDl6JneFki
         JkJCJfKLVLDni3+XaQEzQBgT38/YR64J4PHtE2dc8OczIoJqZg7gfiGOdpAM9Wnx7HxK
         l5ZQh1merYV2b+HRftirYLMgUbJuRV70WhYNsVlM7JGi0a0+0K+LYsyb6lU7uFgvmdXH
         xoi1NI4okaQ25Wy4yIKFKznUhyXMgUJ/jTnJfhuPNIoxG9kijOaZ5wcMRacb2ogO1vdk
         tWIlCWUhLRBX0ZHfr8NfNiKpxRO1JAIJ6Q7giL0uA1x9nslMd6cmZPWtuOLkLST2LR8e
         ubmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2CMaPmFhgUSczabgn5seFFKFRX7ZBQEwXOP5kflvzo=;
        b=LRzY98EBmVxbK1LMlOOtrHLZDxa+tou2pTEJp/tTfhxYw1mROldveQN8pd0yzpPjrj
         dZPaEc9s/ZO58mxFmXrpsu8O33OyKHJum+dRKg0kxeXZSH0sdEvVwNh7Ph+cPUVxz8Lv
         /+SjMcP2DceGriE8yqfQrBKKLrqDsiyorRZPT5ilR3YAkOALDh/nwmpWvvj4o3LYzuQT
         BrFL4Yt00YpaO2+BeJxmS+aBo3n+kDE6KS2Cx0BM1bYsVHIygDfgLRhS0ujymS+G1SRC
         2aLCX/YqPj1YRbIFBZBF4TBUb7SgLSMH3rVjEdB9eokbCkBr3W+rJfL7fk3VaduBaYnC
         81Pw==
X-Gm-Message-State: APjAAAUssHd56YArNpgSmwuhmmzCgf3gUgKNTkYMDaFZldAIdQxekAn3
        Ovh8PQrutved6v7Dkfx7OsGSahSsncWp0g==
X-Google-Smtp-Source: APXvYqzkzJPidjPjU0th78+XWXE74z4yAjTlizY/SeAc2LinQjY4m8SinjVPc2zpTzshJdaQFboG6w==
X-Received: by 2002:a62:2c93:: with SMTP id s141mr22093710pfs.114.1565677000124;
        Mon, 12 Aug 2019 23:16:40 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id w9sm5803654pfn.19.2019.08.12.23.16.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 23:16:39 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2 1/3] drbd: Use refcount_t for refcount
Date:   Tue, 13 Aug 2019 14:16:34 +0800
Message-Id: <20190813061634.5372-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reference counters are preferred to use refcount_t instead of
atomic_t.
This is because the implementation of refcount_t can prevent
overflows and detect possible use-after-free.
So convert atomic_t ref counters to refcount_t.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/block/drbd/drbd_int.h  |  3 ++-
 drivers/block/drbd/drbd_main.c |  4 ++--
 drivers/block/drbd/drbd_req.c  | 16 ++++++++--------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index ddbf56014c51..d5167a7a87db 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -30,6 +30,7 @@
 #include <linux/genhd.h>
 #include <linux/idr.h>
 #include <linux/dynamic_debug.h>
+#include <linux/refcount.h>
 #include <net/tcp.h>
 #include <linux/lru_cache.h>
 #include <linux/prefetch.h>
@@ -354,7 +355,7 @@ struct drbd_request {
 
 
 	/* once it hits 0, we may complete the master_bio */
-	atomic_t completion_ref;
+	refcount_t completion_ref;
 	/* once it hits 0, we may destroy this drbd_request object */
 	struct kref kref;
 
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 9bd4ddd12b25..37746708ee84 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2295,14 +2295,14 @@ static void do_retry(struct work_struct *ws)
 		bool expected;
 
 		expected =
-			expect(atomic_read(&req->completion_ref) == 0) &&
+			expect(refcount_read(&req->completion_ref) == 0) &&
 			expect(req->rq_state & RQ_POSTPONED) &&
 			expect((req->rq_state & RQ_LOCAL_PENDING) == 0 ||
 				(req->rq_state & RQ_LOCAL_ABORTED) != 0);
 
 		if (!expected)
 			drbd_err(device, "req=%p completion_ref=%d rq_state=%x\n",
-				req, atomic_read(&req->completion_ref),
+				req, refcount_read(&req->completion_ref),
 				req->rq_state);
 
 		/* We still need to put one kref associated with the
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index f86cea4c0f8d..cb5d573e7ea2 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -69,7 +69,7 @@ static struct drbd_request *drbd_req_new(struct drbd_device *device, struct bio
 	INIT_LIST_HEAD(&req->req_pending_local);
 
 	/* one reference to be put by __drbd_make_request */
-	atomic_set(&req->completion_ref, 1);
+	refcount_set(&req->completion_ref, 1);
 	/* one kref as long as completion_ref > 0 */
 	kref_init(&req->kref);
 	return req;
@@ -95,11 +95,11 @@ void drbd_req_destroy(struct kref *kref)
 	const unsigned s = req->rq_state;
 
 	if ((req->master_bio && !(s & RQ_POSTPONED)) ||
-		atomic_read(&req->completion_ref) ||
+		refcount_read(&req->completion_ref) ||
 		(s & RQ_LOCAL_PENDING) ||
 		((s & RQ_NET_MASK) && !(s & RQ_NET_DONE))) {
 		drbd_err(device, "drbd_req_destroy: Logic BUG rq_state = 0x%x, completion_ref = %d\n",
-				s, atomic_read(&req->completion_ref));
+				s, refcount_read(&req->completion_ref));
 		return;
 	}
 
@@ -315,7 +315,7 @@ static void drbd_req_put_completion_ref(struct drbd_request *req, struct bio_and
 	if (!put)
 		return;
 
-	if (!atomic_sub_and_test(put, &req->completion_ref))
+	if (!refcount_sub_and_test(put, &req->completion_ref))
 		return;
 
 	drbd_req_complete(req, m);
@@ -440,15 +440,15 @@ static void mod_rq_state(struct drbd_request *req, struct bio_and_error *m,
 	kref_get(&req->kref);
 
 	if (!(s & RQ_LOCAL_PENDING) && (set & RQ_LOCAL_PENDING))
-		atomic_inc(&req->completion_ref);
+		refcount_inc(&req->completion_ref);
 
 	if (!(s & RQ_NET_PENDING) && (set & RQ_NET_PENDING)) {
 		inc_ap_pending(device);
-		atomic_inc(&req->completion_ref);
+		refcount_inc(&req->completion_ref);
 	}
 
 	if (!(s & RQ_NET_QUEUED) && (set & RQ_NET_QUEUED)) {
-		atomic_inc(&req->completion_ref);
+		refcount_inc(&req->completion_ref);
 		set_if_null_req_next(peer_device, req);
 	}
 
@@ -466,7 +466,7 @@ static void mod_rq_state(struct drbd_request *req, struct bio_and_error *m,
 	}
 
 	if (!(s & RQ_COMPLETION_SUSP) && (set & RQ_COMPLETION_SUSP))
-		atomic_inc(&req->completion_ref);
+		refcount_inc(&req->completion_ref);
 
 	/* progress: put references */
 
-- 
2.20.1

