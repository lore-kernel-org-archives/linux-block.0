Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5CD34D916;
	Tue,  4 Aug 2026 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847882; cv=none; b=MZfAG/KqUZUgen7vwb4d8Fcm36JuzND9LhrM7LTCNsEeJivbTxnsF4zOi7xJAGeleMQESecGlotGXfOXgiJISKe/HZ3g6U6Zub6HPZQ7oqsIBz5SIa63KBExLecs3cLsR6L0Py5aQZIHsdXEd8hhauANasPj2NK0x8N3tAgTTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847882; c=relaxed/simple;
	bh=StAmeBpL6wrjkCnkrdoHzT1WLyPt/v/rpq1GkMZML90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7uZqFMubUrxIQRZVBPHoW8GDz3I9Z3GfGgcmr4dePkEIFRiVQ/LntD9E3IpoWEWiFw/shNewyn3xIf1kH6zmYzIP9SkLSH4Q+FHTsXm97g4EP2ff0UJ0GuLyPvfSQKnpAbqmom6TkbYOWarg1U0RM3DFcYVH+uQulV6/9GqJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VqMPrkIJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VqMPrkIJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RBwbeeSO26zAb7ys4o8/EKYxrQFS6RG4fwq6KOQiM50=; b=VqMPrkIJGlY5eEtiEzBGpW3GZA
	9fO/UJXvGM1Z74fm1bAdRpF38z8Nbd3KbhSKNvwQ77J3VcgDc4a3rGaZg/qaonRbl/QKGp7eLgeQ9
	8FqWmErbdSQFeTSndWtoZRB3/keB7AIoMDG3fzwuDEPiP3+x3+MhfgMk6KJ5DPUWPcfQC4aOSP8+g
	dIpUFjX5wrDZqoVCBPMavpWewRRSLwihbqcbmyzaDa6kQlJHFLUBG2zMJqqoOqNjqzGiXkzV7r7T1
	Q0iExzqXAEHWAD/pvbNkvFavn2icmjuNshU7IpKBek7OsxrxCf8/oW5S573xuDnQ7xennCAe5oj7T
	X6uvImnA==;
Received: from [93.123.20.94] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrEbl-00000001r4h-3bM8;
	Tue, 04 Aug 2026 12:51:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH 2/6] block: allow REQ_NOWAIT zone management commands
Date: Tue,  4 Aug 2026 05:50:18 -0700
Message-ID: <20260804125038.740388-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804125038.740388-1-hch@lst.de>
References: <20260804125038.740388-1-hch@lst.de>
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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

