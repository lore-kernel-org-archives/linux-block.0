Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F77C0650F
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 13:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F3D2184E
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 13:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbkZmszM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfHHNKs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:10:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46422 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732645AbfHHNKr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 09:10:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id c3so20955505pfa.13;
        Thu, 08 Aug 2019 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2CMaPmFhgUSczabgn5seFFKFRX7ZBQEwXOP5kflvzo=;
        b=RbkZmszMz5ZzLBIxKnUAhuZ9BIkcr9fJcUQlpMgcBP9qv5QFUF1UYpSRsxN6RoF4eB
         4fmmS6lwWA+uY5G7vNV7agj1OFVNDG7cPUIZO51uHiIXDlvQuWIenZ9wx6Fu4UIu092v
         iOcHtskkORsSaSbk7iiTnY5pOhLpvmqQkXLpweFPh6ZrftFPl77EkyRKvgBFinLWFyh2
         8Whva3hDjlMIM8MCt7lXa2G/N0Zv73FvufSxwwciMauU8YJVhOK8MwKuMdoNFMspE6V1
         k749K0Yy4TOYflwHWqBSUmpna8ICQ6MU3Xg5phUogQx0rIISQocBVg9pslY6D5tpZ4Ji
         hwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2CMaPmFhgUSczabgn5seFFKFRX7ZBQEwXOP5kflvzo=;
        b=VU0mXA1Wpkt5h2HrsHtTz4u+mFG/9wk/b19MCIW/7EzVwIRjyMmwXcmL1333hO/DEy
         EkP+v3kAO1/bqBmXJ6CjkmXv67y8oXniAq6Z975chrlWYKc8BUiBxwiywROkmrzcRnED
         I6RZ5I/WnmJl6Rx8gnvuk51UxpX7Kt4nJDdb93h8FYh4EnC+hElj/eNvMTWX6LcN9Uoa
         hZLHplDZ04iN2WnvQPHC/X/pREsU+Lp7gsL0STCMO+ykuWEUmv50fr1bc+PMlX1dkpmh
         +mYUpwbW3g1ZU8b7qWlnTMtKei0XGLJOh8Ho9HYJdboqWEPHYfnkjX8c8iZ0KlTZ2GTj
         Es1w==
X-Gm-Message-State: APjAAAUvyb0kX0Gx+IWkKIHjAT/yGqNpZOrKW6vYPDZ/P4HJEUOz+/cB
        yX2Hl7FMYoiVGGxwwZmowWE=
X-Google-Smtp-Source: APXvYqxcevcZNFez9HgwjbnMPHfEcer0ur32uUhIXO/CB6UE2IuIpanHo6PYFEIDRuJgDU8OSXHnrA==
X-Received: by 2002:a63:ee0c:: with SMTP id e12mr12945562pgi.184.1565269846763;
        Thu, 08 Aug 2019 06:10:46 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id i9sm106827335pgg.38.2019.08.08.06.10.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 06:10:45 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 1/3] drbd: Use refcount_t for refcount
Date:   Thu,  8 Aug 2019 21:10:40 +0800
Message-Id: <20190808131040.24640-1-hslester96@gmail.com>
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

