Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94D1865A
	for <linux-block@vger.kernel.org>; Tue, 21 May 2024 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716329771; cv=none; b=cl/mOe3qW7YtfDadFUVD5sVg7SBeQ0ehdrRwPUPcbPr2mFNSTTxSs90kCtai/fcpgqcLYGaf72AXEU8fUQp0UI1woKc6Svistcwo+K0TgwwrddBNEicX5yTn0ocRT1L10Co/8x7Z7TnoTTNPnYBgWtV1YmdkXARxPO3DGYh2dTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716329771; c=relaxed/simple;
	bh=8XgZla35QVh/SpUJYcxsbTKBWF3WAVEQW7+5yQ6v3u4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r70+Q1Kbpw1G+kdayNKKFBoh9GHm+t/o3r/IyJ7fI3cjTtaCounZ5R7lfotU9bWr1V/3DEoDlZUTI6Zp8Y2n7Trn8g1O3GuQaf/xaCD/Bh1eYMB8wRT2/60AfrtPxruvQhycG49BntSbWzEQy1xZgct+tJ+aftMnMkOZAh3thbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GhTlZIsz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GhTlZIsz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=IQkqazie/83sGd/fqGP0kLq8HBmjBJlij2MG6QW8+ro=; b=GhTlZIszr//6/WhY3mho1u24iR
	rFrRir0HqQkndOMt3Rr9HMORYZi/FSdJ+f6/+VWXrjGRxPKYXcHM9X71LsTRCbnoxud9vKHY9QviI
	d3JPddm4XNjFDN1wqNK9Kut1LlSysEHTa7/I2y9u6KxfWrnCL1mEKdr7kJzKJc4XHwHlR8vVLnjXz
	Mz9KkBII1X8W4k3z7aEb44CGf/VJI1Ly3hLMYfKQ7GNdKDJZKZ/L+WrWFRRILxSH5Ue6s3VtHerAH
	+COIwLiJAvnEs+SA64yRR1rGdoDzkHy4dNktOikKNvx/Gj9MchbaBGpYJg12LAEC7NqzY9ve6SK5p
	9IX/SyvQ==;
Received: from [165.225.242.189] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9XmA-00000001Dvt-2fSi;
	Tue, 21 May 2024 22:16:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: remove blk_queue_max_integrity_segments
Date: Tue, 21 May 2024 15:16:06 -0700
Message-ID: <20240521221606.393040-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This is unused now that all the atomic queue limit conversions are
merged.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk-integrity.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index e253e7bd0d1793..7428cb43952da0 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -66,12 +66,6 @@ blk_integrity_queue_supports_integrity(struct request_queue *q)
 	return q->integrity.profile;
 }
 
-static inline void blk_queue_max_integrity_segments(struct request_queue *q,
-						    unsigned int segs)
-{
-	q->limits.max_integrity_segments = segs;
-}
-
 static inline unsigned short
 queue_max_integrity_segments(const struct request_queue *q)
 {
@@ -151,10 +145,6 @@ static inline void blk_integrity_register(struct gendisk *d,
 static inline void blk_integrity_unregister(struct gendisk *d)
 {
 }
-static inline void blk_queue_max_integrity_segments(struct request_queue *q,
-						    unsigned int segs)
-{
-}
 static inline unsigned short
 queue_max_integrity_segments(const struct request_queue *q)
 {
-- 
2.43.0

