Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719AA1BB6A0
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933061; cv=none; b=tVaRNFeutrSV6SVlToZn9TCvbjncPqf6VBy0IhvJASj8SomzFuGEjhbUlOKidlUUuE2SAlmV2gjSzdhebkfAak7msvMviaqE/Xjv5PgQ3Cjt0yTdmVHhvYcpX0Tn1S4ooLzMO424RrELsdu994O04tDcoeozekKbrbFCOhECDh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933061; c=relaxed/simple;
	bh=pQnMNxzTz6sx53YbdMFbqXEB1iZOq/9Qr+ggkfpnZi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwl42wniIMhDh6LoVmjx+VKUsajPC8jr+KIaloW9JRV2+jmbT28NGi4pb6sTy6Tx28K0axQmCf/0mR6y2YQ9PgkSg3rMIL9xI3jJIbmeVEAn0vAZLnphwoeGgQyqHAHw0umZ1CUgjXE65bNjY5WzXhL4XjRzjVLtXymMWS1n6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IUXMtlLS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IUXMtlLS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=njpzKyRI9Qvkux/MnNAf6eEOBeyv2fOl7BBE+/NdCFs=; b=IUXMtlLS57/WjX8KZUcfC6s5GB
	xx3G/Ro8UshlKbUpDfgcPj9GuO4aPu81Eok7YL1171xkuO1+6DTVXPyVyP020zNNzJRXPbwydKY4x
	x2m4pNQP7GiIyrMFXhos67W6xXuCiYBU+BgMjoXZJxIEYRrE5I+mh8ETnIJ4SOzsL6mSG7JotjKFR
	yzYfkLssVyOBWy7j4s0FLzanf9fjSpwbWReU4TRKxf4TzouYN2VaqxXbXnIiQiLhWEZZ4bVlOis/g
	d9CJdqNxN+VU5ICf5wg5Eps52GdrnG9tywRbqTKno0sLDSy6hI7uc2zbQdLVoioa5au2OCzyqU+33
	u4iKRdOw==;
Received: from 2a02-8389-2341-5b80-4c69-cf21-4832-bbca.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c69:cf21:4832:bbca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOf9n-000000079Uk-3Lqn;
	Tue, 02 Jul 2024 15:11:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 4/6] block: call bio_integrity_unmap_free_user from blk_rq_unmap_user
Date: Tue,  2 Jul 2024 17:10:22 +0200
Message-ID: <20240702151047.1746127-5-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702151047.1746127-1-hch@lst.de>
References: <20240702151047.1746127-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

blk_rq_unmap_user always unmaps user space pass-through request.  If such
a request has integrity data attached it must come from a user mapping
as well.  Call bio_integrity_unmap_free_user from blk_rq_unmap_user
and remove the nvme_unmap_bio wrapper in the nvme driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
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

