Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9619620896A
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494697; cv=none; b=AcopwYnFAK1qp1Qi09iwkO0BcTR+pdHXRmeYHdwXBSkDTLTnjkbiXEgIMIz10zUVIyg25864KcXPPZhS7/l+3ISlnXCxhmjzWIvwKwOak9tsCPuG+WwwFicdqLIPOFeVOh6929+fq1Tma/u+Dl+DBZjNSH9l5iGDkcXrE2nM5sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494697; c=relaxed/simple;
	bh=CIp4/pGngL2eeI7L7SlkTIp1aEoV4GKhiRytdBbJ0L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8wNfxbCdSnYlihjL5CGdb4tuSnvnTqtGDQV9jncp9OCrkeMh6enTxdD1uPwICaOUZiezOJT+brUhOAjR9x9JgMSTrKE2RIqSm3A1umCJYfKzAdx9atjtFCMO+1IJHWguKlR/ttaHmy7BJi3tNPwfldk2yYU64+MHrU6Y+8j8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rKb741zp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rKb741zp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GleDJqF1Ska9OhiZxaP8JYwFeW87TAxXN7QGenaOOGA=; b=rKb741zp975Dd9Z6WztLVDd/Ao
	R6ZPHnitXdcgFgrHNvJMDjXjhgXXn8UACqMrTYHpU4R7gktN9ULnd0ZCRLEf6ke7EzDJJQXTjAbm/
	7c5p5GeNcpDze/MEE8GJb1y2iE3Fk9fY3kDgdi6mMs9jQMNw9LLHSwxvrPBYiP8EFFuOyoumh1T9Z
	7b2VmRK2VaBazJ0BNktTvs8G4ropZZC0hBhUWJkZF0vkgembxXdkNGUJzmd5L5dKZqfSJ7PbHVT8L
	uaqWqoNCax0uHMnLfHlEsQJOJ9Cn7kB1MNacjMHCITmZn2eOOZwhksmNvUCKKyfxSQ4H448cVB0Un
	WLWOKgsg==;
Received: from 2a02-8389-2341-5b80-76c3-a3dc-14f6-94e8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:76c3:a3dc:14f6:94e8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9ax-0000000EOUs-2XZ9;
	Fri, 10 Jan 2025 07:38:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 6/8] loop: allow loop_set_status to re-enable direct I/O
Date: Fri, 10 Jan 2025 08:37:36 +0100
Message-ID: <20250110073750.1582447-7-hch@lst.de>
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

Unlike all other calls of (__)loop_update_dio, loop_set_status never
looks at the O_DIRECT flag of the backing file, and thus doesn't
re-enable direct I/O on an O_DIRECT backing file if e.g. the new block
size would allow it.  Fix that and remove the need for the separate
__loop_update_dio flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6eb6d901151c..2e1f8aa045a9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -196,8 +196,9 @@ static bool lo_can_use_dio(struct loop_device *lo)
 	return true;
 }
 
-static void __loop_update_dio(struct loop_device *lo, bool dio)
+static inline void loop_update_dio(struct loop_device *lo)
 {
+	bool dio = lo->use_dio || (lo->lo_backing_file->f_flags & O_DIRECT);
 	bool use_dio = dio && lo_can_use_dio(lo);
 
 	if (lo->use_dio == use_dio)
@@ -531,12 +532,6 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	}
 }
 
-static inline void loop_update_dio(struct loop_device *lo)
-{
-	__loop_update_dio(lo, (lo->lo_backing_file->f_flags & O_DIRECT) |
-				lo->use_dio);
-}
-
 static void loop_reread_partitions(struct loop_device *lo)
 {
 	int rc;
@@ -1301,7 +1296,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	}
 
 	/* update the direct I/O flag if lo_offset changed */
-	__loop_update_dio(lo, lo->use_dio);
+	loop_update_dio(lo);
 
 out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue);
-- 
2.45.2

