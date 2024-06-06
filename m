Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776DE1754B
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 05:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651682; cv=none; b=Nbocf/IXNjF+9Xkq3Ly8ViRUnBwGDxAlMAjEcJnzOa6PXv5FBT8qEHfTRy/giyw53TopIf3hf1lt/GaUVKso1GjUBCzJQCgKuSUVOLMmhV96vDdE6IWJE8t0zigLRdtqKN3cmxHfUWMVd0ZmBOssbCvggYkt2KRS8V3NpKAiSGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651682; c=relaxed/simple;
	bh=yY0uNbPQOrufhgaQFeATHZ7HMCnS3ncNTc56pLNjK4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fckFwe9r2/lyBYYaStrKibSE8jDwf8MvcGmXBFARZgmvKzFMpeDebcLPhV1vtL3CaaeOmjrV6LHrmaYXI1gFUpwhReSO2nLffmT8x/7+LQYnbPJ0Ccn/dRXfa+mc45KGC+Q/BIXjtq9yitwYVMagEtFHk24xinAT1M6ZCql8Zos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uwxVKed1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uwxVKed1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Ru6e7QlCJJG/gBR+o3ggbDTJvKsMm+SRm2m/B6Mvy6c=; b=uwxVKed1cY3zjEJt78Ymver9+2
	1jvUZ6A3OPW1PJNEPBDyehgfnYT505bd7heXZ+YyaRrDPaSFqIjqOuFBJLb+pkqNCXdRSxTb3w7+t
	Rde5T/SmDB7IpY8gzYiMZ1GpaqEGTAP1G+brjhmEYAoeey9SD4iyPPrauBX/H82BU7zR8vcvWglAl
	SUn/MFgprCBSTxe9mw1renGL7EmDoSs+GNo8t3JBZychlP4/7KOGjLnt73m9S8q/vEzWI0ydO0pkA
	v5zjHQUJ6sB6Sjc/SCFT8VI4v0RuoRnQRHMCB2plIgwgxI49P3A2zpE/YLHDXBZpkV6mnSDc0wQ09
	NK7GEq4w==;
Received: from 2a02-8389-2341-5b80-b586-1966-ebf0-2fd8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b586:1966:ebf0:2fd8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF5fJ-00000008P37-2fbq;
	Thu, 06 Jun 2024 05:27:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: martin.petersen@oracle.com,
	linux-block@vger.kernel.org
Subject: [PATCH] block: initialize integrity buffer to zero before writing it to media
Date: Thu,  6 Jun 2024 07:27:45 +0200
Message-ID: <20240606052754.3462514-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Metadata added by bio_integrity_prep is using plain kmalloc, which leads
to random kernel memory being written media.  For PI metadata this is
limited to the app tag that isn't used by kernel generated metadata,
but for non-PI metadata the entire buffer leaks kernel memory.

Fix this by adding the __GFP_ZERO flag to allocations for writes.

Fixes: 7ba1ba12eeef ("block: Block layer data integrity support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 2e3e8e04961eae..af7f71d16114de 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -432,6 +432,7 @@ bool bio_integrity_prep(struct bio *bio)
 	unsigned long start, end;
 	unsigned int len, nr_pages;
 	unsigned int bytes, offset, i;
+	gfp_t gfp = GFP_NOIO;
 
 	if (!bi)
 		return true;
@@ -454,11 +455,19 @@ bool bio_integrity_prep(struct bio *bio)
 		if (!bi->profile->generate_fn ||
 		    !(bi->flags & BLK_INTEGRITY_GENERATE))
 			return true;
+
+		/*
+		 * Zero the memory allocated to not leak uninitialized kernel
+		 * memory to disk.  For PI this only affects the app tag, but
+		 * for non-integrity metadata it affects the entire metadata
+		 * buffer.
+		 */
+		gfp |= __GFP_ZERO;
 	}
 
 	/* Allocate kernel buffer for protection data */
 	len = bio_integrity_bytes(bi, bio_sectors(bio));
-	buf = kmalloc(len, GFP_NOIO);
+	buf = kmalloc(len, gfp);
 	if (unlikely(buf == NULL)) {
 		printk(KERN_ERR "could not allocate integrity buffer\n");
 		goto err_end_io;
-- 
2.43.0

