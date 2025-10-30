Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB6526529B
	for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835542; cv=none; b=YzUmVzMLhtNOqNw3FZQW2iXzuFRT80qKiNOdq/iZt6wvmAY0VxxCx9xZ7MBdUQW4601GZlIxcWb3KldTvetpy0auEjErmPi64zg13rD33b0rmz2Uz4hBmj7fqdL3+QGQx230vO0qsPJB3uX1kQMeMHG5vgDkWfiM0J+P0GE3RIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835542; c=relaxed/simple;
	bh=B7gbaHZiLLNm1LvdL1QrDT1ZKvsBbUMsp6YgX4UMo/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCQP/ndAj0ecIs/8mirUk0KPam93a9AMq6Cpf4GJdYUSLxMCD6vAW+suirLCZWvfOEiz6M5UKS9qEIKmyoIbpNEdwZAjrJd0roHVRnfTLPU9/b8aDwcNHExLLRQ+dJb/7SGaRcxhWbBAduwRxI6I4kdFFp50z+qVKEMH6DvjA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HxQKySNB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HxQKySNB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HHjmWO90ARBQT1tU6TMRJOcxkdQWg/oY4D7Pd/GfJQU=; b=HxQKySNBJN+h38OaIDXe8ZAl1d
	JWC+anOLtY+bLiJ4YCK/Z6OiiEyTLKMN63ZkqZXCxbamUOCjT4yQwIya6ObbgonQL2uJ+3kUKgas3
	6z2WJYCOOKyGQClUG2TjpwJQ4BQjPEAokYZEGUQNat/NIRuOl+GsoLU5jvfZ5QJ1/hKjFQbXfE9Dg
	3/Zw11aKg52NSRna4580y0G2D2QOpHBXqCaBcRxZKWqxjukVDLdEP+uk/7zJACmqk4/vpbyw6nZL0
	NOHotJeszUovboLu0qqhFRJwuhqPrn9xw9uQbp4AuPLGD5fypU0grAU9sFpr5mYjjp86//Gu+mZkz
	pybQIdpw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vETuF-00000004K0o-2d1q;
	Thu, 30 Oct 2025 14:45:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: blocking mempool_alloc doesn't fail
Date: Thu, 30 Oct 2025 15:44:53 +0100
Message-ID: <20251030144530.1372226-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251030144530.1372226-1-hch@lst.de>
References: <20251030144530.1372226-1-hch@lst.de>
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
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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

