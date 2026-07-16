Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EAC357D03;
	Thu, 16 Jul 2026 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193534; cv=none; b=R0uMtluCmc3Nf7u1msLH3uQeS66LLqWUN96/cXSAMLed0g0Ep2YtqvzcBURGc9byeu4sUw93XxCV+7Ik0eHfQJvWrZ8wmaoJ0riYEPlkIDrCtSfsn+KWzrH/aqILmh8nZPMiGZg2vNSZe3rbauFYqCdjIeHX/kyw4fmhP7RGR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193534; c=relaxed/simple;
	bh=d3EGm2DxD7uPMv/kKIvfgiXIFHh33Eb/NJBbYx6kO+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUPHSpemdZLlsikRK2QkM8EGueRU6W4yziunLJWWzHvZJl6UDaK4rIhV5EKx/rOY8Zkbt00pYHOSjHLTsYm3LstWCJHn8ZHy1odkgaaIJhBFtVWflM9aHtYcg5+FWrAuZN6H9wKJI3EXm1vQk1A4zToF/+qe3mp2a5HfFxyGnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jt/rWxsX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jt/rWxsX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eqfUAHtAOp9Ya4erZ6Ut3RfuP/copl20+D0iGVDeUZs=; b=Jt/rWxsXJnRii0PM9FNDHM2OD9
	DouabvbitXq3HT7IZGhB/PzlTOL7YiFwZCMGLvuPu+ArP/6XtbB74IXYPA3Btfa0refr1AViNPDq7
	SmkrPu8e0FvaBDevorz6OUfSwaamK5zz6+Rqqcg1blM2zE1ANiSWWh0cLKmCI5r3YJmSAHmFN2KJR
	kS2tl83pb7MzSOoS2Hv7iepDQicfBBl/D8I29j0yJg+cTYZVm7ppqXqE7xTc7XDACZ7qX8mGp8bWF
	6y3b1/qOgXhokERorixEwll7Wkdh20v08CC2jyXDovApcJVmr4UeFDtX+begiS7SfciJt4jVf5mpQ
	skZ+iLnw==;
Received: from 2a02-8389-2301-9f00-b29a-36e9-8c1c-0994.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:b29a:36e9:8c1c:994] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkIF2-0000000GqEq-2ks1;
	Thu, 16 Jul 2026 09:18:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH 4/6] block: also reject zone open / close on conventional zones
Date: Thu, 16 Jul 2026 11:17:50 +0200
Message-ID: <20260716091838.318082-5-hch@lst.de>
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

Just like zone reset / finish, these only apply to sequential zones.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 67cfd7bd8542..196bccf27f58 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -897,17 +897,14 @@ void submit_bio_noacct(struct bio *bio)
 		if (!q->limits.max_write_zeroes_sectors)
 			goto not_supported;
 		break;
+	case REQ_OP_ZONE_OPEN:
+	case REQ_OP_ZONE_CLOSE:
 	case REQ_OP_ZONE_RESET:
 	case REQ_OP_ZONE_FINISH:
-		/*
-		 * Zone reset and zone finish operations do not apply to
-		 * conventional zones.
-		 */
+		/* Zone management operations require sequential zones. */
 		if (!bdev_zone_is_seq(bio->bi_bdev, bio->bi_iter.bi_sector))
 			goto end_io;
 		break;
-	case REQ_OP_ZONE_OPEN:
-	case REQ_OP_ZONE_CLOSE:
 	case REQ_OP_ZONE_RESET_ALL:
 		if (!bdev_is_zoned(bio->bi_bdev))
 			goto not_supported;
-- 
2.53.0

