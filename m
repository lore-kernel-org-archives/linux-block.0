Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC02EAB78
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206978; cv=none; b=mGZ+Mmp5CRtNP2rKIUTGGoslpZ7ZoigTGqYBICdc3UGdqC9JoVHQeePgvy9E0BDzLLXpb8f9kHnK+pD/xYTKlbNh7zL9UcuY5eAwIJodDpxmcKcz4iXavp/l2hgOSeAS9deYbfklJSTRCF6ae6gZM23YXrnk9UJytHGNCP+gohQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206978; c=relaxed/simple;
	bh=cMyPEwVxr2wsLve8DzYY6/E1/i60lUlIVDEjLlhqzYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnD7TtDQYnCaqr4OWwrQz1ROXz54v2V87YpQwizOfstXFRS7KJxn5Rp7bmox5BQIk7FSMlOQHdDFcc5Gfh9X7tO1K7tWot8aYZNJDIQPtyAHQiLNChAtjhW0IaLlf6t4SXVVUgCWknfEd9ahZ6wJ1//PQoSiFVH6nch31LGKyGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kV16myGL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kV16myGL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aAMKm+7bDXxhjSF5naz/L3X2AhxzM7SMNuu5TaNOAXc=; b=kV16myGLCrGCuAwJ0iylxpdMe3
	awstSqDvkibiB4VkiwoH+rothfdpso3zRLR8yfzC+jY+AXAWuqHh4hGHcGaKBF95s8KPbrogFEiGY
	tfvlBXO9iMxGOpZMwnSZc2gotBRnP+jb2tVrrrHezqUX3fl8LVDCdhziXQsfPYOQx/WWdN07bP9Ve
	tMmElJ2YFclax0NjZyAc51m9GIUBkXKvEmPmIhioD3TMDN6IW/Wag9a6AsBTOBuc4Ufl6RvmkL6FB
	ISLDDqsbHJv4QQF8z0sCHxFQrLP+vzu/xwo/GwdCTmt4HibXN7cRZxAJglaGD4bDVPu+4emhazRYN
	czU4Jj1A==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBqO6-00000005Tns-0eWC;
	Thu, 23 Oct 2025 08:09:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] block: blocking mempool_alloc doesn't fail
Date: Thu, 23 Oct 2025 10:08:55 +0200
Message-ID: <20251023080919.9209-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023080919.9209-1-hch@lst.de>
References: <20251023080919.9209-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

So remove the error check for it in bio_integrity_prep.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-auto.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 687952f63bbb..2f4a244749ac 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -158,8 +158,6 @@ bool bio_integrity_prep(struct bio *bio)
 	if (!buf)
 		goto err_end_io;
 	bid = mempool_alloc(&bid_pool, GFP_NOIO);
-	if (!bid)
-		goto err_free_buf;
 	bio_integrity_init(bio, &bid->bip, &bid->bvec, 1);
 
 	bid->bio = bio;
@@ -187,8 +185,6 @@ bool bio_integrity_prep(struct bio *bio)
 		bid->saved_bio_iter = bio->bi_iter;
 	return true;
 
-err_free_buf:
-	kfree(buf);
 err_end_io:
 	bio->bi_status = BLK_STS_RESOURCE;
 	bio_endio(bio);
-- 
2.47.3

