Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B16442EEC4;
	Fri,  9 Oct 2026 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791539887; cv=none; b=ObjIGWOBKgi5KZ/sC6MXlP6snuQdSqhUSCzXX/k4RDFBBHCC3kh2Wa5PTvaV+oJBwi33/dE1l7wSLMMZ1hAGdh8gYLOX+P3MSyffHsGbeKnJPEykC67dX4ePffe5IZvZ4sKDHq4r+QwlmrQ7NuTdj/sncwb9e5dW36IMGMyfqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791539887; c=relaxed/simple;
	bh=tk6XYWRxCrokkBXwYI30MLvzAAG5o7EubBUaOaP1Hmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ghf0Hl2rYKGWB0spfF5Try757zZ1k2Mfm+KST+5sDyioGFzPMOpJ55mZZKKh4lX/qxdIPw0jJGVoeYdC3xEK24QZAhSGOugJloM97h+ym7a1NYCXImGd2WW93HlIe87T79csEdhVWxLLRoI5FzYVj7xwoy0d4zDq02c/mxaXoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CFA3147979;
	Fri, 09 Oct 2026 11:58:01 +0200 (CEST)
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
Subject: [RFC PATCH 1/4] buffer: writeback: extract shared bio build/complete helpers
Date: Fri,  9 Oct 2026 11:57:48 +0200
Message-ID: <20261009095754.430875-2-l.sichert@proxmox.com>
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
X-Bm-Transport-Timestamp: 1791539880815

Split the bio allocation out of __bh_submit() and the folio writeback
completion out of bh_end_async_write() into helpers, so that other
submit and completion paths can share them. This prevents code
duplication and code drift.

As this is a pure refactor the behavior of __bh_submit() and
bh_end_async_write() is unchanged.

Signed-off-by: Lukas Sichert <l.sichert@proxmox.com>
---
 fs/buffer.c | 89 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 36 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ed966fa73b1b..3389d866a85c 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -386,27 +386,10 @@ static void bh_end_async_read(struct bio *bio)
 	end_buffer_async_read(bh, uptodate);
 }
 
-/**
- * bh_end_async_write - I/O end handler for async folio writes
- * @bio: The bio being completed.
- *
- * Pass this function to bh_submit() if you're doing the equivalent of
- * block_write_full_folio().  That is, the folio is unlocked, and will
- * have its writeback flag cleared once all async write buffers have
- * completed.
- */
-void bh_end_async_write(struct bio *bio)
+static void bh_complete_write(struct buffer_head *bh, bool success)
 {
-	struct buffer_head *bh;
-	bool success = bio_endio_bh(bio, &bh);
-	unsigned long flags;
-	struct buffer_head *first;
-	struct buffer_head *tmp;
-	struct folio *folio;
-
 	BUG_ON(!buffer_async_write(bh));
 
-	folio = bh->b_folio;
 	if (success) {
 		set_buffer_uptodate(bh);
 	} else {
@@ -414,8 +397,14 @@ void bh_end_async_write(struct bio *bio)
 		mark_buffer_write_io_error(bh);
 		clear_buffer_uptodate(bh);
 	}
+}
+
+static void bh_complete_folio_write(struct folio *folio, struct buffer_head *bh)
+{
+	struct buffer_head *first = folio_buffers(folio);
+	struct buffer_head *tmp;
+	unsigned long flags;
 
-	first = folio_buffers(folio);
 	spin_lock_irqsave(&first->b_uptodate_lock, flags);
 
 	clear_buffer_async_write(bh);
@@ -435,6 +424,25 @@ void bh_end_async_write(struct bio *bio)
 still_busy:
 	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 }
+
+/**
+ * bh_end_async_write - I/O end handler for async folio writes
+ * @bio: The bio being completed.
+ *
+ * Pass this function to bh_submit() if you're doing the equivalent of
+ * block_write_full_folio().  That is, the folio is unlocked, and will
+ * have its writeback flag cleared once all async write buffers have
+ * completed.
+ */
+void bh_end_async_write(struct bio *bio)
+{
+	struct buffer_head *bh;
+	bool success = bio_endio_bh(bio, &bh);
+	struct folio *folio = bh->b_folio;
+
+	bh_complete_write(bh, success);
+	bh_complete_folio_write(folio, bh);
+}
 EXPORT_SYMBOL(bh_end_async_write);
 
 
@@ -1082,24 +1090,11 @@ static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
 			folio_pos(bh->b_folio) + bh_offset(bh), gfp_mask);
 }
 
-static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
-		enum rw_hint write_hint, struct writeback_control *wbc,
-		bio_end_io_t end_bio)
+static struct bio *bh_bio_alloc(struct buffer_head *bh, blk_opf_t opf,
+				enum rw_hint write_hint, bio_end_io_t end_bio)
 {
-	const enum req_op op = opf & REQ_OP_MASK;
 	struct bio *bio;
 
-	BUG_ON(!buffer_locked(bh));
-	BUG_ON(!buffer_mapped(bh));
-	BUG_ON(buffer_delay(bh));
-	BUG_ON(buffer_unwritten(bh));
-
-	/*
-	 * Only clear out a write error when rewriting
-	 */
-	if (test_set_buffer_req(bh) && (op == REQ_OP_WRITE))
-		clear_buffer_write_io_error(bh);
-
 	if (buffer_meta(bh))
 		opf |= REQ_META;
 	if (buffer_prio(bh))
@@ -1115,10 +1110,32 @@ static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_write_hint = write_hint;
+	bio->bi_end_io = end_bio;
 
-	bio_add_folio_nofail(bio, bh->b_folio, bh->b_size, bh_offset(bh));
+	return bio;
+}
 
-	bio->bi_end_io = end_bio;
+static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
+		enum rw_hint write_hint, struct writeback_control *wbc,
+		bio_end_io_t end_bio)
+{
+	const enum req_op op = opf & REQ_OP_MASK;
+	struct bio *bio;
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
+	bio = bh_bio_alloc(bh, opf, write_hint, end_bio);
+
+	bio_add_folio_nofail(bio, bh->b_folio, bh->b_size, bh_offset(bh));
 	bio->bi_private = bh;
 
 	/* Take care of bh's that straddle the end of the device */

