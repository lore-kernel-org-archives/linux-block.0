Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D095ECCA47B
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbiGNSJh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbiGNSJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:09:18 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DF813F0E
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:11 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id e16so2539596pfm.11
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQj0Oqf1mWJI1F+e5GcaW+mY/XX8MU9X2eSXyoRsEgM=;
        b=P/KeNGVURhQmHBvDc0SViQQBdIxONIaAfcvRj7jn66A/GZgRhX2oTWT1Oa93NQIkZ5
         oErSgucGudA8Gqh6FhFioZiwfmPxqukfXLZBVl4V12fyE0MkClRXT5hKm5djLfd/AS+P
         VM+fv+8HW49XgVrHmfg/qabvNrctmdaj4/++pjsJSjrPueyqomb5rGi8UleXaPjv95ED
         9fZaU4YLDg6Q2J/HtZk4KVUMwD06/uW+GFrMpuP8amogec2Jr7O887WynwhPM7Ut4OSl
         rqxd5BcOEsluy++OLrYx5I/SwIsxbnybvVjlWseFXjD/OBtt5sWmyynr5e7UDYE42cky
         DRww==
X-Gm-Message-State: AJIora87c+GyH34QkCNp/pnS0zjKC3v+pf6asfi2lbLlZDE8gr4wwlwe
        g4VOoQ0weD9OyahyYxyOOxA=
X-Google-Smtp-Source: AGRyM1sHG2gO6U46VGtczKevNnTV03MFBeV894Ckc30HyKFaROjDEgoxOoM258smbUFZd3gEuAEtNw==
X-Received: by 2002:a65:6a50:0:b0:3f6:4566:581d with SMTP id o16-20020a656a50000000b003f64566581dmr8551913pgu.122.1657822151171;
        Thu, 14 Jul 2022 11:09:11 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:09:10 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v3 58/63] fs/nilfs2: Use the enum req_op and blk_opf_t types
Date:   Thu, 14 Jul 2022 11:07:24 -0700
Message-Id: <20220714180729.1065367-59-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags. Combine the 'mode' and
'mode_flags' arguments of nilfs_btnode_submit_block into a single
argument 'opf'.

Reviewed-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/nilfs2/btnode.c            |  8 ++++----
 fs/nilfs2/btnode.h            |  4 ++--
 fs/nilfs2/btree.c             |  6 +++---
 fs/nilfs2/gcinode.c           |  5 ++---
 fs/nilfs2/mdt.c               | 19 ++++++++++---------
 include/trace/events/nilfs2.h |  4 ++--
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 5c39efbf733f..e74fda212620 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -70,7 +70,7 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 }
 
 int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
-			      sector_t pblocknr, int mode, int mode_flags,
+			      sector_t pblocknr, blk_opf_t opf,
 			      struct buffer_head **pbh, sector_t *submit_ptr)
 {
 	struct buffer_head *bh;
@@ -103,13 +103,13 @@ int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
 		}
 	}
 
-	if (mode_flags & REQ_RAHEAD) {
+	if (opf & REQ_RAHEAD) {
 		if (pblocknr != *submit_ptr + 1 || !trylock_buffer(bh)) {
 			err = -EBUSY; /* internal code */
 			brelse(bh);
 			goto out_locked;
 		}
-	} else { /* mode == READ */
+	} else { /* opf == REQ_OP_READ */
 		lock_buffer(bh);
 	}
 	if (buffer_uptodate(bh)) {
@@ -122,7 +122,7 @@ int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
 	bh->b_blocknr = pblocknr; /* set block address for read */
 	bh->b_end_io = end_buffer_read_sync;
 	get_bh(bh);
-	submit_bh(mode | mode_flags, bh);
+	submit_bh(opf, bh);
 	bh->b_blocknr = blocknr; /* set back to the given block address */
 	*submit_ptr = pblocknr;
 	err = 0;
diff --git a/fs/nilfs2/btnode.h b/fs/nilfs2/btnode.h
index bd5544e63a01..4bc5612dff94 100644
--- a/fs/nilfs2/btnode.h
+++ b/fs/nilfs2/btnode.h
@@ -34,8 +34,8 @@ void nilfs_init_btnc_inode(struct inode *btnc_inode);
 void nilfs_btnode_cache_clear(struct address_space *);
 struct buffer_head *nilfs_btnode_create_block(struct address_space *btnc,
 					      __u64 blocknr);
-int nilfs_btnode_submit_block(struct address_space *, __u64, sector_t, int,
-			      int, struct buffer_head **, sector_t *);
+int nilfs_btnode_submit_block(struct address_space *, __u64, sector_t,
+			      blk_opf_t, struct buffer_head **, sector_t *);
 void nilfs_btnode_delete(struct buffer_head *);
 int nilfs_btnode_prepare_change_key(struct address_space *,
 				    struct nilfs_btnode_chkey_ctxt *);
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index f544c22fff78..9f4d9432d38a 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -477,7 +477,7 @@ static int __nilfs_btree_get_block(const struct nilfs_bmap *btree, __u64 ptr,
 	sector_t submit_ptr = 0;
 	int ret;
 
-	ret = nilfs_btnode_submit_block(btnc, ptr, 0, REQ_OP_READ, 0, &bh,
+	ret = nilfs_btnode_submit_block(btnc, ptr, 0, REQ_OP_READ, &bh,
 					&submit_ptr);
 	if (ret) {
 		if (ret != -EEXIST)
@@ -495,8 +495,8 @@ static int __nilfs_btree_get_block(const struct nilfs_bmap *btree, __u64 ptr,
 			ptr2 = nilfs_btree_node_get_ptr(ra->node, i, ra->ncmax);
 
 			ret = nilfs_btnode_submit_block(btnc, ptr2, 0,
-							REQ_OP_READ, REQ_RAHEAD,
-							&ra_bh, &submit_ptr);
+						REQ_OP_READ | REQ_RAHEAD,
+						&ra_bh, &submit_ptr);
 			if (likely(!ret || ret == -EEXIST))
 				brelse(ra_bh);
 			else if (ret != -EBUSY)
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index 847def8af315..b0d22ff24b67 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -129,9 +129,8 @@ int nilfs_gccache_submit_read_node(struct inode *inode, sector_t pbn,
 	struct inode *btnc_inode = NILFS_I(inode)->i_assoc_inode;
 	int ret;
 
-	ret = nilfs_btnode_submit_block(btnc_inode->i_mapping,
-					vbn ? : pbn, pbn, REQ_OP_READ, 0,
-					out_bh, &pbn);
+	ret = nilfs_btnode_submit_block(btnc_inode->i_mapping, vbn ? : pbn, pbn,
+					REQ_OP_READ, out_bh, &pbn);
 	if (ret == -EEXIST) /* internal code (cache hit) */
 		ret = 0;
 	return ret;
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 66e8811c2528..cbf4fa60eea2 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -111,8 +111,8 @@ static int nilfs_mdt_create_block(struct inode *inode, unsigned long block,
 }
 
 static int
-nilfs_mdt_submit_block(struct inode *inode, unsigned long blkoff,
-		       int mode, int mode_flags, struct buffer_head **out_bh)
+nilfs_mdt_submit_block(struct inode *inode, unsigned long blkoff, blk_opf_t opf,
+		       struct buffer_head **out_bh)
 {
 	struct buffer_head *bh;
 	__u64 blknum = 0;
@@ -126,12 +126,12 @@ nilfs_mdt_submit_block(struct inode *inode, unsigned long blkoff,
 	if (buffer_uptodate(bh))
 		goto out;
 
-	if (mode_flags & REQ_RAHEAD) {
+	if (opf & REQ_RAHEAD) {
 		if (!trylock_buffer(bh)) {
 			ret = -EBUSY;
 			goto failed_bh;
 		}
-	} else /* mode == READ */
+	} else /* opf == REQ_OP_READ */
 		lock_buffer(bh);
 
 	if (buffer_uptodate(bh)) {
@@ -148,10 +148,11 @@ nilfs_mdt_submit_block(struct inode *inode, unsigned long blkoff,
 
 	bh->b_end_io = end_buffer_read_sync;
 	get_bh(bh);
-	submit_bh(mode | mode_flags, bh);
+	submit_bh(opf, bh);
 	ret = 0;
 
-	trace_nilfs2_mdt_submit_block(inode, inode->i_ino, blkoff, mode);
+	trace_nilfs2_mdt_submit_block(inode, inode->i_ino, blkoff,
+				      opf & REQ_OP_MASK);
  out:
 	get_bh(bh);
 	*out_bh = bh;
@@ -172,7 +173,7 @@ static int nilfs_mdt_read_block(struct inode *inode, unsigned long block,
 	int i, nr_ra_blocks = NILFS_MDT_MAX_RA_BLOCKS;
 	int err;
 
-	err = nilfs_mdt_submit_block(inode, block, REQ_OP_READ, 0, &first_bh);
+	err = nilfs_mdt_submit_block(inode, block, REQ_OP_READ, &first_bh);
 	if (err == -EEXIST) /* internal code */
 		goto out;
 
@@ -182,8 +183,8 @@ static int nilfs_mdt_read_block(struct inode *inode, unsigned long block,
 	if (readahead) {
 		blkoff = block + 1;
 		for (i = 0; i < nr_ra_blocks; i++, blkoff++) {
-			err = nilfs_mdt_submit_block(inode, blkoff, REQ_OP_READ,
-						     REQ_RAHEAD, &bh);
+			err = nilfs_mdt_submit_block(inode, blkoff,
+						REQ_OP_READ | REQ_RAHEAD, &bh);
 			if (likely(!err || err == -EEXIST))
 				brelse(bh);
 			else if (err != -EBUSY)
diff --git a/include/trace/events/nilfs2.h b/include/trace/events/nilfs2.h
index 84ee31fc04cc..8efc6236f57c 100644
--- a/include/trace/events/nilfs2.h
+++ b/include/trace/events/nilfs2.h
@@ -192,7 +192,7 @@ TRACE_EVENT(nilfs2_mdt_submit_block,
 	    TP_PROTO(struct inode *inode,
 		     unsigned long ino,
 		     unsigned long blkoff,
-		     int mode),
+		     enum req_op mode),
 
 	    TP_ARGS(inode, ino, blkoff, mode),
 
@@ -200,7 +200,7 @@ TRACE_EVENT(nilfs2_mdt_submit_block,
 		    __field(struct inode *, inode)
 		    __field(unsigned long, ino)
 		    __field(unsigned long, blkoff)
-		    __field(int, mode)
+		    __field(enum req_op, mode)
 	    ),
 
 	    TP_fast_assign(
