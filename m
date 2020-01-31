Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA9DC35246
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 10:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC3620CC7
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 10:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgAaKiG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:38:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:55858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbgAaKiF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 05:38:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E189CB011;
        Fri, 31 Jan 2020 10:38:01 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Sage Weil <sage@redhat.com>, Daniel Disseldorp <ddiss@suse.com>,
        Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/15] rbd: reorder switch statement in rbd_advance_write()
Date:   Fri, 31 Jan 2020 11:37:29 +0100
Message-Id: <20200131103739.136098-6-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200131103739.136098-1-hare@suse.de>
References: <20200131103739.136098-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reorder switch statement to avoid the use of a label/goto
statement and add a 'done' state to indicate that the state
machine has completed.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/rbd.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4d7857667e9c..766d67e4d5e5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -267,7 +267,8 @@ enum rbd_obj_read_state {
  * even if there is a parent).
  */
 enum rbd_obj_write_state {
-	RBD_OBJ_WRITE_START = 1,
+	RBD_OBJ_WRITE_DONE,
+	RBD_OBJ_WRITE_START,
 	RBD_OBJ_WRITE_PRE_OBJECT_MAP,
 	RBD_OBJ_WRITE_OBJECT,
 	__RBD_OBJ_WRITE_COPYUP,
@@ -3382,31 +3383,37 @@ static bool rbd_obj_advance_write(struct rbd_obj_request *obj_req, int *result)
 	int ret;
 
 again:
+	dout("%s: obj %p state %d\n", __func__, obj_req, obj_req->write_state);
 	switch (obj_req->write_state) {
 	case RBD_OBJ_WRITE_START:
 		rbd_assert(!*result);
 
-		if (rbd_obj_write_is_noop(obj_req))
+		if (rbd_obj_write_is_noop(obj_req)) {
+			obj_req->write_state = RBD_OBJ_WRITE_DONE;
 			return true;
+		}
 
 		ret = rbd_obj_write_pre_object_map(obj_req);
 		if (ret < 0) {
 			*result = ret;
+			obj_req->write_state = RBD_OBJ_WRITE_DONE;
 			return true;
 		}
 		obj_req->write_state = RBD_OBJ_WRITE_PRE_OBJECT_MAP;
-		if (ret > 0)
-			goto again;
-		return false;
+		if (ret == 0)
+			return false;
+		/* fall through */
 	case RBD_OBJ_WRITE_PRE_OBJECT_MAP:
 		if (*result) {
 			rbd_warn(rbd_dev, "pre object map update failed: %d",
 				 *result);
+			obj_req->write_state = RBD_OBJ_WRITE_DONE;
 			return true;
 		}
 		ret = rbd_obj_write_object(obj_req);
 		if (ret) {
 			*result = ret;
+			obj_req->write_state = RBD_OBJ_WRITE_DONE;
 			return true;
 		}
 		obj_req->write_state = RBD_OBJ_WRITE_OBJECT;
@@ -3426,33 +3433,40 @@ static bool rbd_obj_advance_write(struct rbd_obj_request *obj_req, int *result)
 			if (obj_req->flags & RBD_OBJ_FLAG_DELETION)
 				*result = 0;
 		}
-		if (*result)
+		if (*result) {
+			obj_req->write_state = RBD_OBJ_WRITE_DONE;
 			return true;
-
+		}
 		obj_req->write_state = RBD_OBJ_WRITE_COPYUP;
 		goto again;
 	case __RBD_OBJ_WRITE_COPYUP:
 		if (!rbd_obj_advance_copyup(obj_req, result))
 			return false;
+		obj_req->write_state = RBD_OBJ_WRITE_COPYUP;
 		/* fall through */
 	case RBD_OBJ_WRITE_COPYUP:
 		if (*result) {
 			rbd_warn(rbd_dev, "copyup failed: %d", *result);
+			obj_req->write_state = RBD_OBJ_WRITE_DONE;
 			return true;
 		}
+		obj_req->write_state = RBD_OBJ_WRITE_POST_OBJECT_MAP;
 		ret = rbd_obj_write_post_object_map(obj_req);
 		if (ret < 0) {
 			*result = ret;
+			obj_req->write_state = RBD_OBJ_WRITE_DONE;
 			return true;
 		}
-		obj_req->write_state = RBD_OBJ_WRITE_POST_OBJECT_MAP;
-		if (ret > 0)
-			goto again;
-		return false;
+		if (ret == 0)
+			return false;
+		/* fall through */
 	case RBD_OBJ_WRITE_POST_OBJECT_MAP:
 		if (*result)
 			rbd_warn(rbd_dev, "post object map update failed: %d",
 				 *result);
+		obj_req->write_state = RBD_OBJ_WRITE_DONE;
+		/* fall through */
+	case RBD_OBJ_WRITE_DONE:
 		return true;
 	default:
 		BUG();
-- 
2.16.4

