Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.gtisc.gatech.edu ([143.215.130.82]:41611 "EHLO
        mx2.gtisc.gatech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbdISV34 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Sep 2017 17:29:56 -0400
From: Meng Xu <mengxu.gatech@gmail.com>
To: hch@infradead.org, axboe@kernel.dk, linux-block@vger.kernel.org
Cc: meng.xu@gatech.edu, sanidhya@gatech.edu, taesoo@gatech.edu,
        Meng Xu <mengxu.gatech@gmail.com>
Subject: [PATCH] scsi: skip message header in next fetch
Date: Tue, 19 Sep 2017 17:29:41 -0400
Message-Id: <1505856581-9036-1-git-send-email-mengxu.gatech@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In sg_scsi_ioctl(), the header of the userspace buffer, sic->data, is
fetched twice from the userspace. The first fetch is used to peek at the
opcode and derive cmdlen while the second fetch copies the whole message.
However, the userspace memory backing opcode can change across fetches
which means that the corresponding opcode field in req->cmd could be
different from what is fetched in for the first time (and so is the
derived cmdlen).

Whether this double-fetch situation is a security critical bug depends
on how req->cmd will be used later. However, given that it is hard to
enumerate all the possible use cases, a safer way is to construct the message
by concating the opcode fetched before and the rest of the message from
userspace.

Signed-off-by: Meng Xu <mengxu.gatech@gmail.com>
---
 block/scsi_ioctl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 7440de4..8fe1e05 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -463,7 +463,13 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
 	 */
 	err = -EFAULT;
 	req->cmd_len = cmdlen;
-	if (copy_from_user(req->cmd, sic->data, cmdlen))
+
+	/* 
+	 * avoid copying the opcode twice
+	 */
+	memcpy(req->cmd, &opcode, sizeof(opcode));
+	if (copy_from_user(req->cmd + sizeof(opcode), 
+				sic->data + sizeof(opcode), cmdlen - sizeof(opcode)))
 		goto error;
 
 	if (in_len && copy_from_user(buffer, sic->data + cmdlen, in_len))
-- 
2.7.4
