Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32879 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932582AbcL0QHd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:07:33 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
Subject: [PATCH v1 53/54] btrfs: comment on direct access bvec table
Date: Wed, 28 Dec 2016 00:05:02 +0800
Message-Id: <1482854706-14128-22-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
References: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/btrfs/compression.c |  4 ++++
 fs/btrfs/inode.c       | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 485a60923bba..54306dee392a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -601,6 +601,10 @@ int btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 	/* we need the actual starting offset of this extent in the file */
 	read_lock(&em_tree->lock);
+	/*
+	 * It is still safe to retrieve the 1st page of the bio
+	 * in this way after supporting multipage bvec.
+	 */
 	em = lookup_extent_mapping(em_tree,
 				   page_offset(bio->bi_io_vec->bv_page),
 				   PAGE_SIZE);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fa77cb210907..d0714208495f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7914,6 +7914,11 @@ static int dio_read_error(struct inode *inode, struct bio *failed_bio,
 		return -EIO;
 	}
 
+	/*
+	 * In this case it is still correct to retrieve length
+	 * of the 1st bvec of the bio in this way after supporting
+	 * multipage bvec.
+	 */
 	if ((bio_segments_all(failed_bio) > 1)
 		|| (failed_bio->bi_io_vec->bv_len
 			> btrfs_inode_sectorsize(inode)))
@@ -7960,6 +7965,12 @@ static void btrfs_retry_endio_nocsum(struct bio *bio)
 	if (bio->bi_error)
 		goto end;
 
+	/*
+	 * WARNING:
+	 *
+	 * With multipage bvec, the following way of direct access to
+	 * bvec table is only safe if the bio includes single page.
+	 */
 	ASSERT(bio->bi_vcnt == 1);
 	inode = bio->bi_io_vec->bv_page->mapping->host;
 	ASSERT(bio->bi_io_vec->bv_len == btrfs_inode_sectorsize(inode));
@@ -8045,6 +8056,12 @@ static void btrfs_retry_endio(struct bio *bio)
 
 	start = done->start;
 
+	/*
+	 * WARNING:
+	 *
+	 * With multipage bvec, the following way of direct access to
+	 * bvec table is only safe if the bio includes single page.
+	 */
 	ASSERT(bio->bi_vcnt == 1);
 	inode = bio->bi_io_vec->bv_page->mapping->host;
 	ASSERT(bio->bi_io_vec->bv_len == btrfs_inode_sectorsize(inode));
-- 
2.7.4

