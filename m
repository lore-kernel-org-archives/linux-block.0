Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A012E1411EB
	for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 05:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378004; cv=none; b=Nv81644tKllxf1OFcISOQczJwQbPTnB4RO+w5UrDKsSJDpLMNmn3u4m8yPTOOq/qCgCen0SNuZk2DNB2gOcM6skGNXSCL9Ais8Qk4J81gplJHSb2kQ46crn6/6hbZfbYweU8uxjeFkqsONSiMTiArAgYB/dmvOW+0u98HQYbBQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378004; c=relaxed/simple;
	bh=FdBOCXIwcT5j4YtBiY8rkX7d+qIIjkK1n4El5jSYJ6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EP1YXfQPm1zWsZITrr1UGaGxS/KVF/XmWJ6UFNYmfSPgCiNWhVu7a+ly9YzJ+NL+14wRTVoZgsj1dqgBmSVIg/4NEYYBfVoNy6U5pxQgbZ9kvLrlGMa8ReGwvftbjCqckOd9DS8qiBTrf2iXna1okW07+QKVpRqltEt2VhgAg+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B/UW8Byx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B/UW8Byx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XzP272gxGewxI5PdYCImorh/ghJpKV6N9gdcybQzjSM=; b=B/UW8ByxCKO429PN2s+QI+Q6g3
	sknsqSlgBdfMClbhUFyJZ2xmm2k/HVe6+0tJSDzpe1wgLWnzjBb7yV4sxeXgch4+DRq8qH0AL50jg
	LwnNspDzfC+XWJ9+73/PWrgSSJ73jcZLNqCoEWcS/nQLWvbVz9wBAbwx+esI8IjMUhDI6c0+dX3O8
	HsjgKG0SpGaCHLBLuDIPB5xay/mk+GGlagDVSaPG0QE5liJi/BHyuHZAoYbil2k+Hc6jjItts/85K
	/212OAcIp86QAf9MbieXsCKh0xTxfIVqR+FPsGzZ6/EQd2BvxFS8TY4dt+kaog7tu2DrjkPRy/GS2
	Hm/YHdWA==;
Received: from [2001:4bb8:2cd:5bfc:fac4:f2e7:8d6c:958e] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMKlF-00000005Nkv-3DS1;
	Wed, 26 Jun 2024 05:00:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/5] block: remove allocation failure warnings in bio_integrity_prep
Date: Wed, 26 Jun 2024 06:59:36 +0200
Message-ID: <20240626045950.189758-4-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626045950.189758-1-hch@lst.de>
References: <20240626045950.189758-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Allocation failures already leave a stack trace, so don't spew another
warning.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 2efab4b3957978..1017984552baf8 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -465,13 +465,11 @@ bool bio_integrity_prep(struct bio *bio)
 	len = bio_integrity_bytes(bi, bio_sectors(bio));
 	buf = kmalloc(len, gfp);
 	if (unlikely(buf == NULL)) {
-		printk(KERN_ERR "could not allocate integrity buffer\n");
 		goto err_end_io;
 	}
 
 	bip = bio_integrity_alloc(bio, GFP_NOIO, 1);
 	if (IS_ERR(bip)) {
-		printk(KERN_ERR "could not allocate data integrity bioset\n");
 		kfree(buf);
 		goto err_end_io;
 	}
-- 
2.43.0

