Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C91448EA
	for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378007; cv=none; b=R7xLPP6kK9agjR68UOQzogUZnShqihmbuAro6JX3cVxBFItGb8ls34e4VrjXFomAAfO1eshRVjc192fPwKfGG1VEIoE/vFcU4mz8GTY/uzZyVEeaBEBOp237txvy8w6ahjUvGb7eqParCc/dMhv0Ewi8cQUQHkYTgzBmPaGX8Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378007; c=relaxed/simple;
	bh=d2qtFQBF5PisLq7gjtFPOlkyXWy7jFP6hL08jZev124=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lq2z7ivvE+KSEBfZ1ZFiSv8N6Az0m8n2KsPmuQCx4A/piVppuXwM+onaHiq/3uq+il1LTVqen/NmFpW+eaT709IHb3l27ZF7GYT+Ab5oeUoIc+lViz5KdaPbUZd8sIDhwW1x+9x/ghBmqcOxuAzXgx2V9dcp6VopfPohny4EXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2rVxZfZX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2rVxZfZX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Sl/DNmEsMokbnraCCUVvgMV51n7Gs9kMcwiqNJuRN1o=; b=2rVxZfZXipyatMOOZsnO0NbfTH
	HUSjmTqiRit0jbvN9rTlLVGLai5tRdZmcHN3q9qFam6s0doxI5hndneI4fLtMOqQZBW/P0wMTVEd/
	LHNqDfS3jHg3rnYazPxRcb6dv63Zpj8Mfcvxi/XC4QfvhBz3Th9UY8sXeAxNYweaUb/9OpOupuR6r
	BkLwdZYWrpcRR4FZcbncxQ66jRb0pXMOS9cahfqwQKx5HSTjEgGb3U4qG8IrjCgZ0RGjeewLnXXlc
	SUyEAcYa22ayUHwTWe+fjuZ4wKbz2DP5w2wk/mIsCkok8S6Z5GcDvrwYB8OnCqd7AiwEAIoEJD3bQ
	mR/ZAZSw==;
Received: from [2001:4bb8:2cd:5bfc:fac4:f2e7:8d6c:958e] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMKlI-00000005NlX-2mce;
	Wed, 26 Jun 2024 05:00:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 4/5] block: switch on bio operation in bio_integrity_prep
Date: Wed, 26 Jun 2024 06:59:37 +0200
Message-ID: <20240626045950.189758-5-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626045950.189758-1-hch@lst.de>
References: <20240626045950.189758-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use a single switch to perform read and write specific checks and exit
early for other operations instead of having two checks using different
predicates.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 1017984552baf8..3cd867b0544cf0 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -435,9 +435,6 @@ bool bio_integrity_prep(struct bio *bio)
 	if (!bi)
 		return true;
 
-	if (bio_op(bio) != REQ_OP_READ && bio_op(bio) != REQ_OP_WRITE)
-		return true;
-
 	if (!bio_sectors(bio))
 		return true;
 
@@ -445,10 +442,12 @@ bool bio_integrity_prep(struct bio *bio)
 	if (bio_integrity(bio))
 		return true;
 
-	if (bio_data_dir(bio) == READ) {
+	switch (bio_op(bio)) {
+	case REQ_OP_READ:
 		if (bi->flags & BLK_INTEGRITY_NOVERIFY)
 			return true;
-	} else {
+		break;
+	case REQ_OP_WRITE:
 		if (bi->flags & BLK_INTEGRITY_NOGENERATE)
 			return true;
 
@@ -459,6 +458,9 @@ bool bio_integrity_prep(struct bio *bio)
 		 */
 		if (bi->csum_type == BLK_INTEGRITY_CSUM_NONE)
 			gfp |= __GFP_ZERO;
+		break;
+	default:
+		return true;
 	}
 
 	/* Allocate kernel buffer for protection data */
-- 
2.43.0

