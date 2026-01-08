Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EC2387362
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864017; cv=none; b=Nl7ltiQZgFII/Jh8g90LluuVBu2x87W6cJM+zgESzumWslujAEuQLtrihc8M25RTrLXxIvlEzxH5yg4wkHS5XDif2syRpcm92Pdv3HwGma5WJfZPPB+XuDbUoWVqoDsZQZgZT0nw5EptiIS/+M1ym000ushHiLHvkSQxgtl0zgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864017; c=relaxed/simple;
	bh=z5UvEG7yIk3hIRSI6lWmN/+q3tRGUV7m3XtA/IVPt/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvbnas0qIvd3Sih8sCk5K/kIu5UJM9pp/VHLavkA8xaVjbaU5IvG7it/zzgPGYMGRntsHOk/QTyOsJg4BD/C3MvWAua8tUqYbXB7RPaIgR9ZVonRz2ZhiIChePc9V1YJQ5/8n8xDnSAjPpB7Fe5csxfeXtAV3njueFmNqUvA+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EWoHWW6h; arc=none smtp.client-ip=74.125.82.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EWoHWW6h"
Received: by mail-dl1-f98.google.com with SMTP id a92af1059eb24-11ddccf4afdso203676c88.3
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863997; x=1768468797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRF9PTlw3a8gb0UkNXk8W27Ux0Z9UemKi8/DWwSUOqE=;
        b=EWoHWW6h9vLld1mamuXoTWA/yykQTXFUr95g8ZBBQlNZq8NIsqqIzJX5LlApm7h5AJ
         cNW8t34S3kMkqwFNeL5XG/TGbjYBXicaXCaUL4s2aODArbBBHkkgf9llh+lxOI8l6HGN
         dw/9XdRY5b/aIlXdQCGUdB8XB/Mws5i7NjOeAsHbQLN2ZRQ87CWvRgDGuDzViLLG0KCZ
         +ho0DmlCbw4ELLdJgovHSjXjZ0lRxXw2yr4Cp24lNcRpxb+KKIiVZJMsQNPr3ymkQ140
         jLMOSqf8epTmGNyGkjXTdHhZC8cTW3w1gTkWh0UfKdjW288kvnpSHR2MGe0dUvDzTKlg
         Q+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863997; x=1768468797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LRF9PTlw3a8gb0UkNXk8W27Ux0Z9UemKi8/DWwSUOqE=;
        b=mNCU9lS147qIUXlK6EW35vuG4+s+oVfL/9U3+11vbqLIh3PEhvPkOll1yjCD8lAQ3l
         gd1xG+La5HQmisHOxZ9gaFf+Vku0pjz6ISH2sWannGlvyJObmavlrb/ZOSWZbtL4kjOG
         TBU9ULXYCDixOf4f6HxITFyPqfxMmecw4+qwXktgxbN7CAmlSE+76Yq3Z/mXaXlcvka9
         yalDkSkv3cggCTBetpOg1LklQOkWkGzzPUD3tlPzA5y2khQ1B6q8txjx0vXbXYHm0xEe
         nsaHlyt15kkWZMlHFAvD0IbsxgEu3UK/ZYvVJ/Y3KLY4HnVL2Jw4QmMhB+dVq7NOcb8b
         Xi3g==
X-Gm-Message-State: AOJu0YyE6cgBOCP8o0OWvRTbQ89K2i2yvGgvLc7mQlNz/9Ar0K1g/drc
	vMfps/4trRIT5RnlC/NF65FecAN4Qy4x4CsGnSB7MsF9LyLaug+PYUFhKYtLepnumOC2umjwM7B
	54y/7IsmmJutWpHuZVcI7cHQPyvAFoVAnOEAbopzBbVH/Zc8UNVlF
X-Gm-Gg: AY/fxX6V9TKhzKLV5rZrPpZrX1iPaboUe3AiTBfRJvPF7gfCdvLsaa6OIwzQ++T3mBV
	sPBU2u4MC94NNLKVwS0ubaiPcRCCm7JbfBxbs0IL53bS3vDKdx40BgxemjGKq2t1gfvhzpwhK07
	zfJEXMK1/OwPOFRBvIXMvKBaak+VmVdVA+BU+bKntBnPAneYp8SrnVOwqUXpwz3tvI9FhHh+ZWn
	wIt7ag3QImVLNvpu6figb9eH9wYhzKQbjoG9mx/6mOA1IpcS7X/DG2R3oTlevlU00lTqsbMEN0T
	1shR+BEROh/G0hKaAjPQ+3UesyXyONxmkTXX7LNCIhxYKZGlLOX1yvwwhmv1JLjumsKHAVg/aU7
	cI/ptNT8u7TmOqYJLW+NahkjC1uE=
X-Google-Smtp-Source: AGHT+IF+tnZp1NPJYPMuToiP9g/0nFAnKouh8tNmhphYS8zUh1epFsXDHslCkoq5UuiMCq74MYJVWgq8pNzt
X-Received: by 2002:a05:7022:f415:b0:119:e56b:46b6 with SMTP id a92af1059eb24-121f8a30d8emr2644521c88.0.1767863996644;
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121f24966f5sm1633750c88.6.2026.01.08.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:56 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 31E5734225B;
	Thu,  8 Jan 2026 02:19:56 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2C8F8E42F2C; Thu,  8 Jan 2026 02:19:56 -0700 (MST)
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
Subject: [PATCH v4 08/19] ublk: move offset check out of __ublk_check_and_get_req()
Date: Thu,  8 Jan 2026 02:19:36 -0700
Message-ID: <20260108091948.1099139-9-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
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
index e7697dc4a812..8eefb838b563 100644
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
@@ -2288,11 +2288,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	int ret;
 
 	if (!ublk_dev_support_zero_copy(ub))
 		return -EINVAL;
 
-	req = __ublk_check_and_get_req(ub, q_id, tag, io, 0);
+	req = __ublk_check_and_get_req(ub, q_id, tag, io);
 	if (!req)
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
 				      issue_flags);
@@ -2582,11 +2582,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
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
@@ -2603,13 +2603,10 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
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
@@ -2687,14 +2684,19 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 
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

