Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933888AbdLRMb5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Dec 2017 07:31:57 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 37/45] xfs: conver to bio_for_each_page_all2
Date: Mon, 18 Dec 2017 20:22:39 +0800
Message-Id: <20171218122247.3488-38-ming.lei@redhat.com>
In-Reply-To: <20171218122247.3488-1-ming.lei@redhat.com>
References: <20171218122247.3488-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bio_for_each_page_all() can't be used any more after multipage bvec is
enabled, so we have to convert to bio_for_each_page_all2().

Given bvec can't be changed under bio_for_each_page_all2(), this patch
marks the bvec parameter as 'const' for xfs_finish_page_writeback().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/xfs/xfs_aops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 8c19f7e0fd32..c0d970817cdc 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -107,7 +107,7 @@ xfs_find_daxdev_for_inode(
 static void
 xfs_finish_page_writeback(
 	struct inode		*inode,
-	struct bio_vec		*bvec,
+	const struct bio_vec	*bvec,
 	int			error)
 {
 	struct buffer_head	*head = page_buffers(bvec->bv_page), *bh = head;
@@ -169,6 +169,7 @@ xfs_destroy_ioend(
 	for (bio = &ioend->io_inline_bio; bio; bio = next) {
 		struct bio_vec	*bvec;
 		int		i;
+		struct bvec_iter_all bia;
 
 		/*
 		 * For the last bio, bi_private points to the ioend, so we
@@ -180,7 +181,7 @@ xfs_destroy_ioend(
 			next = bio->bi_private;
 
 		/* walk each page on bio, ending page IO on them */
-		bio_for_each_page_all(bvec, bio, i)
+		bio_for_each_page_all2(bvec, bio, i, bia)
 			xfs_finish_page_writeback(inode, bvec, error);
 
 		bio_put(bio);
-- 
2.9.5
