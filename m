Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB9D265632
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949718; cv=none; b=sSnsqMB0wkg0u6p1pF1lFFsY87WBSXxmZuKyaa6C8GIHMRHvecdv4nB8WAMp35/lduE/S5R3J/ycY1kben7x+CdYPLk1KL/Okt+PDntWciYtD05mAyWkmXKHihWL8ZJdwI/QA9ai+uDQm2FqIUKJ54mkNGjzOdBznHGEywFdJoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949718; c=relaxed/simple;
	bh=FTZpTJFk7vIPg1PZH6cxAezI3CLxjX8XLWzJZS/E38A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pI+K1Fw4fxdaKf9XDerSqH99G1v/iDndR5qItAx+SWQ/MSKiSBuQZiTMFLvG0pV/T+2GesVlyll6ZmjlrhQwRyZqBCNTQShWwSRKnPMhLwl2Ov2yKtNqlviSJR5BLk1ALGOunifCOZmseb5q+YK/I5PHLEdwdpiQh0N+b7dNj0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UrL80x2I; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UrL80x2I"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-29f3018dfc3so9002835ad.0
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949713; x=1766554513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Eb5T1Z9IaRsBIIzFsefoZOCFYrX4XELdNdKDdwX2OE=;
        b=UrL80x2IIqRxbqNiKdBMndhmY218ynIUj3f+ABIl5rG0LNtmk8MClLS+JrTx97gbxj
         EGuHMGLfe2rGNSqmKP1hkQuCYW9Ap9flj97qa0RWEb/N2jKAZSwhXJsLogoAJNCv0XMZ
         gYdPs++HRYwsOvM9eWElnw62JpQmUvHW8mt1uDQscQCh2l88iQyUqXweUUqKbKeTu0kf
         jdUfqNhbMVAw900A85C5cUMqcTFYw1seQxW9pweW9VSrtzluFB+z10cRabZkjY0jAaxw
         Djpv7ZVd/68+Kt7QGAUkI1FumqpGFkWv2TlZwwaRgH5n9Q1bpZ+xl8N0rfkyzoVb8ob5
         HNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949713; x=1766554513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Eb5T1Z9IaRsBIIzFsefoZOCFYrX4XELdNdKDdwX2OE=;
        b=W0TMncCuVyqfD351xJVLR8FV8i4ckosYiTGd7m2NEq1euXt4PLQB6jnwCcMTH3JQN5
         PYIWdoWoLqE19vtXEMDZF9a0eN5cRlUHLWN2YTxrABLMfXcxfqeTOc5fZRxJwyMHX40B
         dh/qhVdu6CprntViVqvsEoUCV3RNm0d5MHejm/GyqJdH9tDy2E+ha/22ikFxePul9QD/
         2HeeJFT6Y1GufJ0kXVcWf95pcTeQj0ure1UTHcAeHUmazA9CbBsEtHmTii+ERaezE8Jb
         HoBYHX9AAkXsvpWVEuyZibhbvJ33WtdcIIax1/deva0m7+BJm0qV7BK7Ku6W0MqEQ65N
         ETdQ==
X-Gm-Message-State: AOJu0Yzl6cxRp7WVed8HP8mUu+1lPJmFDxUBojSeTzA0H6u89e4nRIKZ
	iqsCIkR2dtwx4+wmomLUikCxqvehYfGJuENgQrrfbLLTycTxpk80TxerheLUWMyl/InNECac/Yk
	HGi+95gMIfoAIW3XbPnmN5yrppRK6bGu4Hd+e
X-Gm-Gg: AY/fxX4SSQE87HsIosQPKFEoWvDW5VFCK7jh0CtkiwS9bpsOx5JTEKl6sv6NX4GH1r2
	E1LU95a+JiN6KIF2MBEnxO4Gq1jWOC13AoL/1NqjJCvhyiFB88Kjodl/IPUIGWXuSNviQgp4SBD
	rdDcAGOeVolEc6qe8zyF32yfehzO5AtY4IZBNuJcBwRGjVc5+dgTV0RWS6hktzizL0WYpBZsMoE
	LI6hdspAfdiX47I6uAtbHJ9ONFwYbPYV3WkQxn/ihja6BtfOsSJUJz/B9jeI5RhAAkr9/E4Pgc5
	haxCV25pJJhs6EdJ8Dm7Zejbi6iDZVW8N0EBFSSRatKlvhofcz1XvaDYCM/SDzld0b3tb9xmRDY
	u28GwvPF64qIxiyTii9Tl01ABeCAqpfiONQgQ3reWeg==
X-Google-Smtp-Source: AGHT+IE2xX+5q3QLWUczI7JtChS+3j5Z/I15mSSIt/VFnctqFMoYNA5Mvf7xTmrSibK16r0UTRNvLsajsS3B
X-Received: by 2002:a05:693c:40cf:b0:2ab:ca55:8940 with SMTP id 5a478bee46e88-2ac3013640bmr5765988eec.7.1765949713248;
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ae4f055014sm417501eec.12.2025.12.16.21.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C11473420C0;
	Tue, 16 Dec 2025 22:35:12 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BE89AE41A08; Tue, 16 Dec 2025 22:35:12 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 12/20] ublk: implement integrity user copy
Date: Tue, 16 Dec 2025 22:34:46 -0700
Message-ID: <20251217053455.281509-13-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Zhang <stazhang@purestorage.com>

Add a function ublk_copy_user_integrity() to copy integrity information
between a request and a user iov_iter. This mirrors the existing
ublk_copy_user_pages() but operates on request integrity data instead of
regular data. Check UBLKSRV_IO_INTEGRITY_FLAG in iocb->ki_pos in
ublk_user_copy() to choose between copying data or integrity data.

Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
[csander: change offset units from data bytes to integrity data bytes,
 test UBLKSRV_IO_INTEGRITY_FLAG after subtracting UBLKSRV_IO_BUF_OFFSET,
 fix CONFIG_BLK_DEV_INTEGRITY=n build,
 rebase on ublk user copy refactor]
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 43 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7fa0a9f0bfae..042df4de9253 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -606,10 +606,15 @@ static inline unsigned ublk_pos_to_tag(loff_t pos)
 {
 	return ((pos - UBLKSRV_IO_BUF_OFFSET) >> UBLK_TAG_OFF) &
 		UBLK_TAG_BITS_MASK;
 }
 
+static inline bool ublk_pos_is_integrity(loff_t pos)
+{
+	return !!((pos - UBLKSRV_IO_BUF_OFFSET) & UBLKSRV_IO_INTEGRITY_FLAG);
+}
+
 static void ublk_dev_param_basic_apply(struct ublk_device *ub)
 {
 	const struct ublk_param_basic *p = &ub->params.basic;
 
 	if (p->attrs & UBLK_ATTR_READ_ONLY)
@@ -1034,10 +1039,31 @@ static size_t ublk_copy_user_pages(const struct request *req,
 			break;
 	}
 	return done;
 }
 
+static size_t ublk_copy_user_integrity(const struct request *req,
+		unsigned offset, struct iov_iter *uiter, int dir)
+{
+	size_t done = 0;
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	struct bio *bio = req->bio;
+	struct bvec_iter iter;
+	struct bio_vec iv;
+
+	if (!blk_integrity_rq(req))
+		return 0;
+
+	bio_for_each_integrity_vec(iv, bio, iter) {
+		if (!ublk_copy_user_bvec(iv, &offset, uiter, dir, &done))
+			break;
+	}
+#endif
+
+	return done;
+}
+
 static inline bool ublk_need_map_req(const struct request *req)
 {
 	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE;
 }
 
@@ -2616,10 +2642,12 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 {
 	struct ublk_device *ub = iocb->ki_filp->private_data;
 	struct ublk_queue *ubq;
 	struct request *req;
 	struct ublk_io *io;
+	unsigned data_len;
+	bool is_integrity;
 	size_t buf_off;
 	u16 tag, q_id;
 	ssize_t ret;
 
 	if (!user_backed_iter(iter))
@@ -2629,10 +2657,11 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 		return -EACCES;
 
 	tag = ublk_pos_to_tag(iocb->ki_pos);
 	q_id = ublk_pos_to_hwq(iocb->ki_pos);
 	buf_off = ublk_pos_to_buf_off(iocb->ki_pos);
+	is_integrity = ublk_pos_is_integrity(iocb->ki_pos);
 
 	if (q_id >= ub->dev_info.nr_hw_queues)
 		return -EINVAL;
 
 	ubq = ublk_get_queue(ub, q_id);
@@ -2645,21 +2674,31 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 	io = &ubq->ios[tag];
 	req = __ublk_check_and_get_req(ub, q_id, tag, io);
 	if (!req)
 		return -EINVAL;
 
-	if (buf_off > blk_rq_bytes(req)) {
+	if (is_integrity) {
+		struct blk_integrity *bi = &req->q->limits.integrity;
+
+		data_len = bio_integrity_bytes(bi, blk_rq_sectors(req));
+	} else {
+		data_len = blk_rq_bytes(req);
+	}
+	if (buf_off > data_len) {
 		ret = -EINVAL;
 		goto out;
 	}
 
 	if (!ublk_check_ubuf_dir(req, dir)) {
 		ret = -EACCES;
 		goto out;
 	}
 
-	ret = ublk_copy_user_pages(req, buf_off, iter, dir);
+	if (is_integrity)
+		ret = ublk_copy_user_integrity(req, buf_off, iter, dir);
+	else
+		ret = ublk_copy_user_pages(req, buf_off, iter, dir);
 
 out:
 	ublk_put_req_ref(io, req);
 	return ret;
 }
-- 
2.45.2

