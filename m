Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B65C41514
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 16:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4DD20844
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 16:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfHMQj7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:39:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbfHMQj6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 12:39:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44188348BCA;
        Tue, 13 Aug 2019 16:39:56 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-122-147.rdu2.redhat.com [10.10.122.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89E3A38E06;
        Tue, 13 Aug 2019 16:39:55 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 2/4] nbd: add function to convert blk req op to nbd cmd
Date:   Tue, 13 Aug 2019 11:39:50 -0500
Message-Id: <20190813163952.23486-3-mchristi@redhat.com>
In-Reply-To: <20190813163952.23486-1-mchristi@redhat.com>
References: <20190813163952.23486-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 13 Aug 2019 16:39:58 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds a helper function to convert a block req op to a nbd cmd type.
It will be used in the last patch to log the type in the timeout
handler.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/block/nbd.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 69d0e5260e1d..c6ff8f922fd7 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -344,6 +344,22 @@ static void sock_shutdown(struct nbd_device *nbd)
 	dev_warn(disk_to_dev(nbd->disk), "shutting down sockets\n");
 }
 
+static u32 req_to_nbd_cmd_type(struct request *req)
+{
+	switch (req_op(req)) {
+	case REQ_OP_DISCARD:
+		return NBD_CMD_TRIM;
+	case REQ_OP_FLUSH:
+		return NBD_CMD_FLUSH;
+	case REQ_OP_WRITE:
+		return NBD_CMD_WRITE;
+	case REQ_OP_READ:
+		return NBD_CMD_READ;
+	default:
+		return U32_MAX;
+	}
+}
+
 static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 						 bool reserved)
 {
@@ -480,22 +496,9 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 
 	iov_iter_kvec(&from, WRITE, &iov, 1, sizeof(request));
 
-	switch (req_op(req)) {
-	case REQ_OP_DISCARD:
-		type = NBD_CMD_TRIM;
-		break;
-	case REQ_OP_FLUSH:
-		type = NBD_CMD_FLUSH;
-		break;
-	case REQ_OP_WRITE:
-		type = NBD_CMD_WRITE;
-		break;
-	case REQ_OP_READ:
-		type = NBD_CMD_READ;
-		break;
-	default:
+	type = req_to_nbd_cmd_type(req);
+	if (type == U32_MAX)
 		return -EIO;
-	}
 
 	if (rq_data_dir(req) == WRITE &&
 	    (config->flags & NBD_FLAG_READ_ONLY)) {
-- 
2.20.1

