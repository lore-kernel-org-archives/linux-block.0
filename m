Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6A3E1D1A;
	Thu, 16 Jul 2026 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193528; cv=none; b=SsHbYecCX/oqs6AkJlKiaJ/a/jqUkcnxwX6PoFystHyLAHnutkbVQGZo0bNM0/iBML0CWgCoJtyOf81zcT3BJfrgVw1kOnGDL1TdnwACjchg3oifBzECUq2LL/4AYvmVvVR6GeGcASAf2f5i4YXWH12pFduLYRJQxDTUXw++5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193528; c=relaxed/simple;
	bh=CzViMgENoHw07eWjKY3ugN16O/lggIEVGaFrVUgdJIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmnHWZj679LN5fYYxzxRe+OcAG4PJrr7KaISWZsirxR2ms7oeD/gTEXK7kbnJq/kwmjY+msqzbm2gmadGT0TtxCqD5Sy6BLp1J8pM1k1TbckDYYROIZul/ooPkJRYviTpXUQ/HWb4PDX9ZyYPl0mpiqvAyeL+JE53kZZXTxyKmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SZZDg2sG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SZZDg2sG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5VkiJgfBfLVb2s6gxym/rUlhDV32xeZKbOmj/6B4cRc=; b=SZZDg2sG2IxNaLrjfncI//uTqM
	Pmw1LmVuOT9d/12ZUO8ATLHdKyyka5Itn574/94pm5mwK9r4ZEdgvOyLYNn57a6jOtXKcUflDyyXx
	D3HiTGVzhqTt82tk6tHdLLaL9UFaoocE56guBhrHkJ5nu2/PMKPivAekdo3SBkhX+UxfecfEGv8aK
	s7BPl2bP5tAhtc/YVOVL0sDRXU9NmzN//bh9yGc0idKwMt5jeCpAQrJSv1CWO9Cj5GFLf9R9TyrMI
	1ADUGZVjboK/fKMafo9t+5Yi6+veHNGf7bYS8UoerhNjNZSFA+qoyiVKdn4qAv+VBXlom2BpHSN/d
	vqR0p+Vw==;
Received: from 2a02-8389-2301-9f00-b29a-36e9-8c1c-0994.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:b29a:36e9:8c1c:994] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkIEw-0000000GqCU-2oST;
	Thu, 16 Jul 2026 09:18:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH 2/6] block: allow REQ_NOWAIT zone management commands
Date: Thu, 16 Jul 2026 11:17:48 +0200
Message-ID: <20260716091838.318082-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716091838.318082-1-hch@lst.de>
References: <20260716091838.318082-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Commit efae226c2ef1 ("block: handle zone management operations
completions") moved all block layer tracking of zone management
operations to the I/O completion handler.  With that REQ_NOWAIT zone
management operations are just fine, so allow them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 034af9dfb5f9..3b7a5f2bdf98 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1586,15 +1586,6 @@ static bool blk_zone_wplug_handle_zone_mgmt(struct bio *bio)
 		return true;
 	}
 
-	/*
-	 * No-wait zone management BIOs do not make much sense as the callers
-	 * issue these as blocking operations in most cases. To avoid issues
-	 * with the BIO execution potentially failing with BLK_STS_AGAIN, warn
-	 * about REQ_NOWAIT being set and ignore that flag.
-	 */
-	if (WARN_ON_ONCE(bio->bi_opf & REQ_NOWAIT))
-		bio->bi_opf &= ~REQ_NOWAIT;
-
 	return false;
 }
 
-- 
2.53.0

