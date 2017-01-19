Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54446 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751316AbdASVI4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2017 16:08:56 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0JL4ip2025963
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2017 13:08:56 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 28306h96w8-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2017 13:08:56 -0800
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>, <axboe@fb.com>
Subject: [PATCH] nbd: only set MSG_MORE when we have more to send
Date: Thu, 19 Jan 2017 16:08:49 -0500
Message-ID: <1484860129-14727-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A user noticed that write performance was horrible over loopback and we
traced it to an inversion of when we need to set MSG_MORE.  It should be
set when we have more bvec's to send, not when we are on the last bvec.
This patch made the test go from 20 iops to 78k iops.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 454f770..510ae02 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -275,7 +275,7 @@ static inline int sock_send_bvec(struct nbd_device *nbd, int index,
 static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
-	int result, flags;
+	int result;
 	struct nbd_request request;
 	unsigned long size = blk_rq_bytes(req);
 	struct bio *bio;
@@ -314,7 +314,6 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	if (type != NBD_CMD_WRITE)
 		return 0;
 
-	flags = 0;
 	bio = req->bio;
 	while (bio) {
 		struct bio *next = bio->bi_next;
@@ -323,9 +322,8 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 
 		bio_for_each_segment(bvec, bio, iter) {
 			bool is_last = !next && bio_iter_last(bvec, iter);
+			int flags = is_last ? 0 : MSG_MORE;
 
-			if (is_last)
-				flags = MSG_MORE;
 			dev_dbg(nbd_to_dev(nbd), "request %p: sending %d bytes data\n",
 				cmd, bvec.bv_len);
 			result = sock_send_bvec(nbd, index, &bvec, flags);
-- 
2.5.5

