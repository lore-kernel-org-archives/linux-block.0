Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6860C36126
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 05:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719810569; cv=none; b=tpCtS9deIYdKRylKI9pyxRifcrurf4TCZx0v2aFQohR7Jm7STJ0BqVPrk9GVlpOZp90IGP3XKr7lIxQfFCRy8dIrkcj6mgPNkOSsfhdkcB8YknnhzkVNWeRE29MVT2unglrGmRbNgyaQdr1KtMrEzmMVA1m9pA3sPoJHMmLjiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719810569; c=relaxed/simple;
	bh=3lcwhe5LcChmpPuPOhMvTLKoq9Cjc/ndmXtsAo5nrWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cz9afHYZF9BXj+5tXQzSvB5DaThq993IkK3w2j6aEukmGc6kRT8zdN3rMwJ4H7MVrcsrBFfV0y+GnFA3/CJoZ2FDD8teBhvR4KwJYrUAtzkYDK/kxoelB7Mm4dphLBT9/JXkdZfxi/3a+nc0rnJrbY+hgFvGOZSUyqo6faoSkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sL4vIMjC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sL4vIMjC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PWsNLFWQCV+ZSYJwxuSOGaEnUvrONMa2+qXxytoLeGY=; b=sL4vIMjCShxRBEOvFfTD1zMA6C
	ilB2fQbMskKg2/HrXZZMFyaG06ORky/XmY1hXjBmxVWqMW8NhnD9Js2LgSLhWAVQpj8vySzGV7GeZ
	rBgGVcaC3HCB0I4oryVJHad6jCSFxGjIMQWBxHyeJyf4so/iH1+IUzzdn6KrGDwfsNVFJEORo5ScG
	UzYeJQagaeSREeiJNz0/ngbpm0KsOD4jAV01SpeV27zQo4+00NQs7idaK1cPeLsx1Kzq8lAuUOVe4
	O4F9yE/vcWeM8Ju3iEWDwuPsGNIJL7bgI6Dvvro6A3wIXJ/U1EPFkXF3WgOyBqXLsC4qE1cgLb46D
	lrOgWhjQ==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9I6-00000001iCz-1PjA;
	Mon, 01 Jul 2024 05:09:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/5] block: also return bio_integrity_payload * from stubs
Date: Mon,  1 Jul 2024 07:08:58 +0200
Message-ID: <20240701050918.1244264-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701050918.1244264-1-hch@lst.de>
References: <20240701050918.1244264-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

struct bio_integrity_payload is defined unconditionally. No need to
return void * from bio_integrity() and bio_integrity_alloc().

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio-integrity.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 70ef19a0dc7e8b..cac24dac06fff0 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -85,7 +85,7 @@ void bio_integrity_init(void);
 
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 
-static inline void *bio_integrity(struct bio *bio)
+static inline struct bio_integrity_payload *bio_integrity(struct bio *bio)
 {
 	return NULL;
 }
@@ -138,8 +138,8 @@ static inline bool bio_integrity_flagged(struct bio *bio, enum bip_flags flag)
 	return false;
 }
 
-static inline void *bio_integrity_alloc(struct bio *bio, gfp_t gfp,
-		unsigned int nr)
+static inline struct bio_integrity_payload *
+bio_integrity_alloc(struct bio *bio, gfp_t gfp, unsigned int nr)
 {
 	return ERR_PTR(-EINVAL);
 }
-- 
2.43.0

