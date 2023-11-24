Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FsQa/kX4"
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BDA199A
	for <linux-block@vger.kernel.org>; Fri, 24 Nov 2023 13:34:26 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so332375866b.1
        for <linux-block@vger.kernel.org>; Fri, 24 Nov 2023 13:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700861665; x=1701466465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noIJ/59XHMNwre/U1BzwYUAwqrYsA+aknRQ4PWKBWEs=;
        b=FsQa/kX45nXe3ZGT898SZcAS1jE2eQBzN8AlKIKA8tY5Jilux5b4U6CoeMZEIvMFFC
         PU5xdOLM8bCp4pPvzrB0PF+AAGn8ZdaeWGkgS85fnNTYcZQ8EdtHovKxCIfORmZ9kMSY
         adJeBCgjGBMdsyxmz0UnvDLA3w2Sf8tN2XQEjdhjiw40vLSU1fDPnccjMe68JssC5twn
         LYV5ki5rAxKqfi1uUL7L/nROSRksPnESX/H7gVcLPKypwWq/Lr9NuKZRODzu4Ol+Zliq
         e8+b1xNvSAJPpJBG+MpPK8L57tzrcLH7YAwA8YYewv/mWZCPrMi8O10bgN7LMix/qRrW
         ddlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700861665; x=1701466465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noIJ/59XHMNwre/U1BzwYUAwqrYsA+aknRQ4PWKBWEs=;
        b=jx8LstQe4jIB4MD15vQ2VXKtTANSU8xshCGh2H5EskymtIjXnF9fPdf4qjGdfBXrPN
         r570aJRmTuQEQ0CX9CB6V2NwLFWiv0GL2euntpP0aYzhavAvJIdPKql19Mrbd03zKx2K
         QCSHxx+D2sKnFol2kd9Iopiqfz3FXi3i5igG4zz1Z8dAmBf+joq1kx9tYBtFcJmDIP6Q
         hj6vrlwGXdQ8yJxB4kR3n8njPyN6s1zA5gH366g7v+TchiJZHRcIt4SF0pQEeZyyYmbx
         IhLkSQU/gnm3w/62sbrSh1l76HeBDllSclMc37oGfEXqxYcVnBgpaL1iEmoPvUcyi+Dh
         CSoA==
X-Gm-Message-State: AOJu0YwzbG3LcyNQbgWa636yPYinGGHnCbBqjOjJYbzefU6MtdH8lHkR
	JbO8rvGgB0S9kxbd4qInHp1QgSL0Yk+Ovx2tzYU=
X-Google-Smtp-Source: AGHT+IFtqjH3sTLLGFB7vJVxBXG+PXdA5jVIZeDZgiqqr3AagpFwDR6b82osh6BpBdEcpPorr4JMWg==
X-Received: by 2002:a17:907:d30c:b0:9ae:699d:8a2a with SMTP id vg12-20020a170907d30c00b009ae699d8a2amr4072810ejc.5.1700861665377;
        Fri, 24 Nov 2023 13:34:25 -0800 (PST)
Received: from lb01533.speedport.ip (p200300f00f4ce298610448d17080cbe0.dip0.t-ipconnect.de. [2003:f0:f4c:e298:6104:48d1:7080:cbe0])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090668d200b009fc95fc3dabsm2548857ejr.130.2023.11.24.13.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:34:25 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@infradead.org,
	sagi@grimberg.me,
	bvanassche@acm.org,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Santosh Pradhan <santosh.pradhan@ionos.com>,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 1/2] block/rnbd: add support for REQ_OP_WRITE_ZEROES
Date: Fri, 24 Nov 2023 22:34:21 +0100
Message-Id: <20231124213422.113449-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124213422.113449-1-haris.iqbal@ionos.com>
References: <20231124213422.113449-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Santosh Pradhan <santosh.pradhan@ionos.com>

Remove REQ_OP_WRITE_SAME in favour of REQ_OP_WRITE_ZEROES.

Signed-off-by: Santosh Pradhan <santosh.pradhan@ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c   |  9 ++++++---
 drivers/block/rnbd/rnbd-proto.h | 14 ++++++++++----
 drivers/block/rnbd/rnbd-srv.c   |  3 ++-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index b0550b68645d..499d0e655bc3 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1006,10 +1006,10 @@ static int rnbd_client_xfer_request(struct rnbd_clt_dev *dev,
 	msg.prio	= cpu_to_le16(req_get_ioprio(rq));
 
 	/*
-	 * We only support discards with single segment for now.
+	 * We only support discards/WRITE_ZEROES with single segment for now.
 	 * See queue limits.
 	 */
-	if (req_op(rq) != REQ_OP_DISCARD)
+	if ((req_op(rq) != REQ_OP_DISCARD) && (req_op(rq) != REQ_OP_WRITE_ZEROES))
 		sg_cnt = blk_rq_map_sg(dev->queue, rq, iu->sgt.sgl);
 
 	if (sg_cnt == 0)
@@ -1362,6 +1362,8 @@ static void setup_request_queue(struct rnbd_clt_dev *dev,
 	blk_queue_write_cache(dev->queue,
 			      !!(rsp->cache_policy & RNBD_WRITEBACK),
 			      !!(rsp->cache_policy & RNBD_FUA));
+	blk_queue_max_write_zeroes_sectors(dev->queue,
+					   le32_to_cpu(rsp->max_write_zeroes_sectors));
 }
 
 static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev,
@@ -1626,10 +1628,11 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	}
 
 	rnbd_clt_info(dev,
-		       "map_device: Device mapped as %s (nsectors: %llu, logical_block_size: %d, physical_block_size: %d, max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max_hw_sectors: %d, wc: %d, fua: %d)\n",
+		       "map_device: Device mapped as %s (nsectors: %llu, logical_block_size: %d, physical_block_size: %d, max_write_zeroes_sectors: %d, max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max_hw_sectors: %d, wc: %d, fua: %d)\n",
 		       dev->gd->disk_name, le64_to_cpu(rsp->nsectors),
 		       le16_to_cpu(rsp->logical_block_size),
 		       le16_to_cpu(rsp->physical_block_size),
+		       le32_to_cpu(rsp->max_write_zeroes_sectors),
 		       le32_to_cpu(rsp->max_discard_sectors),
 		       le32_to_cpu(rsp->discard_granularity),
 		       le32_to_cpu(rsp->discard_alignment),
diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index e32f8f2c868a..f35be51d213c 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -128,7 +128,7 @@ enum rnbd_cache_policy {
  * @device_id:		device_id on server side to identify the device
  * @nsectors:		number of sectors in the usual 512b unit
  * @max_hw_sectors:	max hardware sectors in the usual 512b unit
- * @max_write_same_sectors: max sectors for WRITE SAME in the 512b unit
+ * @max_write_zeroes_sectors: max sectors for WRITE ZEROES in the 512b unit
  * @max_discard_sectors: max. sectors that can be discarded at once in 512b
  * unit.
  * @discard_granularity: size of the internal discard allocation unit in bytes
@@ -145,7 +145,7 @@ struct rnbd_msg_open_rsp {
 	__le32			device_id;
 	__le64			nsectors;
 	__le32			max_hw_sectors;
-	__le32			max_write_same_sectors;
+	__le32			max_write_zeroes_sectors;
 	__le32			max_discard_sectors;
 	__le32			discard_granularity;
 	__le32			discard_alignment;
@@ -186,7 +186,7 @@ struct rnbd_msg_io {
  * @RNBD_OP_FLUSH:	     flush the volatile write cache
  * @RNBD_OP_DISCARD:        discard sectors
  * @RNBD_OP_SECURE_ERASE:   securely erase sectors
- * @RNBD_OP_WRITE_SAME:     write the same sectors many times
+ * @RNBD_OP_WRITE_ZEROES:   write zeroes sectors
 
  * @RNBD_F_SYNC:	     request is sync (sync write or read)
  * @RNBD_F_FUA:             forced unit access
@@ -199,7 +199,7 @@ enum rnbd_io_flags {
 	RNBD_OP_FLUSH		= 2,
 	RNBD_OP_DISCARD	= 3,
 	RNBD_OP_SECURE_ERASE	= 4,
-	RNBD_OP_WRITE_SAME	= 5,
+	RNBD_OP_WRITE_ZEROES	= 5,
 
 	/* Flags */
 	RNBD_F_SYNC  = 1<<(RNBD_OP_BITS + 0),
@@ -236,6 +236,9 @@ static inline blk_opf_t rnbd_to_bio_flags(u32 rnbd_opf)
 	case RNBD_OP_SECURE_ERASE:
 		bio_opf = REQ_OP_SECURE_ERASE;
 		break;
+	case RNBD_OP_WRITE_ZEROES:
+		bio_opf = REQ_OP_WRITE_ZEROES;
+		break;
 	default:
 		WARN(1, "Unknown RNBD type: %d (flags %d)\n",
 		     rnbd_op(rnbd_opf), rnbd_opf);
@@ -268,6 +271,9 @@ static inline u32 rq_to_rnbd_flags(struct request *rq)
 	case REQ_OP_SECURE_ERASE:
 		rnbd_opf = RNBD_OP_SECURE_ERASE;
 		break;
+	case REQ_OP_WRITE_ZEROES:
+		rnbd_opf = RNBD_OP_WRITE_ZEROES;
+		break;
 	case REQ_OP_FLUSH:
 		rnbd_opf = RNBD_OP_FLUSH;
 		break;
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 65de51f3dfd9..64ad1cd44942 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -544,7 +544,8 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 	rsp->max_segments = cpu_to_le16(bdev_max_segments(bdev));
 	rsp->max_hw_sectors =
 		cpu_to_le32(queue_max_hw_sectors(bdev_get_queue(bdev)));
-	rsp->max_write_same_sectors = 0;
+	rsp->max_write_zeroes_sectors =
+		cpu_to_le32(bdev_write_zeroes_sectors(bdev));
 	rsp->max_discard_sectors = cpu_to_le32(bdev_max_discard_sectors(bdev));
 	rsp->discard_granularity = cpu_to_le32(bdev_discard_granularity(bdev));
 	rsp->discard_alignment = cpu_to_le32(bdev_discard_alignment(bdev));
-- 
2.25.1

