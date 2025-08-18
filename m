Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDFE267B9B
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755492906; cv=none; b=LRu2OTWdUMVkExKmsujgmVyga17uNueasFQofZDxpIKGEaRA2awK6S8/+LBeFEkAUDUsynclL3/mlLyGrauvY3ze+y52oVc7Of4V4pfFAnh/RhT9pBn1S1T0BwniL00LeM8TO9JFX6WwwhoKfV77eEIEIbcOY4KQCFb2tNRQ6Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755492906; c=relaxed/simple;
	bh=U1eALPoV0+r8TKrpG30crq8409IVZ9F6IFhoAI28EzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEP90R0F+KKvA7YhZWq0ORmKMP9XyB/xbVU4hJ3tWcM5TmoUaZG0R9wTkbg3dOF0RkwQVeucxL5B4e7TKuO1EMVecR9hq2oKZmFIra0ua4kU4/JY9bv/wVAEvAnM5JIJtdKbY2ZB/wjbk5ht8g95qQdW3jN4hDAUB7KnP+zJXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rAdaQFVX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rAdaQFVX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jqgPQ7Ea96cLvskgwbAIyHbJe7tenJ52AoWVFJtkqTc=; b=rAdaQFVX7zRyVqGYx/UaggSHwB
	r3DMlkKs6CaepIZjxXL3snZfAAv0qLPp6+mfa7VIr5cPtBRWKDgzezks+j1XcpwWd9QunjvJrfblu
	kHa84tY3YEonhZd4jxsoaHPuCa37B3ES3+twHnAuYxaB+hafuElq6KI+dq1ImN660SyudSKM7WbJ1
	dPXJhSxebr6E4/VarvpScyyA3DVHYpUZNgqpB3KVus1wI3iaNTDKgwIg+g/PGgpPvo91Uv716kpa4
	t2I8GVcyQxICm/CchHZRxPPrEETDU+VOun0vIsmeqVhwQx53lrkyVjna9Ukv+xrSRaOQ8plXaxWwW
	H/xNFq6Q==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unrtg-00000006VQU-1Ugx;
	Mon, 18 Aug 2025 04:55:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: remove newlines from the warnings in blk_validate_integrity_limits
Date: Mon, 18 Aug 2025 06:54:51 +0200
Message-ID: <20250818045456.1482889-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818045456.1482889-1-hch@lst.de>
References: <20250818045456.1482889-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Otherwise they are very hard to read in the kernel log.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 491c0c48d52b..d6438e6c276d 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -157,16 +157,14 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 	switch (bi->csum_type) {
 	case BLK_INTEGRITY_CSUM_NONE:
 		if (bi->pi_tuple_size) {
-			pr_warn("pi_tuple_size must be 0 when checksum type \
-				 is none\n");
+			pr_warn("pi_tuple_size must be 0 when checksum type is none\n");
 			return -EINVAL;
 		}
 		break;
 	case BLK_INTEGRITY_CSUM_CRC:
 	case BLK_INTEGRITY_CSUM_IP:
 		if (bi->pi_tuple_size != sizeof(struct t10_pi_tuple)) {
-			pr_warn("pi_tuple_size mismatch for T10 PI: expected \
-				 %zu, got %u\n",
+			pr_warn("pi_tuple_size mismatch for T10 PI: expected %zu, got %u\n",
 				 sizeof(struct t10_pi_tuple),
 				 bi->pi_tuple_size);
 			return -EINVAL;
@@ -174,8 +172,7 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 		break;
 	case BLK_INTEGRITY_CSUM_CRC64:
 		if (bi->pi_tuple_size != sizeof(struct crc64_pi_tuple)) {
-			pr_warn("pi_tuple_size mismatch for CRC64 PI: \
-				 expected %zu, got %u\n",
+			pr_warn("pi_tuple_size mismatch for CRC64 PI: expected %zu, got %u\n",
 				 sizeof(struct crc64_pi_tuple),
 				 bi->pi_tuple_size);
 			return -EINVAL;
-- 
2.47.2

