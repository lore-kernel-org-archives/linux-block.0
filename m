Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC90581E
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184233; cv=none; b=r0q+chBnm836/wfHQmQ/iFxrSWyWhrmdj94NOuLDXFzZGxfWZomdbFQjFwKbBCG9JAVaAITh00cGLx1x9oHS+mSJygiT9A6ndIbVamkSe5InchnNRNXuEH3SeSWydJN4yNxzRD8suDwHzbae4DeQuaHldSdFCc9UnEY9GtxG6ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184233; c=relaxed/simple;
	bh=Oc63CIWc2BD0IPwLC5glX6C+82UclApN4REy29JWhTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afBy18yXbyZVLQ/U0U3OZBn/BgcSEgndjUP6n2wCLQK+GW0J/qZTJM1W+upppLzxGqaANCkj3IrJ7Xe2IrfwrTZUEeIqzeE5inTiVbbBzV4RVGaSJAu5Pu8Y/IwkpL6OgvSt0A+Y+S/izCkCZ9iPKpn3uCt6t5hyaXwct9nGSn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3cDzSsJ5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3cDzSsJ5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nbxcwmP7c5XQb1JlQ9KDPdCjNlEGItoBUTyWzTVXhds=; b=3cDzSsJ5kYIjSCG73eAkjeq9Q1
	YkLz05hdMDyzItO+OG+qlyU6QsCwoPA7HSmg8IgNvjMVpbHdY1iTHbaxD0lh5cTrHIHz6Z43TbZfH
	pVYq1xaTXECzQX514BXynSC93gogMBvPZjzbRwBgVisrMc0Tf8UFpcHiSXm3V/GPWAFRVx8AhBN9j
	ASIKz0rwVdYHkhBbOdGv/8PtI3JIvRc1W7CkRVHA+hrg7gI8FdoSS3jOEZQofiYIBmLadrgE1pPHc
	Jz1fYkxaHL4NugTceLFrKGaEUCDwx0lPrgKXVuqcd4fl53egEDXYJroZny1fej+knjoVLYTF2MLao
	lkLbtjEA==;
Received: from 2a02-8389-2341-5b80-e919-81a4-5d6c-0d5c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e919:81a4:5d6c:d5c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPiUw-0000000FyZK-49PJ;
	Fri, 05 Jul 2024 12:57:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] brd: remove sector alignment checks
Date: Fri,  5 Jul 2024 14:56:51 +0200
Message-ID: <20240705125700.2174367-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705125700.2174367-1-hch@lst.de>
References: <20240705125700.2174367-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The block layer now takes care of these.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/brd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 2fd1ed1017481b..42545e4ddfac4b 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -256,10 +256,6 @@ static void brd_submit_bio(struct bio *bio)
 		unsigned int len = bvec.bv_len;
 		int err;
 
-		/* Don't support un-aligned buffer */
-		WARN_ON_ONCE((bvec.bv_offset & (SECTOR_SIZE - 1)) ||
-				(len & (SECTOR_SIZE - 1)));
-
 		err = brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
 				  bio->bi_opf, sector);
 		if (err) {
-- 
2.43.0

