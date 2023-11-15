Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DBC3BB57
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cfuEpn7K"
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576BC8E
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 08:37:54 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so10515582a12.3
        for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 08:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700066273; x=1700671073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npvHEDs0lQ5fjOX3IfGreXxIgJW8dWgFpYtFpCOR51g=;
        b=cfuEpn7KMDApEvQOEos/e4az0F5PqcuLIwQAykqDoNLlJw8IV8hnNUe/P0+XXGjyUq
         h97uO8dHnaoJlDcaiGLuUZ/zIVLl0x/KUd0FztREAAfbIPMx6X35PTdJifETWianYVlB
         uTmgOpIfZnieUENJ9vMF4btEGqdj/1sq64SeM9us3Osa3XkRF2hsEMYvB3gjrapcRAC5
         rFls5WrsjNTdlDZdYwsJ3Wk4djhdsf5KuQJgKNZbb0JqYdBD1/KUXy0JSxWjEO43aALL
         jgR2/SKDduCMvniV2x1XicXYS4FIPekUYeKGHDdnOvY9M2X0DOSPF3tPrTBQq/I61r0e
         9EKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700066273; x=1700671073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npvHEDs0lQ5fjOX3IfGreXxIgJW8dWgFpYtFpCOR51g=;
        b=RjX43fEwTWYHEzes9r9u+BoRuFm8m4d6ijWTGiI0BZTn96Fe3wiBlfsecGoXfnCmTD
         O5srRK2lhb0fNJZEj6lZLNMPVKUoLC6VfGaJhBRl5QsxPb2oxn+gw6HUV6r+ME5X5kBu
         Nwthu9cRfnXTL+3auuF6gejWYf+GxoNGqmPG5LezINTivUr0Vyza004i19pcy4oLhMrX
         4ZVTbp06iZphqkEHN5biC4JJTgH3w1CKx92T1qB9F/v56E29So5Rw3vlzhTO/9q3KnLv
         vND8b2AxpZt4kiyZ467k26Npz51IwauJutZb5sr/6gGUBSze/UiPD1+4idIoyYIO8J0m
         aZIA==
X-Gm-Message-State: AOJu0YyoZgzjyOsUc1yCyC3UrcbnOYZgFy7n9gZheiVM2gOUZixh/SwY
	7LlnhslGgKZFpfK3a4ygVF06q860qYOt6Kmk9ms=
X-Google-Smtp-Source: AGHT+IHCB8hxcIBAQ/PZ2dO+P7uBBzIqhGF2KgKzqV9sAOUs2wYDE/lOtQbkznIe68+6tZNO2PCygA==
X-Received: by 2002:a17:907:6d11:b0:9c5:cfa3:d04d with SMTP id sa17-20020a1709076d1100b009c5cfa3d04dmr12463568ejc.52.1700066272770;
        Wed, 15 Nov 2023 08:37:52 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id sa31-20020a1709076d1f00b009d2eb40ff9dsm4591316ejc.33.2023.11.15.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:37:52 -0800 (PST)
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
Subject: [PATCH for-next 1/2] block/rnbd: add support for REQ_OP_WRITE_ZEROES
Date: Wed, 15 Nov 2023 17:37:48 +0100
Message-Id: <20231115163749.715614-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231115163749.715614-1-haris.iqbal@ionos.com>
References: <20231115163749.715614-1-haris.iqbal@ionos.com>
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
index c186df0ec641..c6dafce731dc 100644
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

