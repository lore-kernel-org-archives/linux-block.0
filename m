Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AD1434408
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618280; cv=none; b=iLRzNnifByk9eEuLgjA9ZjhuXxeGf9th+NjpYlpsErPZpNkuxRcuILJHXspnmnNkm0DZu4GIuUR/xHrCH27aQq39swGndb2ZjX1RyVvUQMK9V4JcHOJ5BcfKKrTHStSe3Uz0hzFY52TSfPtRHNXMxk/7N5Kv6t3XROnaglxXRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618280; c=relaxed/simple;
	bh=d91T+NDtDb14V+r2YY4jowEgdI1nR9br/+EuhPy6hJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEa3iGwQ4Umwu7fGHWlRsbjhjMMt0+YfibHjp1aO8Df7bQsudLLCkQakO1QuWLs4a5g4HkYbRgjpWwVTrpOlaeaWQEdIayWpguHzlLfIOA0Bn/bfFpwqCE8jIQVgH/tvTFd2jFujd0QtRt2CbKBDhvwpqqmBzOg8cjn4fUlyxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z6gI8YNm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z6gI8YNm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=K19X9JObthT6lCD0T6UWWQ610ZiKntgc8qmddXUZCH0=; b=Z6gI8YNmzTHSusfATyeHOJQlrg
	+dJ2irsLb+6sFLW9CjFWwxBVPfzJ4jGZiVlpBQ9TtomasWJVhE4JBUX6IzOLIZ1HZ+iDJ+EFlzjl4
	rM83aps96ym7H/CDifRLIVmigw+tdCxIG+gYRl8WRbzr2QvHECGQoz1wQAYy+3Rn8UF4ypfkY1fyV
	Ql9n9sJoULrJ51OXlU09CEPc6zSuTA9H4C6fjIMULSehFGyv/4V4WU8zIAkiYm17+7RBCMfNScr4R
	ityfX5dRJpmIU1ZO+BKisSBsPfh/TMtjYmq60gTXbeJJCu8KAQ/hN+zwt6pj9XX0kFjmEXiEQAFnp
	PaUfvwxA==;
Received: from 2a02-8389-2301-9f00-b29a-36e9-8c1c-0994.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:b29a:36e9:8c1c:994] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm4jk-00000008dOX-3QGo;
	Tue, 21 Jul 2026 07:17:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 4/4] block: remove the fs_bio_integrity_alloc return value
Date: Tue, 21 Jul 2026 09:17:28 +0200
Message-ID: <20260721071739.2514228-5-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721071739.2514228-1-hch@lst.de>
References: <20260721071739.2514228-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Not used anymore.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-fs.c      | 5 ++---
 include/linux/bio-integrity.h | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
index 5ad43476a3c7..1be80fdf1b92 100644
--- a/block/bio-integrity-fs.c
+++ b/block/bio-integrity-fs.c
@@ -14,14 +14,14 @@ struct fs_bio_integrity_buf {
 static struct kmem_cache *fs_bio_integrity_cache;
 static mempool_t fs_bio_integrity_pool;
 
-unsigned int fs_bio_integrity_alloc(struct bio *bio)
+void fs_bio_integrity_alloc(struct bio *bio)
 {
 	struct fs_bio_integrity_buf *iib;
 	unsigned int action;
 
 	action = bio_integrity_action(bio);
 	if (!action)
-		return 0;
+		return;
 
 	iib = mempool_alloc(&fs_bio_integrity_pool, GFP_NOFS);
 	bio_integrity_init(bio, &iib->bip, &iib->bvec, 1);
@@ -29,7 +29,6 @@ unsigned int fs_bio_integrity_alloc(struct bio *bio)
 	bio_integrity_alloc_buf(bio, GFP_NOFS, action & BI_ACT_ZERO);
 	if (action & BI_ACT_CHECK)
 		bio_integrity_setup_default(bio);
-	return action;
 }
 
 void fs_bio_integrity_free(struct bio *bio)
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 0ea2a8bf7efb..f6fc6c66268f 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -148,7 +148,7 @@ void bio_integrity_alloc_buf(struct bio *bio, gfp_t gfp, bool zero_buffer);
 void bio_integrity_free_buf(struct bio_integrity_payload *bip);
 void bio_integrity_setup_default(struct bio *bio);
 
-unsigned int fs_bio_integrity_alloc(struct bio *bio);
+void fs_bio_integrity_alloc(struct bio *bio);
 void fs_bio_integrity_free(struct bio *bio);
 void fs_bio_integrity_generate(struct bio *bio);
 int fs_bio_integrity_verify(struct bio *bio, sector_t sector,
-- 
2.53.0

