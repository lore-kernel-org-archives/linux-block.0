Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92B207A11
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494701; cv=none; b=XT4z8f7icgCZ3MEcAJi8WVnivu1wqIfM64in9ayGvT/NnUppX+DoGqbcZxETUGoGGCvrlYehPxx7/xr0hgLRwBnrRDVruUoPgMFN/aXsSfHgBs+7Si6CBZKdhs53a7nYwGxAufuQcOcksqB0TTxu0W1OaL3PNJXyG4YDo0V4jOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494701; c=relaxed/simple;
	bh=OsbCom6Fg/UasFWKuW0xQQvWLbq4I7yjnmf7yIRjVPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eM5iUYdgQjTYemRH54Av+/VJmtCBPYez5mv1HJ2vyf4l/oDEiIJ/WKuN96X69a2c32BrHv456amd1txnJNFb5+syv6pHv7LcCdK0qcOVpM4Zg/Z+VimojytO0oi6Z2fv6aGjQRrEeJ3ltcVw0ZnVqwLGKV/Zh5PA5ypwHQasQM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X49AdG/2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X49AdG/2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wSEfXYhlhmvAtNThGIhg3iNUE9ObFa3rkgFmAgRQsvU=; b=X49AdG/2e5qpXfsO/nUoizn2sW
	cwUr/mcIRBAEelO5kblBD5A9pWS0Lr+bqbn5VQkdRjAahQYPS0XVohwCIkU49kP6ATxX2SrWyRwM/
	Uv9MbnrqzwCp8sgzFijovaBUNmATrjbjXEQBrsBePqKHQa9CJenrxVi1716XWhLo6R1Vhbl/iPfDN
	4twMJysXS0Q2Pm99FqGjxlmmssAXbnz0so2I9pJdwSZbAgrJxRWmCzUiixXUN9x+XAO3WYeHsuyPz
	eypGx41BEMNF/iyZFOznkmXAwqBjR+oIanWXsnBUnRtfRuURe0emxT1rb+B1pIsdxU4CWhq0Oj+9a
	SKzzhaZA==;
Received: from 2a02-8389-2341-5b80-76c3-a3dc-14f6-94e8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:76c3:a3dc:14f6:94e8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9b1-0000000EOXi-23s1;
	Fri, 10 Jan 2025 07:38:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 7/8] loop: don't freeze the queue in loop_update_dio
Date: Fri, 10 Jan 2025 08:37:37 +0100
Message-ID: <20250110073750.1582447-8-hch@lst.de>
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

All callers of loop_update_dio except for loop_configure already have the
queue frozen, and loop_configure works on an unbound device.  Remove the
superfluous recursive freezing in loop_update_dio and add asserts for the
locking and freezing state instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2e1f8aa045a9..acb1a0cdfb27 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -201,6 +201,10 @@ static inline void loop_update_dio(struct loop_device *lo)
 	bool dio = lo->use_dio || (lo->lo_backing_file->f_flags & O_DIRECT);
 	bool use_dio = dio && lo_can_use_dio(lo);
 
+	lockdep_assert_held(&lo->lo_mutex);
+	WARN_ON_ONCE(lo->lo_state == Lo_bound &&
+		     lo->lo_queue->mq_freeze_depth == 0);
+
 	if (lo->use_dio == use_dio)
 		return;
 
@@ -213,15 +217,11 @@ static inline void loop_update_dio(struct loop_device *lo)
 	 * LO_FLAGS_READ_ONLY, both are set from kernel, and losetup
 	 * will get updated by ioctl(LOOP_GET_STATUS)
 	 */
-	if (lo->lo_state == Lo_bound)
-		blk_mq_freeze_queue(lo->lo_queue);
 	lo->use_dio = use_dio;
 	if (use_dio)
 		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
 	else
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
-	if (lo->lo_state == Lo_bound)
-		blk_mq_unfreeze_queue(lo->lo_queue);
 }
 
 /**
-- 
2.45.2

