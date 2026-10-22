Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680350;
	b=3HNDUqS+4jqZAJfTeVMTjK23U6vQElefdGkBlAPtJfq4O93L+oq9N8ES1PsnfBf/C74i
	 WFYvC7Tb3ih5R9kmK8/sk/FWkhWxJxB1sZlYVDDkmsGnhFtlBM4mi7ni0aFeCfmY87XLc
	 H4pFHjkvqcMqvOnXJvi1mGDLryhGKiPCya6s1+2v1aYrAPiasjSEGNhHWt69A8Xzlnbtw
	 ohm7nYfK3l9pb0giXFwpF+1f5OxU1ow0kjCi+tBzhZfRACF8Tw1mlphhgjsh4J7Q8N3L/
	 U4cb3RaHv+b7mFIeCJhypD0CPvvNlco3TgUS3BgFu+mcoPuGCtt8z4pj2zwC2HbtITw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8Bvapck2YZWyHBU4/NPzDAoWoqpmu4MGPJ1W1o84MUI=;
	b=t0G0/3MhVRieze6TcWOIx2pxz12l8E6T1Dw+RzCkzw+K37Lac3YpVcvXAasNrfrHiQHZ
	 DqzuKHgFAhOSr1Rjz689BpRrN9VpXcnafopZs4dRmJ8ARuUXWfWrdMGoq/V+v7XZnLjRM
	 38sorwQY5EJKpXHjyNKRsrgwpSO5SjEGqln2uxHyk03wpr9qC+FBiPAb7V9u0AA72qU9g
	 0cWJZV+Ag8kSZzrWFplN5h2LPm49VB/69HKA0apX9LpEF7UmLOOlw9oR5H0jgrkaDhAIM
	 wo4OwK+2bcBGhrgn+P3ZMANnF9aTR3leqelNhCUBfUv9b29+kaLNZAkU769oR801U4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P9SOghJH;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFE606A31A
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 14:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7EFE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P9SOghJH
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36681e85e87so4073259eec.1
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 07:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792680349; x=1793285149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Bvapck2YZWyHBU4/NPzDAoWoqpmu4MGPJ1W1o84MUI=;
        b=P9SOghJHObLq9J5Tiaoz7sSrJUBjqbMaAaEVeg6HivGx2sgyt79pFvmte4xPwYiRY1
         RYvY5bYLVTxgBoLtzQxKxde473SW6YhXxV4Z8MUXBUHgPoHA4gnbJKK9Xzx56YRbeySn
         WD1srDNYYn29WCupO9wDHleWFMilODG12NQMkdsUgbra1pKBekay/iIAfdUPiMFrvxS0
         ZEVzUrJmn3LDG4XvYTkH3facur7BERUUC051UA9lckveOTJNsc9ZADXkANI6VayFadPI
         s9zZNztNMKBHH9KdHCyPzkoYLx5disFyq1C+86eLx0csZhlvd/9V2Ftj/00OyZzc4bi7
         ejwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680349; x=1793285149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Bvapck2YZWyHBU4/NPzDAoWoqpmu4MGPJ1W1o84MUI=;
        b=OMyhZkW3dgzcNYiHZvlO2srkytdbOaaa08e/TFcL9A1Lumsx8SrWGGtKPtunLCsqow
         mFaNJJXElTzFlMaUV3SRO2jzb8o6go/8DGtpOwRTtZ8zA/UrRMiFp5MiXQdLPsj0IfOa
         8FRDBjoMg8tmgVfua2uOIo2DaKqFpLuXRzv0sltWjB2Ufl1fCf0J8dsvehMy1lL7XY+P
         Y4Cf6sPWY5vDjBhgB1J3UwqNnlEyWvzcPYXIWFgq+V2hyKgvzBf+d7rySSPIV4KEU0/p
         P5Ivqa3uayIM3I5u7orK1LGQlu04+WSMspQkVzQDZMjjI8G4hLU9uuK+cWSwAUqMKOt1
         +cSw==
X-Forwarded-Encrypted: i=1; AKwUvBxHdMzoQn7b1ty9FkmwreQEEzWMw47Q0KXoOFPXdlv9LtwyL+f8U4vUY6Q+is6bmiSiC2ZV9RXk44VX5g==@vger.kernel.org
X-Gm-Message-State: AFq9FYIOV32H57zQnskX6RhV0S9/d6AGuE35cFfqk/K2XMDGmtqKsgTD
	sjaEcdLRb3IJhIubEApmNYiWdgcZVwMQ5JFxgBOJINx6Ce7xetJRljI=
X-Gm-Gg: AYBFou0sAU9PGslwGS1SrU2kmmofUcgR9fKV4tLulxg4YKiMo01F+lfETwvlzDptm83
	H4woLZOlp/xCHxc97zKnQZQk7/9fNOE5diP9k9ScW9tUmdGYDdYt36UUaWUwXYLzaAv042wRiie
	iOMX81Zh7Yg6y6OUGot4Gtc/mWK2Lkpc71snwsCWzwRJxqI79HXo14TfiQJJzx5zbC3TfaJw+qS
	jHh4ScNhXJwQLRwzWuiU4E2Y8x4ZDQC62yjzkgpBvp4GOGPXOT0g9Qr1LBCV5IY2WND2CTrQ/G/
	GKTEycfm+mioOeknz2nQmZaH/1MIqVOhZWlnTJ9ksMCcktoKfrf31PGK0lRFaEJZB/juwymqNQP
	/euerqbhKJz4Ouw2iVNRc83SKDmy7CWaHJfBtvD3QP6tHp7TVcT2Eg160bTjoy09B3AR/Z6BkwF
	tgxopmb88hFtx4R31L0MfV4MX9JOQ2gXIhCnu7crsBaJJ/xL2fStTDo3qHq4nuHs/fISofuyBEk
	VHCzfxB3iYugT/Y0cbfZHJY1Ph7K293jGk44H8OAnlyEv23dX++4zkMW1mejXxjzVSp0QkLFbzS
	DCafSW5KY6Row2P3sLhCoytIaz7pkBEUhuXCYXk/SiP39rLtQjuSMb0ObhX/C9gB
X-Received: by 2002:a05:701b:4284:10b0:14a:9dc3:dd11 with SMTP id a92af1059eb24-190a5999e7fmr7654858c88.18.1792680348543;
        Thu, 22 Oct 2026 07:45:48 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:5016:92c7:7a35:f3ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm23625880c88.5.2026.10.22.07.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:45:47 -0700 (PDT)
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
Subject: [PATCH v2 1/5] io_uring/rsrc: pass import flags to io_import_reg_buf()
Date: Thu, 22 Oct 2026 20:14:52 +0530
Message-ID: <20261022144501.2478417-2-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022144501.2478417-1-anuj1072538@gmail.com>
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
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

Give io_import_reg_buf() the import flags argument and drop the
__io_import_reg_buf() variant, which only existed to pass them.

No functional change.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 io_uring/net.c       |  6 +++---
 io_uring/rsrc.c      |  6 +++---
 io_uring/rsrc.h      | 13 +++----------
 io_uring/rw.c        |  5 +++--
 io_uring/uring_cmd.c |  2 +-
 5 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 050ed274170a..63089744d43e 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -644,7 +644,7 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 	if (req->flags & REQ_F_IMPORT_BUFFER) {
 		ret = io_import_reg_buf(req, &kmsg->msg.msg_iter,
 					(u64)(uintptr_t)sr->buf, sr->len,
-					ITER_SOURCE, issue_flags);
+					ITER_SOURCE, issue_flags, 0);
 		if (unlikely(ret))
 			return ret;
 		req->flags &= ~REQ_F_IMPORT_BUFFER;
@@ -1216,7 +1216,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	if (req->flags & REQ_F_IMPORT_BUFFER) {
 		ret = io_import_reg_buf(req, &kmsg->msg.msg_iter,
 					(u64)(uintptr_t)sr->buf, sr->len,
-					ITER_DEST, issue_flags);
+					ITER_DEST, issue_flags, 0);
 		if (unlikely(ret)) {
 			kmsg->msg.msg_inq = -1;
 			sel.buf_list = NULL;
@@ -1509,7 +1509,7 @@ static int io_send_zc_import(struct io_kiocb *req,
 	if (!(sr->flags & IORING_SEND_VECTORIZED)) {
 		ret = io_import_reg_buf(notif, &kmsg->msg.msg_iter,
 					(u64)(uintptr_t)sr->buf, sr->len,
-					ITER_SOURCE, issue_flags);
+					ITER_SOURCE, issue_flags, 0);
 	} else {
 		unsigned uvec_segs = kmsg->msg.msg_iter.nr_segs;
 
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index d64228b0e19e..1abfbb86dae8 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1365,9 +1365,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
-			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags, unsigned import_flags)
+int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+		      u64 buf_addr, size_t len, int ddir,
+		      unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 418d236152ff..6226c7862d4e 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -66,21 +66,14 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
 struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 				      unsigned issue_flags);
-int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
-			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags, unsigned import_flags);
+int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+		      u64 buf_addr, size_t len, int ddir,
+		      unsigned issue_flags, unsigned import_flags);
 int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
 			unsigned nr_iovs, unsigned issue_flags,
 			unsigned import_flags);
 
-static inline int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
-				    u64 buf_addr, size_t len, int ddir,
-				    unsigned issue_flags)
-{
-	return __io_import_reg_buf(req, iter, buf_addr, len, ddir, issue_flags, 0);
-}
-
 static inline int io_import_reg_vec(int ddir, struct iov_iter *iter,
 				    struct io_kiocb *req, struct iou_vec *vec,
 				    unsigned nr_iovs, unsigned issue_flags)
diff --git a/io_uring/rw.c b/io_uring/rw.c
index d33b925a848e..71782a23e16b 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -360,8 +360,9 @@ static int io_init_rw_fixed(struct io_kiocb *req, unsigned int issue_flags,
 	int ret;
 
 	if (!io->bytes_done) {
-		ret = __io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
-					  issue_flags, IO_REGBUF_IMPORT_ALLOW_DMABUF);
+		ret = io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
+					issue_flags,
+					IO_REGBUF_IMPORT_ALLOW_DMABUF);
 		if (ret)
 			return ret;
 		iov_iter_save_state(&io->iter, &io->iter_state);
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 73b606899833..45c9c845f5d0 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -279,7 +279,7 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 	if (WARN_ON_ONCE(!(ioucmd->flags & IORING_URING_CMD_FIXED)))
 		return -EINVAL;
 
-	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags);
+	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags, 0);
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
-- 
2.43.0

