Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286243;
	b=rK0tj60H1m4cCuKdwobItY9okQYlcpL0Ov3kvu/qQI73tGjT1br/CFB+9Z8EJMw/SJkm
	 R7KrwKkVY2TQ73gmO8tycMnwbFPfdw2DZbcttr0XKfTbXqm7aCzPLkFLKl19qThIQe1ja
	 XhJuIwd9CBG3Q2gVY08CC9FAFZ4npvj4A7tTfqwsVBdZ5FzzxB0qE4Jh16Xs31sePKG/B
	 WiAeVzg/nz3cDZfFzGW6+OgprOti+jh9pxyhPshbJbPulojOc0RD9sp1QnNtEYCaU1gwr
	 /wz3vCv7yRw0rlKHI8t+XB5Q5YtBxgMS8e65Hs/jt6n6W0Le2xuJFXXvLizGqukfpjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286243;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-SRS-Rewrite;
	bh=p1eqHlaFZcGm01gYRyzzQFSITliKxDOWS+koHCqKc5E=;
	b=zFX6PNRLmwapYrgapsl00C/XCH06yPE+cGJ56LHmL6DDveFVdZ/XU3i08lg37WZGB+T6
	 PqkLVdjQc9jmF550zW7CVVIoFeHjkTWsj1YDwZF3CjT3uLKinHhgBhUyH6PLrk7sNaISL
	 Ek62pvcQo1ENdl1tw8MEvMeQYBtp0xvLo3V2gb2YYOQ+DI+i2eGTaWKXoCcbZcuBYOh/j
	 2Ird2d3uJaDW1nksVH95vqrBPEPnSBaUoD9MaYq1WHup7uTbTHW41niAZRe/RNZf3kaxq
	 u7KPLTPoaxsuRCFFUX5HJZqsqJ6cRAPgmzilB3H3+/RDTJdhiH45NPh4wRofn2lV9MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=lst.de;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gUcCuCOg;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B20606A31C
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 15:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7B20606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gUcCuCOg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=p1eqHlaFZcGm01gYRyzzQFSITliKxDOWS+koHCqKc5E=; b=gUcCuCOgpUcEjZhvfihADAIKZe
	o2N/kkGtGaCTTfPCD9NHCl46cOr8j87SPLKD0vZXh5S/rkIndhM6SGcDHjktrMlfAFz61eS1cJKLU
	rPTcssA4Zt5d0mozPWL9OPk5OgrJvJeRxWVEfkl8phm3EA6UYKI9o4X0ZJb/Yrs6lADPJbHdCP5w0
	EkORu+tPIe1QLIezxSxGbITP0pfGOYzSZ6WzyLceDH87hfzO6LRRpXVH8dzZSMOlm7YjabdLEahp2
	DxsfXeZPGmnjSRFIIxMLsrfD5EiJwmPAq5K4cGtpyUOA6RaonAWRkxLCxSg1Y8Vv+UoiPRyqjCI46
	OGEHbcMA==;
Received: from 2a02-8389-2301-9f00-31e8-efb6-e973-61ca.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:31e8:efb6:e973:61ca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMRfd-00000009bt4-02bo;
	Thu, 29 Oct 2026 15:04:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/4] zloop: remove a duplicate call to zloop_get_block_size
Date: Thu, 29 Oct 2026 16:03:32 +0100
Message-ID: <20261029150353.2503201-2-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029150353.2503201-1-hch@lst.de>
References: <20261029150353.2503201-1-hch@lst.de>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The sequential zone path has two calls to zloop_get_block_size, one
conditional on not having a block size, and one unconditionally.

Remove the latter as the block size only needs to be queried once.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zloop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 9145e0f98d56..71f7685efb13 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1183,8 +1183,6 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
 			return ret;
 	}
 
-	zloop_get_block_size(zlo, zone);
-
 	mutex_lock(&zone->lock);
 	ret = zloop_update_seq_zone(zlo, zone_no);
 	mutex_unlock(&zone->lock);
-- 
2.53.0

