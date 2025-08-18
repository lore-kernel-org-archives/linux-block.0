Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942C267B9B
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755492904; cv=none; b=mqXNv/1mPvlbWFmh2wNiXpSSKAxemUksOm9vWYA8PF2+3GrJbWWtceYGUdNr0fve9l/ga+ZEeaiX5UFU+orAMeNfrTWPODvNmD31s7/3Wf19/6swcvpQ9SV8hbwPteCW4lizYAbS62Resa2Ypy+vF+9LHxavpwvgaZGkyGKDZ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755492904; c=relaxed/simple;
	bh=B2k33vMtEDqO3r4bLKT/pA9LvsWI++bx7B3ZsYorhfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4NhIlSVlKR+RR/l8vnZS4gzrYBZoVA0UDtjlZdVbzWSfsAGoqWQlv3KGDOwLpwWMXJoSxjzN+y4F/uIilqDccdknQSIfTIBoaf8xiAH5DZIAlPBVr4dVKWrpz4O2cKS0O4G3Tmeoswd2eCIVwXZjQUuNHVwtUnvf3ITnvCz9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WVfxXEKx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WVfxXEKx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8Wss6xA8mKVBJYlZamqcZi4vuaZ0A3n3wZFk2qJCUFs=; b=WVfxXEKx4e38CI37gkwg8fK0ZF
	m+K+xEVDrieePZ0Jw9UuD2dCcVmWuaK3heHTdCWxV3eKPjrqLtoJQAz8scpVMAfFO+lO9F4pW/dM4
	GZ7/y7lKPgfWFUyO0rIhtZssxIAerTYiruZipoHHULZqNuYa9wuYGyozgwaAexKjQI2Jrd5c8iOQ6
	ernrpNfmThd/P4BAJ4ibPvUdeZlvUc/o2IOnlWek6MadWXYX1QLbSFSBZGAiCczE5KdcxNnh3jAAD
	lpURNZhCLSE0EKm2kPNFrYRQSBoosqRNYtqJhcRnxlJL3IVNZsK8PvLyFBtAwUR5PQLf0rc173hZ0
	wQGq6tFg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unrte-00000006VQ5-0RJT;
	Mon, 18 Aug 2025 04:55:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: handle pi_tuple_size in queue_limits_stack_integrity
Date: Mon, 18 Aug 2025 06:54:50 +0200
Message-ID: <20250818045456.1482889-2-hch@lst.de>
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

queue_limits_stack_integrity needs to handle the new pi_tuple_size field,
otherwise stacking PI-capable devices will always fail.

Fixes: 76e45252a4ce ("block: introduce pi_tuple_size field in blk_integrity")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 07874e9b609f..491c0c48d52b 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -972,6 +972,8 @@ bool queue_limits_stack_integrity(struct queue_limits *t,
 			goto incompatible;
 		if (ti->csum_type != bi->csum_type)
 			goto incompatible;
+		if (ti->pi_tuple_size != bi->pi_tuple_size)
+			goto incompatible;
 		if ((ti->flags & BLK_INTEGRITY_REF_TAG) !=
 		    (bi->flags & BLK_INTEGRITY_REF_TAG))
 			goto incompatible;
@@ -980,6 +982,7 @@ bool queue_limits_stack_integrity(struct queue_limits *t,
 		ti->flags |= (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE) |
 			     (bi->flags & BLK_INTEGRITY_REF_TAG);
 		ti->csum_type = bi->csum_type;
+		ti->pi_tuple_size = bi->pi_tuple_size;
 		ti->metadata_size = bi->metadata_size;
 		ti->pi_offset = bi->pi_offset;
 		ti->interval_exp = bi->interval_exp;
-- 
2.47.2

