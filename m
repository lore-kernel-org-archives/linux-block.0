Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60D81BB6A0
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933057; cv=none; b=pVKCw/SSCKn0/O7CFZjmhlZgFCO5k2h/B+eHP7YWkhMHvPKdMUsCfhphejkcbwD/ND0CqMPZWKtg+lW1EU5Fa61s3dHsSsQiVCp0mvxQ9H9Ry36n/cRRJGy0SuBQEJRBnyif5jnvWUAGOrV+0lG1V9/W+oGK9iULAF6Jx25ATLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933057; c=relaxed/simple;
	bh=M5GQ7BCJq4PXak1TLgKx3Zae1ajJkHsYeoobxN3xZNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIpJnhVTLwdGi/HgLxvjX1j5pDiytYnVxmcGSyp8i1OT1CoxDWevGFHgOFqzWKVEPLMnitwZa7PnRfquq119raw1w7wEEywnecIyj8jFXklnHTe0UQdDekcmD0fsf973duK6cfp+R/Ixa3TR618Gb3QLas+RX5sFDvmnwhrUnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mxd6i/eH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mxd6i/eH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1XuL9DY/pU8TnRQZjZdiKw2eF70rYsniNjTqrte+D7k=; b=mxd6i/eHXxcGoB1rEUqF/jbBuQ
	9tYfdvQquB+sql5dOmLfda8nw23AvEG2sb8RkLqPGDsHlnW4cTtGJaGGzFD4w9MaDbUlxGb3RBb8h
	4sCZHFfwrIwq4wKOM/ACg02qpLBwyStq2ftQqIBINmDrRvxFUqz6H+8XuuBkMKmk8eW4WTu4L8ZZE
	3dnyhsPuThPsNHJ6ZWW2nXVxHFjqXdIkj4+yoAk8PuF2PCtGnQ50JYQ1N967o/ZH1dY+XDdeYtad/
	G1GSoV0wyiGFjRYhQRekIuIlo7fAZCgY0uVTAH/quaVLMOmLv31SANtVRtBUVBOgqCAz3+NlFRuKO
	RYOLo2iw==;
Received: from 2a02-8389-2341-5b80-4c69-cf21-4832-bbca.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c69:cf21:4832:bbca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOf9j-000000079UD-08tU;
	Tue, 02 Jul 2024 15:10:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/6] block: also return bio_integrity_payload * from stubs
Date: Tue,  2 Jul 2024 17:10:20 +0200
Message-ID: <20240702151047.1746127-3-hch@lst.de>
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

struct bio_integrity_payload is defined unconditionally. No need to
return void * from bio_integrity() and bio_integrity_alloc().

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
---
 include/linux/bio-integrity.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 70ef19a0dc7e8b..cac24dac06fff0 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -85,7 +85,7 @@ void bio_integrity_init(void);
 
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 
-static inline void *bio_integrity(struct bio *bio)
+static inline struct bio_integrity_payload *bio_integrity(struct bio *bio)
 {
 	return NULL;
 }
@@ -138,8 +138,8 @@ static inline bool bio_integrity_flagged(struct bio *bio, enum bip_flags flag)
 	return false;
 }
 
-static inline void *bio_integrity_alloc(struct bio *bio, gfp_t gfp,
-		unsigned int nr)
+static inline struct bio_integrity_payload *
+bio_integrity_alloc(struct bio *bio, gfp_t gfp, unsigned int nr)
 {
 	return ERR_PTR(-EINVAL);
 }
-- 
2.43.0

