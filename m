Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F5329E5A;
	Thu, 16 Jul 2026 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193526; cv=none; b=G+6fnHtTCLsjhL+unpAguN6043XGv7c0FPxq2l4Yf/lr5N9LYvfpFzNApupxEvsVyTFa6aRvxaGB5j6gNKIJovP5dFLmLE80Zn1WDcNXinzFO4Hg8C+hbplQxe7ujhJ2qWZTJY2r4QYx6gRDvDH8eGQrfF2Caskv5edg9oBrpso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193526; c=relaxed/simple;
	bh=WWAp7ikJM52w0EvidYXVMQbDd1nHnr6lI5DophAu1EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIVJoiTFMSRXogs8poDV5TRjWPOQIFN704xx0rfTYZiDVFUEH6ZSNHUs5KnxyKSrWAz/drBHxKQDpL0PTkEb2RYdJxrz43XRDBQtGu0SW+jZQ97bVBEfB3siDiyXoILCGwLdABBlsly0d9bCmy+KY6cekcjvFRS8Vb6I/oOTcRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B8jZSsCb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B8jZSsCb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mS9TEwsIYGtIO+KQMOkH85uMaFv14hjzDwNeFYaLixw=; b=B8jZSsCbI2uwf9k3kUWN1bt8m9
	EXkHF66X6qFQoPJ2TTxuarinKdUjISLCRZP3tsWB33dwudpL6a3qH83ZoC3k85OT5QtCyZGjC3aBS
	1MnYHQ+kWzWcobklGW/7dLlBcwPLaA+EmlAGJnUwdqL+U/vSDpt7qm+OAAFYSg+bFAOYXCXf596xj
	c2mQkcOUY+UcyCOyCXY9n6t6wfeTRbGDd6Lwen0l65yB72Lnbi2EsYMSj1XWTXOpUx6T1CM+FmGNu
	DOzE9bosxlYZi7vFIoVeLkmzgykAns+NU+CNTw5qBQNa6o0ED6sfSf8/CJ/PAHCbnsysy1DNDFwhy
	58LeNrLA==;
Received: from 2a02-8389-2301-9f00-b29a-36e9-8c1c-0994.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:b29a:36e9:8c1c:994] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkIEt-0000000GqCJ-36Ox;
	Thu, 16 Jul 2026 09:18:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH 1/6] block: remove a dead return statement in blk_zone_plug_bio
Date: Thu, 16 Jul 2026 11:17:47 +0200
Message-ID: <20260716091838.318082-2-hch@lst.de>
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

The switch at the end of blk_zone_plug_bio always returns, so remove
the dead extra return statement after it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

