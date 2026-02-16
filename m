Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398AC275AE8
	for <linux-block@vger.kernel.org>; Mon, 16 Feb 2026 05:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771219785; cv=none; b=XnakRWRI7j5Rvb/wqnAGhtt1Re0JcxTR0rOH76YoZVL3QoH1wd5yqqJl4rvTmogl6nG+QPxUY7WgTzUbcOloi1g/6FaLcHg2e+bw6jL1GL6MMj79/AqUvVw31dNa+bCJ5jf4is8j8yDbvZHs3auBvnWqMcqJTfYsdCTKcI5XsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771219785; c=relaxed/simple;
	bh=W5wagGPAXJloy7RQqapubvfI4cJmxS5nuJH0nR3/WNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I5VxJUeQQtSP3ZsP4ELzu33+JuwT55jFrrFtOSVECGzU4V8l42Ov2/ZieF9sSMRngK5UkyscYo9gjSryzUuRkvijkNcep9gE5y+s49uhd/VDhw7H6c5lXsvFl41beQwHklh1I2qSZOCkxg80jvgQJgo7nR7y0czKU1bPpnWiuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OmSTSqRk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OmSTSqRk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=988VS4cRI/xn1E8bzDrfvLH1eAAYDsnVQsEMw39Hum4=; b=OmSTSqRkL41gN/QaXoyYzOt6Wo
	rYwz+XkHTVd1C3kbIo9gHAmvMf8aRZw2+LoHd51/g8VG5DNnnlWnsznr270mVgMPjUdfD6OQaYheQ
	s9UORZtORGP5g/0RthamsLRHdQRNaOfIvy46+f8YxDQHICxeE4ClNxQcaWUPK8sYIEhHJAHrJVrLJ
	BWDKhRNg0QKVeayY3Rz7HF3mYgtW1iG5+3nnIepMEEE2NWiQNaGTk2tTOmhukOWFjZKsENvAdXpiG
	PDjOwRxsf5aGR65+1RCjHgtOE4aqtTlbO8uSs4B1ljishsrc1yoXCAjQVOIz8in8dFXoGGPPTs2y+
	YuBWHytw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrrAz-00000005z6o-3lnE;
	Mon, 16 Feb 2026 05:29:41 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-block@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: fix enum descriptions kernel-doc
Date: Sun, 15 Feb 2026 21:29:41 -0800
Message-ID: <20260216052941.2744390-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix all kernel-doc warnings in blk_types.h:

Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_READ' not described in enum 'req_op'
Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_WRITE' not described in enum 'req_op'
Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_FLUSH' not described in enum 'req_op'
Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_DISCARD' not described in enum 'req_op'
Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_SECURE_ERASE' not described in enum 'req_op'
Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_ZONE_APPEND' not described in enum 'req_op'
Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_WRITE_ZEROES' not described in enum 'req_op'
Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_ZONE_OPEN' not described in enum 'req_op'
Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_ZONE_CLOSE' not described in enum 'req_op'
Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_ZONE_FINISH' not described in enum 'req_op'
Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_ZONE_RESET' not described in enum 'req_op'
Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_ZONE_RESET_ALL' not described in enum 'req_op'
Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_DRV_IN' not described in enum 'req_op'
Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_DRV_OUT' not described in enum 'req_op'
Warning: include/linux/blk_types.h:371 Enum value 'REQ_OP_LAST' not described in enum 'req_op'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jens Axboe <axboe@kernel.dk>

 include/linux/blk_types.h |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- linext-2026-0209.orig/include/linux/blk_types.h
+++ linext-2026-0209/include/linux/blk_types.h
@@ -339,32 +339,33 @@ typedef __u32 __bitwise blk_mq_req_flags
  * meaning.
  */
 enum req_op {
-	/* read sectors from the device */
+	/** @REQ_OP_READ: read sectors from the device */
 	REQ_OP_READ		= (__force blk_opf_t)0,
-	/* write sectors to the device */
+	/** @REQ_OP_WRITE: write sectors to the device */
 	REQ_OP_WRITE		= (__force blk_opf_t)1,
-	/* flush the volatile write cache */
+	/** @REQ_OP_FLUSH: flush the volatile write cache */
 	REQ_OP_FLUSH		= (__force blk_opf_t)2,
-	/* discard sectors */
+	/** @REQ_OP_DISCARD: discard sectors */
 	REQ_OP_DISCARD		= (__force blk_opf_t)3,
-	/* securely erase sectors */
+	/** @REQ_OP_SECURE_ERASE: securely erase sectors */
 	REQ_OP_SECURE_ERASE	= (__force blk_opf_t)5,
-	/* write data at the current zone write pointer */
+	/** @REQ_OP_ZONE_APPEND: write data at the current zone write pointer */
 	REQ_OP_ZONE_APPEND	= (__force blk_opf_t)7,
-	/* write the zero filled sector many times */
+	/** @REQ_OP_WRITE_ZEROES: write the zero filled sector many times */
 	REQ_OP_WRITE_ZEROES	= (__force blk_opf_t)9,
-	/* Open a zone */
+	/** @REQ_OP_ZONE_OPEN: Open a zone */
 	REQ_OP_ZONE_OPEN	= (__force blk_opf_t)11,
-	/* Close a zone */
+	/** @REQ_OP_ZONE_CLOSE: Close a zone */
 	REQ_OP_ZONE_CLOSE	= (__force blk_opf_t)13,
-	/* Transition a zone to full */
+	/** @REQ_OP_ZONE_FINISH: Transition a zone to full */
 	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)15,
-	/* reset a zone write pointer */
+	/** @REQ_OP_ZONE_RESET: reset a zone write pointer */
 	REQ_OP_ZONE_RESET	= (__force blk_opf_t)17,
-	/* reset all the zone present on the device */
+	/** @REQ_OP_ZONE_RESET_ALL: reset all the zone present on the device */
 	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)19,
 
 	/* Driver private requests */
+	/* private: */
 	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
 	REQ_OP_DRV_OUT		= (__force blk_opf_t)35,
 
