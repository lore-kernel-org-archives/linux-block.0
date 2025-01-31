Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233C914F70
	for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738324895; cv=none; b=b/A6vDL+5+doo3a6PYVKSLbzhTnwpZcw+TRf3r8kkdJJEAqwYpqp2+a27K9RYttCv8B8uCPPR8WFvidxHKEVYxEcEej4BIby3IDnW8I1GVo90Z9kpCLcNrLs9qNxX9ZO6kneEAQcC0ma5iGkjjRp0T8twbICzHrb2uj+3zgRWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738324895; c=relaxed/simple;
	bh=RYYUut+0GgqHKiTDpL7lhZb8oIfQGwwhZG/s7kwoP4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljcVZ03GxoA4w78HJyxC2E3qtYkCzmhoAnJt3xgnrK4OVXqrQLZeQVSsQPRSB3vlvNr+Fv/jt/LvEh9iEsYf4dn0wxJXQxSkyuB+7HUoL2gtgcU1+ABnVMiGhiCKNMkhwyi05wZYe/Qq9n30+YnxAnnMefo8lCNrgsncN9ck7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3UaVTVYJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3UaVTVYJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5RI2bTOpkU7V69JWbVFJx7CTYt5ZBdgUgqPfV9kw+5c=; b=3UaVTVYJu/6c3E70tc3CqbYiZk
	6aKUg9sjZLeybnqoSrDvgfSYxSrnfZADZQ8jqeFqk/zOwWOlJXIR016ssOC/Xdz14fz7TIId1D4Uc
	0BwBNQLKwHkLmtZOzODKIEU1bay1lFH2Tm9g2/FuVjc/Pf7isbrngrrTcQncFVBLnYwftwbHC74h7
	wG+Er329MVfEF9GyoTeYVxH4lWydHss3b2KmSIVU2tPiiYwEX33RE2ATauniAUhAr2PThVuzquaU2
	y8RBF1wL4JDWC58umvmzU5X2f827NR2qyeAuvJzy3bzc26Hxw6dbDlj2S6RCs2Ohppe927fxJxFg1
	us8oB8lA==;
Received: from 2a02-8389-2341-5b80-85a0-dd45-e939-a129.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:85a0:dd45:e939:a129] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tdpiH-0000000AZCp-1vEH;
	Fri, 31 Jan 2025 12:01:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/4] loop: check in LO_FLAGS_DIRECT_IO in loop_default_blocksize
Date: Fri, 31 Jan 2025 13:00:40 +0100
Message-ID: <20250131120120.1315125-4-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250131120120.1315125-1-hch@lst.de>
References: <20250131120120.1315125-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

We can't go below the minimum direct I/O size no matter if direct I/O is
enabled by passing in an O_DIRECT file descriptor or due to the explicit
flag.  Now that LO_FLAGS_DIRECT_IO is set earlier after assigning a
backing file, loop_default_blocksize can check it instead of the
O_DIRECT flag to handle both conditions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 11f483d43bf4..36b01c36e06b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -979,7 +979,7 @@ static unsigned int loop_default_blocksize(struct loop_device *lo,
 		struct block_device *backing_bdev)
 {
 	/* In case of direct I/O, match underlying block size */
-	if ((lo->lo_backing_file->f_flags & O_DIRECT) && backing_bdev)
+	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && backing_bdev)
 		return bdev_logical_block_size(backing_bdev);
 	return SECTOR_SIZE;
 }
-- 
2.45.2

