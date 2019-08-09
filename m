Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0D9C31E40
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 21:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D87920844
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 21:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfHIV0Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:26:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfHIV0Y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Aug 2019 17:26:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6425F308FBAC;
        Fri,  9 Aug 2019 21:26:24 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-125-29.rdu2.redhat.com [10.10.125.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C683C60872;
        Fri,  9 Aug 2019 21:26:23 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 2/4] nbd: add function to convert blk req op to nbd cmd
Date:   Fri,  9 Aug 2019 16:26:08 -0500
Message-Id: <20190809212610.19412-3-mchristi@redhat.com>
In-Reply-To: <20190809212610.19412-1-mchristi@redhat.com>
References: <20190809212610.19412-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 09 Aug 2019 21:26:24 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds a helper function to convert a block req op to a nbd cmd type.
It will be used in the last patch to log the type in the timeout
handler.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 drivers/block/nbd.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index cb2b98392ae5..131b541d07c3 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -342,6 +342,22 @@ static void sock_shutdown(struct nbd_device *nbd)
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
@@ -476,22 +492,9 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 
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

