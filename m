Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA6376E7
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 05:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719810571; cv=none; b=BpuyuckOdgn5b99Vmgs49gfvy9ZXR237DVgQvu97YVMmnW4QcWC8N7Wlwaay0IJ6+6V9pzIH9yi2stGaAoRq0Ez+UdXnRYGP0aTlo3MNfaC7usUuW2T/+ByQhOzL6byqNLs0ZeGVEP1ozy1klwUjXhwjaa/eP/b8ychGOul2baE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719810571; c=relaxed/simple;
	bh=Q2RYNIuORvJe8FKOrW9CkWJx2X+OSjx7v9KYAcO7Fn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUpucg6znlrHMWbg4H4rGH+Ss2ei+IOvhj4nKvIGcZxYMBAbnmAM0gTA+YDKdubwwMHJvFm6M9f98uMm9pP3JGHoxgJDm8e8DGmwiOYOV/9cKP24TT7uampx9nCEEGWL4zFLY7DrJAK/6JaA/OYwhPBBpFgnQq5W7KFrgKFTJ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QEVkYk6S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QEVkYk6S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vnOFrUrMdO9of/g24Z5u8DzS078m9vGYX6da2/MfHok=; b=QEVkYk6S+tAGxp8ugnEIwsbVzQ
	IPsMwW7oKJwkol6w4ASwaI04UyWjO2TwkkMGqayZKAbu8qI/u9+zn0wynLgrj9os/AcTLsG/OXIsK
	rvBc9pbM8Eov5fwv0UuWCwd/XYR9x9AR1m+20jZsLlXyc2EQ3zB5v2MILEiDF1psVhvMB52JImDH0
	xC736teUBRCF+DRY/mLbgj+N2XBONVrs8LLr6hwOAOJ+vqvl0WjGP/Z4s2KrZVjQCzFovDY18AuL1
	bszpYw9RqfyH2DT4MdsinU4EpH2uqyj4pYUPEVv7ZbcYcjlvrwdbBnAyIpxgdS3SxTCDaMPp6SiCq
	DBGRlYkA==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9I8-00000001iDE-3XAC;
	Mon, 01 Jul 2024 05:09:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/5] block: call bio_integrity_unmap_free_user from blk_rq_unmap_user
Date: Mon,  1 Jul 2024 07:08:59 +0200
Message-ID: <20240701050918.1244264-4-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701050918.1244264-1-hch@lst.de>
References: <20240701050918.1244264-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

blk_rq_unmap_user always maps user space pass-through request.  If such
a request has integrity data attached it must come from a user mapping
as well.  Call bio_integrity_unmap_free_user from blk_rq_unmap_user
and remove the nvme_unmap_bio wrapper in the nvme driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c     |  1 -
 block/blk-map.c           |  3 +++
 drivers/nvme/host/ioctl.c | 15 ++++-----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index c4aed1dfa497a3..c8757d47e0ef62 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -174,7 +174,6 @@ void bio_integrity_unmap_free_user(struct bio *bio)
 	bio->bi_integrity = NULL;
 	bio->bi_opf &= ~REQ_INTEGRITY;
 }
-EXPORT_SYMBOL(bio_integrity_unmap_free_user);
 
 /**
  * bio_integrity_add_page - Attach integrity metadata
diff --git a/block/blk-map.c b/block/blk-map.c
index bce144091128f6..df5f82d114720f 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -757,6 +757,9 @@ int blk_rq_unmap_user(struct bio *bio)
 			bio_release_pages(bio, bio_data_dir(bio) == READ);
 		}
 
+		if (bio_integrity(bio))
+			bio_integrity_unmap_free_user(bio);
+
 		next_bio = bio;
 		bio = bio->bi_next;
 		blk_mq_map_bio_put(next_bio);
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index fb46f55f8b2894..f1d58e70933f54 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -112,13 +112,6 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 	return req;
 }
 
-static void nvme_unmap_bio(struct bio *bio)
-{
-	if (bio_integrity(bio))
-		bio_integrity_unmap_free_user(bio);
-	blk_rq_unmap_user(bio);
-}
-
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, struct io_uring_cmd *ioucmd, unsigned int flags)
@@ -165,7 +158,7 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 
 out_unmap:
 	if (bio)
-		nvme_unmap_bio(bio);
+		blk_rq_unmap_user(bio);
 out:
 	blk_mq_free_request(req);
 	return ret;
@@ -203,7 +196,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (result)
 		*result = le64_to_cpu(nvme_req(req)->result.u64);
 	if (bio)
-		nvme_unmap_bio(bio);
+		blk_rq_unmap_user(bio);
 	blk_mq_free_request(req);
 
 	if (effects)
@@ -414,7 +407,7 @@ static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd,
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 
 	if (pdu->bio)
-		nvme_unmap_bio(pdu->bio);
+		blk_rq_unmap_user(pdu->bio);
 	io_uring_cmd_done(ioucmd, pdu->status, pdu->result, issue_flags);
 }
 
@@ -440,7 +433,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	 */
 	if (blk_rq_is_poll(req)) {
 		if (pdu->bio)
-			nvme_unmap_bio(pdu->bio);
+			blk_rq_unmap_user(pdu->bio);
 		io_uring_cmd_iopoll_done(ioucmd, pdu->result, pdu->status);
 	} else {
 		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
-- 
2.43.0

