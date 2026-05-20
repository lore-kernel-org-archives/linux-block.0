Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AB2372691
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779309419; cv=none; b=Sef1H1YVXXGsKtX7w6n9psnAf5duPhr8ky8aFCX93fPtQO0EMyjNdVXo6RpncX18r6JOQscwP7VXa88u+tV0yFmF+U5786wDpw2IqTZwrPfWQMQ0EVGOz7x7kgoJoMy9BLtClsLV3puEUPQhzNAdsCGWcDCKtfVlRYdz79OZZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779309419; c=relaxed/simple;
	bh=2hbRQo7mkMARJQnyKMP2SNSnjNvSc36eDda5MF7AeAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diGIzZbl/t/me6PaOpG5kdv3ZTN8YGgiYOwxWyh4X0+QiJQqTgzFoCm3qWliLRQwCfnUtdh/t8WF7aIOV3zb4dlCyoAiBfvCoaTUjubk6jR9TqXejBqPgQPIsglp1ckJXZoMMp5htzRIvTgUXsU0meqodxHPQT1HY+QkB2eEICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=K8epy9xE; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="K8epy9xE"
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-7bfea8dc6d8so3217787b3.0
        for <linux-block@vger.kernel.org>; Wed, 20 May 2026 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1779309417; x=1779914217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpAgpwJbrwOx5gZ5eUZ47nuZhUbhppL2lbd7NNf+mb0=;
        b=K8epy9xEdckXt4WxWkq20AoVv8SfeK3/ZtrC0SOTTFwV5Isg1zJoL2nnYJD+39A2uN
         zIg+F3pk/AEcPzkxmkGs17OYGsikPM76HBixGkT37CBhk+rboOddFgAiNQHJ2rv6lWqf
         /5t4scOA2z98iqWMu66EY4w3Mpzjeg+FBFowt009s9MrejIaxnIOzbHPO6uTNeIp6Vc6
         rGVXhhaakp/zjwZkSCm8MCvvZhsTyIml9E+cXrr+iQoTOMDHeA3ls6B00dOSh2cdN2hL
         Qx201RVoOuiSAfd5aU9g8PTxVyay++GC1lUS2BUUpjriCJY5Yq7WQTdOrlJifY0Aij2T
         H1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779309417; x=1779914217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpAgpwJbrwOx5gZ5eUZ47nuZhUbhppL2lbd7NNf+mb0=;
        b=MT0I3oZfPSpBApb/F0cbsj0JsSdzALblX6Rn8cgLIEzT/DO+vRSHWUtPf+SFuiUZnG
         stzOASuwknAKe/pH7quxocLEEDClfbDgMRu24IBL0bAShHy4lBphsNGMsjQ5UDdXgWSP
         imDpSTDC1xY7d7PcT2DdusntgvMmXg8Vc3NjU3ea6ykmDqqSygl32DATH+wrF0B6cELB
         uNp1okTb3KATpdP7zpMhmIN5ZEjllEEVGjSBJEUc7nPEchUGbqL44S07mIXn2p4XAgHJ
         YqtrbjQ/P2gH5ywV/+LDS/wYkF6+War8mX3tgBYCYEgx8+9EuZXkw6sOhunTq28VBZJ3
         F4Gg==
X-Gm-Message-State: AOJu0YxHzn/zk7h/BbVCuettJUZrP2dzJzWSlefwg4Jm2OxKEs+P7lUU
	NCMZyQzE6bME3cEShUsHoMDgyln1jhHUUtt0jNxPw8dYlrAfYi7fQCslrkKCbY+fMRvq+8ahKZA
	OIUbNtiNQsF3HpnDrg1DdKIShN3ftN1IJTRCZHFZSv2n1K6vOmoqW
X-Gm-Gg: Acq92OGoWyc2xTFd82BgYr8TIGtFOEbCHHZaIGZ/O3zkILOz5kZSwFMKEdH5WBrEmFA
	YF2vaHZFpooAma+RJhYm/QPcuLDvFLM1+jskZ4waCXNg6SGOq6Dh8VHh7FNjV90GaIqUdMV1Eou
	AKPZF/AcfD+sQZVwPDho2pa5Rn+7JjCLvTZu2eQUc2/udhVosRfdNyN8eR34zbV4kJDIY2lsXSf
	ytnEaOdmT4xSXp+NjDKewbhMlWiLhCEafLUU93NmrFtB19aew/jocObDEnn/gDvF76X9xAI+gjD
	WjkF44BhrSM3a/sQ9rNXtX58bun/ZgvarVvSPA6+1x/jw24aW5SfNbjKGAcoIp1E1AbPkYZG1vH
	I4WSxhN/RrisfroVydwaIv7ZDfyn7QhDFp34apKs=
X-Received: by 2002:a05:690c:7108:b0:79c:ff02:a03e with SMTP id 00721157ae682-7d20a6aea9cmr339647b3.2.1779309417149;
        Wed, 20 May 2026 13:36:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7cc9b6331easm8584207b3.19.2026.05.20.13.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:36:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.46.22])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 854DC3421AE;
	Wed, 20 May 2026 14:36:56 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7ACA7E40A79; Wed, 20 May 2026 14:36:56 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 7.2 2/2] ublk: factor out ublk_init_iod() helper
Date: Wed, 20 May 2026 14:36:54 -0600
Message-ID: <20260520203654.1413640-3-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520203654.1413640-1-csander@purestorage.com>
References: <20260520203654.1413640-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code for initializing struct ublksrv_io_desc on I/O dispatch is
largely duplicated in 3 places. Commit 4d4a512a1f87 ("ublk: add PFN-
based buffer matching in I/O path") added support to ublk_setup_iod()
for matching request buffers against registered UBLK_F_SHMEM_ZC buffers,
but missed adding it to ublk_setup_iod_zoned() for zoned requests. Move
the duplicated logic to a new helper ublk_init_iod(). This way, zone
appends can also benefit from avoiding the data copy.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 60 +++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0cb29be561b5..49624e65fe75 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -499,10 +499,35 @@ static inline unsigned int ublk_req_build_flags(struct request *req)
 		flags |= UBLK_IO_F_INTEGRITY;
 
 	return flags;
 }
 
+static void ublk_init_iod(struct ublk_queue *ubq, struct request *req,
+			  uint8_t ublk_op, uint32_t nr_sectors,
+			  uint64_t start_sector)
+{
+	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
+	struct ublk_io *io = &ubq->ios[req->tag];
+
+	iod->op_flags = ublk_op | ublk_req_build_flags(req);
+	iod->nr_sectors = nr_sectors;
+	iod->start_sector = start_sector;
+
+	/* Try shmem zero-copy match before setting addr */
+	if (ublk_support_shmem_zc(ubq) && blk_rq_has_data(req)) {
+		u32 buf_idx, buf_off;
+
+		if (ublk_try_buf_match(ubq->dev, req, &buf_idx, &buf_off)) {
+			iod->op_flags |= UBLK_IO_F_SHMEM_ZC;
+			iod->addr = ublk_shmem_zc_addr(buf_idx, buf_off);
+			return;
+		}
+	}
+
+	iod->addr = io->buf.addr;
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 
 struct ublk_zoned_report_desc {
 	__u64 sector;
 	__u32 operation;
@@ -680,12 +705,10 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 }
 
 static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 					 struct request *req)
 {
-	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
-	struct ublk_io *io = &ubq->ios[req->tag];
 	struct ublk_zoned_report_desc *desc;
 	u32 ublk_op;
 
 	switch (req_op(req)) {
 	case REQ_OP_ZONE_OPEN:
@@ -711,13 +734,12 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 		if (!desc)
 			return BLK_STS_IOERR;
 		ublk_op = desc->operation;
 		switch (ublk_op) {
 		case UBLK_IO_OP_REPORT_ZONES:
-			iod->op_flags = ublk_op | ublk_req_build_flags(req);
-			iod->nr_zones = desc->nr_zones;
-			iod->start_sector = desc->sector;
+			ublk_init_iod(ubq, req, ublk_op, desc->nr_zones,
+				      desc->sector);
 			return BLK_STS_OK;
 		default:
 			return BLK_STS_IOERR;
 		}
 	case REQ_OP_DRV_OUT:
@@ -725,15 +747,11 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 		return BLK_STS_NOTSUPP;
 	default:
 		return BLK_STS_IOERR;
 	}
 
-	iod->op_flags = ublk_op | ublk_req_build_flags(req);
-	iod->nr_sectors = blk_rq_sectors(req);
-	iod->start_sector = blk_rq_pos(req);
-	iod->addr = io->buf.addr;
-
+	ublk_init_iod(ubq, req, ublk_op, blk_rq_sectors(req), blk_rq_pos(req));
 	return BLK_STS_OK;
 }
 
 #else
 
@@ -1468,12 +1486,10 @@ static unsigned int ublk_unmap_io(bool need_map,
 	return rq_bytes;
 }
 
 static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
-	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
-	struct ublk_io *io = &ubq->ios[req->tag];
 	u32 ublk_op;
 
 	switch (req_op(req)) {
 	case REQ_OP_READ:
 		ublk_op = UBLK_IO_OP_READ;
@@ -1494,29 +1510,11 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 		if (ublk_queue_is_zoned(ubq))
 			return ublk_setup_iod_zoned(ubq, req);
 		return BLK_STS_IOERR;
 	}
 
-	/* need to translate since kernel may change */
-	iod->op_flags = ublk_op | ublk_req_build_flags(req);
-	iod->nr_sectors = blk_rq_sectors(req);
-	iod->start_sector = blk_rq_pos(req);
-
-	/* Try shmem zero-copy match before setting addr */
-	if (ublk_support_shmem_zc(ubq) && blk_rq_has_data(req)) {
-		u32 buf_idx, buf_off;
-
-		if (ublk_try_buf_match(ubq->dev, req,
-					  &buf_idx, &buf_off)) {
-			iod->op_flags |= UBLK_IO_F_SHMEM_ZC;
-			iod->addr = ublk_shmem_zc_addr(buf_idx, buf_off);
-			return BLK_STS_OK;
-		}
-	}
-
-	iod->addr = io->buf.addr;
-
+	ublk_init_iod(ubq, req, ublk_op, blk_rq_sectors(req), blk_rq_pos(req));
 	return BLK_STS_OK;
 }
 
 static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 		struct io_uring_cmd *ioucmd)
-- 
2.54.0

