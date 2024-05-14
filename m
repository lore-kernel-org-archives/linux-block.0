Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51E181325
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708360; cv=none; b=bg8+K3yooY2pZ6b5+YH5x3g2Xix7IQ+3Xx/w4FRJfdObSCnKxLYJi0rjif0ZWD4L8zyIlsPWB4V6fEACMthsc+mLez+sICkVl6nAwGvjN5lGdQ37C93kAON4es9dJ9nXbF3Ja/HI63YZ36/WPZcCckI7YRgEuY7IcYJY2BFehSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708360; c=relaxed/simple;
	bh=J3KaC8y/QoqDXiQG7pAOqRWVFiVs5GHTt0L+EDHw71c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZvSECMYybmhWCGLqLS0lFW/SvmtvD72X6jWSI3XsH6f3XiqQSxpEiHcxJvE1foXDyExph5EAKcVt6q0tkYCEnttNbh1c5gtzdxMAw1xojSv+KG2SR1w4xhTgBMBKDcZoW/8cvICQzeFFZJ/cTPS0T8ofaStBcGhhBRz6xjZkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXCmkK4/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXCmkK4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAE7C2BD11;
	Tue, 14 May 2024 17:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708360;
	bh=J3KaC8y/QoqDXiQG7pAOqRWVFiVs5GHTt0L+EDHw71c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXCmkK4/VtpzFaonE3Dktl0jjwhcklOmSUqOuRvUKoo3bpnE/I1d7n5nurn4k6ePU
	 /nVeIjFiuXXZQWqPS08lvR+9lMBHFQe314Q0987eB8d/+pWBBUeLY3X9G4al1uZvgM
	 fnmXoV2eyc8VGLiJlS7MYM7vUXfb5an24Yu7hxdJrNPmlhfhytFzKmjP6N474/SmhL
	 5yW3ckuZh1xNU4bozH4BYE4YiBsgEJyu5yqsiBYGxfFsdsL5AsRQRJDDK9VzfRGYzh
	 UZiQdoosl24DCKV/ZsTyLP717lwuXyY/DoUBtRYao0dMJzizDzma2ZMy7Dvfg+kQt6
	 ltk9OS54ArgdQ==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/6] fs/mpage: use blocks_per_folio instead of blocks_per_page
Date: Tue, 14 May 2024 19:38:56 +0200
Message-Id: <20240514173900.62207-3-hare@kernel.org>
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

Convert mpage to folios and associate the number of blocks with
a folio and not a page.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/mpage.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 558b627d382c..7cb9d9efdba8 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -114,7 +114,7 @@ static void map_buffer_to_folio(struct folio *folio, struct buffer_head *bh,
 		 * don't make any buffers if there is only one buffer on
 		 * the folio and the folio just needs to be set up to date
 		 */
-		if (inode->i_blkbits == PAGE_SHIFT &&
+		if (inode->i_blkbits == folio_shift(folio) &&
 		    buffer_uptodate(bh)) {
 			folio_mark_uptodate(folio);
 			return;
@@ -160,7 +160,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	struct folio *folio = args->folio;
 	struct inode *inode = folio->mapping->host;
 	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
+	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;
 	const unsigned blocksize = 1 << blkbits;
 	struct buffer_head *map_bh = &args->map_bh;
 	sector_t block_in_file;
@@ -168,7 +168,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	sector_t last_block_in_file;
 	sector_t first_block;
 	unsigned page_block;
-	unsigned first_hole = blocks_per_page;
+	unsigned first_hole = blocks_per_folio;
 	struct block_device *bdev = NULL;
 	int length;
 	int fully_mapped = 1;
@@ -177,9 +177,6 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	unsigned relative_block;
 	gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 
-	/* MAX_BUF_PER_PAGE, for example */
-	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-
 	if (args->is_readahead) {
 		opf |= REQ_RAHEAD;
 		gfp |= __GFP_NORETRY | __GFP_NOWARN;
@@ -189,7 +186,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 		goto confused;
 
 	block_in_file = folio_pos(folio) >> blkbits;
-	last_block = block_in_file + args->nr_pages * blocks_per_page;
+	last_block = block_in_file + ((args->nr_pages * PAGE_SIZE) >> blkbits);
 	last_block_in_file = (i_size_read(inode) + blocksize - 1) >> blkbits;
 	if (last_block > last_block_in_file)
 		last_block = last_block_in_file;
@@ -211,7 +208,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 				clear_buffer_mapped(map_bh);
 				break;
 			}
-			if (page_block == blocks_per_page)
+			if (page_block == blocks_per_folio)
 				break;
 			page_block++;
 			block_in_file++;
@@ -223,7 +220,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	 * Then do more get_blocks calls until we are done with this folio.
 	 */
 	map_bh->b_folio = folio;
-	while (page_block < blocks_per_page) {
+	while (page_block < blocks_per_folio) {
 		map_bh->b_state = 0;
 		map_bh->b_size = 0;
 
@@ -236,7 +233,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 
 		if (!buffer_mapped(map_bh)) {
 			fully_mapped = 0;
-			if (first_hole == blocks_per_page)
+			if (first_hole == blocks_per_folio)
 				first_hole = page_block;
 			page_block++;
 			block_in_file++;
@@ -254,7 +251,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 			goto confused;
 		}
 	
-		if (first_hole != blocks_per_page)
+		if (first_hole != blocks_per_folio)
 			goto confused;		/* hole -> non-hole */
 
 		/* Contiguous blocks? */
@@ -267,7 +264,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 			if (relative_block == nblocks) {
 				clear_buffer_mapped(map_bh);
 				break;
-			} else if (page_block == blocks_per_page)
+			} else if (page_block == blocks_per_folio)
 				break;
 			page_block++;
 			block_in_file++;
@@ -275,8 +272,8 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 		bdev = map_bh->b_bdev;
 	}
 
-	if (first_hole != blocks_per_page) {
-		folio_zero_segment(folio, first_hole << blkbits, PAGE_SIZE);
+	if (first_hole != blocks_per_folio) {
+		folio_zero_segment(folio, first_hole << blkbits, folio_size(folio));
 		if (first_hole == 0) {
 			folio_mark_uptodate(folio);
 			folio_unlock(folio);
@@ -310,10 +307,10 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	relative_block = block_in_file - args->first_logical_block;
 	nblocks = map_bh->b_size >> blkbits;
 	if ((buffer_boundary(map_bh) && relative_block == nblocks) ||
-	    (first_hole != blocks_per_page))
+	    (first_hole != blocks_per_folio))
 		args->bio = mpage_bio_submit_read(args->bio);
 	else
-		args->last_block_in_bio = first_block + blocks_per_page - 1;
+		args->last_block_in_bio = first_block + blocks_per_folio - 1;
 out:
 	return args->bio;
 
@@ -392,7 +389,7 @@ int mpage_read_folio(struct folio *folio, get_block_t get_block)
 {
 	struct mpage_readpage_args args = {
 		.folio = folio,
-		.nr_pages = 1,
+		.nr_pages = folio_nr_pages(folio),
 		.get_block = get_block,
 	};
 
@@ -463,12 +460,12 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
 	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
+	const unsigned blocks_per_folio = folio_size(folio) >> blkbits;
 	sector_t last_block;
 	sector_t block_in_file;
 	sector_t first_block;
 	unsigned page_block;
-	unsigned first_unmapped = blocks_per_page;
+	unsigned first_unmapped = blocks_per_folio;
 	struct block_device *bdev = NULL;
 	int boundary = 0;
 	sector_t boundary_block = 0;
@@ -493,12 +490,12 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 				 */
 				if (buffer_dirty(bh))
 					goto confused;
-				if (first_unmapped == blocks_per_page)
+				if (first_unmapped == blocks_per_folio)
 					first_unmapped = page_block;
 				continue;
 			}
 
-			if (first_unmapped != blocks_per_page)
+			if (first_unmapped != blocks_per_folio)
 				goto confused;	/* hole -> non-hole */
 
 			if (!buffer_dirty(bh) || !buffer_uptodate(bh))
@@ -543,7 +540,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 		goto page_is_mapped;
 	last_block = (i_size - 1) >> blkbits;
 	map_bh.b_folio = folio;
-	for (page_block = 0; page_block < blocks_per_page; ) {
+	for (page_block = 0; page_block < blocks_per_folio; ) {
 
 		map_bh.b_state = 0;
 		map_bh.b_size = 1 << blkbits;
@@ -625,14 +622,14 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	BUG_ON(folio_test_writeback(folio));
 	folio_start_writeback(folio);
 	folio_unlock(folio);
-	if (boundary || (first_unmapped != blocks_per_page)) {
+	if (boundary || (first_unmapped != blocks_per_folio)) {
 		bio = mpage_bio_submit_write(bio);
 		if (boundary_block) {
 			write_boundary_block(boundary_bdev,
 					boundary_block, 1 << blkbits);
 		}
 	} else {
-		mpd->last_block_in_bio = first_block + blocks_per_page - 1;
+		mpd->last_block_in_bio = first_block + blocks_per_folio - 1;
 	}
 	goto out;
 
-- 
2.35.3

