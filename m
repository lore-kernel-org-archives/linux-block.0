Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0201ACEAC
	for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738324892; cv=none; b=PUHNLrWW1jkVJEzmg/Q8499HIW4pkjh7BhU41XXAqhGOeRg/DfFQtXafZhANQq8ZpwvqkF2FcsjjDM3/LMOyyfu5ZLBqrt8m/LS06DeT7dYu0DlIdLZhTH1toJiiNhIPNoOzCx2CarPlTsiyRrnmxBpQZnPEDQE2U29GLs2oHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738324892; c=relaxed/simple;
	bh=gV3hvvhRyHVCLJh5raFxyfBNyNILchc6clVggqClIS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6460g17+XwAwwmGh2ni1JhjLScKPDbh7vmiEPM55tlm2E60guoZUBGVwLhGLWyunewqbANCO5dHURzPLnoLfhKhnNtlRceCMqhlHS7vKSJtDA9eDJCh4H8Ci0x+bI9YR4Q2T2QGPiYXd77sGTwo/FstQtnPRBmsKmyk8APPK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qQ78BNtd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qQ78BNtd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Q4ah5uWFy9kdam0/QVIr8O+KheHAShKClNujSCNGJoA=; b=qQ78BNtdArXDEEdkdfFBpBwAGQ
	xQqZ8UErZNOc8nhySIsNFH5DxEX/uJi3omvXx22+5xmN3zni8E2785dFzrVRXjo5rDi4gFVR1ygIk
	kXjvNLEr1fApqz5/DloZp4ihgpUtc/FABOq0UW3rXSo8GalF3a8HCVemIMZcVlh+wZKDwGFQtKxBL
	RrXTYKTO4Rz0c5mFHg0WIpFI3nECbVluMciJVauqSesSf/5JjfN4uBnwuhliZDPQ/KoKxDMMjdGaf
	3ixCPnTk2ShJ4qgzpTc7Ehp7tvB/PFiQpHyGE9M1s2RajGLV5+oNhzCGe3Z4t16WIG82Jl3Uq7uYI
	jPREK8YA==;
Received: from 2a02-8389-2341-5b80-85a0-dd45-e939-a129.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:85a0:dd45:e939:a129] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tdpiD-0000000AZCJ-44qS;
	Fri, 31 Jan 2025 12:01:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/4] loop: set LO_FLAGS_DIRECT_IO in loop_assign_backing_file
Date: Fri, 31 Jan 2025 13:00:39 +0100
Message-ID: <20250131120120.1315125-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250131120120.1315125-1-hch@lst.de>
References: <20250131120120.1315125-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Assigning LO_FLAGS_DIRECT_IO from the O_DIRECT flag is related to
assigning a new backing file.  Move the assignment in preparation
of using the flag more and earlier.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 85a6aa551bb5..11f483d43bf4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -211,8 +211,6 @@ static inline void loop_update_dio(struct loop_device *lo)
 	WARN_ON_ONCE(lo->lo_state == Lo_bound &&
 		     lo->lo_queue->mq_freeze_depth == 0);
 
-	if (lo->lo_backing_file->f_flags & O_DIRECT)
-		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
 	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
 
@@ -579,6 +577,8 @@ static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
 	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
 	mapping_set_gfp_mask(file->f_mapping,
 			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
+	if (lo->lo_backing_file->f_flags & O_DIRECT)
+		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
 }
 
 /*
-- 
2.45.2

