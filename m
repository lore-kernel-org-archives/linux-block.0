Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729FE2236E1
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160243; cv=none; b=P/oGEuNe0A4t6i1+etCr7tUyiEPC1DobQGszTQRj7rt3HE2AcsmjxoD9MPE8hK84BA4wYGP03z4OrMUiQa259ReHMOlbhH+cRC+N1Fy2fVZ8pNcs7OaPR4Ur7hd84ASRn7MXgToHh5DcyPjkQ88SJzqwGEtxIMitnj42zcv+m6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160243; c=relaxed/simple;
	bh=DlDgj6eQ2EJT7r8ICH2mTMh6q5NNv2cREX+Wo9B+YWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJvpYFsWYr0wyJrg0PxPVCt9U/pi+GsIvEFuppYDNTxodCcK0zlh8lpYUe8vzn40q1Apmrhh6Jv2qaj2FE+Lx3iItmlgYrvaNcaslvPJCHn0f6cq72o7UWeeLniSPdKX0jcD4kIv899Pgxufv+k32HlTazk34y/mGogW5C5yf8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KERz78NH; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KERz78NH"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-267fad019d4so794685ad.3
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160241; x=1758765041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbcWxaY4vl/Q4W3/rZm6xbJSq4ZIWjy+imubsiA0GUQ=;
        b=KERz78NHAwj/HZ65fN2dDof7/KV4WoZNGCG8/7xjbuJiz3iBoONwVd2siHYlwqUUzL
         roR4SNNz6AtwP2R9DwWP9tocnsAzzRP94g9Pm2uN53qSXHOj5yD75E9ugzv48miUNau7
         Rd0savGw0LG039/hxUp3smoDJ3fcYT8agTAYMDVlMVVv0tTqqW53yAzUPqONKqhCnyOk
         F3O8YH1tSOQp6teLqwaDsafqIcozJA7CQhcQSdmriwxLwEcenwLxEvsqMhvB6QgTrYzx
         y51k+zswsvO3XtZWdA1HpVBKdg6zbuXHuPXfDwQZ/W4E76WIyYlADWdM8fP9QnljkyOb
         he1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160241; x=1758765041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbcWxaY4vl/Q4W3/rZm6xbJSq4ZIWjy+imubsiA0GUQ=;
        b=EgGOSaXJuCWNnlxOdkhHsIkLvXy6cWEDiymnKheXo3aUErgt82QDUAXozxtSyBwXPB
         qfRpIm9fFPRWimBDxPRdtWxPhpdO24qTuITgoLbFIdBxUGgoLBJpqdKjJ9GGNKEzVUKy
         7no3TavikBofoDHCFlTX3wp6pwbJZAypcKDlYmZio9NnYxwTbMT2k2xU+9zMh3J11q1G
         lrMwubuL+RrYROC13QYRYIC74pOxZDnh5ph+uAmvlO/wXKyPNzyDhL6vDBFTL74z2hFt
         3GZiu+MZbkoP9hjV2+jV4c0yvztxld56c7qWUwDdHUO/heuEv+E1V93wM3fG9gQIkr9g
         /U3Q==
X-Gm-Message-State: AOJu0YwduwMQWSoST+SuRHH28so3TQTB92FKHN7Ex3lwYu2SmmnfEvjq
	uWrwRCBhNyatEUCtt3BcmrFsSInKDs248ArVaqX7DjUMNjVQjEQZU7QE4zpl5k482/uGS2nWBVT
	Xcv1k4ec7OvbPDn5mH1BdfO7r/QKakO4DMlD3JrF6+v7FPdA8R1+w
X-Gm-Gg: ASbGncuGlGc0YFIXYncr2anXrxyJW3MG7XbrxVm2dRTYZlTcRKXWqI2MQH+2+J3NLvf
	YJ1Uzi2eHpaj1IBG4n3kK+MXyYN9RhsMAdrppbziQvCvFJ30G8zEvy/3KX7Nd+PDC4NZSZI3iIy
	vIzrqBEfHAa/Bm93FUfiQkl/ecr+5MEfw5ZcmDxlVKnwaJfNNjNZObOIWaoP6q3jW4VMqjr8G5B
	MOz8CZRXmIquX6AovZQoUhIr6rAG7DvZAf/OyZI8NNLVAxyFf5iMVlutzJR0QpQzRFMTeobobCz
	D4qI6Uwq6fQuIgAasvVuVEktPG1czlsAb34KbAvfIKsA3ex0hzUasmzxIA==
X-Google-Smtp-Source: AGHT+IHptDo3d5jV+E6losHoXv1hOTO1W8T3gN+lg8n40CzHrfVfO2OTCR2VUJInQKlrX02lFQirrnIrtek1
X-Received: by 2002:a05:6a21:6da8:b0:24c:a32b:3257 with SMTP id adf61e73a8af0-27a736353fdmr3197417637.0.1758160240742;
        Wed, 17 Sep 2025 18:50:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-77cfbe620b3sm86273b3a.1.2025.09.17.18.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1D358341A3D;
	Wed, 17 Sep 2025 19:50:40 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1AF7FE41B42; Wed, 17 Sep 2025 19:50:40 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 17/17] ublk: don't access ublk_queue in ublk_unmap_io()
Date: Wed, 17 Sep 2025 19:49:53 -0600
Message-ID: <20250918014953.297897-18-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ublk servers with many ublk queues, accessing the ublk_queue in
ublk_unmap_io() is a frequent cache miss. Pass to __ublk_complete_rq()
whether the ublk server's data buffer needs to be copied to the request.
In the callers __ublk_fail_req() and ublk_ch_uring_cmd_local(), get the
flags from the ublk_device instead, as its flags have just been read.
In ublk_put_req_ref(), pass false since all the features that require
reference counting disable copying of the data buffer upon completion.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a677eca1ee86..5ab7ff5f03f4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -527,11 +527,12 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 	return BLK_STS_NOTSUPP;
 }
 
 #endif
 
-static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io);
+static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
+				      bool need_map);
 
 static dev_t ublk_chr_devt;
 static const struct class ublk_chr_class = {
 	.name = "ublk-char",
 };
@@ -735,12 +736,15 @@ static inline bool ublk_get_req_ref(struct ublk_io *io)
 	return refcount_inc_not_zero(&io->ref);
 }
 
 static inline void ublk_put_req_ref(struct ublk_io *io, struct request *req)
 {
-	if (refcount_dec_and_test(&io->ref))
-		__ublk_complete_rq(req, io);
+	if (!refcount_dec_and_test(&io->ref))
+		return;
+
+	/* ublk_need_map_io() and ublk_need_req_ref() are mutually exclusive */
+	__ublk_complete_rq(req, io, false);
 }
 
 static inline bool ublk_sub_req_ref(struct ublk_io *io)
 {
 	unsigned sub_refs = UBLK_REFCOUNT_INIT - io->task_registered_buffers;
@@ -1046,17 +1050,17 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
 }
 
-static int ublk_unmap_io(const struct ublk_queue *ubq,
+static int ublk_unmap_io(bool need_map,
 		const struct request *req,
 		const struct ublk_io *io)
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (!ublk_need_map_io(ubq))
+	if (!need_map)
 		return rq_bytes;
 
 	if (ublk_need_unmap_req(req)) {
 		struct iov_iter iter;
 		const int dir = ITER_SOURCE;
@@ -1144,13 +1148,13 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 {
 	return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
 }
 
 /* todo: handle partial completion */
-static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io)
+static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
+				      bool need_map)
 {
-	struct ublk_queue *ubq = req->mq_hctx->driver_data;
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
 
 	/* failed read IO if nothing is read */
 	if (!io->res && req_op(req) == REQ_OP_READ)
@@ -1170,11 +1174,11 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io)
 	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE &&
 	    req_op(req) != REQ_OP_DRV_IN)
 		goto exit;
 
 	/* for READ request, writing data in iod->addr to rq buffers */
-	unmapped_bytes = ublk_unmap_io(ubq, req, io);
+	unmapped_bytes = ublk_unmap_io(need_map, req, io);
 
 	/*
 	 * Extremely impossible since we got data filled in just before
 	 *
 	 * Re-read simply for this unlikely case.
@@ -1747,11 +1751,11 @@ static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 
 	if (ublk_nosrv_should_reissue_outstanding(ub))
 		blk_mq_requeue_request(req, false);
 	else {
 		io->res = -EIO;
-		__ublk_complete_rq(req, io);
+		__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub));
 	}
 }
 
 /*
  * Called from ublk char device release handler, when any uring_cmd is
@@ -2392,11 +2396,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
 			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
 			req->__sector = addr;
 		if (compl)
-			__ublk_complete_rq(req, io);
+			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub));
 
 		if (ret)
 			goto out;
 		break;
 	case UBLK_IO_NEED_GET_DATA:
-- 
2.45.2

