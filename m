Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B2181319
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708358; cv=none; b=PriIg1PYqAvqqI3EJin36BLiFw9UJVzdtmohajTYA+ZbJrE1MFZl1lkdi4x3c5uh2SPXFEnqgQbUS0izH2WdTd2/9P8+XCn1WYwO7j2HcZa8bLEJwO4tzrAk37wp+YG4JQAnTSt6/JnK0m8AdxRVh7bSBD4vmgLDyYdfxuZrRHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708358; c=relaxed/simple;
	bh=nfZe9PyFcNTBz+0MHtHtGvd+j23GfMlHF02ruavVO6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aKf5tKU+tRdJ4vc64gTRpMamqXEALW6++UhLF2uRdgeyrmqyfLHE3QEoT7HZhgblB9F4GqysB6QvNJZDXcxH2LcL3k347zpd6boyZiXmmlEBmLRvLClahERaWI0evwDt9tP7GjPLzuSMM3O9eqMYKcFCSAZhibaa44dyrqLb9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8KkhFEG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8KkhFEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B23C4AF08;
	Tue, 14 May 2024 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708358;
	bh=nfZe9PyFcNTBz+0MHtHtGvd+j23GfMlHF02ruavVO6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s8KkhFEGgXJ94xhNL/cTpJqbsnNTkK/tBlwgBBH9S5gYr8UIdQONeWyRm3qlhNdNC
	 H9WwXJJETlCIYLj8/dzCvvANr1imqRCDgh36tNiFkVv473ytgKAXwIg5Ha0uKibXN2
	 qzbpYiKFMCWt0EIOCH3MF9wPjsT1c55mHIkBNDGSBZxGZCAkT4XTQeVWDWGHiYGLjl
	 /UW8OUJta+uw1GCV3gOmVMy0fQscyHbVVDvY/MtW2Pa+T4wq8nTAgyUiUPTZgTNZXs
	 6TkTd64nx5niCsajI9D4W0qaOcoCdWL/tVGQDAx6Ga3TN1UHCKU1quwVVcGD444BQ2
	 d2mi2zLItvQrQ==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/6] fs/mpage: avoid negative shift for large blocksize
Date: Tue, 14 May 2024 19:38:55 +0200
Message-Id: <20240514173900.62207-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240514173900.62207-1-hare@kernel.org>
References: <20240514173900.62207-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For large blocksizes the number of block bits is larger than PAGE_SHIFT,
so use folio_pos() to calculate the sector number from the folio.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/mpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index fa8b99a199fa..558b627d382c 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -188,7 +188,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	if (folio_buffers(folio))
 		goto confused;
 
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = folio_pos(folio) >> blkbits;
 	last_block = block_in_file + args->nr_pages * blocks_per_page;
 	last_block_in_file = (i_size_read(inode) + blocksize - 1) >> blkbits;
 	if (last_block > last_block_in_file)
@@ -534,7 +534,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	 * The page has no buffers: map it to disk
 	 */
 	BUG_ON(!folio_test_uptodate(folio));
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = folio_pos(folio) >> blkbits;
 	/*
 	 * Whole page beyond EOF? Skip allocating blocks to avoid leaking
 	 * space.
-- 
2.35.3

