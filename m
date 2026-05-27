Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B73F426EC1
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894661; cv=none; b=s6Fwt2KZSc9+OicffyBVJjoWb29yr4oyt9GfxdYpb2xC+e52fyLfvPSzzOIcFbKYR9Qcx4/dwHlT24HSMRkQp0E6wgOag5tmv3kNP08NUU4IbImRBHjulUMLf8ZxazRR7XrwpzaHdjQTEAt0k01Lx3f8qhz8ZPSh/erVEWsVhB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894661; c=relaxed/simple;
	bh=5FhqfsKN/TMYCXjrR54+/XKP8eyzS4UnTD2/xaQlqhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfdPJO3tCVRjOkQiJb6rTuFJnqZIMdrK3iRejOIuG0nWmpBNuhj25HkfOr5RBRVnXjmsYexoNzfpdyNpLwTL9FrqC52y86JtSMtbNqOmCbH/IfXU79mMz06hd1CvVEcZiirG/GXA9JkO4cJCXjO+6caDCIKXTMNFBkFAEMhRwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aRifvWxF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aRifvWxF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2KEyzXbJPuE0a1jUK29wcgYb0GSLQISya811Z5xV88A=; b=aRifvWxFGuoj2/5Pk5vB9sZ13d
	UBCwOeKNIEUuQifZaitFuT7I9UPfsch45sP/Uj7ArgAsko9n0psCbmmhH0F0s5Xvz+ZnYyvtjeoTG
	zIlGfEm/x5dnUlE7xzPdvJIaA3xUlosHqkRJ8CrZTCY8HEIbS1M0ZNrz2GO5mBrOHhIbyLkBAwYgK
	lgVFiuFPvLM7t64JF45D0pfcFbCC7NDKBxIUNl2DzPzr/U1LAlULyGsrS/JJWsQt0lx0B8ZYv5QuX
	4/HpRfw0Uh1AOvgILcdbJio/dusNE3qDZcW4E8sNwrZSjscDC6um2YSih+O9dMoDzUeZMUTgCwq5T
	trKMbIpQ==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFuF-00000004NYo-0IjT;
	Wed, 27 May 2026 15:10:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] loop: cleanup lo_rw_aio
Date: Wed, 27 May 2026 17:10:20 +0200
Message-ID: <20260527151043.2349900-2-hch@lst.de>
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

Port over the changes from the zloop driver to remove the need for
the local bio, bvec and offset variables and clean up the code by
that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..310de0463beb 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -342,23 +342,19 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 {
 	struct iov_iter iter;
 	struct req_iterator rq_iter;
-	struct bio_vec *bvec;
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
-	struct bio *bio = rq->bio;
 	struct file *file = lo->lo_backing_file;
-	struct bio_vec tmp;
-	unsigned int offset;
 	unsigned int nr_bvec;
 	int ret;
 
 	nr_bvec = blk_rq_nr_bvec(rq);
 
 	if (rq->bio != rq->biotail) {
+		struct bio_vec tmp, *bvec;
 
-		bvec = kmalloc_objs(struct bio_vec, nr_bvec, GFP_NOIO);
-		if (!bvec)
+		cmd->bvec = kmalloc_objs(*cmd->bvec, nr_bvec, GFP_NOIO);
+		if (!cmd->bvec)
 			return -EIO;
-		cmd->bvec = bvec;
 
 		/*
 		 * The bios of the request may be started from the middle of
@@ -366,26 +362,26 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		 * copy bio->bi_iov_vec to new bvec. The rq_for_each_bvec
 		 * API will take care of all details for us.
 		 */
+		bvec = cmd->bvec;
 		rq_for_each_bvec(tmp, rq, rq_iter) {
 			*bvec = tmp;
 			bvec++;
 		}
-		bvec = cmd->bvec;
-		offset = 0;
+		iov_iter_bvec(&iter, rw, cmd->bvec, nr_bvec, blk_rq_bytes(rq));
+		iter.iov_offset = 0;
 	} else {
 		/*
 		 * Same here, this bio may be started from the middle of the
 		 * 'bvec' because of bio splitting, so offset from the bvec
 		 * must be passed to iov iterator
 		 */
-		offset = bio->bi_iter.bi_bvec_done;
-		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
+		iov_iter_bvec(&iter, rw,
+			__bvec_iter_bvec(rq->bio->bi_io_vec, rq->bio->bi_iter),
+			nr_bvec, blk_rq_bytes(rq));
+		iter.iov_offset = rq->bio->bi_iter.bi_bvec_done;
 	}
 	atomic_set(&cmd->ref, 2);
 
-	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
-	iter.iov_offset = offset;
-
 	cmd->iocb.ki_pos = pos;
 	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
-- 
2.53.0

