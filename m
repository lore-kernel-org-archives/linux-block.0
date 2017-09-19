Return-Path: <meng@gtisc.gatech.edu>
From: Meng Xu <mengxu.gatech@gmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Cc: meng.xu@gatech.edu, sanidhya@gatech.edu, taesoo@gatech.edu, Meng Xu <mengxu.gatech@gmail.com>
Subject: [PATCH] scsi: ensure the header peeked does not change in the actual message
Date: Tue, 19 Sep 2017 11:23:58 -0400
Message-Id: <1505834638-37142-1-git-send-email-mengxu.gatech@gmail.com>
List-ID: <linux-block@vger.kernel.org>

In sg_scsi_ioctl(), the header of the userspace buffer, sic->data, is
fetched twice from the userspace. The first fetch is used to peek at the
opcode and derive cmdlen while the second fetch copies the whole message.
However, the userspace memory backing opcode can change across fetches
which means that the corresponding opcode field in req->cmd could be
different from what is fetched in for the first time (and so is the
derived cmdlen).

Whether this double-fetch situation is a security critical bug depends
on how req->cmd will be used later. However, given that it is hard to
enumerate all the possible use cases, a safer way is to ensure that
the peeked header does not change after the second fetch.

This patch enforces that the opcode field in req->cmd is the same as what
is fetched in originally.

Signed-off-by: Meng Xu <mengxu.gatech@gmail.com>
---
 block/scsi_ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 7440de4..971044d 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -466,6 +466,12 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
 	if (copy_from_user(req->cmd, sic->data, cmdlen))
 		goto error;
 
+	/*
+	 * override the request header (opcode) to make sure that it matches
+	 * the first fetch from sic->data 
+	 */
+	*((unsigned int *)req->cmd) = opcode;
+
 	if (in_len && copy_from_user(buffer, sic->data + cmdlen, in_len))
 		goto error;
 
-- 
2.7.4
