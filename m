Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83CE233136
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246032; cv=none; b=jEd1cQZPEARRs2mrvpNrJ1OCw9hCMwHrFOahsjHsUeXJr4uKiS8x2mxBD6cqZGweHLgEqKwxE5gNWp8uAAeNiUey0RD9BCpHeVhEu8GAXAkjeETUFX/81sMfTuJ89nzPXGoVQI/YOLIEsNLlNQpQjGSbCVSHXKioGFjaHHeaNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246032; c=relaxed/simple;
	bh=eZlKVaYoX+oDj3KEWN4HaAuLIGHVzCR6TZf62rQujmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMzfWSaPQaWrrCeokZs8Ps5KbKwpt+pwqr+D/umt7inV4NLqwkDO38qyRLTKM2sZj7m5FSpgiJg03ZwF7NtF3uE7nMbweSjcEQhGlxsLrpeVJEEj1FyWvjrtKkZjCW12jsOAzE8SM4leflZlb2GfzYBbF6+TcHz4RfwIJi2xYhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AlDnK1IC; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AlDnK1IC"
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-7d09a878262so32942885a.3
        for <linux-block@vger.kernel.org>; Fri, 06 Jun 2025 14:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749246030; x=1749850830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPBs0/jDgZvxw/HJQ1MUbSYsKIoNmGmOMgYAxM++V48=;
        b=AlDnK1ICBfjyeVg+rnYPW1uXF052Fn4vlYFn8KoVN0oR5aDpxjS5sN6Jf4OwT0jCgD
         5gxmYvMxaVTipOvUIZYeAV0QBtOG9RHUaxKTU6e/qfbf9Y8vbqdKnKrsPYWAKCHrCVM9
         6KxcSsRqDe1C2uwg6k6fKnQWJP/hM5X72e6oE0E53UWfognf7Lh1zLybDCq9pS5IUjbz
         79Dgfu3nf9uh6z4meTCwGtHch1XGCUSLJHznI9vTTqahNeDA8iEf7oB7pecANMq9vlUP
         duzHs8mfL2VBzCNlETZCljYfVIBZOrw4C/YhqfPIm807WKnpe0cUaBA62GigT198pAFN
         BkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246030; x=1749850830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPBs0/jDgZvxw/HJQ1MUbSYsKIoNmGmOMgYAxM++V48=;
        b=E+YuP8bNF/t3JY2aFHn4zaIJWMCVKwpPJCKuVC54IEWm5m1fh02x4GP5xjGhNBj/pm
         yBox4PJyOusxytPmcflPU/K3dgEdRxKfc3OSWRX9NeDgH1u6Fn4jhwKn+M6TCx3a0oZO
         1kq+fzpJfYRbIBVP7Y9Ju/SGyatSu/x91t9vX1F9QHxrKJ89k+QOcyKT+FZhGYSUQDTU
         aM6NjQmglgYxpqfvUb03r1F8lXR3mDOEDKuaxzdGM2VzLnl/6mDpGOa+ON4tLzG3F4yb
         9f49vkCM8qA/MsZU75+YAH4OJqrxWoGNjzevf2tBETtvbpYnqFET8c7upRcARCHFUk7e
         9iUw==
X-Forwarded-Encrypted: i=1; AJvYcCU/rAvHz9wdh0XbHKdhZdV3WyhoSBY7k+D1YqLUM46PuJCbT3gqJKQdA9RwhXt65io+7KJpW1t5CeJnjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7mjAjqCYy4G7b3eT0yFrXx2wwG3rHG0snKskZBeOM5+njdM/X
	hVXMx91o0HiQ9tvWJ6bVUjsX6bxR8tJnPTQs/VerBmNYXh9hI8Z2isQxXDUwCtPFuLVOc74roAQ
	ufAerihiyRNAjtrv8JnWR60beYsveDUHz2sSc
X-Gm-Gg: ASbGncsoKGiuWwzb5e7X+JpvqLufDi7nJ6t5xxgKafo5+4j8nyhkz3FmwlgYzokVBS0
	BJbaSCn0Fg9kiE5/n0+ZHSMAc1vGtboKVtyE0T5brfs3FZUyvKsRZubPJ5O9Zo7l7WfLCL16VEg
	D92JkseO1FX7obwXCBfs8ZYUb/kqtc1X4uaNcsNgS2yEdK/TfJnxUbGJu+PsGD/T+X6sofzbQz+
	2J2UnX4nq/PZRgCXeeIxVZNnmyu8hGpxP43yshK4e0CJd317QT4AkGrJlPDfNYVi5EoMkURFRJa
	2ITQVpeN8qayEnon6IfnUWHLRKyxzpNUkGntQUvtgQumz9KUIfBzFe8=
X-Google-Smtp-Source: AGHT+IEu4U85APW0UT24zZLwnvAYd7LzF4salmg7+hSwVTMjBfl2enFQWO9UMihbZ+dVMNr7iAB5N57fm5RI
X-Received: by 2002:a05:620a:290b:b0:7ce:e99e:bc87 with SMTP id af79cd13be357-7d229956d52mr280374785a.6.1749246029632;
        Fri, 06 Jun 2025 14:40:29 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6fb09b2d263sm1252826d6.39.2025.06.06.14.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:40:29 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 069AB3400F3;
	Fri,  6 Jun 2025 15:40:29 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id F3B46E41EEA; Fri,  6 Jun 2025 15:40:28 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 7/8] ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon task
Date: Fri,  6 Jun 2025 15:40:10 -0600
Message-ID: <20250606214011.2576398-8-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250606214011.2576398-1-csander@purestorage.com>
References: <20250606214011.2576398-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_register_io_buf() performs an expensive atomic refcount increment,
as well as a lot of pointer chasing to look up the struct request.

Create a separate ublk_daemon_register_io_buf() for the daemon task to
call. Initialize ublk_rq_data's reference count to a large number, count
the number of buffers registered on the daemon task nonatomically, and
atomically subtract the large number minus the number of registered
buffers in ublk_commit_and_fetch().

Also obtain the struct request directly from ublk_io's req field instead
of looking it up on the tagset.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 59 ++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2084bbdd2cbb..ec9e0fd21b0e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -81,12 +81,20 @@
 #define UBLK_PARAM_TYPE_ALL                                \
 	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
 	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
 	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
 
+/*
+ * Initialize refcount to a large number to include any registered buffers.
+ * UBLK_IO_COMMIT_AND_FETCH_REQ will release these references minus those for
+ * any buffers registered on the io daemon task.
+ */
+#define UBLK_REFCOUNT_INIT (REFCOUNT_MAX / 2)
+
 struct ublk_rq_data {
 	refcount_t ref;
+	unsigned buffers_registered;
 
 	/* for auto-unregister buffer in case of UBLK_F_AUTO_BUF_REG */
 	u16 buf_index;
 	void *buf_ctx_handle;
 };
@@ -677,11 +685,12 @@ static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
 		struct request *req)
 {
 	if (ublk_need_req_ref(ubq)) {
 		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
-		refcount_set(&data->ref, 1);
+		refcount_set(&data->ref, UBLK_REFCOUNT_INIT);
+		data->buffers_registered = 0;
 	}
 }
 
 static inline bool ublk_get_req_ref(const struct ublk_queue *ubq,
 		struct request *req)
@@ -706,10 +715,19 @@ static inline void ublk_put_req_ref(const struct ublk_queue *ubq,
 	} else {
 		__ublk_complete_rq(req);
 	}
 }
 
+static inline void ublk_sub_req_ref(struct request *req)
+{
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+	unsigned sub_refs = UBLK_REFCOUNT_INIT - data->buffers_registered;
+
+	if (refcount_sub_and_test(sub_refs, &data->ref))
+		__ublk_complete_rq(req);
+}
+
 static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_NEED_GET_DATA;
 }
 
@@ -1184,14 +1202,12 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 
 static void ublk_auto_buf_reg_fallback(struct request *req)
 {
 	const struct ublk_queue *ubq = req->mq_hctx->driver_data;
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
-	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
 	iod->op_flags |= UBLK_IO_F_NEED_REG_BUF;
-	refcount_set(&data->ref, 1);
 }
 
 static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
 			      unsigned int issue_flags)
 {
@@ -1207,13 +1223,12 @@ static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
 			return true;
 		}
 		blk_mq_end_request(req, BLK_STS_IOERR);
 		return false;
 	}
-	/* one extra reference is dropped by ublk_io_release */
-	refcount_set(&data->ref, 2);
 
+	data->buffers_registered = 1;
 	data->buf_ctx_handle = io_uring_cmd_ctx_handle(io->cmd);
 	/* store buffer index in request payload */
 	data->buf_index = pdu->buf.index;
 	io->flags |= UBLK_IO_FLAG_AUTO_BUF_REG;
 	return true;
@@ -1221,14 +1236,14 @@ static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
 
 static bool ublk_prep_auto_buf_reg(struct ublk_queue *ubq,
 				   struct request *req, struct ublk_io *io,
 				   unsigned int issue_flags)
 {
+	ublk_init_req_ref(ubq, req);
 	if (ublk_support_auto_buf_reg(ubq) && ublk_rq_has_data(req))
 		return ublk_auto_buf_reg(req, io, issue_flags);
 
-	ublk_init_req_ref(ubq, req);
 	return true;
 }
 
 static bool ublk_start_io(const struct ublk_queue *ubq, struct request *req,
 			  struct ublk_io *io)
@@ -2019,10 +2034,31 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	}
 
 	return 0;
 }
 
+static int ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
+				       const struct ublk_queue *ubq,
+				       const struct ublk_io *io,
+				       unsigned index, unsigned issue_flags)
+{
+	struct request *req = io->req;
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+	int ret;
+
+	if (!ublk_support_zero_copy(ubq) || !ublk_rq_has_data(req))
+		return -EINVAL;
+
+	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
+				      issue_flags);
+	if (ret)
+		return ret;
+
+	data->buffers_registered++;
+	return 0;
+}
+
 static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 		      struct ublk_io *io, __u64 buf_addr)
 {
 	struct ublk_device *ub = ubq->dev;
 	int ret = 0;
@@ -2131,13 +2167,17 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 	io->res = ub_cmd->result;
 
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = ub_cmd->zone_append_lba;
 
-	if (likely(!blk_should_fake_timeout(req->q)))
-		ublk_put_req_ref(ubq, req);
+	if (unlikely(blk_should_fake_timeout(req->q)))
+		return 0;
 
+	if (ublk_need_req_ref(ubq))
+		ublk_sub_req_ref(req);
+	else
+		__ublk_complete_rq(req);
 	return 0;
 }
 
 static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io)
 {
@@ -2231,11 +2271,12 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
 		goto out;
 
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
-		return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
+		return ublk_daemon_register_io_buf(cmd, ubq, io, ub_cmd->addr,
+						   issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		ret = ublk_commit_and_fetch(ubq, io, cmd, ub_cmd, issue_flags);
 		if (ret)
 			goto out;
 
-- 
2.45.2

