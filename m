Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC252F39D0
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165019; cv=none; b=peuZdUsA6ziaDCtFp9fpbiAklGnZp0xxaQfHmYw4N7wzGM1lAvJFNhRQSfCBq4sPfBLpAfFtffrrH3IRq0f9BnpYylj9p7Irfqg4fJIlQleSMTzTNeO0jjSdgrAh/Y1QGDX7wx3TUdgdEjT6BLNEIj7ig5J/dgO69apQ3UhqitA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165019; c=relaxed/simple;
	bh=B7gbaHZiLLNm1LvdL1QrDT1ZKvsBbUMsp6YgX4UMo/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0RsV9UFX97AFWpwVTBTD7xB1VSnhy7/+4UnM96LzpE+TWvhI6PFPdZv2EFuSHQBzWzFoiZf5q8YQry/s9atrL8rFkKV52/tRjmnVXVvVWySCtH/+PBVd7WhqkoFKIpB6r2qcZieCurJFEAlr5858FFtyk2UfvXenduDgAKw9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bDUJPp8e; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bDUJPp8e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HHjmWO90ARBQT1tU6TMRJOcxkdQWg/oY4D7Pd/GfJQU=; b=bDUJPp8ey7voP/CgLmwj+J5DCU
	Fc+QphSKnvmjvsWrLwf0O2KRd39YrgS7PrvWYNxOCY9LeaIZeNTLFnydRjSMeMHEmizQNe3GUIqII
	DhkbvgAId4T2uH6A8XqB1DunBIFZlLZ+NpCx9AO4RY7fFVAOu0OwjeD6Z9Ykn7T7dSl87FltbFlW9
	XLl1BUQnpXo8m/HuAHNSCpCGXsR37hAUhRfxy2QObufyEITjmvdezjuTwvEITB1twPFqPxgU48zDp
	H46cesiUR5ldFKSyJKgb5uf89vCpD5cBkeECrgi1dC1scRqL9YDhItg6xvEKQRXRqOqWACg1wW6m8
	ut5QWZSA==;
Received: from [207.253.13.66] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFrcO-00000009blR-1f29;
	Mon, 03 Nov 2025 10:16:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: blocking mempool_alloc doesn't fail
Date: Mon,  3 Nov 2025 05:16:44 -0500
Message-ID: <20251103101653.2083310-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103101653.2083310-1-hch@lst.de>
References: <20251103101653.2083310-1-hch@lst.de>
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

