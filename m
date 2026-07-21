Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEFA433BD6
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618275; cv=none; b=unKo4o19hFMDz38/9cJxSkhHLOD5UIAjZSKlBAFuO0mjgPC/R9T7dG/UATpT4kt8rQEz5HNm/g+bnM2Wjw+3m9Rb3jiKKc9XjpyVpTZBA8hOqY6CRJusxA91dH218PTtBJRjJPhM1IWZjhU7JF0U0kgdC+RFKCAJF/mar8aTnWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618275; c=relaxed/simple;
	bh=X/3ubc4XR8djVNgJgQQ1NUTrfmQy6+JXcd+nE8joi1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2IA2yxT5N8VIfvQD8uqBlOROKMY4DmdIVshJEbebsbMNt1FHEAqnWurEiCLwb7MCE9kx29gMLvZSjsUgHMz8MAnoUCdnDqGzNyXWzUmrwdtlmGqhotHYwdKgkHchpKpiaqYNBJzWYPoxSX/KmTWk7d7+y6Yeik6QT42hIlY4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iOFWK+oQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iOFWK+oQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NFlP/0oLahcbJc+N7dPQv1qw3tA/U2yViQUNoCdnfPk=; b=iOFWK+oQhVP9gP4Uyil4BGztfz
	rZ05ui+kOmBz+Gu8XkYtWmpom8uqdaZue1BacQbACw2XRGC9klTvgDmSFErFTTkZnI8EU51K2rFlC
	1TUQDCnW4zkXFJ3zTlrhHzUX22Pf2HQRyP6au7mitAHrhPetuMQ2VYjn6z9OG0Fay9HwpW3vMAxgD
	t+Pr6Eg9zQeEnwCesjYDL3R3g9CuyL1dP1ETn2mtxSmV0NRedp5PDZ6AhXZTDCQXv8VBH5JeOkIXC
	6x+pM9xCZ1Omg+CVq9tpQ8lSnX0zOR0y2in+sa3Tau2sYOvW8yjVtcG64gCtZD4b80uoZa9ofnJxK
	8a+0X/HA==;
Received: from 2a02-8389-2301-9f00-b29a-36e9-8c1c-0994.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:b29a:36e9:8c1c:994] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm4jh-00000008dOE-2Y5b;
	Tue, 21 Jul 2026 07:17:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/4] block: handle nogenerate/noverify properly in fs-integrity
Date: Tue, 21 Jul 2026 09:17:27 +0200
Message-ID: <20260721071739.2514228-4-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721071739.2514228-1-hch@lst.de>
References: <20260721071739.2514228-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Check the BIP_CHECK flags before generating or verifying PI information,
otherwise this can be incorrectly called for non-PI metadata and
cause incorrect metadata and/or verification failures.

The new behavior matches that of the block layer auto-generated
metadata.

Fixes: 0bde8a12b554 ("block: add fs_bio_integrity helpers")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-fs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
index 9c5fe5fa8f0d..5ad43476a3c7 100644
--- a/block/bio-integrity-fs.c
+++ b/block/bio-integrity-fs.c
@@ -46,7 +46,8 @@ void fs_bio_integrity_free(struct bio *bio)
 
 void fs_bio_integrity_generate(struct bio *bio)
 {
-	if (fs_bio_integrity_alloc(bio))
+	fs_bio_integrity_alloc(bio);
+	if (bio_integrity(bio)->bip_flags & BIP_CHECK_FLAGS)
 		bio_integrity_generate(bio);
 }
 EXPORT_SYMBOL_GPL(fs_bio_integrity_generate);
@@ -60,6 +61,9 @@ int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
 		.bi_size	= size,
 	};
 
+	if (!(bip->bip_flags & BIP_CHECK_FLAGS))
+		return 0;
+
 	/*
 	 * Reinitialize bip->bip_iter.
 	 *
-- 
2.53.0

