Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A4258CF9
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739380; cv=none; b=Cq+hdog775X6kyyTFglxZqgxZI4f/BexqHbEDqBtRAa9huSEt+Q7bVlwvN5Jj8cuqI6A8QQ+sJtDDruDT+xnfUSMy2727MH2jJEtRhcl7NUDOROBAeV6wyYn4ARblpRuZX3pOgPkIU5rOXDGyxEfJi434t/EN7uC2uMKiRzLZms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739380; c=relaxed/simple;
	bh=OtKcJCMIlm0cfrus8AJhVUNnKToTjFAPxcTkRr8MIUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTIfDim5N8OA+KyD9s2NXqpqC6VfVgDMY7OXcSK/roOUpdMHBktzfljpXOrVN2+WRyEMZ0w5UaO5Zua9u330j/xqWv/sqkbVGfWuFKTlhD7OQzNtsDkJKyTQXARLR3eNqJfE8IsSn7DDrvjQSN/lyOACLTpBGebJrcc7haa+2VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QK9sd3BI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QK9sd3BI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=4weoIdCA4ir4aLw1LaB2Ju10UufAmBSl+2YlXa6wuco=; b=QK9sd3BIAIi0CWECOZoxbhPU0u
	DGFg8VJ4V/Ndm0I+0jfwFK5trZbnkye/RP8c/kjYNJXfdJWAQRtHFvOxCk22i96P7khl1IaZGOGCH
	mgV4fhhLY7HKPokBLBz0UsFNZtgobEXbXqGrWtjvynC4Y6itzq92tosRqgzVeg4me3/ITRqMD3KHm
	QQZM3qvPpajLRlLYPQQibjhO9mjhUY2jOJEPrTuvMEG4070sArZJurMNQLF3bOVIvVb5FYqtJ79co
	NQWKx9eUiwE0kS5u9X+kdwOuV3DahPyQfyDOb76i3m8T8sNTxOmh4guENfZiVdahZl09DJX+4WL8R
	u1OP79xQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPj8r-0000000BxUR-3Z1M;
	Thu, 12 Jun 2025 14:42:57 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-block@vger.kernel.org
Subject: [PATCH] block: Fix bvec_set_folio() for very large folios
Date: Thu, 12 Jun 2025 15:42:53 +0100
Message-ID: <20250612144255.2850278-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to 26064d3e2b4d ("block: fix adding folio to bio"), if
we attempt to add a folio that is larger than 4GB, we'll silently
truncate the offset and len.  Widen the parameters to size_t, assert
that the length is less than 4GB and set the first page that contains
the interesting data rather than the first page of the folio.

Fixes: 26db5ee15851 (block: add a bvec_set_folio helper)
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/bvec.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 204b22a99c4b..0a80e1f9aa20 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -57,9 +57,12 @@ static inline void bvec_set_page(struct bio_vec *bv, struct page *page,
  * @offset:	offset into the folio
  */
 static inline void bvec_set_folio(struct bio_vec *bv, struct folio *folio,
-		unsigned int len, unsigned int offset)
+		size_t len, size_t offset)
 {
-	bvec_set_page(bv, &folio->page, len, offset);
+	unsigned long nr = offset / PAGE_SIZE;
+
+	WARN_ON_ONCE(len > UINT_MAX);
+	bvec_set_page(bv, folio_page(folio, nr), len, offset % PAGE_SIZE);
 }
 
 /**
-- 
2.47.2

