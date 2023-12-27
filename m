Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576796FC9
	for <linux-block@vger.kernel.org>; Wed, 27 Dec 2023 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="umxQKy+T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=n+pCM27SIHztKxdG+GEulfyMYLzm9a4HR4uMbYP0EVs=; b=umxQKy+T3wcCsJ2DEuabB4XgNa
	gmWXTCqrXD3//nFP33h7yuXt+8Huj6w1bMG7Z3amub8QUVTNyF3WEMjUI5Q9wmXHM3H8/r3jNKFsN
	1RKXsp+8IaBI7+hPGJ8HnQ7nHVpjg1OPRdBVO1D5aO6FJ5D+mnYviiOUyye2n22J5FXBZxwom62y3
	sWLvRNetXey2gkiUmHFXlmpJcB9sDimh1CqjEBPGaYcbEOKMyi+kJNYgpbnzdz4H5b9qcce7OXaPx
	V/5iX0g+xd19l5JootEEveX245VNbNBgh6GGXOjUVLyXbwrjgcHkc2yOJlNmu1rln5K0aW7Ku93ys
	uUJXmOLw==;
Received: from 213-147-166-244.nat.highway.webapn.at ([213.147.166.244] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIP9Q-00ECrO-2J;
	Wed, 27 Dec 2023 08:20:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH, resend] loop: don't update discard limits from loop_set_status
Date: Wed, 27 Dec 2023 08:20:20 +0000
Message-Id: <20231227082020.249427-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

loop_set_status doesn't change anything relevant to the discard and
write_zeroes setting, so don't bother calling loop_config_discard.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Resend without the other patch from the previous series

 drivers/block/loop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 371a318e691d02..794bc92da165c3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1303,8 +1303,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		loop_set_size(lo, new_size);
 	}
 
-	loop_config_discard(lo);
-
 	/* update dio if lo_offset or transfer is changed */
 	__loop_update_dio(lo, lo->use_dio);
 
-- 
2.39.2

