Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233F5C77B75
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 06:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjESGw2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 02:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjESGw2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 02:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6AAE73
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684479073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30slwXISxJFZKL73S3C9D+yFw0yHPvfEoQqfgGKN6CY=;
        b=YxNxxTi4T2HaoqunJLL6JCpljiZlV1r2s9nSr2OAIEXti3eCPhSIjaOn2y/+i5iQEPg/Uv
        xpYUiQ4zEsN//fMbviyHkYKcF6+af3vMdat3vIQUlxpOf4JMVEMs3VCW/FKYMB9fIrmzj4
        alOtffKwEcGDi4m7+0IwvWzW59BLtMs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-YmkjVZUjOSOlMMUt2jtzgQ-1; Fri, 19 May 2023 02:51:09 -0400
X-MC-Unique: YmkjVZUjOSOlMMUt2jtzgQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 790941C08976;
        Fri, 19 May 2023 06:51:09 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E0ED6B42E;
        Fri, 19 May 2023 06:51:08 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Harris James R <james.r.harris@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 7/7] ublk: support user copy
Date:   Fri, 19 May 2023 14:50:30 +0800
Message-Id: <20230519065030.351216-8-ming.lei@redhat.com>
In-Reply-To: <20230519065030.351216-1-ming.lei@redhat.com>
References: <20230519065030.351216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently copy between io request buffer(pages) and userspace buffer is
done inside ublk_map_io() or ublk_unmap_io(). This way performs very
well in case of pre-allocated userspace io buffer.

For dynamically allocated or external userspace backend io buffer,
UBLK_F_NEED_GET_DATA is added for ublk server to provide buffer by one
extra command communication for WRITE request. For READ, userspace
simply provides buffer, but can't know when the buffer is done[1].

Add UBLK_F_USER_COPY by moving io data copy out of kernel by providing
read()/write() on /dev/ublkcN, and simply let ublk server do the io
data copy. This way makes both side cleaner, the cost is that one extra
syscall for copy io data between request and backend buffer.

With UBLK_F_USER_COPY, it actually becomes possible to run per-io zero
copy now, such as, only do zero copy for big size IO, so it can be
thought as one prep patch for supporting zero copy. Meantime zero copy
still needs to expose read()/write() buffer for some corner case, such
as passthrough IO.

[1] READ buffer in UBLK_F_NEED_GET_DATA
https://lore.kernel.org/linux-block/116d8a56-0881-56d3-9bcc-78ff3e1dc4e5@linux.alibaba.com/T/#m23bd4b8634c0a054e6797063167b469949a247bb

ublksrv loop usercopy code:

	https://github.com/ming1/ubdsrv/commits/usercopy

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 58 ++++++++++++++++++++++++++++-------
 include/uapi/linux/ublk_cmd.h |  3 ++
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ec40ac4f9af3..e00733b6fea8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -55,7 +55,8 @@
 		| UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
 		| UBLK_F_UNPRIVILEGED_DEV \
-		| UBLK_F_CMD_IOCTL_ENCODE)
+		| UBLK_F_CMD_IOCTL_ENCODE \
+		| UBLK_F_USER_COPY)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
@@ -312,9 +313,18 @@ static int ublk_apply_params(struct ublk_device *ub)
 	return 0;
 }
 
+static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
+{
+	return ubq->flags & UBLK_F_USER_COPY;
+}
+
 static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 {
-	return false;
+	/*
+	 * read()/write() is involved in user copy, so request reference
+	 * has to be grabbed
+	 */
+	return ublk_support_user_copy(ubq);
 }
 
 static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
@@ -591,6 +601,9 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
+	if (ublk_support_user_copy(ubq))
+		return rq_bytes;
+
 	/*
 	 * no zero copy, we delay copy WRITE request data into ublksrv
 	 * context and the big benefit is that pinning pages in current
@@ -615,6 +628,9 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
+	if (ublk_support_user_copy(ubq))
+		return rq_bytes;
+
 	if (ublk_need_unmap_req(req)) {
 		struct iov_iter iter;
 		struct iovec iov;
@@ -1390,6 +1406,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
 		goto out;
 
+	if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	ret = ublk_check_cmd_op(cmd_op);
 	if (ret)
 		goto out;
@@ -1408,23 +1429,34 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		 */
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
 			goto out;
-		/* FETCH_RQ has to provide IO buffer if NEED GET DATA is not enabled */
-		if (!ub_cmd->addr && !ublk_need_get_data(ubq))
-			goto out;
+
+		if (!ublk_support_user_copy(ubq)) {
+			/*
+			 * FETCH_RQ has to provide IO buffer if NEED GET
+			 * DATA is not enabled
+			 */
+			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
+				goto out;
+		}
 
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_mark_io_ready(ub, ubq);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
-		/*
-		 * COMMIT_AND_FETCH_REQ has to provide IO buffer if NEED GET DATA is
-		 * not enabled or it is Read IO.
-		 */
-		if (!ub_cmd->addr && (!ublk_need_get_data(ubq) || req_op(req) == REQ_OP_READ))
-			goto out;
+
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
+
+		if (!ublk_support_user_copy(ubq)) {
+			/*
+			 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
+			 * NEED GET DATA is not enabled or it is Read IO.
+			 */
+			if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
+						req_op(req) == REQ_OP_READ))
+				goto out;
+		}
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_commit_completion(ub, ub_cmd);
 		break;
@@ -1996,6 +2028,10 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	ub->dev_info.flags |= UBLK_F_CMD_IOCTL_ENCODE |
 		UBLK_F_URING_CMD_COMP_IN_TASK;
 
+	/* GET_DATA isn't needed any more with USER_COPY */
+	if (ub->dev_info.flags & UBLK_F_USER_COPY)
+		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
+
 	/* We are not ready to support zero copy */
 	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index c0c1632c671e..54b5b0aeefca 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -165,6 +165,9 @@
 /* use ioctl encoding for uring command */
 #define UBLK_F_CMD_IOCTL_ENCODE	(1UL << 6)
 
+/* Copy between request and user buffer by pread()/pwrite() */
+#define UBLK_F_USER_COPY	(1UL << 7)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
-- 
2.40.1

