Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E72B9D9
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063088; cv=none; b=ax8W1usmhHl/nwBZJCbT2yje8nAKmFSlKu8ylCs8DXMV5Xg0Z/XjVH1ZDCFuiwMWzVMNjqwTRRuCFjf6PxdsvfWWy8Bge0i2hUGUZ8H6PNGhfM67ofz7v4PblAgRH0rYoNf4RmBxtitaYeqCs3HCC7PZJ/FudHisrG1nxeaZHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063088; c=relaxed/simple;
	bh=GOcXFdIoaieOTPLxWrYGiea+5Ygz/PYkaYEkbRWI71o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+qy/5wg60yMVPW7b7MNMUp+7vJkPgAaAUY+wufQBliUzKCJ+7fnZFmDQuPew377Ik48JSctYt9cY6nZi2zIh6tKevWOuMr+FXsUXUSyT7jN9189oOvQ5bq1Bnc8zyKQKS1oBcuQ3qXhdaKAXphLfA7d85zXdI+zl++xVa3GOQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UWm4WB3i; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UWm4WB3i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=hVVRlT6K6VWZVoPCWPADdIgA2mznpXfvQNyQuUc/qFs=; b=UWm4WB3iDjJxivWVTHrd8uAgAB
	H9f6gQJ9bqq8+CZGrBkTfr/rks84pQxL4VyyrI62UsaTE2QCV1MfEnTGpXydu18yxcnHwSzNjWxbK
	1Qzh9eEiyneQIu/2evpZqNBf5iuQiDu78QS0T2cj001fU72ZwgxRAWJkd5JAVPyHPBa7hFDoRR2ve
	vK+wbkGnwL6Ud46AXUK84U1L5jaRCafOeNklRCtcn1TM1NHrj2gu/FB71pTfU584c4Py0k9bY0dzf
	/rlM9O+A0CNAzarz4ROqe6ylTL0ibRt3338qTszSYUIKXpy+7CRrA0g6yvD5NONugjzaedrLoC702
	LyRfx5CQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s026j-00000003OT4-26ts;
	Thu, 25 Apr 2024 16:38:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Sterba <dsterba@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	linux-block@vger.kernel.org
Subject: [PATCH] bio: Export bio_add_folio_nofail to modules
Date: Thu, 25 Apr 2024 17:37:56 +0100
Message-ID: <20240425163758.809025-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several modules use __bio_add_page() today and may need to be converted
to bio_add_folio_nofail().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 38baedb39c6f..3f3977c69997 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1125,6 +1125,7 @@ void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
 	WARN_ON_ONCE(off > UINT_MAX);
 	__bio_add_page(bio, &folio->page, len, off);
 }
+EXPORT_SYMBOL_GPL(bio_add_folio_nofail);
 
 /**
  * bio_add_folio - Attempt to add part of a folio to a bio.
-- 
2.43.0

