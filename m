Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0943D9DB4
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 04:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820967; cv=none; b=JWHco1krLDGTDk4GHZ/FWJdLzfrakbjXnLN/KABumnN02ouhTIeyjSY2NNiC8aBnQFd4XPIw4nE83cKr3kYbtxbz6cAf0Dz/PNpWd3XwQxjtMOjIxvsP9f+p/Sl/tEG0JCG8Tq/l/X5jeOfuxcPwFEpSCNOP16BUbYByRyZv3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820967; c=relaxed/simple;
	bh=7q/62FJ5oFt1SqQsjwgUbQi1jfK5lCAbYFcs5wl9D5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSaF+dVsuhagJSKrNBtkr5pmj7aV+OfQack7FaAtBx7xzyzimlCtm6o6/DqZjYf4PvJnbMLOfr+ZUd2GRT1PvNdnt5UklfmEeh2ICv0tG95miaFOT9BcM57yz8G462PIMUUA2ynUQKRe3UGijyU0IfzEUVgfNljQPuEEHj3eOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=w1eRCzWp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w1eRCzWp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4qnU9Ms874Q6tLOw6V4MEWp8NTXDbMBaJPAqU2S4rXA=; b=w1eRCzWpR3Swdt+5JJMy+S/jXV
	dkPS2tITmg80xTFS2iNRJew+qtu/aXCtTtU1IqsycaKOly179KW8wZgzeJtvtrZjsVT7Vham42/Ls
	HEelFLsRbYpkRZIZ/L1d28WcannCqIj6DvrNaoEoWw6wl4oUdhAcWaaP7qipyVrImFlNgyGLfiK5X
	/afmAcIDLdwYBNB19bqmnL5eCyIbrO1Gv0pLFPoxRjxa8BxVHp14I+T/9GPWvrLH5rEGXLuZ+N3ur
	csgI672CfPlCjEH81vKCGVuZmJQBXPbSSh4oDR8QcaUmLOFdBzaTVUSU4RoGX/iwMy65pmippdoof
	qff3Oqsg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkaj-00000007LxV-18il;
	Fri, 15 May 2026 04:56:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 5/5] block: unexport bio_{set,check}_pages_dirty
Date: Fri, 15 May 2026 06:55:34 +0200
Message-ID: <20260515045547.3790129-6-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515045547.3790129-1-hch@lst.de>
References: <20260515045547.3790129-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Only used in built-in code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 57d5a87b3e2f..2d880d1255fe 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1650,7 +1650,6 @@ void bio_set_pages_dirty(struct bio *bio)
 		folio_unlock(fi.folio);
 	}
 }
-EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
 
 /*
  * bio_check_pages_dirty() will check that all the BIO's pages are still dirty.
@@ -1709,7 +1708,6 @@ void bio_check_pages_dirty(struct bio *bio)
 	spin_unlock_irqrestore(&bio_dirty_lock, flags);
 	schedule_work(&bio_dirty_work);
 }
-EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
 
 static inline bool bio_remaining_done(struct bio *bio)
 {
-- 
2.53.0

