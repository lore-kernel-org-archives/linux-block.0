Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5914B207A1D
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494684; cv=none; b=lqTs2IqW9vR2Bf/R7L8CAqlLuJPGvdWrombwGS9LhGGEd3/irsAhZ2dnID7HqBMLzQzfK4iECwS+gTjB/NwOh1X6j64+ewH2xAVrUjBBeeTEihTJIJICXrAMQebh7kgZDkZIoQoYRa/+Hul/3ApafQLdnRkPOW8bqQxDhHFCG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494684; c=relaxed/simple;
	bh=7ddtTOLcuxhXKPG8q+8NNYdNCMSZoIs1KP+qDEHYynA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phLa+Sp5sii+kGPpNDUYouOjUHIyH1SpcluOefO4gkauNKkbyzsxPe+o1au7RsJA9vmq09qZWfxRyTShpszgUZjNxTLGS23IW/qq0fUJdtSWEh24yc/bPr4KwNFYnZsGBWkxzenQWL1gGE6ruX9UwgYVN8aA4NHlUG3DYF3I45s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E6RDTSv+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E6RDTSv+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HJ48E+HRyUvOykPui4TJ51s5rpa3tBNMVaIdNRccCps=; b=E6RDTSv+jtMdXrzrJTQDdKhaoa
	MMs1K92lP5ZKeWayEPqKsKjdVrsocs2PxcRXSMye1FwUZAxQh4U2UZUSltvD/+RmKriNgbAYAkiV0
	jTcxuqLqGnG8385x6F+4rNCc2EPDhsrK21pob4g7asOL33NMj0q8HxPvxLB+wJ+PMm4TnRfOcoBU7
	s7/htOV5dP15naKB0DTzcVm6bFoLV6XJ7t2SuGsbjIwNT/LFqGbhI5iLgszzvYq6mX4FFTtu8Unuy
	h0wJ/7t8VW2lDjrvChN6kwHuCDskAdyrK2pSbZOc5rwHfA2D1pbEKXw2sIy63a3JL+ijy1hjWqPcw
	+UbTtB8g==;
Received: from 2a02-8389-2341-5b80-76c3-a3dc-14f6-94e8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:76c3:a3dc:14f6:94e8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9aj-0000000EOQH-2Rzq;
	Fri, 10 Jan 2025 07:38:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/8] loop: update commands in loop_set_status still referring to transfers
Date: Fri, 10 Jan 2025 08:37:32 +0100
Message-ID: <20250110073750.1582447-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110073750.1582447-1-hch@lst.de>
References: <20250110073750.1582447-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The concept of transfers is gone since commit 47e9624616c8 ("block:
remove support for cryptoloop and the xor transfer").

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6ea729cdce71..0c7dfc6eee12 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1276,7 +1276,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		invalidate_bdev(lo->lo_device);
 	}
 
-	/* I/O need to be drained during transfer transition */
+	/* I/O needs to be drained before changing lo_offset or lo_sizelimit */
 	blk_mq_freeze_queue(lo->lo_queue);
 
 	err = loop_set_status_from_info(lo, info);
@@ -1296,7 +1296,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		loop_set_size(lo, new_size);
 	}
 
-	/* update dio if lo_offset or transfer is changed */
+	/* update the direct I/O flag if lo_offset changed */
 	__loop_update_dio(lo, lo->use_dio);
 
 out_unfreeze:
-- 
2.45.2

