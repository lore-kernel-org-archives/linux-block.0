Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324759;
	b=byR4p4XcGax2yu4GMmzzuKlTE8Rqwzl7j79DF4Nf6+o9YdN1Z46HmxuoJZKkVWrFCPGN
	 0oTKs/Am4zqJp802qRixX8qusHkGX33LAS/ntvOZh5YsR9KOnnLLkWfECcQFy8v0myB8Z
	 SUEjZjTXm1v9HgS4m/5g4jaNavrlk98KtBzxMXOHrJDZFuDAV+tVTi9aCzBDEI9Lu8mte
	 htfEb6ZI6Po1st/czEEeP4gzvhJlkxXEiCpiSYKIs3S6doDcwz+fWUF6OAaAMOhcwdWRg
	 XBHv/YtnhkI8bqXpyv3lGiv650fZuo4p9tR835A/vzd1YfUXE36MGsW5x89s0fPg6Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ODvSAgyV/h/yeJCArNYdVO3F0icLZBSUlmTqdaSk0qI=;
	b=sxMljWub//uF6qHXQIh2VM1wH7yZfPx4Fvuimag/NAl6OxIyORbUtxiIzZNuK/fbp8Cv
	 tKmmWdguOt/BAl5mu9NzLJpEb0VhfHCLHfBTlhONJfXuMYIKQiPY0JKiqJ5rxvbQMMCjt
	 G+UdsuDLgeI9zIX5xiaPUhm80t/IYVe35sGx952ORC9Wi382o2jQhjp2rxsV4c/lg8s6G
	 tLdG4J9D+xPebx3980OcKRZIDYWAzg5EIkU4wyvElIpuUVgfHmGv+l/EDPUzUx7puSo+W
	 YaPWlyFRxdJGcPQPTXjTRQY6FBU8c/PkRAuvhIcKMxGF8KOvIr11uiWOIRBGNmCIFnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ERqyOc/a";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29396606A31C
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 01:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29396606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ERqyOc/a
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35c76e9614aso409576eec.0
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 18:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793324758; x=1793929558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ODvSAgyV/h/yeJCArNYdVO3F0icLZBSUlmTqdaSk0qI=;
        b=ERqyOc/arjTQd+ob0SEMV+H7q4Sy3FNhJRpQZPrMFbzh/E7RaYSsx85yXrbbSpeTG8
         G8nhEDEu/PHW9IE3C06owdQOgNh23BEWdm8ZkeVeKfMj7eAtN2cC1+ws5FKJX/cSVmH3
         xGaFOU8syrrCQgUzYsRapYSJB0Jr8cpHtywlildS/bewHJ/c5VmiarVfQYw4azvQyHgO
         k0v3/8cg7XM8yqd2KEieXWELvfTW3h7yWSPvJj3hrSX7jfRXJdb9cgCFmDiTTfrMBTD7
         4TYzVAxMBqpPXfu7FF8I2Y74oDsbHfQ+860jLEIesNsKe6qiDsAAE2IfU8VwziBF005P
         U4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793324758; x=1793929558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ODvSAgyV/h/yeJCArNYdVO3F0icLZBSUlmTqdaSk0qI=;
        b=mQk18GR7AMZcJjhOoWm60reFtgYNeyISVwi3z+FxJw/NNaDGTCnTh2w3XchUrSXU5J
         eWxk8hfVn5J5yRobzuL59qcNXsyfdmIa//ENe+eql2luDhGCUUVMu0q4zMFgViS7yD8L
         vD/jnF9yXEzdod7cMqa9KkG6mXI9V+zNO4mzkIRjtrJNmO9ZX2/VS+S/NgjZTt+Y0pcH
         5NTywO3raQzjdwfY6qkLDEDPkZWLto8IPCAYJE0aVMljUNgKyi1LPA52T8VdHo9eE9Qm
         C5Wat7eTvyvauQ7YiBcO868o6HEUEls5zNd5lQcjdJrTl+GAOCCCGUgOJbUabILxHmLh
         Ho1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzJPXAlYdMGg+ay+WAZ9SQWhz4K/lP+7lrgH8b1pXAv9yzIRYdRZQuOXKkH2pkvNS7pJKs4OuA6Xl41lg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJt5rN35URUw8XZfUu15acfVcOQTjhCaFgUgox8wmxdlDw8kDed
	M++Jd/EwMDizLxkOpfUoGQlrUeUHzI9N3mn/LBYsGRqKk1J5BkBmaBw=
X-Gm-Gg: AYBFou3F8xFW33VT+CHSCIftq42K8n3EH0xoNVhCuME7bUy7WWS5r7JyF1teo439Oh/
	PxtGiy/7mBB1fmMcaZyB461AQkAEmbu5H0wYeCycCfUWz5vcOR7YqhQByTlue7tOm62xOCz6T5b
	NpLDU6Wm+JO6XlmZ/dSr4r2sYbcCS9C5XgysWqD7ibJf0FpTBRIoUYgYOIl8933w+odYa3l+NSB
	eIeSEeZZrWevfOVoxowQuDuJtmpJjk/+sEMRt2mnNUPSynrzLzk3un3Su6Mg0ap/9yU4lnxL4tS
	tSYOlXjLyublH32yLM2R//gYhDqW+gDAKesMz7KJvZDfF2sUjy5u7+qVHhU6R63GC5FsxYggv1D
	Eap8BnMISovqO69ekyi4R6Qg7o3F0l7P5w98qQ/e+hfgas1X7RuKUrr/fKJhSJd67lrpU6rvtlA
	MwVlhfJSK9Tz20NdDkE1/8wLVxqnddJysNgNw3AQTcaWzMQ8ehPyYJ6BhcE4On40KajsmXbx+Ai
	IpmeD4gDFNQsmXH9sFoD8z1IrDmwRpSkchuqA6kVsJDkvK+V3n69TJmV68ihVsJshGQF2B0FvlU
	VX+MonS6MRNwWM8krItD7gCaHq4NmwJhPJ5+lapKW5Bo39Ff0pcGvqWeZsSNRNkdjfh5xkHP5lI
	ZGpurT3N577Q6ZE6t
X-Received: by 2002:a05:693c:639c:10b0:36a:1f8:a56e with SMTP id 5a478bee46e88-36a423bb931mr1471206eec.23.1793324757946;
        Thu, 29 Oct 2026 18:45:57 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:75fd:f9a4:4062:7980:1324])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm2209020eec.12.2026.10.29.18.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:45:57 -0700 (PDT)
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
Subject: [PATCH v3 1/5] io_uring/rsrc: pass import flags to io_import_reg_buf()
Date: Fri, 30 Oct 2026 07:15:36 +0530
Message-ID: <20261030014540.3065403-2-anuj1072538@gmail.com>
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

Give io_import_reg_buf() the import flags argument and drop the
__io_import_reg_buf() variant, which only existed to pass them.

No functional change.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/net.c       |  6 +++---
 io_uring/rsrc.c      |  6 +++---
 io_uring/rsrc.h      | 13 +++----------
 io_uring/rw.c        |  5 +++--
 io_uring/uring_cmd.c |  2 +-
 5 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 533afd335627..5d0f7c0a1825 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -663,7 +663,7 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 	if (req->flags & REQ_F_IMPORT_BUFFER) {
 		ret = io_import_reg_buf(req, &kmsg->msg.msg_iter,
 					(u64)(uintptr_t)sr->buf, sr->len,
-					ITER_SOURCE, issue_flags);
+					ITER_SOURCE, issue_flags, 0);
 		if (unlikely(ret))
 			return ret;
 		req->flags &= ~REQ_F_IMPORT_BUFFER;
@@ -1242,7 +1242,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	if (req->flags & REQ_F_IMPORT_BUFFER) {
 		ret = io_import_reg_buf(req, &kmsg->msg.msg_iter,
 					(u64)(uintptr_t)sr->buf, sr->len,
-					ITER_DEST, issue_flags);
+					ITER_DEST, issue_flags, 0);
 		if (unlikely(ret)) {
 			kmsg->msg.msg_inq = -1;
 			sel.buf_list = NULL;
@@ -1536,7 +1536,7 @@ static int io_send_zc_import(struct io_kiocb *req,
 	if (!(sr->flags & IORING_SEND_VECTORIZED)) {
 		ret = io_import_reg_buf(notif, &kmsg->msg.msg_iter,
 					(u64)(uintptr_t)sr->buf, sr->len,
-					ITER_SOURCE, issue_flags);
+					ITER_SOURCE, issue_flags, 0);
 	} else {
 		unsigned uvec_segs = kmsg->msg.msg_iter.nr_segs;
 
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index e0345c3e764e..e9e4221ef86f 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1366,9 +1366,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
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
index 3a8559ff4dc6..327215e0f8b2 100644
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
index b5486b56ee0c..4dac3ba162ae 100644
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

