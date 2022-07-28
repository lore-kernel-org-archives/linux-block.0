Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F420EC3F6B0
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 12:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiG1Mjp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 08:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238776AbiG1Mjo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 08:39:44 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C466BD66
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 05:39:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VKfiKRk_1659011980;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VKfiKRk_1659011980)
          by smtp.aliyun-inc.com;
          Thu, 28 Jul 2022 20:39:40 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     ZiyangZhang@linux.alibaba.com, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
Subject: [PATCH V4 2/2] ublk_drv: add support for UBLK_IO_NEED_GET_DATA
Date:   Thu, 28 Jul 2022 20:39:16 +0800
Message-Id: <3a21007ea1be8304246e654cebbd581ab0012623.1659011443.git.ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1659011443.git.ZiyangZhang@linux.alibaba.com>
References: <cover.1659011443.git.ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

UBLK_IO_NEED_GET_DATA is one ublk IO command. It is designed for a user
application who wants to allocate IO buffer and set IO buffer address
only after it receives an IO request from ublksrv. This is a reasonable
scenario because these users may use a RPC framework as one IO backend
to handle IO requests passed from ublksrv. And a RPC framework may
allocate its own buffer(or memory pool).

This new feature (UBLK_F_NEED_GET_DATA) is optional for ublk users.
Related userspace code has been added in ublksrv[1] as one pull request.

Test cases for this feature are added in ublksrv and all the tests pass.
The performance result shows that this new feature does bring additional
latency because one IO is issued back to ublk_drv once again to copy data
from bio vectors to user-provided data buffer. UBLK_IO_NEED_GET_DATA is
suitable for bigger block size such as 512B or 1MB.

[1] https://github.com/ming1/ubdsrv

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 106 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 12 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 255b2de46a24..df2c91558349 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -47,7 +47,9 @@
 #define UBLK_MINORS		(1U << MINORBITS)
 
 /* All UBLK_F_* have to be included into UBLK_F_ALL */
-#define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_URING_CMD_COMP_IN_TASK)
+#define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY \
+		| UBLK_F_URING_CMD_COMP_IN_TASK \
+		| UBLK_F_NEED_GET_DATA)
 
 struct ublk_rq_data {
 	struct callback_head work;
@@ -86,6 +88,15 @@ struct ublk_uring_cmd_pdu {
  */
 #define UBLK_IO_FLAG_ABORTED 0x04
 
+/*
+ * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
+ * get data buffer address from ublksrv.
+ *
+ * Then, bio data could be copied into this data buffer for a WRITE request
+ * after the IO command is issued again and UBLK_IO_FLAG_NEED_GET_DATA is unset.
+ */
+#define UBLK_IO_FLAG_NEED_GET_DATA 0x08
+
 struct ublk_io {
 	/* userspace buffer address from io cmd */
 	__u64	addr;
@@ -168,6 +179,13 @@ static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
 	return false;
 }
 
+static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
+{
+	if (ubq->flags & UBLK_F_NEED_GET_DATA)
+		return true;
+	return false;
+}
+
 static struct ublk_device *ublk_get_device(struct ublk_device *ub)
 {
 	if (kobject_get_unless_zero(&ub->cdev_dev.kobj))
@@ -509,6 +527,21 @@ static void __ublk_fail_req(struct ublk_io *io, struct request *req)
 	}
 }
 
+static void ubq_complete_io_cmd(struct ublk_io *io, int res)
+{
+	/* mark this cmd owned by ublksrv */
+	io->flags |= UBLK_IO_FLAG_OWNED_BY_SRV;
+
+	/*
+	 * clear ACTIVE since we are done with this sqe/cmd slot
+	 * We can only accept io cmd in case of being not active.
+	 */
+	io->flags &= ~UBLK_IO_FLAG_ACTIVE;
+
+	/* tell ublksrv one io request is coming */
+	io_uring_cmd_done(io->cmd, res, 0);
+}
+
 #define UBLK_REQUEUE_DELAY_MS	3
 
 static inline void __ublk_rq_task_work(struct request *req)
@@ -531,6 +564,30 @@ static inline void __ublk_rq_task_work(struct request *req)
 		return;
 	}
 
+	if (ublk_need_get_data(ubq) &&
+			(req_op(req) == REQ_OP_WRITE ||
+			req_op(req) == REQ_OP_FLUSH)) {
+		/*
+		 * We have not handled UBLK_IO_NEED_GET_DATA command yet,
+		 * so immepdately pass UBLK_IO_RES_NEED_GET_DATA to ublksrv
+		 * and notify it.
+		 */
+		if (!(io->flags & UBLK_IO_FLAG_NEED_GET_DATA)) {
+			io->flags |= UBLK_IO_FLAG_NEED_GET_DATA;
+			pr_devel("%s: need get data. op %d, qid %d tag %d io_flags %x\n",
+					__func__, io->cmd->cmd_op, ubq->q_id,
+					req->tag, io->flags);
+			ubq_complete_io_cmd(io, UBLK_IO_RES_NEED_GET_DATA);
+			return;
+		}
+		/*
+		 * We have handled UBLK_IO_NEED_GET_DATA command,
+		 * so clear UBLK_IO_FLAG_NEED_GET_DATA now and just
+		 * do the copy work.
+		 */
+		io->flags &= ~UBLK_IO_FLAG_NEED_GET_DATA;
+	}
+
 	mapped_bytes = ublk_map_io(ubq, req, io);
 
 	/* partially mapped, update io descriptor */
@@ -553,17 +610,7 @@ static inline void __ublk_rq_task_work(struct request *req)
 			mapped_bytes >> 9;
 	}
 
-	/* mark this cmd owned by ublksrv */
-	io->flags |= UBLK_IO_FLAG_OWNED_BY_SRV;
-
-	/*
-	 * clear ACTIVE since we are done with this sqe/cmd slot
-	 * We can only accept io cmd in case of being not active.
-	 */
-	io->flags &= ~UBLK_IO_FLAG_ACTIVE;
-
-	/* tell ublksrv one io request is coming */
-	io_uring_cmd_done(io->cmd, UBLK_IO_RES_OK, 0);
+	ubq_complete_io_cmd(io, UBLK_IO_RES_OK);
 }
 
 static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd)
@@ -846,6 +893,25 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	mutex_unlock(&ub->mutex);
 }
 
+static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
+		int tag, struct io_uring_cmd *cmd)
+{
+	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
+	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
+
+	if (ublk_can_use_task_work(ubq)) {
+		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+
+		/* should not fail since we call it just in ubq->ubq_daemon */
+		task_work_add(ubq->ubq_daemon, &data->work, TWA_SIGNAL_NO_IPI);
+	} else {
+		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+
+		pdu->req = req;
+		io_uring_cmd_complete_in_task(cmd, ublk_rq_task_work_cb);
+	}
+}
+
 static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->cmd;
@@ -884,6 +950,14 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		goto out;
 	}
 
+	/*
+	 * ensure that the user issues UBLK_IO_NEED_GET_DATA
+	 * iff the driver have set the UBLK_IO_FLAG_NEED_GET_DATA.
+	 */
+	if ((!!(io->flags & UBLK_IO_FLAG_NEED_GET_DATA))
+			^ (cmd_op == UBLK_IO_NEED_GET_DATA))
+		goto out;
+
 	switch (cmd_op) {
 	case UBLK_IO_FETCH_REQ:
 		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
@@ -917,6 +991,14 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		io->cmd = cmd;
 		ublk_commit_completion(ub, ub_cmd);
 		break;
+	case UBLK_IO_NEED_GET_DATA:
+		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+			goto out;
+		io->addr = ub_cmd->addr;
+		io->cmd = cmd;
+		io->flags |= UBLK_IO_FLAG_ACTIVE;
+		ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag, cmd);
+		break;
 	default:
 		goto out;
 	}
-- 
2.34.1

