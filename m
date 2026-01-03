Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B2623EAB2
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401143; cv=none; b=TPA0po3ArFdS+MzNIKymeMDg6BU1MO9ZdrES6dDQ3AtVp8C5tAnwOic6sHD8k9dFVM3ASbD0Vcs5WxMhDbTTmPRPMnL4qxx+D8ZjUgH6NbiDxqbgdyUjhiwsU2SNP3LdvygT6EpVmxqIRd2JJ8FgmIYnQMFnNB5PY+ZyE0jhnk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401143; c=relaxed/simple;
	bh=u8VnCRtsCK+roPqEMb0mv2OQs8zLb0C00qKIxa4dpzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvBAkSFC3RtJZ/DzfRnYNPXo1PHtkDF0/sJyjv/e+fMpcjNXgmzR5893APuMs3W8cOYN3/Dhn+OtTsfXnddg9j0roENFY1+qfQ3C8356bL3ZfwNQWtqBYu/1HwVJ48Mc5BcfVQwKLvqIFn0MOjBYaRXljut2XkIFkRDs5owwZn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WmAZQOxI; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WmAZQOxI"
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-55fe0e4dc4dso352032e0c.3
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401135; x=1768005935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZU/lwXcYKwC3oKPxKrMeHEJqc1EBKCdeJfQj5Te361k=;
        b=WmAZQOxIWPZrYxk8iqNfkSq/fqDy+EL+l1gUHntnw/52d1evbVv8QXczixm4+FMcos
         our0kqwWu3x+u9Kx3/1MXCJ1zG7uVHNhA1uUjMrhokUbFO2BlLFfU7XemPUPPZX6g0vt
         IbmKubCEzBVn5PUfMoiEG+A8wcLUZ8k0Ru9Pu3nPsaR93Wzna/5ZAYIcqoCb5Ttid4bN
         hju7J2xb/oXSwbeGu1dAvwSv1NTcYt7WJ3Pc3LsoqrIPuPWVsf7hFDE4xs5MsXp5Lhch
         goJGahhfZktyiYAOXSlISv6NhNiBWoQ5Vd7RVexEYNu4+fKGlIk+GTwFlotQ3RI54XY0
         skbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401135; x=1768005935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZU/lwXcYKwC3oKPxKrMeHEJqc1EBKCdeJfQj5Te361k=;
        b=YGHm99UgdN9XzCH/M62Z9zsIlD+v6KFOhJnA+XQ8+8XtEL5X5c1h6CTpXlFtHArh/J
         XTsGmkPRlN8fpm4W3yalnJO4UykH36USqnCYSWljbEtFdYfj/ijdLdzzfm2ArZeRooB3
         2w5Slk58NVUweEw+sl8dMzZhzhTByTOejeotbE8XBuuQrtlF18/DGVbsKxdEBRYx/ziP
         JIn3xRYYwcAQVlenMGqcg9GS0zX94OSQy5CVTA9Ss0d1544ChxoHJDZWmHH+BlMi3GEH
         UysX3M2uVD7Vhd+0peRPFM0vPoMI7WONDueZ6MpdeWkB1qmLGC681PsBhxnXjEqLPBlX
         rvMg==
X-Gm-Message-State: AOJu0YzVRRjclxSuu3gPVbmg24j0lAOw+VlvqOCg/N9FhbO1Hac/PZzI
	NtZnwMmmLZmwH3vm6VL0TPcv/wx6EpuJYCR3XOWO8rIzVZBOv/6+wlNmTEuOHSHr2WcmWjab7+E
	oafV5BN1TCym4WsVTdbs5QKo6136gf9yk06EPxi4zgm4l3qbCoNyN
X-Gm-Gg: AY/fxX4RCQYavJA423d7d0hfIUlcaTqR/cyRPizAYM3gtZ2qqhbGuQlhJRN7tcLFigf
	HVT36U4YEtIGyA5DZYrO3De0yGmbv+wbOpO2mweyIhcHzup4v8gK/fgpSh1d6belGC8phoOlkf8
	gNu2C4AJOVnkpyRY1IaNq4li/42Gj360+xh0nn6tZq07wf7GNguJV4cf75tyecvfE3RM6Uzlx7u
	9+vmuC4Igq1e6N2pBhMZ1dYXnXD1zKHQc43pmPMLEey8cvrdar5qRwRs4T0nIwz/dO/oLR7m20r
	F0XpkxRjwrIPliebAk6MA2S46xdYW5ogGCd9m2LfMPL+tL3IcN+NOHuvUEFaw2DvqxkS6dqH+yM
	R0PMlZQlZQaN4JSrtvs4q5oGeaRs=
X-Google-Smtp-Source: AGHT+IHonTKzAOlzeoLskF6gmHl/PMN2D8E3cioL5vTyJF/M/be03SS0Q608h+LkpxY8jhR/zDlA7yzKs5rd
X-Received: by 2002:a05:6122:e4a:b0:559:a30f:1648 with SMTP id 71dfb90a1353d-5615bb9b244mr6259848e0c.0.1767401134900;
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5615cf48388sm6448141e0c.0.2026.01.02.16.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 916F1341D2E;
	Fri,  2 Jan 2026 17:45:33 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8CCD5E43D1D; Fri,  2 Jan 2026 17:45:32 -0700 (MST)
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
Subject: [PATCH v2 04/19] ublk: set request integrity params in ublksrv_io_desc
Date: Fri,  2 Jan 2026 17:45:14 -0700
Message-ID: <20260103004529.1582405-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indicate to the ublk server when an incoming request has integrity data
by setting UBLK_IO_F_INTEGRITY in the ublksrv_io_desc's op_flags field.
If the ublk device doesn't support integrity, the request will never
provide integrity data. If the ublk device supports integrity, the
request may omit the integrity buffer only if metadata_size matches the
PI tuple size determined by csum_type. In this case, the ublk server
should internally generate/verify the protection information from the
data and sector offset.
Set the UBLK_IO_F_CHECK_{GUARD,REFTAG,APPTAG} flags based on the
request's BIP_CHECK_{GUARD,REFTAG,APPTAG} flags, indicating whether to
verify the guard, reference, and app tags in the protection information.
The expected reference tag (32 or 48 bits) and app tag (16 bits) are
indicated in ublksrv_io_desc's new struct ublksrv_io_integrity integrity
field. This field is unioned with the addr field to avoid changing the
size of struct ublksrv_io_desc. UBLK_F_INTEGRITY requires
UBLK_F_USER_COPY and the addr field isn't used for UBLK_F_USER_COPY, so
the two fields aren't needed simultaneously.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c      | 43 +++++++++++++++++++++++++++++++----
 include/uapi/linux/ublk_cmd.h | 27 ++++++++++++++++++++--
 2 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2f9316febf83..51469e0627ff 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -316,10 +316,36 @@ static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
 static inline bool ublk_queue_is_zoned(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_ZONED;
 }
 
+static void ublk_setup_iod_buf(const struct ublk_queue *ubq,
+			       const struct request *req,
+			       struct ublksrv_io_desc *iod)
+{
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	if (ubq->flags & UBLK_F_INTEGRITY) {
+		struct bio_integrity_payload *bip;
+		sector_t ref_tag_seed;
+
+		if (!blk_integrity_rq(req))
+			return;
+
+		bip = bio_integrity(req->bio);
+		ref_tag_seed = bip_get_seed(bip);
+		iod->integrity.ref_tag_lo = ref_tag_seed;
+		iod->integrity.ref_tag_hi = ref_tag_seed >> 32;
+		iod->integrity.app_tag = bip->app_tag;
+	} else
+#endif /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
+	{
+		const struct ublk_io *io = &ubq->ios[req->tag];
+
+		iod->addr = io->buf.addr;
+	}
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 
 struct ublk_zoned_report_desc {
 	__u64 sector;
 	__u32 operation;
@@ -498,11 +524,10 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 
 static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 					 struct request *req)
 {
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
-	struct ublk_io *io = &ubq->ios[req->tag];
 	struct ublk_zoned_report_desc *desc;
 	u32 ublk_op;
 
 	switch (req_op(req)) {
 	case REQ_OP_ZONE_OPEN:
@@ -545,11 +570,11 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 	}
 
 	iod->op_flags = ublk_op | ublk_req_build_flags(req);
 	iod->nr_sectors = blk_rq_sectors(req);
 	iod->start_sector = blk_rq_pos(req);
-	iod->addr = io->buf.addr;
+	ublk_setup_iod_buf(ubq, req, iod);
 
 	return BLK_STS_OK;
 }
 
 #else
@@ -1120,17 +1145,27 @@ static inline unsigned int ublk_req_build_flags(struct request *req)
 		flags |= UBLK_IO_F_NOUNMAP;
 
 	if (req->cmd_flags & REQ_SWAP)
 		flags |= UBLK_IO_F_SWAP;
 
+	if (blk_integrity_rq(req)) {
+		flags |= UBLK_IO_F_INTEGRITY;
+
+		if (bio_integrity_flagged(req->bio, BIP_CHECK_GUARD))
+			flags |= UBLK_IO_F_CHECK_GUARD;
+		if (bio_integrity_flagged(req->bio, BIP_CHECK_REFTAG))
+			flags |= UBLK_IO_F_CHECK_REFTAG;
+		if (bio_integrity_flagged(req->bio, BIP_CHECK_APPTAG))
+			flags |= UBLK_IO_F_CHECK_APPTAG;
+	}
+
 	return flags;
 }
 
 static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
-	struct ublk_io *io = &ubq->ios[req->tag];
 	u32 ublk_op;
 
 	switch (req_op(req)) {
 	case REQ_OP_READ:
 		ublk_op = UBLK_IO_OP_READ;
@@ -1155,11 +1190,11 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 
 	/* need to translate since kernel may change */
 	iod->op_flags = ublk_op | ublk_req_build_flags(req);
 	iod->nr_sectors = blk_rq_sectors(req);
 	iod->start_sector = blk_rq_pos(req);
-	iod->addr = io->buf.addr;
+	ublk_setup_iod_buf(ubq, req, iod);
 
 	return BLK_STS_OK;
 }
 
 static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index a54c47832fa2..a22de3fc5447 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -412,10 +412,25 @@ struct ublksrv_ctrl_dev_info {
  *
  * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLBACK is
  * passed in.
  */
 #define		UBLK_IO_F_NEED_REG_BUF		(1U << 17)
+/* Request has an integrity data buffer */
+#define		UBLK_IO_F_INTEGRITY		(1UL << 18)
+/* Guard tag verification requested */
+#define		UBLK_IO_F_CHECK_GUARD		(1UL << 19)
+/* Reference tag verification requested */
+#define		UBLK_IO_F_CHECK_REFTAG		(1UL << 20)
+/* Application tag verification requested */
+#define		UBLK_IO_F_CHECK_APPTAG		(1UL << 21)
+
+struct ublksrv_io_integrity
+{
+	__u32 ref_tag_lo; /* low 32 bits of reference tag seed */
+	__u16 ref_tag_hi; /* high 16 bits of reference tag seed */
+	__u16 app_tag;
+};
 
 /*
  * io cmd is described by this structure, and stored in share memory, indexed
  * by request tag.
  *
@@ -432,12 +447,20 @@ struct ublksrv_io_desc {
 	};
 
 	/* start sector for this io */
 	__u64		start_sector;
 
-	/* buffer address in ublksrv daemon vm space, from ublk driver */
-	__u64		addr;
+	union {
+		/*
+		 * buffer address in ublksrv daemon vm space, from ublk driver.
+		 * Unused for UBLK_F_SUPPORT_ZERO_COPY, UBLK_F_USER_COPY, or
+		 * UBLK_F_AUTO_BUF_REG.
+		 */
+		__u64		addr;
+		/* Integrity options, for UBLK_F_INTEGRITY */
+		struct ublksrv_io_integrity integrity;
+	};
 };
 
 static inline __u8 ublksrv_get_op(const struct ublksrv_io_desc *iod)
 {
 	return iod->op_flags & 0xff;
-- 
2.45.2

