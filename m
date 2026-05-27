Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E67426EA6
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894659; cv=none; b=gxI6HxaHYbkaz+zpogzUK7AoWgEk/9wZbVlHMapNVV2IiTOixprlMAhrJefugmYhsvwdP8SXVSRicYK8FcNk91dB3s1GKm8rZTkLxqXOkFilMczwaJTONU9E/s8nPef1XHn27nE/eIPmhuthhtuiPv2oQLdYQ0TAB1wa6YGpVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894659; c=relaxed/simple;
	bh=JsJdO7ZwgoYgACdPmI+PULg1m+jtnG5PJYuu8TuFxOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGAG/yCrwPxT/B0PjBxvAFeHJ58dYcaKVk9N0qLjknabaoI4pN4MAd2dmZHWK1LfEfAkTYK1uexRFuKRltbrC0v2RBIVEBxowIwSCoOedAXKrVm823yQckj9B4vtN8dm6BPjarLYrqEVeJ6YFHd4RLBTsH3nXHCqG3gN7D7YSGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WRG3bWEo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WRG3bWEo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Mm/qnc7jP80KHSMsNawLUGCDZW5gR0UcuDRrCHUzi2c=; b=WRG3bWEoJ602p7QNQQOoXwz4cS
	jSWpQXobJW9VUeV8B2heC9A++PQYZNOK9x/w1GRBNZsUCxL9uRyziAZJcq8SVwyZg7gYe2u5Vh4tH
	T1s17ojZuk7naSn5j7IAbci8Szof8ElSgACNHDE9cST1SCIXR8SlJonmWMy9Y34XtwxZ3kqoW8FFa
	aNiD7s2M9hQRj9YipqrtFEpIKVooYzh2C7LNQbgo2e5QNIsCA+KJHzodDSKGLTvmUm9qW4CfLKSy1
	2A+ADz/EnInzNJc6jIAjWRE6VcLYJTdd/XGl7xbReu8FnZb5xhexyaSJ+zCL7u3tPLn6sSl7HY2Bx
	M93X+jvA==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFuI-00000004NZx-46t3;
	Wed, 27 May 2026 15:10:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvme-tcp: cleanup nvme_tcp_init_iter
Date: Wed, 27 May 2026 17:10:21 +0200
Message-ID: <20260527151043.2349900-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527151043.2349900-1-hch@lst.de>
References: <20260527151043.2349900-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Split the two init cases based on code in the zloop driver.  This
simplifies the code and makes it easier to follow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/tcp.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 36b3ec50a9fd..9313ab211c67 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -340,32 +340,25 @@ static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
 		unsigned int dir)
 {
 	struct request *rq = blk_mq_rq_from_pdu(req);
-	struct bio_vec *vec;
-	unsigned int size;
-	int nr_bvec;
-	size_t offset;
 
 	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		vec = &rq->special_vec;
-		nr_bvec = 1;
-		size = blk_rq_payload_bytes(rq);
-		offset = 0;
+		iov_iter_bvec(&req->iter, dir, &rq->special_vec, 1,
+				blk_rq_payload_bytes(rq));
+		req->iter.iov_offset = 0;
 	} else {
 		struct bio *bio = req->curr_bio;
 		struct bvec_iter bi;
 		struct bio_vec bv;
+		int nr_bvec = 0;
 
-		vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
-		nr_bvec = 0;
-		bio_for_each_bvec(bv, bio, bi) {
+		bio_for_each_bvec(bv, bio, bi)
 			nr_bvec++;
-		}
-		size = bio->bi_iter.bi_size;
-		offset = bio->bi_iter.bi_bvec_done;
-	}
 
-	iov_iter_bvec(&req->iter, dir, vec, nr_bvec, size);
-	req->iter.iov_offset = offset;
+		iov_iter_bvec(&req->iter, dir,
+			__bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter), nr_bvec,
+			bio->bi_iter.bi_size);
+		req->iter.iov_offset = bio->bi_iter.bi_bvec_done;
+	}
 }
 
 static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
-- 
2.53.0

