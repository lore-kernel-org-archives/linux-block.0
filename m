Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2tZygyO/"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF8CD5D
	for <linux-block@vger.kernel.org>; Mon,  4 Dec 2023 09:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/cRF4/q0hP7Ltz2+BmjR5++Q0P2QA5L8ttB95wKhFrE=; b=2tZygyO/lvyaAvAITFulM0uSdZ
	7y9eHg49czZaLxq6RcFGcx6ed3An2iE7E2ThUANXEcpNYPs18fChdZpSROwguRQLhwv1SxkufHBin
	NT+ur4FZt1ajwCrgdu7TfEjKXABZmMlOIkCizftsJrTc4u24V0KWGOWebBa60ZzIN51yzYKU85B71
	0E3Or3Svsfv+I02VFy9pTURYb4uSemRXPeScBZ84eLWZ0Hga3qc6juR4n4uR7JV8pfy1Hx0g/YgTF
	qXFM1KZQWhvz+pdUBedS1x2XpNJViWS1F4wRfHwerUvunajF2cUMgaKGVeEknzh+D/y9+ONjlgs3x
	lZI4TKiQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rACpy-005CuW-2E;
	Mon, 04 Dec 2023 17:34:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: support adding less than len in bio_add_hw_page
Date: Mon,  4 Dec 2023 18:34:19 +0100
Message-Id: <20231204173419.782378-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204173419.782378-1-hch@lst.de>
References: <20231204173419.782378-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

bio_add_hw_page currently always fails or succeeds.  This is fine for
the existing callers that always add PAGE_SIZE worth given that the
max_segment_size and max_sectors must always allow at least a page
worth of data.  But when we want to add it for bigger amounts of data
this means it can also fail when adding the data to a bio, and creating
a fallback for that becomes really annoying in the callers.

Make use of the existing API design that allows to return a smaller
length than the one passed in and add up to max_segment_size worth
of data from a larger input.  All the existing callers are fine with
this - not because they handle this return correctly, but because they
never pass more than a page in.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index cef830adbc06e0..335d81398991b3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -966,10 +966,13 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page)
 {
+	unsigned int max_size = max_sectors << SECTOR_SHIFT;
+
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
 
-	if (((bio->bi_iter.bi_size + len) >> SECTOR_SHIFT) > max_sectors)
+	len = min3(len, max_size, queue_max_segment_size(q));
+	if (len > max_size - bio->bi_iter.bi_size)
 		return 0;
 
 	if (bio->bi_vcnt > 0) {
-- 
2.39.2

