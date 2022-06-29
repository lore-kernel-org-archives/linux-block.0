Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A570BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiF2XeG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbiF2Xdq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:46 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BD47644
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:27 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id x8so12168844pgj.13
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uoPiXPJ41RkMIDIBXB/dxmN7DuDhtDvtY8AJfvsQi9A=;
        b=W6eecNvnLq/2TbE/FKsFjsr3hT6W7+EUusnbP+Yp9grZnRHlwSze1Uqr0yb6dv/LQ3
         JR2lHetPp3igZ+fpiOv0zoykGhO0Y0pXUmQqFEe0/I6A7mC8RsKZCJxK62M/QCUNN9j6
         DwTKgNwd483QbIHTHIRqNDb3dULF52e7Hev+fkx2c97dmwEauVFxd1M0F0ySgN8LVJ63
         a9ujbbZEZ38ki59PH8M3j5xVF9HL5KAAN8l0aDfF6D8NOvnt6I5hyriAIcz16dD4Gbnu
         X/Zqx3aJmneYtKLzYJUD4/VnTIASaZTGrsNpfQwV5Vt+GMUbSdMoj/6xyG1lqWb7athK
         OWNA==
X-Gm-Message-State: AJIora+mJCzXqQSazqg1qVsjudamkyDdrzx2Y5j1mNiFxINUFyFeo0rK
        0H8WNdcKl11khvcBdpftYAg=
X-Google-Smtp-Source: AGRyM1vjvQHcgnaO0cHAD+RajmdhZ09z6Zs6LytGvITbCquzZr0GWnl9FRLfgWpOevXnUECWNFP1sw==
X-Received: by 2002:a62:6dc2:0:b0:525:43c8:79f7 with SMTP id i185-20020a626dc2000000b0052543c879f7mr12497502pfc.49.1656545601521;
        Wed, 29 Jun 2022 16:33:21 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:20 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v2 58/63] fs/nilfs2: Use the enum req_op and blk_opf_t types
Date:   Wed, 29 Jun 2022 16:31:40 -0700
Message-Id: <20220629233145.2779494-59-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
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

Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
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
