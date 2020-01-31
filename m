Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEDDC35240
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 10:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4D6206F0
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 10:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgAaKiD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:38:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:55706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbgAaKiD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 05:38:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 899BCAF41;
        Fri, 31 Jan 2020 10:38:01 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Sage Weil <sage@redhat.com>, Daniel Disseldorp <ddiss@suse.com>,
        Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 03/15] rbd: reorder rbd_img_advance()
Date:   Fri, 31 Jan 2020 11:37:27 +0100
Message-Id: <20200131103739.136098-4-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200131103739.136098-1-hare@suse.de>
References: <20200131103739.136098-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reorder switch statement to avoid the use of a label/goto and add
an RBD_IMG_DONE state to signal that the state machine has completed.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/rbd.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 792180548e89..c80942e08164 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -321,9 +321,9 @@ enum img_req_flags {
 };
 
 enum rbd_img_state {
-	RBD_IMG_START = 1,
+	RBD_IMG_DONE,
+	RBD_IMG_START,
 	RBD_IMG_EXCLUSIVE_LOCK,
-	__RBD_IMG_OBJECT_REQUESTS,
 	RBD_IMG_OBJECT_REQUESTS,
 };
 
@@ -3591,40 +3591,44 @@ static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
 	struct rbd_device *rbd_dev = img_req->rbd_dev;
 	int ret;
 
-again:
+	dout("%s: img %p state %d\n", __func__, img_req, img_req->state);
 	switch (img_req->state) {
 	case RBD_IMG_START:
 		rbd_assert(!*result);
 
+		img_req->state = RBD_IMG_EXCLUSIVE_LOCK;
 		ret = rbd_img_exclusive_lock(img_req);
 		if (ret < 0) {
 			*result = ret;
+			img_req->state = RBD_IMG_DONE;
 			return true;
 		}
-		img_req->state = RBD_IMG_EXCLUSIVE_LOCK;
-		if (ret > 0)
-			goto again;
-		return false;
+		if (ret == 0)
+			return false;
+		/* fall through */
 	case RBD_IMG_EXCLUSIVE_LOCK:
-		if (*result)
+		if (*result) {
+			img_req->state = RBD_IMG_DONE;
 			return true;
+		}
 
 		rbd_assert(!need_exclusive_lock(img_req) ||
 			   __rbd_is_lock_owner(rbd_dev));
 
+		img_req->state = RBD_IMG_OBJECT_REQUESTS;
 		rbd_img_object_requests(img_req);
 		if (!img_req->pending.num_pending) {
 			*result = img_req->pending.result;
-			img_req->state = RBD_IMG_OBJECT_REQUESTS;
-			goto again;
+			img_req->state = RBD_IMG_DONE;
+			return true;
 		}
-		img_req->state = __RBD_IMG_OBJECT_REQUESTS;
 		return false;
-	case __RBD_IMG_OBJECT_REQUESTS:
+	case RBD_IMG_OBJECT_REQUESTS:
 		if (!pending_result_dec(&img_req->pending, result))
 			return false;
+		img_req->state = RBD_IMG_DONE;
 		/* fall through */
-	case RBD_IMG_OBJECT_REQUESTS:
+	case RBD_IMG_DONE:
 		return true;
 	default:
 		BUG();
-- 
2.16.4

