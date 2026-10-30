Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324772;
	b=heVU98G5WcRqgKmfqPht+bVNJnN4GaKCwXyaoHDST0zVbkQRg2gBfKCv7VNeYCsgPsAf
	 1yalXex6UiaIDWc62aIoK+Y5YKXCojjat2X1HSKo03PUijPZTe77sq/m0pxFvUFRTjlqa
	 vclKuu0nizIN/tZG/xHIlCXi+I2PBzE5QljqwdP0832mRBbeltR0a5q6XcVyiD2jaLOtp
	 AXrK+Y0ui8paANXys6237MeEZGfF7ptka95KzYNEjHDjnDPmXG4AbLSvCZelkkcotM2FU
	 HHZYjDECrpBFy084KD/6XfNhpTXfWm6K2lbmA8udaIku9mUm6eMyOZ7n4F/KcnJ7qBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lCyrcMpBQiz0VtWC05/bFg8KKUJTwPO8EsDhKRgsAck=;
	b=5qPf8eepWfhrVqQNf7AMO43ZRKmf99XyUtXlNEtpwZPjAlJdJelkgC3sE2dJsNJ/AbXR
	 WwIqyrerDxD2sUtkQ+EJoqzVntmaWuHPANP9+VkuBo6xV8jCsS0/k+Gicw7VrNd+WZrGS
	 vujTq0AFGj+XJFEpqy5fBkaS+zmukvtL+hcd3VKL0QW0i0bjVdyKJ6TEfIm5CUoXA7rXW
	 uyf9qtHsdrFXs7e8b6MTOIzfrW14JEHda20FkIwpiYDt0GIDQ+ZuNc7pkx6JK4zdvut9R
	 t7VVgtd+sUcMRoYsoiAjZ60QvYl7MRfLOb2MXAxysapyyM+gJP+Z6e/LN44XSO7LAGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mP1cJL/M";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766D7606A323
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 01:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 766D7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mP1cJL/M
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso352742eec.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 18:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793324771; x=1793929571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lCyrcMpBQiz0VtWC05/bFg8KKUJTwPO8EsDhKRgsAck=;
        b=mP1cJL/MpFzT6P3oH6WSjjB1MEHetUrgSXupQ7NyBzECGts+xtuiX3NQv+D7joCawY
         44Dmki5CtdoN29CZkIe9KQKJGnN2B4xWMlxBhENhWOeDoKNpuUOyVDT9lMIml3DcG9RS
         Jn6miet0U2fXe16f3NBzAw3dHSo8SMKHrNSqxSNMNea11SXGuik+yVhPxHN0Gyd+nHaC
         vqvLDU0LyGz9xjIrW7SU3hFy5ntKvRzbkpX/O8FHF6j0z362uQrwQzghqUgfhhX3eeaw
         v5z9c92JOVCTREB4HJBKiGpctKDYzFT4llI0JTN6HpIA2ECzBlU4lhEusNzAc9N9SEQc
         zduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793324771; x=1793929571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lCyrcMpBQiz0VtWC05/bFg8KKUJTwPO8EsDhKRgsAck=;
        b=qGouZX6fZXlQJJa2J0XoO+oXsutWXio4TdMVmIYSnLTOAWQM8IA7weltkCzNblUKM1
         xdRk3S/jS3uzpWZtBaDTviw0O4gzHAli2WPC0qKtBMjJzpT0WQ46mgTYZVUwfx0koA7f
         /awrzyE4eJ8VDGoPCwKDSe1UEKMfHL5ruspVuT329SnbUh2t+B1dzDO4YiJAHcInn1Cn
         94qHRRQ9NRzYfSZSCtTZRCjxi35GfYoK1XPbXeWvD/BI57MfB7ATjAIwV0TpnDALc5IH
         My5IuRpEcSVcAfqVfxpTi9UbmIsTHwT06q0Q1O6jYIjgnHdKLPoaoLWU1Vh6ZEOlwo+G
         eQEw==
X-Forwarded-Encrypted: i=1; AKwUvBxK02vVTTdSVLmvOzhuqsMu7NT5i3zP9Cb96PmQDDL3C9oLj01SBNSAJsZ29pzdav1+MeaadAPduAfUFw==@vger.kernel.org
X-Gm-Message-State: AFq9FYI8+oFoq+8ZqMb716AVVkFk1mz16roDXxRplPzVLmbOthUROdlu
	2CckMvvcIdMzpY37VXo0wbpxpahb82JK1u3VJGA7j8uoff4bqi4TINg=
X-Gm-Gg: AYBFou3Jj/52sXdJTPc+5HeDOQmGS1qYLLaQkpmx0bR8Iy0wq0V+ApSlH3nVgtVQKiD
	VBQhVhumiGMKowSOH2Ct6gZtZEesYbKX486tLZs+xTYzHmstg35Wl5D2ZAY9+YQeOYVbp8DiYBo
	gPB0gXgvzQ3S3QUrAiXttQgM7orE2xD5Bocusla4N4ag6bu6TS/rlx0+E+gCMJheFYDKn2ZXbGa
	5wk1ZZdTltbp8Z2CbvrmJfDHAPS1h3/0xtKeWeMRCHTG9vlZlouWzbvMfTgaXPG2pbWQ1eMgiVy
	LNf98CkgPUDxNjqO9yMAVgivvxzp6wqzHadxlqF6myJMJA2Hhc+AC1lFDkH3B7B65zbdA0kBmuY
	HkDuc1NNLwXv/alQIirasag2r65bzD5Mr17OfzECsTvL0Zu1ahR5wmACdfyKMikA8YFxlnNW2fy
	GIOBjTLirwIX7pI+nUY3rTECHSptcY1/KVA/iBpu1mZCjuUmuD2qpfH0QmMdJ0pL6uDMnU0wqtr
	B2b5s72aolzZcZZZNLpTzTU2wK7t3kCKf1pvUueY6/pVSpJQ7CCBPhBQQ+3gtsUNSx6ot6slPxV
	9XMUc2JZAhZuKGBJVMR/Vbcbkg1MM3dqdFhqAsBkmOwNekCIcFuM4WcqBOC7cXbYd8kBJEb9hfY
	wBKBRx34RwdnX2cDRvQ==
X-Received: by 2002:a05:701b:4189:20b0:182:6c6c:d876 with SMTP id a92af1059eb24-1ac5cb1a331mr1177745c88.8.1793324770340;
        Thu, 29 Oct 2026 18:46:10 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:75fd:f9a4:4062:7980:1324])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm2209020eec.12.2026.10.29.18.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:46:09 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	mkp@kernel.org,
	bernd@bsbernd.com,
	joannelkoong@gmail.com,
	miklos@szeredi.hu
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	joshi.k@samsung.com,
	anuj20.g@samsung.com
Subject: [PATCH v3 3/5] io_uring/uring_cmd: support dma-buf registered buffers
Date: Fri, 30 Oct 2026 07:15:38 +0530
Message-ID: <20261030014540.3065403-4-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030014540.3065403-1-anuj1072538@gmail.com>
References: <20261030014540.3065403-1-anuj1072538@gmail.com>
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

From: Anuj Gupta <anuj20.g@samsung.com>

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
index d77a94d19cb5..446bc8a363e6 100644
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
@@ -276,13 +293,20 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
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
2.43.0

