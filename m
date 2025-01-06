Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC501D79B6
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151285; cv=none; b=CfFgVGZCkWn413kBI1t1XCn4fiLhVjAWnjlyudgj/vOpdaak4+rLt9WZ6wgA/xpLWMaKtIvSYTBWEeuPow95sSOOL7EM1GhOilpNe5GCO3GWZwutzubFRCyTCdbCiWnhJilMtE4hU1Qv0msnwlse21MoEFtPHa3luPuadSyAKCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151285; c=relaxed/simple;
	bh=9zkH0y+q8F2TL7K8oiZuQtjYDcKRVcbJ0k8e7mLSxkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RyMmuYCHKteNnoPGwLHht1bVH9AoCnVdJRvRip6KCZeywal9uFqcuvNz4CgAoyIA1NZjBCSOdspUhxo0lrdJC6QUEE25HCF8bk37FFZl/Yz1cq3ZoCfq3nEWSh8pwXYyQ+S5CIHUWttJXuKm/WTphWbWqYYeNRviRGryvPorhro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z2qJev0i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z2qJev0i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DBE78+zECDgRxTo8wLqeiPTYxJZxGyeG2iMyadNwnIg=; b=z2qJev0i6+PQpAdmY8rTASgQDl
	vkdG8xGPr8MngMXxtqjGv9LW9KpehL+lwdbLxfUB8xyL7Awye+TjB/jckQ1dvnza4+lo8XASNsQqn
	jkcoUU3h8EYN2CZpJ4lapEz+ITtYbZWD03Pzx++9wer9+RUB9xnNoANBb/ny2r/L+jdjYGA8je4WO
	W4aDbvdOK2C5e2jtUdso2lHXBqB1elnATWu7w84Vq+fMK4v9J5cnzAo1lLzYhbvwDQKKvRpR938BA
	ManY5FzRDuF3SCcRliX/PxklmeRcDEdOEwjgAgJBLITWFcUjtPLqqrWHUEZY/Yq3by45rM+kzIWTf
	J/cUYe/Q==;
Received: from 2a02-8389-2341-5b80-db6b-99e8-3feb-3b4e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:db6b:99e8:3feb:3b4e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tUiG3-00000000TyY-03ex;
	Mon, 06 Jan 2025 08:14:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: use page_to_phys in bvec_phys
Date: Mon,  6 Jan 2025 09:14:37 +0100
Message-ID: <20250106081437.798213-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use page_to_phys instead of open coding it now that it is available in an
architecture independent way.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bvec.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index f41c7f0ef91e..ba8f52d48b94 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -286,12 +286,7 @@ static inline void *bvec_virt(struct bio_vec *bvec)
  */
 static inline phys_addr_t bvec_phys(const struct bio_vec *bvec)
 {
-	/*
-	 * Note this open codes page_to_phys because page_to_phys is defined in
-	 * <asm/io.h>, which we don't want to pull in here.  If it ever moves to
-	 * a sensible place we should start using it.
-	 */
-	return PFN_PHYS(page_to_pfn(bvec->bv_page)) + bvec->bv_offset;
+	return page_to_phys(bvec->bv_page) + bvec->bv_offset;
 }
 
 #endif /* __LINUX_BVEC_H */
-- 
2.45.2

