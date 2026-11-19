Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088959;
	b=UT3Je/9JMlmZ7eIW3bg/A5kq+jP8FOpaQyPyr+hhiyHObWR61wU5AhiwLiJx8Jh9QDAv
	 P2W11gw5FrmhwwUSYV0Egs0VGovJ3eeljftprpjVgsY6yv6SdueatSwWBg/xGrlE0oVJE
	 I22+z4YJq15CBBes2W7320jrdGbgpVTnhQzOY9Poh2tR/LKCfMBzHpiuOnxzZbjrUKCo7
	 WtoFA1T1EsZh+CTEFo6gBm45po5jopDm06q/b/95Kc0F02i8NOq1vsPghdgnid6ySEYQX
	 Gf1uupXOuUbnSquGA4XfScEYFuwZ7HSxEjCKloZp+akDRFnpssxs68Xb9AoyT9wZc4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088959;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:X-Sendblock-Type:CMS-TYPE:cpgsPolicy:
	 X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=N7tVbsh0LqT0VzEJMeLD6neUt6uM+hXrRx1fqrE8qBc=;
	b=UaDTZBwYse7LiMcrNNGkE/FyXQT4UO4d8ydndgW1GjRoWNpn05h8tydKLwoVuc5aQXSZ
	 w+LHO1MRnts68hoLIkuMJrZRLwR8bXemYKQUvuVGGX2V+ApFimzOhxDeOQxFjjEuY5QKe
	 f5N0pRllccytEiF57EZePp0mTsjIrEaL9vFfgFyWUuwQKwS/ziIljFTBuL4sz0CQ4waHy
	 l/co1m7Pag7gbaykfaUPBToMTSlAzck5M+o4KdNqsLhiPh500Zctl5gcUaiAM+bgYq3La
	 5DnzAu3k61xhPuDkHlaG/1kI6Rzugepk74VqzpcoXGqKSC3o9tXCmkpz55PFB+RDjmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=OrFzQOG8;
	arc=none smtp.remote-ip=203.254.224.25
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF7606A32A
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 11:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DEF7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=OrFzQOG8
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20261119114916epoutp0289aaea1aa2fb78b92adfd7385a716fc4~pb_U1OYkb2967229672epoutp02b
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 11:49:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20261119114916epoutp0289aaea1aa2fb78b92adfd7385a716fc4~pb_U1OYkb2967229672epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795088956;
	bh=N7tVbsh0LqT0VzEJMeLD6neUt6uM+hXrRx1fqrE8qBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OrFzQOG8AhKTS+JWp1fcHm/2kQw3x63WaqzeEaD1wLuMOdEYRo2+UfHAga9uzV5yz
	 bFmxsRbOQ9vOBcp84vEofZgCLaBShxXnvSG4ym6217Bmk2mtMVFkEYWxZ7PxBrddmO
	 dLrFBzAoYgYBlPyxjEtiwgWYe50G31mGhM7kHhas=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20261119114916epcas5p2796b27294f94ffccea07dcaf08feef05~pb_UPL93_2787827878epcas5p25;
	Thu, 19 Nov 2026 11:49:16 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4jVcFR2mQLz6B9m4; Thu, 19 Nov
	2026 11:49:15 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20261119095723epcas5p211971408f19e8e1f0a576a9aa9b17cdd~pacod56ka2073620736epcas5p2E;
	Thu, 19 Nov 2026 09:57:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119095720epsmtip1b3b66c8f284ae599fa36ef294ae64995~pacmHDkUO2192721927epsmtip1Z;
	Thu, 19 Nov 2026 09:57:20 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, asml.silence@gmail.com, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, James.Bottomley@HansenPartnership.com, mkp@kernel.org,
	bernd@bsbernd.com, joannelkoong@gmail.com, miklos@szeredi.hu
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	fuse-devel@lists.linux.dev, joshi.k@samsung.com, anuj20.g@samsung.com
Subject: [PATCH v4 3/5] io_uring/uring_cmd: support dma-buf registered
 buffers
Date: Thu, 19 Nov 2026 15:26:13 +0530
Message-Id: <20261119095615.1840522-4-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261119095615.1840522-1-anuj20.g@samsung.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261119095723epcas5p211971408f19e8e1f0a576a9aa9b17cdd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261119095723epcas5p211971408f19e8e1f0a576a9aa9b17cdd
References: <20261119095615.1840522-1-anuj20.g@samsung.com>
	<CGME20261119095723epcas5p211971408f19e8e1f0a576a9aa9b17cdd@epcas5p2.samsung.com>

Let callers of io_uring_cmd_import_fixed() opt in to dma-buf registered
buffers with IO_URING_CMD_IMPORT_DMABUF, and attach the current map on
import.

The map has to be dropped at hardware completion rather than from
task_work. Add io_uring_cmd_hw_done() for drivers to call from end_io,
which drops the map and queues task_work, and warn if task_work is
queued with a map still attached.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/io_uring/cmd.h |  9 +++++++++
 io_uring/uring_cmd.c         | 28 ++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 23fb66a1e2c1..d4e17c2f59fd 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -12,6 +12,9 @@
 /* io_uring_cmd is being issued again */
 #define IORING_URING_CMD_REISSUE	(1U << 31)
 
+/* io_uring_cmd_import_fixed() flags */
+#define IO_URING_CMD_IMPORT_DMABUF	(1U << 0)
+
 struct io_uring_cmd {
 	struct file	*file;
 	const struct io_uring_sqe *sqe;
@@ -86,6 +89,8 @@ void __io_uring_cmd_done(struct io_uring_cmd *, unsigned issue_flags);
 void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 			    io_req_tw_func_t task_work_cb,
 			    unsigned flags);
+void io_uring_cmd_hw_done(struct io_uring_cmd *ioucmd,
+			  io_req_tw_func_t task_work_cb);
 
 /*
  * Note: the caller should never hard code @issue_flags and only use the
@@ -145,6 +150,10 @@ static inline void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 			    io_req_tw_func_t task_work_cb, unsigned flags)
 {
 }
+static inline void io_uring_cmd_hw_done(struct io_uring_cmd *ioucmd,
+					io_req_tw_func_t task_work_cb)
+{
+}
 static inline void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 7198647f542d..c64b86c6f028 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -10,6 +10,7 @@
 
 #include "io_uring.h"
 #include "alloc_cache.h"
+#include "dma-buf.h"
 #include "rsrc.h"
 #include "kbuf.h"
 #include "uring_cmd.h"
@@ -28,6 +29,7 @@ static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	struct io_async_cmd *ac = req->async_data;
 
+	io_detach_dmabuf_map(req);
 	if (issue_flags & IO_URING_F_UNLOCKED)
 		return;
 
@@ -132,12 +134,26 @@ void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 
 	if (WARN_ON_ONCE(req->flags & REQ_F_APOLL_MULTISHOT))
 		return;
+	/* the dma-buf map must be dropped first, see io_uring_cmd_hw_done() */
+	WARN_ON_ONCE(req->dmabuf_map);
 
 	req->io_task_work.func = task_work_cb;
 	__io_req_task_work_add(req, flags);
 }
 EXPORT_SYMBOL_GPL(__io_uring_cmd_do_in_task);
 
+/*
+ * Queue completion in task context after dropping references that must be
+ * released at hardware completion rather than from task_work.
+ */
+void io_uring_cmd_hw_done(struct io_uring_cmd *ioucmd,
+			  io_req_tw_func_t task_work_cb)
+{
+	io_detach_dmabuf_map(cmd_to_io_kiocb(ioucmd));
+	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, IOU_F_TWQ_LAZY_WAKE);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_hw_done);
+
 /*
  * Called by consumers of io_uring_cmd, if they originally returned
  * -EIOCBQUEUED upon receiving the command.
@@ -257,6 +273,7 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 
 	ret = file->f_op->uring_cmd(ioucmd, issue_flags);
 	if (ret == -EAGAIN) {
+		io_detach_dmabuf_map(req);
 		ioucmd->flags |= IORING_URING_CMD_REISSUE;
 		return ret;
 	}
@@ -274,13 +291,20 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      unsigned int import_flags)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	unsigned int flags = 0;
+	int ret;
 
 	if (WARN_ON_ONCE(!(ioucmd->flags & IORING_URING_CMD_FIXED)))
 		return -EINVAL;
-	if (WARN_ON_ONCE(import_flags))
+	if (WARN_ON_ONCE(import_flags & ~IO_URING_CMD_IMPORT_DMABUF))
 		return -EINVAL;
+	if (import_flags & IO_URING_CMD_IMPORT_DMABUF)
+		flags |= IO_REGBUF_IMPORT_ALLOW_DMABUF;
 
-	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags, 0);
+	ret = io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags, flags);
+	if (ret)
+		return ret;
+	return io_attach_dmabuf_map(req, iter, issue_flags);
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
-- 
2.25.1

