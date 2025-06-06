Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3477D2356DB
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246032; cv=none; b=RS7DA1Yh5Nq2/Xas3G4t0BXltuU3dz7IsstTgnu1ydYk17ekDb+vefocHJf6RivFuvg1TR1FfjLfIFu1zUh1FzpBBZvsQc28V6PhS3apP006L3TAFxTKyB4fXMJjkCReYSKHrgPrd2ZeijU03el3lxSyci1QiqTCisWUR+Jyo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246032; c=relaxed/simple;
	bh=t8sxgr3ZvImixG1380H4Y1MmSodcyubsERt15FglPcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hB9xx60ovpW3+sDPUXnXAnaVnj87+cNkve5LzyuKV03Ef+TfjUER3L8Jf5FWQ2WFskq9mgSFT3BF0R9TIAN8t6sTif3XB5r2hWmPxG3TmNEs22wpf3ScXi7xSfCVKL1HLxruvxu+Ov6ZMOgfaG+T0h1xXgbChkFdUmaCeQxG2Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UOxYWkdP; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UOxYWkdP"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-7376e00c0a2so189536b3a.3
        for <linux-block@vger.kernel.org>; Fri, 06 Jun 2025 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749246030; x=1749850830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5BPaRgwoN2riUQck/ld6AUrgtqY+oS82fKQKuCNqi4=;
        b=UOxYWkdPVyFhbhbdvia2RGDHTutDPgzQPok93p9W/nUpbmVGzAzla7mqO7YS5Btz2q
         npAsWy3IXpsGfjlOpyklhh7799czNUaaDaDABnIJf7DCha/w5sm5Tv6T6wfhZyI1RL7N
         miteE1SYSTu2s9vTLiPM9ekhoH0jplTJGpPh2a5/Rp4ZcqPb1kZiL8qVFiqUglnHg3ly
         BWUCuHSwJMcex8LHPl9Es7MGXlfxwnlMwY+leESVDHVDW4Clh02OMmUoGwOaDsCK6vej
         ZEUrTTDtVc7JwNb7aopdYpmtDh9N1r4ViwxRuZBH+KtINkNp3t2GfrW4Nmt2uH0pDdpc
         S0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246030; x=1749850830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5BPaRgwoN2riUQck/ld6AUrgtqY+oS82fKQKuCNqi4=;
        b=KMDhyMgW3heG/cfwnUl6IIaoKnfxzut9vZSgk43ZpoEhVQkZVG6fqdHajQkGlkYe+R
         +5vQjx0RLvMkx0o+tQ32u8dtlmcI+vs19uwNsp/EpjXyi1svmsDm7xy4jU2ze8BRq+Sv
         3UvqagblHYrX5SGyvSQQH596XblfxqZUQ614qfrtkaNP1/Tl3FFh1Bi2LtDN9emHjtLI
         GaGaIH7pjHO88xIQCV0js3umAPYrDHUXjAV2A/6hlvw1wgFaHXE1p7NwlBIbL4cqQTlC
         XPXoqmqTpMXj1FzGDu7jZn61bTUlsEulst0ZL2x2dxuoBBlcxiRxhTJ4dB4ZYzt+FDFP
         ha6A==
X-Forwarded-Encrypted: i=1; AJvYcCWv8mL+ILy0m56XW5abPXX9vPJSmrIcxUrqJb+ETQOt1+GpKuCxjXFL0K3PwrTesqf/bIybIt8gD9D8+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNTPAg/VjYezdiz6NI5/ql1XNwA4+dIe9qcJcRF1zk7v+HNpXn
	cYcYy/hp9Mv5sryZReFHWp7Ir6QfwYlIDWDrsuVYDZd1JRxo2/brjimDdNX1lXbslurOaMczEMZ
	0xNV8MGmnSjSJRCDy7uW2jkq2oKcm6nWtDx6phIH/58YKTqLJX3nX
X-Gm-Gg: ASbGnctfjNoklhjJbFhtmQGamRVG7UxdnAZM1bKHNlkMOppaC9FFQuEn1wxjo0uw8Oj
	cucSix7qLLzPBr9ct2VxC5BBFmrZBoCxga9TfbKTVO54EqZz5L/dsEURnXZ+nt9LrgM24MJhOn4
	03Y59j59i6NxWfBXLbtnpF/vVTUBIMSMBmpi9ky/lMc5vJyVabcSsaC+6Ma+LsZt21LZ7xmooRJ
	MRraR5eQLUOSeSSzG9//uGtW43/2SbhSK9rJkRQiq8cnvjB/XdCoJrHqaBukD+Co6+LaCjdonpv
	KI/LJAAh7T8aB3mfglzR732Va7LMQvSC5Vf/nbLz
X-Google-Smtp-Source: AGHT+IFDp1ZyuMEi/f/n9kBipffN13CNjnRphy3lAvPAngXhB/WxjgKMMR4M/A3b0ubyYOIbMwtCpwt6VwmX
X-Received: by 2002:a17:902:e5cd:b0:233:fbbf:f8b3 with SMTP id d9443c01a7336-23601dec522mr25917935ad.14.1749246030487;
        Fri, 06 Jun 2025 14:40:30 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2360330382esm1314385ad.83.2025.06.06.14.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:40:30 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id AC296340332;
	Fri,  6 Jun 2025 15:40:29 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A5428E41EEA; Fri,  6 Jun 2025 15:40:29 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 8/8] ublk: remove ubq checks from ublk_{get,put}_req_ref()
Date: Fri,  6 Jun 2025 15:40:11 -0600
Message-ID: <20250606214011.2576398-9-csander@purestorage.com>
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

ublk_get_req_ref() and ublk_put_req_ref() currently call
ublk_need_req_ref(ubq) to check whether the ublk device features require
reference counting of its requests. However, all callers already know
that reference counting is required:
- __ublk_check_and_get_req() is only called from
  ublk_check_and_get_req() if user copy is enabled, and from
  ublk_register_io_buf() if zero copy is enabled
- ublk_io_release() is only called for requests registered by
  ublk_register_io_buf(), which requires zero copy
- ublk_ch_read_iter() and ublk_ch_write_iter() only call
  ublk_put_req_ref() if ublk_check_and_get_req() succeeded, which
  requires user copy to be enabled

So drop the ublk_need_req_ref() check and the ubq argument in
ublk_get_req_ref() and ublk_put_req_ref().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 41 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ec9e0fd21b0e..f9a6b2abfd20 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -690,33 +690,23 @@ static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
 		refcount_set(&data->ref, UBLK_REFCOUNT_INIT);
 		data->buffers_registered = 0;
 	}
 }
 
-static inline bool ublk_get_req_ref(const struct ublk_queue *ubq,
-		struct request *req)
+static inline bool ublk_get_req_ref(struct request *req)
 {
-	if (ublk_need_req_ref(ubq)) {
-		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
-
-		return refcount_inc_not_zero(&data->ref);
-	}
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
-	return true;
+	return refcount_inc_not_zero(&data->ref);
 }
 
-static inline void ublk_put_req_ref(const struct ublk_queue *ubq,
-		struct request *req)
+static inline void ublk_put_req_ref(struct request *req)
 {
-	if (ublk_need_req_ref(ubq)) {
-		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
-		if (refcount_dec_and_test(&data->ref))
-			__ublk_complete_rq(req);
-	} else {
+	if (refcount_dec_and_test(&data->ref))
 		__ublk_complete_rq(req);
-	}
 }
 
 static inline void ublk_sub_req_ref(struct request *req)
 {
 	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
@@ -2004,13 +1994,12 @@ static inline int ublk_set_auto_buf_reg(struct io_uring_cmd *cmd)
 }
 
 static void ublk_io_release(void *priv)
 {
 	struct request *rq = priv;
-	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
 
-	ublk_put_req_ref(ubq, rq);
+	ublk_put_req_ref(rq);
 }
 
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 				const struct ublk_queue *ubq, unsigned int tag,
 				unsigned int index, unsigned int issue_flags)
@@ -2027,11 +2016,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
 				      issue_flags);
 	if (ret) {
-		ublk_put_req_ref(ubq, req);
+		ublk_put_req_ref(req);
 		return ret;
 	}
 
 	return 0;
 }
@@ -2303,11 +2292,11 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 
 	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
 	if (!req)
 		return NULL;
 
-	if (!ublk_get_req_ref(ubq, req))
+	if (!ublk_get_req_ref(req))
 		return NULL;
 
 	if (unlikely(!blk_mq_request_started(req) || req->tag != tag))
 		goto fail_put;
 
@@ -2317,11 +2306,11 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 	if (offset > blk_rq_bytes(req))
 		goto fail_put;
 
 	return req;
 fail_put:
-	ublk_put_req_ref(ubq, req);
+	ublk_put_req_ref(req);
 	return NULL;
 }
 
 static inline int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
@@ -2431,46 +2420,42 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 		goto fail;
 
 	*off = buf_off;
 	return req;
 fail:
-	ublk_put_req_ref(ubq, req);
+	ublk_put_req_ref(req);
 	return ERR_PTR(-EACCES);
 }
 
 static ssize_t ublk_ch_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ublk_queue *ubq;
 	struct request *req;
 	size_t buf_off;
 	size_t ret;
 
 	req = ublk_check_and_get_req(iocb, to, &buf_off, ITER_DEST);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
 	ret = ublk_copy_user_pages(req, buf_off, to, ITER_DEST);
-	ubq = req->mq_hctx->driver_data;
-	ublk_put_req_ref(ubq, req);
+	ublk_put_req_ref(req);
 
 	return ret;
 }
 
 static ssize_t ublk_ch_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ublk_queue *ubq;
 	struct request *req;
 	size_t buf_off;
 	size_t ret;
 
 	req = ublk_check_and_get_req(iocb, from, &buf_off, ITER_SOURCE);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
 	ret = ublk_copy_user_pages(req, buf_off, from, ITER_SOURCE);
-	ubq = req->mq_hctx->driver_data;
-	ublk_put_req_ref(ubq, req);
+	ublk_put_req_ref(req);
 
 	return ret;
 }
 
 static const struct file_operations ublk_ch_fops = {
-- 
2.45.2

