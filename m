Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEF540BCDA
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618270; cv=none; b=n02OWBxVX6fXErTRdyiB/dvUzTOA8dmtvxM8UJHE9gpaxVQ3bYX2MZrkNcv2jcL3r4HN2kO++DsxmHImsFG+mai5ryeDERdoESbmctHj+Dz908vyxh0WsNVz90amW/Ar4G1YdF5D4a+8yZmKP/4H6JQCkzrmXiSYUT+qtKGMSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618270; c=relaxed/simple;
	bh=DZMKxSJzjMBEuUS6MOY5DQJEuD8ii5Dm2UQzkqI2f2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1bfSogEL++vopTAMi0IT4dQUv1eI67yUwbX+GOwxRRKe+xxTax064voZrD1POoMU0PVU2zLEf0aYwYwKlLR+z9vDA2ABa6/0mIvndP809h4S+ckPPw0h9EJqh8NdbvxsU0iLd3iFsE30gMFBO5GKCWHlHIZmpMigkmApSK5TLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rv9BeQ9J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rv9BeQ9J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Y8AC90H/4qYLT4uQMDpP0smbOZWiazFdPh9iJ7h6qlI=; b=rv9BeQ9Ja1jYBfc/ucA7hhwN4F
	aEkVxrtxegJlBjfOHlJWTRa9zEcIAIhce/MMpF+1mQeMlga6M0FUbCsziDkoDfEHCdSEq/Kkl6t5n
	r/T/BdPr9aDk88vdb9NnoqUyRyKErMs2jLYo8ZLz604x5lfQ5woN3a+ibsdHLtqBrmzW/YAnKo1xx
	i0DuLYWdjPiF/THXz4zp7bP8uYEbOtRyVv033U5fQD9CrPXTrCgfWgfFCgFlmxo77KGgr7dS4v8B2
	1I6nRNzyVdfwppma29EuHRTvTvfW89AIvsURiscx7Exs9Shw4y+A0Vq+OfPY+CVJNJ0X7MvoJ7oeW
	vGojeIVA==;
Received: from 2a02-8389-2301-9f00-b29a-36e9-8c1c-0994.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:b29a:36e9:8c1c:994] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm4jb-00000008dNQ-0NQT;
	Tue, 21 Jul 2026 07:17:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/4] block: remove bip_should_check
Date: Tue, 21 Jul 2026 09:17:25 +0200
Message-ID: <20260721071739.2514228-2-hch@lst.de>
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

Ther is no benefit in using this helper over the simple flags check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-auto.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index b1c733ecfd2e..43ac9f338183 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -45,10 +45,6 @@ static void bio_integrity_verify_fn(struct work_struct *work)
 }
 
 #define BIP_CHECK_FLAGS (BIP_CHECK_GUARD | BIP_CHECK_REFTAG | BIP_CHECK_APPTAG)
-static bool bip_should_check(struct bio_integrity_payload *bip)
-{
-	return bip->bip_flags & BIP_CHECK_FLAGS;
-}
 
 /**
  * __bio_integrity_endio - Integrity I/O completion function
@@ -66,7 +62,7 @@ bool __bio_integrity_endio(struct bio *bio)
 		container_of(bip, struct bio_integrity_data, bip);
 
 	if (bio_op(bio) == REQ_OP_READ && !bio->bi_status &&
-	    bip_should_check(bip)) {
+	    (bip->bip_flags & BIP_CHECK_FLAGS)) {
 		INIT_WORK(&bid->work, bio_integrity_verify_fn);
 		queue_work(kintegrityd_wq, &bid->work);
 		return false;
@@ -99,7 +95,7 @@ void bio_integrity_prep(struct bio *bio, unsigned int action)
 		bio_integrity_setup_default(bio);
 
 	/* Auto-generate integrity metadata if this is a write */
-	if (bio_data_dir(bio) == WRITE && bip_should_check(&bid->bip))
+	if (bio_data_dir(bio) == WRITE && (bid->bip.bip_flags & BIP_CHECK_FLAGS))
 		bio_integrity_generate(bio);
 	else
 		bid->saved_bio_iter = bio->bi_iter;
-- 
2.53.0

