Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F25221277
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661095; cv=none; b=kF129fYbi+Orb0cCkkmqez5kgw7F0KfE2TtFo/j+N2D+rOV5PhNEXKy//2lMMz6J1RS2xL5Jttgh+Miz93Lcny4lApPxr9W5lTurimJcCoWuBUqw13enNZDmJbDZ1xXhBqAd8OFfSp8ZHSPCD/hMrg4qVuCQk8ZwfxkHP+vsqZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661095; c=relaxed/simple;
	bh=O2B3nDNTOvA1fCnP/c4U5ok+FRqPgHkTWB1k6b6wlJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYpGULN58OKGXbdK811Uat5sSkEmjHuXzuzZW5gPcGl3/DOU3CfKG5v9HvJFF5xrFgk+aPDx4a8GXY6mOUYiHkUhTxZaWmfy4GeDlfXhnbkqxm5FIxq3frzlJ4KxBknR9xYSgHfkCpBrCm41xzG/JatkTzpHEiyyaeE6vNzpUKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QiLRhF/J; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QiLRhF/J"
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-55b2d80b290so7214e0c.0
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 16:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661091; x=1768265891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CNvd1Mx9gekfNSEieO/2PmHTz2A3J9iRZA5969nWLY=;
        b=QiLRhF/J3i0O5W9Wi2e+qvDWm+0pDiIlQDab3LWzYNz5+80z6xsIv1fmFCstYI2dX+
         dKRrIYQkoJqxFxC841VHGC25elqM5oMYlDhj4I2PNddOrYcL5LjiJ3m9HFzIzhE8J1O4
         EruIp/3l3LuEtg7NU+OWHJ2Uz+cItbryxWJRK1gbEANykY5zeiovLU0Q8u/7Gj9VCGpe
         CJy6LHYXocqlkPFDsbSgnSoMj5vD2HUEjce3ROpmm4nF6MUc++N/K3O8xDtMKiviM3Xc
         HJYxPjrforx8KCMDEk4rnugrVAKHXEmms4QcxtqWy5HIbR1cq7r/ACGIVsfFFbxnwRSN
         0/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661091; x=1768265891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2CNvd1Mx9gekfNSEieO/2PmHTz2A3J9iRZA5969nWLY=;
        b=dO4W9rmZhNJx2p9q+Ef+dWh5kcpk+uwApdbuG6LHgBJ5Ym5b4NZuV2E21E+MO1b1iF
         w64aKQVbmeQ0H8pW91XSBcDniZvn/Fq35tq0Z6KWX5vmjxs4MreyfEEJLTdGLkGxTitN
         V5UKauKgJNRmXUpekJ/4eC5SPahmqzL9pybpDwcw31MTZJlXJV7bnGKTmfXTOKAAjtVq
         xu8pKb3iOnSj0Uf9Qq16szFcnh7HspKjJwcvkQiScaSBEZhdk0bh+lbvGWlVkSO6dgua
         kTpYVtPft8I6d0ktAy9t0GFeMzJTBKpMfW6whE6j0Dm8/FpuR0drJkk7rEcHeDJfCUmE
         IZDA==
X-Gm-Message-State: AOJu0YykTVE9aS5CfOlnaiYnhqujRC8SgpedPxyNlKGXTFTnTTgVwDhI
	cAT2V59/PqCoRaFdY6Aa1uThjG/WjZoYZw8AH7QevFE9l6U0obJRo9OWjSOuyKB+OdviDXXDskq
	Z4auVd5nMxX3IIWShMxX7Ng6ejYu+lZVme6M8aq4XOpSG+J8Hj9fJ
X-Gm-Gg: AY/fxX4KS6c0bPbqxilJDOlz2pqhZTTFxNHEkWbC9Ha5TwWp0u53Ayo7vHa2NzLNw5u
	2+dTmrwfj/HjC5VtzxCS+APOvwbRGnYUtl4VpUw24IYpU9WmoDKV6BU6OPxxx66uRpIcfVKhJDw
	qaLDz+WDmV9+k5qm51IZnzi/2uuM5Hfqt0qiSEtu/KUy/zaCB81AASVsNiVrlCHXu8zuGoPUYvc
	iAQ5dlOswmyo5uSQ3OIsO8PeoOJeU3bqS6zvHFI36hyW65ZIEQpIVjyR0VnwN0DwmjJCl2bNUnI
	0q7r0+zoEsJH6pDp4uo4L8xbats9Dkki0ZLYzNhF2SBr0OTZmByHzEIPo1OsP19MqghHNZ/nTzl
	oGo/G03RBCdqojLlW9PuuEuLHerM=
X-Google-Smtp-Source: AGHT+IH8mCx6YKDu+wL7IQQyl+rfNWEG6hhp/rXOGPYtOLg3VYxrjm0M6YCvDU+p9XB1FYaFESnhadRuF0M+
X-Received: by 2002:a05:6122:20a7:b0:559:5ac3:4451 with SMTP id 71dfb90a1353d-5633955dc2bmr276579e0c.3.1767661090697;
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5633a3b1388sm87798e0c.3.2026.01.05.16.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 514953401CC;
	Mon,  5 Jan 2026 17:58:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 42DBCE44554; Mon,  5 Jan 2026 17:58:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 08/19] ublk: move offset check out of __ublk_check_and_get_req()
Date: Mon,  5 Jan 2026 17:57:40 -0700
Message-ID: <20260106005752.3784925-9-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ublk_check_and_get_req() checks that the passed in offset is within
the data length of the specified ublk request. However, only user copy
(ublk_check_and_get_req()) supports accessing ublk request data at a
nonzero offset. Zero-copy buffer registration (ublk_register_io_buf())
always passes 0 for the offset, so the check is unnecessary. Move the
check from __ublk_check_and_get_req() to ublk_check_and_get_req().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index abb668b460a8..e44ab9981ef4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -253,11 +253,11 @@ struct ublk_params_header {
 
 static void ublk_io_release(void *priv);
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
+		u16 q_id, u16 tag, struct ublk_io *io);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 
 static void ublk_partition_scan_work(struct work_struct *work)
 {
 	struct ublk_device *ub =
@@ -2283,11 +2283,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	int ret;
 
 	if (!ublk_dev_support_zero_copy(ub))
 		return -EINVAL;
 
-	req = __ublk_check_and_get_req(ub, q_id, tag, io, 0);
+	req = __ublk_check_and_get_req(ub, q_id, tag, io);
 	if (!req)
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
 				      issue_flags);
@@ -2577,11 +2577,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 			__func__, cmd_op, tag, ret, io ? io->flags : 0);
 	return ret;
 }
 
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		u16 q_id, u16 tag, struct ublk_io *io, size_t offset)
+		u16 q_id, u16 tag, struct ublk_io *io)
 {
 	struct request *req;
 
 	/*
 	 * can't use io->req in case of concurrent UBLK_IO_COMMIT_AND_FETCH_REQ,
@@ -2598,13 +2598,10 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		goto fail_put;
 
 	if (!ublk_rq_has_data(req))
 		goto fail_put;
 
-	if (offset > blk_rq_bytes(req))
-		goto fail_put;
-
 	return req;
 fail_put:
 	ublk_put_req_ref(io, req);
 	return NULL;
 }
@@ -2682,14 +2679,19 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 
 	if (tag >= ub->dev_info.queue_depth)
 		return -EINVAL;
 
 	io = &ubq->ios[tag];
-	req = __ublk_check_and_get_req(ub, q_id, tag, io, buf_off);
+	req = __ublk_check_and_get_req(ub, q_id, tag, io);
 	if (!req)
 		return -EINVAL;
 
+	if (buf_off > blk_rq_bytes(req)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!ublk_check_ubuf_dir(req, dir)) {
 		ret = -EACCES;
 		goto out;
 	}
 
-- 
2.45.2

