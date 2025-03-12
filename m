Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8452139CE3
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791693; cv=none; b=TRIpLFMyw9Pvx1Ao594s8IGlgQYgo6HbMcRmBil5kDJpumTHST/ZIXMMYMMjBE8OTCq6VCAz/YBIBJLTwGoF9pBT5wGHfBpny4lXGMF+5WftUJL7fDVwVwORCo7EFxIIYwBFoeefca+AgqZC08TZiGITmA/vJEGRWvC364AcF/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791693; c=relaxed/simple;
	bh=zfXdgjsn4jotX0gU/wLEybx4NSSTxKMMi7oRl9w2FEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IE1C9zwGuqB8CRIq1YFArgr2e/7BBdPwYEcScKnwxQBRGbyHg4xdfQfEPQ/xntoFJWszqjleI+HTTrHYB9xo4Sok0pPGRKnFq9bd2pCta7lc2J1Is6JrfJTzCk8sfOMhmjuLQM13kUYkb0BYvTedpZH+GX5gd/+gbNKvxZ9WPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Oxgix4Ei; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oxgix4Ei"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=VkhONVgBZPRVpFnog11+NqMPYsG0NfayAyjjvBPvr+o=; b=Oxgix4EiKfIK8dC7Pfmq+xOrX+
	RB9LMsYYFMxXTCrVW0udCe6mbK/8hugXFK+Igr7ihRnTQkyboSHNGIaZbqMtPhszpEWF39lrfMcW+
	kFz3+IlC6Lh4b8DThbyKnA08rghv+cZF+uSZVxvGPUd73A5qzpEQQOLqH4L8b9Ni93/qKET24W+iJ
	bgF0M4dF040AFmmALU1fTtiReg+fqxLl6KOhPsCl1sr5XI3ZZRk3hM5EGlAGP5FHvNNr3Dbo4Sf6F
	aBW6h4IX5GpGsF2KvtgJ9PpHtXfwXJD5rAc6gky4Zrl3HD9u1VzjG3H7rUCtAuLOeAA7CGH4F1ajr
	DsqigHIQ==;
Received: from 2a02-8389-2341-5b80-f359-bc8f-8f56-db64.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:f359:bc8f:8f56:db64] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNaM-00000008mEb-3Ot9;
	Wed, 12 Mar 2025 15:01:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: nilay@linux.ibm.com,
	linux-block@vger.kernel.org
Subject: [PATCH] block: fix a comment in the queue_attrs[] array
Date: Wed, 12 Mar 2025 16:01:27 +0100
Message-ID: <20250312150127.703534-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

queue_ra_entry uses limits_lock just like the attributes above it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index d584461a1d84..a2882751f0d2 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -671,11 +671,6 @@ static struct attribute *queue_attrs[] = {
 	&queue_dax_entry.attr,
 	&queue_virt_boundary_mask_entry.attr,
 	&queue_dma_alignment_entry.attr,
-
-	/*
-	 * Attributes which require some form of locking other than
-	 * q->sysfs_lock.
-	 */
 	&queue_ra_entry.attr,
 
 	/*
-- 
2.45.2

