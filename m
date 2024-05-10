Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8EA16C43B
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336975; cv=none; b=VSfjc4kkVBdQgkGeLC+Q3/J8sZHE2VmNy/tHQFh51pcb8Tvetq9m1EbgWnldNUQP5cU6d32pFnmUj19USxLUyQzjNlGRw0OWljR0U6pdm/3Sh/1yVZYIgFPmaPFscRjvtVm0XYdVhMCOORq1l26TVsQiBAz762n2GcTKnyd4e5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336975; c=relaxed/simple;
	bh=13Q13FxbeBZfXsma08UVYuDt48mFE069IzP5r4sL7n8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSCXfPqHYXaVH0H92smG9wbYQi/K+EgjyP6sn99sDI0Rb5N6cgcMA02ICn+3sByp3/2oreZu429WQlGhBjY3xhKGE/nBLKeOKrBlIGKl17HyKenFZM7W/6I4rfyB0T/0I2ZhiRa+1mMbNSz+o4UbIE0QeHCFjcWuPmNOl2/AOwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRASUid+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRASUid+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CF5C113CC;
	Fri, 10 May 2024 10:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715336975;
	bh=13Q13FxbeBZfXsma08UVYuDt48mFE069IzP5r4sL7n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRASUid+NCrno7Pi9fT4HWOe1Pv/5IujmapV0DAiwpMzBSlYWeGVYaY8fhzLPPbmF
	 0Cc/9nb+zyjy0JASv+Rfyf7cJIdzpI63/q16FxrYr6B1AgeyHF4Op7xFSlxZ3Be8M7
	 B0IWarwHNhEC9UYpGY3/lN9+dwm7p6SRLXGddTOJc8xevUlGNsJ9NX9HgSVLoygxPs
	 19MQziag/eCNi0P0WdU2gsGsuCleST19KSrexsXLiP7rqoihfCHB04IbmX/RT53Ocv
	 92o1kb0YAXKFYU4St+nL3qIdD8YS59s6QmnptcpUZzp+/SyYPu67f8UKLZd7Bs5l1e
	 R61COEGfOJk1g==
From: hare@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/5] fs/mpage: avoid negative shift for large blocksize
Date: Fri, 10 May 2024 12:29:03 +0200
Message-Id: <20240510102906.51844-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240510102906.51844-1-hare@kernel.org>
References: <20240510102906.51844-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@kernel.org>

For large blocksizes the number of block bits is larger than PAGE_SHIFT,
so use shift to calculate the sector number from the page cache index.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/mpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 379a71475c42..e3732686e65f 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -188,7 +188,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	if (folio_buffers(folio))
 		goto confused;
 
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = (sector_t)(((loff_t)folio->index << PAGE_SHIFT) >> blkbits);
 	last_block = block_in_file + args->nr_pages * blocks_per_folio;
 	last_block_in_file = (i_size_read(inode) + blocksize - 1) >> blkbits;
 	if (last_block > last_block_in_file)
@@ -534,7 +534,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	 * The page has no buffers: map it to disk
 	 */
 	BUG_ON(!folio_test_uptodate(folio));
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = (sector_t)(((loff_t)folio->index << PAGE_SHIFT) >> blkbits);
 	/*
 	 * Whole page beyond EOF? Skip allocating blocks to avoid leaking
 	 * space.
-- 
2.35.3

