Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0E6347FCD
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 01:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373799; cv=none; b=u9fFcZhk+8drjxLWpgxg7E+axoKobMbPcoFEuMDxWTqQRV0pzSxaWsAAsJ7sV+wX6jSwPuqo42VzRDM5v5R8kymztj2IkhF9vC75A6v/5U842N63r+mOOT/RzyFhc5uujFwUbdLta6/tYZpK+39+wtojTruTzLUe3SLEGzQtoDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373799; c=relaxed/simple;
	bh=AX0Azi0G2RD55naC5jKyrDFPqe1qhzE7QwEeIReazEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jXCIhLKYGcxBvb1Nj1NO5YtDagL8X+qghQ+sQUBrZ+yncNBgkNWm9QnziuRbb2L0dsY8vXQMOfbJ395V/XF6BEfsc3G6CvGlx5F0kLt0DxM1ZdUzQbUEO7+f9EUz0IecvC1kVIsRc+oHCxoz1RxTRBGNVy539KUP3eOfWDNueWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ibjOZYnZ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ibjOZYnZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=NK
	JQaUWGQwb2nKbSz8h3tgvy+ThjHOThSU5/IpAZPAA=; b=ibjOZYnZ9I+d8ZAlRX
	HvWfQZj8Ux029W8fxIgWxYmlg5o7r2JcmbV/GHQn+/8CulcoDpU0oKBMab/HW8tj
	fvMAY8ucByLMfWrCv1ktbalQJLAOfIO+8QPfs/IR9UCCTJzYGr8GIFVL8o5sMkNU
	790RzwjbwIl9XhggDjgKKxOCM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA3hJo4pGpqNlSGKQ--.42512S3;
	Thu, 30 Jul 2026 09:09:14 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH v2 1/2] ublk: validate auto buf reg before taking uring_cmd
Date: Thu, 30 Jul 2026 09:09:09 +0800
Message-Id: <20260730010910.799346-2-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730010910.799346-1-yangxiuwei@kylinos.cn>
References: <20260730010910.799346-1-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgA3hJo4pGpqNlSGKQ--.42512S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF45Cry3CF1fXr47XFy3twb_yoW7uF1rpF
	43C34ayFyUXr1xWF4kArZ7Aa4Yvr1xJa9rCrW5W3ZakF15ArZIqFW7tr4YvF4xXry8CF43
	Xa1SyF1kCr47CF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcrc-UUUUU=
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwhps-GpqpDraxQAA3J

With UBLK_F_AUTO_BUF_REG, invalid sqe->addr can fail after
ublk_fill_io_cmd() has set UBLK_IO_FLAG_ACTIVE. The uring_cmd is
completed while the tag stays active, which can hang teardown.

Split validation from buffer apply so the check has no side effects,
then take the uring_cmd and store the already-validated buffer. Apply
the same order in FETCH so io->buf is not written before __ublk_fetch()
state checks.

Fixes: 52460dda3a77 ("ublk: move auto buffer register handling into one dedicated helper")
Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
---
 drivers/block/ublk_drv.c | 74 +++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4ca6ec738c93..041bd3ea023f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3075,18 +3075,19 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
 	return 0;
 }
 
-static inline int ublk_set_auto_buf_reg(struct ublk_io *io, struct io_uring_cmd *cmd)
+/* Must run before ublk_fill_io_cmd() / __ublk_fetch(). */
+static inline int ublk_validate_io_buf(const struct ublk_device *ub,
+				       struct io_uring_cmd *cmd,
+				       struct ublk_auto_buf_reg *buf)
 {
-	struct ublk_auto_buf_reg buf;
-
-	buf = ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->addr));
+	if (!ublk_dev_support_auto_buf_reg(ub))
+		return 0;
 
-	if (buf.reserved0 || buf.reserved1)
+	*buf = ublk_sqe_addr_to_auto_buf_reg(READ_ONCE(cmd->sqe->addr));
+	if (buf->reserved0 || buf->reserved1)
 		return -EINVAL;
-
-	if (buf.flags & ~UBLK_AUTO_BUF_REG_F_MASK)
+	if (buf->flags & ~UBLK_AUTO_BUF_REG_F_MASK)
 		return -EINVAL;
-	io->buf.auto_reg = buf;
 	return 0;
 }
 
@@ -3107,17 +3108,25 @@ static void ublk_clear_auto_buf_reg(struct ublk_io *io,
 		 * responsibility for unregistering the buffer, otherwise
 		 * this ublk request gets stuck.
 		 */
-		if (io->buf_ctx_handle == io_uring_cmd_ctx_handle(cmd))
+		if (buf_idx &&
+		    io->buf_ctx_handle == io_uring_cmd_ctx_handle(cmd))
 			*buf_idx = io->buf.auto_reg.index;
 	}
 }
 
-static int ublk_handle_auto_buf_reg(struct ublk_io *io,
-				    struct io_uring_cmd *cmd,
-				    u16 *buf_idx)
+static inline void ublk_apply_io_buf(const struct ublk_device *ub,
+				     struct ublk_io *io,
+				     struct io_uring_cmd *cmd,
+				     unsigned long buf_addr,
+				     const struct ublk_auto_buf_reg *auto_buf,
+				     u16 *buf_idx)
 {
-	ublk_clear_auto_buf_reg(io, cmd, buf_idx);
-	return ublk_set_auto_buf_reg(io, cmd);
+	if (ublk_dev_support_auto_buf_reg(ub)) {
+		ublk_clear_auto_buf_reg(io, cmd, buf_idx);
+		io->buf.auto_reg = *auto_buf;
+	} else {
+		io->buf.addr = buf_addr;
+	}
 }
 
 /* Once we return, `io->req` can't be used any more */
@@ -3134,18 +3143,6 @@ ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd)
 	return req;
 }
 
-static inline int
-ublk_config_io_buf(const struct ublk_device *ub, struct ublk_io *io,
-		   struct io_uring_cmd *cmd, unsigned long buf_addr,
-		   u16 *buf_idx)
-{
-	if (ublk_dev_support_auto_buf_reg(ub))
-		return ublk_handle_auto_buf_reg(io, cmd, buf_idx);
-
-	io->buf.addr = buf_addr;
-	return 0;
-}
-
 static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 				    unsigned int issue_flags,
 				    struct ublk_queue *ubq, unsigned int tag)
@@ -3286,6 +3283,7 @@ static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 		      struct ublk_io *io, __u64 buf_addr, u16 q_id)
 {
+	struct ublk_auto_buf_reg auto_buf;
 	int ret;
 
 	/*
@@ -3294,11 +3292,13 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 	 * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
 	 */
 	mutex_lock(&ub->mutex);
-	ret = __ublk_fetch(cmd, ub, io, q_id);
-	if (!ret)
-		ret = ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
+	ret = ublk_validate_io_buf(ub, cmd, &auto_buf);
 	if (!ret)
+		ret = __ublk_fetch(cmd, ub, io, q_id);
+	if (!ret) {
+		ublk_apply_io_buf(ub, io, cmd, buf_addr, &auto_buf, NULL);
 		ublk_mark_io_ready(ub, q_id, io);
+	}
 	mutex_unlock(&ub->mutex);
 	return ret;
 }
@@ -3441,13 +3441,18 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 	case UBLK_IO_REGISTER_IO_BUF:
 		return ublk_daemon_register_io_buf(cmd, ub, q_id, tag, io, addr,
 						   issue_flags);
-	case UBLK_IO_COMMIT_AND_FETCH_REQ:
+	case UBLK_IO_COMMIT_AND_FETCH_REQ: {
+		struct ublk_auto_buf_reg auto_buf;
+
 		ret = ublk_check_commit_and_fetch(ub, io, addr);
+		if (ret)
+			goto out;
+		ret = ublk_validate_io_buf(ub, cmd, &auto_buf);
 		if (ret)
 			goto out;
 		io->res = result;
 		req = ublk_fill_io_cmd(io, cmd);
-		ret = ublk_config_io_buf(ub, io, cmd, addr, &buf_idx);
+		ublk_apply_io_buf(ub, io, cmd, addr, &auto_buf, &buf_idx);
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
 			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
 		compl = ublk_need_complete_req(ub, io);
@@ -3456,10 +3461,8 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 			req->__sector = addr;
 		if (compl)
 			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
-
-		if (ret)
-			goto out;
 		break;
+	}
 	case UBLK_IO_NEED_GET_DATA:
 		/*
 		 * ublk_get_data() may fail and fallback to requeue, so keep
@@ -3467,8 +3470,7 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		 * request
 		 */
 		req = ublk_fill_io_cmd(io, cmd);
-		ret = ublk_config_io_buf(ub, io, cmd, addr, NULL);
-		WARN_ON_ONCE(ret);
+		io->buf.addr = addr;
 		if (likely(ublk_get_data(ubq, io, req))) {
 			__ublk_prep_compl_io_cmd(io, req);
 			return UBLK_IO_RES_OK;
-- 
2.25.1

