Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAFB146D7D
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486864; cv=none; b=MA8JfZ66wSIspGArGljk6vzkQ1c+3JNlL3A++sa2+aNLhJ85eM4ZoIHwNLva/ZygWGWOmRox+xzYTBwBVYA4gafA0VLUom8scXm6B7CSsC5Oao0JENbmEdHwE1zhoY02BQrq+6gjQhJ+4RNi11hx+e+Rb7/h6GieSJT0kC0Ve2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486864; c=relaxed/simple;
	bh=GjAA1/bmgd4sKNxSWb8/cPB9PBF6OUIYGPp3qWIJ760=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTfmhm/6hE9QEhh/Y14KHWBUnBhzbVlTGXgYiyReRAHNZaWyEiEkYSOBu2cFlGlM+Hr53LznHv7Wp6R+E/8zgjXM8Nm6swjUDkhwd6s3UcbJpYzL0+PJj8p2WF8Bg6z9Sq4dsvyCgUeQ1HVsbeiJRsJ9TiAyNp2ZMxl3abSeguY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zqXXHhBc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zqXXHhBc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NgBvIbGr3n69Ad5SYWN0xSdMevmem2BeEOvD6/rUOdA=; b=zqXXHhBcBRN/lJBikcLCzRGPmK
	db4z3FeHKOyoksRnOjHGKsB5i4vWahS5SaSnw5lP57PwCf9+3gkQha2kpG6CtyiW7SolsiD96M70r
	gi1e8p51q/MqdC8QWehJm1uPbDADRiznF9nxdO5PZcpNMM+qv3x7AjY9PDY512VmFn3Z9VVdbfHe2
	I0GG9T3Y3ggnqoZxepp58tkU76l2/At9EJDW7HUcRR3AV8MHZ/0uLvqoEtAvmPe5B+uXCjhfnfejv
	1HIfF7Kt3SlYWHJz5TBWJBGWAW2BKEo/wW6cMwyxtV3KwNkPS+J02/+cluyckoU/IpxkK7eDLi5k4
	WaYHu/xA==;
Received: from [2001:4bb8:2dc:6d4c:6789:3c0c:a17:a2fe] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMn4u-0000000A7HL-432P;
	Thu, 27 Jun 2024 11:14:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/3] block: simplify queue_logical_block_size
Date: Thu, 27 Jun 2024 13:14:01 +0200
Message-ID: <20240627111407.476276-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627111407.476276-1-hch@lst.de>
References: <20240627111407.476276-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

queue_logical_block_size is never called with a 0 queue, and the
logical_block_size field in queue_limits is always initialized for
a live queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a53e3434e1a28c..d38bbe7417586f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1228,12 +1228,7 @@ static inline unsigned int bdev_max_segments(struct block_device *bdev)
 
 static inline unsigned queue_logical_block_size(const struct request_queue *q)
 {
-	int retval = 512;
-
-	if (q && q->limits.logical_block_size)
-		retval = q->limits.logical_block_size;
-
-	return retval;
+	return q->limits.logical_block_size;
 }
 
 static inline unsigned int bdev_logical_block_size(struct block_device *bdev)
-- 
2.43.0

