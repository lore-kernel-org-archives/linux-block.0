Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011043DDDB1;
	Tue,  4 Aug 2026 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847867; cv=none; b=D5GrZkTV8fqt5ehJXZsyKdJnRViVJUp299zZwGrm4B3/eY+u59NzijnMQO/GSP2L+PImIjGrnDgaELIRnavKIMuH+0WpnvbN9fFjjld3rIjA42Qe5Yl3aqssgphQ5tQyqnDao6zzGX5LwLiY941NBDp3rCNzJsWnIkH2nq/XNxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847867; c=relaxed/simple;
	bh=XL39XMtBlfWraGqJl5lvYNpQ58C5TstfLykeH2CqTig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAbD3CIvC/crAniSXNVpwRoS/fXlGd1ehAVwa7teIoXDrCjqmTHk0QDMi6W8uZLpKNVl+vXbN5FWKiJhDDqFsX7gSkdkOj1TEvWHQZeCBhdGlBJVW5hIGM8yBFMDYv6rS/7drM3mWNTljIZjjDbeUmi0OJqZKIySquibuX6JdNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bxs7kT0Z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bxs7kT0Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ot6fVfACh0lRWvFfBkqtOpJCnvmjYob1vpIWR/jANwk=; b=bxs7kT0Z6gEuIse1LzV41KP0GR
	XctKGKvXSUXff2Okv7okhumXTWlkcefKZeUOVLPWTwYjXOlPBbUY2PWU4EKG5yjOM4vIP1vtsE1QL
	ZFjx682GrpJyh0kh3RHM/C7rBTg/ungogEeKYaCrX9Thcz4NJVjqkV8fLqAByjkErmIc41TDWasCG
	R9ABTbAv9/PBr+3ZgTn94SsEP4yfgSKRMG3/g6562xflbbd3tOx7ZfUIl8DS2GuOaklIH+xX/yPP6
	ZsxsYZehWM+gHoPruC8zQbuVRv/Qpi4Dk4u5TfdOeZjd4MzszfAAmIw67N8NbvDIN9bI1lTgOjbzd
	i4t9Z00g==;
Received: from [93.123.20.94] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrEbf-00000001r1t-2YFg;
	Tue, 04 Aug 2026 12:50:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH 1/6] block: remove a dead return statement in blk_zone_plug_bio
Date: Tue,  4 Aug 2026 05:50:17 -0700
Message-ID: <20260804125038.740388-2-hch@lst.de>
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

The switch at the end of blk_zone_plug_bio always returns, so remove
the dead extra return statement after it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ca30caec838e..034af9dfb5f9 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1651,8 +1651,6 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
 	default:
 		return false;
 	}
-
-	return false;
 }
 EXPORT_SYMBOL_GPL(blk_zone_plug_bio);
 
-- 
2.53.0

