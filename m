Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113E71FC101
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288026; cv=none; b=L8Mw8em4kUJTlyTBnYjUGDpG6bVlmQYRWLy4j+jPVF7eVBAW8ruvHKvN/XQ325KD2y6d6UAtrSwwqcR8vSwQTyIMDADgi9sMM0YdVPiPOIfkDd5TqkKAGeUX38ULgiFu2khpmZfyOj3QZQzznJRb/23HkGtCRkuEHSP3S3UDeAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288026; c=relaxed/simple;
	bh=KSjhFLzZnzzpxxk3FW3Gb7uRU82iwMzQ3WdxSaQrE0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ER3Bwn55qlL1WOzqbZlwawTOYRGBgNoUx5NrXKYmXsTLZ/MjzoQIbI5bsLhznhQCxVpaHUjow4zfFZx722Jx81miJKEKrzbMPl/0FZia5kxGRWw+VIQCjp7acUKrz0qPa7okl3fFX5q8O7++INbjtDbH9u2feendx1CGcqAklnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CZSAdRNF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CZSAdRNF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XOi9wEbrlKQArVFLSTakrmyjhtQge5IlRsJZ0Q+DPu0=; b=CZSAdRNFbzrb2Nnsnrj0T2sJMO
	8KxSI49yTFZd1IEblYT02EbxJMZqi73dVTwTKfud24/4dUvxdzAYiH+TpC8U4auE+FHWXQFdXwj5t
	9y2fV4esKN6EF3pm11I/l8cEI2dOfeav/AzxTdyBnD6lR3QEUaJca/SwZX36/5RvlQO6bxKmhNTYm
	UxhfoaV59ZMcLF69RkGEmrXfWUM9Gu+q+OhNaSx7g0/8TBsc3tmeO9D44s5n4td6QiUFK1CmxMK5P
	bN2bnvHNeqw4OZy93dkrHlNTpR15FVSwpMRosDgB6myUIFBr3LV2RDcXZrz+vRL0L1wb6gJFYdxb1
	X8fS6WEA==;
Received: from 2a02-8389-2301-9f00-3397-c9eb-6d8a-9179.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:3397:c9eb:6d8a:9179] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcIX2-00000007MeS-1Qhp;
	Wed, 24 Jun 2026 08:00:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: handle REQ_OP_ZONE_APPEND in __bio_integrity_action
Date: Wed, 24 Jun 2026 10:00:03 +0200
Message-ID: <20260624080014.1998650-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624080014.1998650-1-hch@lst.de>
References: <20260624080014.1998650-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Otherwise zone append commands will miss their integrity data.  While
this works "fine" for auto-PI, it break file system PI and non-PI
metadata.

With this XFS on ZNS namespace with non-PI metadata and 512 byte sectors
with PI work, while PI 4k sector formats with PI work only when Caleb's
"block: fix integrity offset/length conversions" is applied as well.

Note that unlike regular writes, zone append does need remapping as
partitions are not supported on zoned block devices.

Fixes: df3c485e0e60 ("block: switch on bio operation in bio_integrity_prep")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index a53b38cf8a1a..b23e2434d80c 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -38,6 +38,7 @@ unsigned int __bio_integrity_action(struct bio *bio)
 		}
 		return BI_ACT_BUFFER | BI_ACT_CHECK;
 	case REQ_OP_WRITE:
+	case REQ_OP_ZONE_APPEND:
 		/*
 		 * Flush masquerading as write?
 		 */
-- 
2.53.0

