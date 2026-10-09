Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4C3D4108;
	Fri,  9 Oct 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791539887; cv=none; b=ZP3+UeHx1dCfJw+xCY7BAA032d2Jzn4RjdpLeEAl0u/yLVRl1yaf78RaesKqDWp9/ttgZ/0301ZMLKga873l6D84umwaghXr/SEbuAJUkLFo8EXj3/aU/LMpzNY1paqPenwE/Ob577dRJ3TMo4Ne7dUbTkaLRKAaqO/7IWLv6AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791539887; c=relaxed/simple;
	bh=ewf7NH8t7OoqvNF5e3ebUOK1+u01wdvsIhxf8gIXJJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9R0qCLd5K+khwigvLzGd0jbMf7K+KAE1lVYDgbdxUQx3K6luC1w0h0Nx7Fcq1Z2YJCBuVx5iJO+huJygbNb1nmOqxqt/ZHHqNmuY2YKKiIXfymD+NuyYdHEUZuvVcu4NqG8nEmWz3wHxAWzSSaZgIV4PS9ZkurdjSE0ikjFzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9F2ED4797F;
	Fri, 09 Oct 2026 11:58:02 +0200 (CEST)
From: Lukas Sichert <l.sichert@proxmox.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Sichert <l.sichert@proxmox.com>
Subject: [RFC PATCH 2/4] buffer: writeback: batch contiguous async-write buffers per folio
Date: Fri,  9 Oct 2026 11:57:49 +0200
Message-ID: <20261009095754.430875-3-l.sichert@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009095754.430875-1-l.sichert@proxmox.com>
References: <20261009095754.430875-1-l.sichert@proxmox.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791539881350

Writeback of a folio with several buffers submits one bio per buffer
head, even when the buffers are contiguous on disk. That is a lot of
small bios, and the block layer has to merge them again or not at all.
Build one bio per run of contiguous buffers instead.

Buffers only merge if they target the same bdev and have the same
REQ_META/REQ_PRIO state, since bh_submit() applies those bits per
buffer. A bio that does not complete in task context cannot take
folios marked dropbehind, so a new bio is started for those.

Such a bio completes a whole run of buffers at once, so let
bh_complete_folio_write() clear BH_Async_Write on the run while
taking the folio's uptodate lock only once.

Signed-off-by: Lukas Sichert <l.sichert@proxmox.com>
---
 fs/buffer.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 113 insertions(+), 8 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 3389d866a85c..ae350d443b27 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -399,17 +399,20 @@ static void bh_complete_write(struct buffer_head *bh, bool success)
 	}
 }
 
-static void bh_complete_folio_write(struct folio *folio, struct buffer_head *bh)
+static void bh_complete_folio_write(struct folio *folio, struct buffer_head *bh,
+				    unsigned nr)
 {
 	struct buffer_head *first = folio_buffers(folio);
-	struct buffer_head *tmp;
+	struct buffer_head *tmp = bh;
 	unsigned long flags;
+	unsigned i;
 
 	spin_lock_irqsave(&first->b_uptodate_lock, flags);
 
-	clear_buffer_async_write(bh);
-	unlock_buffer(bh);
-	tmp = bh->b_this_page;
+	for (i = 0; i < nr; i++, tmp = tmp->b_this_page) {
+		clear_buffer_async_write(tmp);
+		unlock_buffer(tmp);
+	}
 	while (tmp != bh) {
 		if (buffer_async_write(tmp)) {
 			BUG_ON(!buffer_locked(tmp));
@@ -441,7 +444,7 @@ void bh_end_async_write(struct bio *bio)
 	struct folio *folio = bh->b_folio;
 
 	bh_complete_write(bh, success);
-	bh_complete_folio_write(folio, bh);
+	bh_complete_folio_write(folio, bh, 1);
 }
 EXPORT_SYMBOL(bh_end_async_write);
 
@@ -1164,6 +1167,100 @@ void bh_submit(struct buffer_head *bh, blk_opf_t opf, bio_end_io_t end_io)
 }
 EXPORT_SYMBOL(bh_submit);
 
+static void __bh_bio_append(struct bio **biop, struct buffer_head *bh,
+			    blk_opf_t opf, enum rw_hint write_hint,
+			    struct writeback_control *wbc, bio_end_io_t end_bio)
+{
+	const enum req_op op = opf & REQ_OP_MASK;
+	sector_t sector = bh->b_blocknr * (bh->b_size >> 9);
+	struct bio *bio = *biop;
+
+	BUG_ON(!buffer_locked(bh));
+	BUG_ON(!buffer_mapped(bh));
+	BUG_ON(buffer_delay(bh));
+	BUG_ON(buffer_unwritten(bh));
+
+	/*
+	 * Only clear out a write error when rewriting
+	 */
+	if (test_set_buffer_req(bh) && (op == REQ_OP_WRITE))
+		clear_buffer_write_io_error(bh);
+
+	/*
+	 * The open bio can only be extended with a buffer head if it passes
+	 * every check below. If any one of them fails, submit the bio as it
+	 * is and start a new one for this buffer head.
+	 *
+	 * The buffer head does not fit if:
+	 * - it is written to a different block device
+	 * - its REQ_META or REQ_PRIO property differs from the bio's, as
+	 *   these apply to the bio as a whole
+	 * - its write hint differs from the bio's
+	 * - its folio is dropbehind, but the bio would complete in IRQ
+	 *   context instead of task context
+	 * - it does not start on disk right where the bio's data ends, for
+	 *   example because the file is fragmented
+	 * - its fscrypt key differs or its data unit numbers would not
+	 *   continue those of the bio
+	 * - bio_add_folio() cannot take it, for example because the bio is
+	 *   full. This is checked last because it adds the buffer on success.
+	 */
+	if (bio &&
+	    (bio->bi_bdev != bh->b_bdev ||
+	     !!(bio->bi_opf & REQ_META) != buffer_meta(bh) ||
+	     !!(bio->bi_opf & REQ_PRIO) != buffer_prio(bh) ||
+	     bio->bi_write_hint != write_hint ||
+	     (!bio_flagged(bio, BIO_COMPLETE_IN_TASK) &&
+	      folio_test_dropbehind(bh->b_folio)) ||
+	     bio_end_sector(bio) != sector ||
+	     !fscrypt_mergeable_bio(bio, bh->b_folio->mapping->host,
+				    folio_pos(bh->b_folio) + bh_offset(bh)) ||
+	     !bio_add_folio(bio, bh->b_folio, bh->b_size, bh_offset(bh)))) {
+		guard_bio_eod(bio);
+		blk_crypto_submit_bio(bio);
+		bio = NULL;
+	}
+
+	if (!bio) {
+		bio = bh_bio_alloc(bh, opf, write_hint, end_bio);
+		if (wbc)
+			wbc_init_bio(wbc, bio);
+		bio_add_folio_nofail(bio, bh->b_folio, bh->b_size, bh_offset(bh));
+	}
+
+	if (wbc)
+		wbc_account_cgroup_owner(wbc, bh->b_folio, bh->b_size);
+
+	*biop = bio;
+}
+
+static void bh_end_async_write_range(struct bio *bio)
+{
+	bool success = bio->bi_status == BLK_STS_OK;
+	bool quiet = bio_flagged(bio, BIO_QUIET);
+	struct folio_iter fi;
+
+	bio_for_each_folio_all(fi, bio) {
+		struct folio *folio = fi.folio;
+		struct buffer_head *first_bh = folio_buffers(folio);
+		struct buffer_head *bh;
+		unsigned int i, nr;
+
+		while (bh_offset(first_bh) < fi.offset)
+			first_bh = first_bh->b_this_page;
+
+		nr = DIV_ROUND_UP(fi.length, first_bh->b_size);
+		for (i = 0, bh = first_bh; i < nr; i++, bh = bh->b_this_page) {
+			if (quiet)
+				set_bit(BH_Quiet, &bh->b_state);
+			bh_complete_write(bh, success);
+		}
+
+		bh_complete_folio_write(folio, first_bh, nr);
+	}
+	bio_put(bio);
+}
+
 static struct buffer_head *__bread_slow(struct buffer_head *bh)
 {
 	lock_buffer(bh);
@@ -1745,6 +1842,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 	size_t blocksize;
 	int nr_underway = 0;
 	blk_opf_t write_flags = wbc_to_write_flags(wbc);
+	struct bio *bio;
 
 	head = folio_create_buffers(folio, inode,
 				    (1 << BH_Dirty) | (1 << BH_Uptodate));
@@ -1828,16 +1926,23 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 	BUG_ON(folio_test_writeback(folio));
 	folio_start_writeback(folio);
 
+	bio = NULL;
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
-			__bh_submit(bh, REQ_OP_WRITE | write_flags,
+			__bh_bio_append(&bio, bh, REQ_OP_WRITE | write_flags,
 					inode->i_write_hint, wbc,
-					bh_end_async_write);
+					bh_end_async_write_range);
 			nr_underway++;
 		}
 		bh = next;
 	} while (bh != head);
+
+	if (bio) {
+		guard_bio_eod(bio);
+		blk_crypto_submit_bio(bio);
+	}
+
 	folio_unlock(folio);
 
 	err = 0;

