Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33809 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbcL0P7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 10:59:51 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure))
Subject: [PATCH v1 05/54] fs/buffer: comment on direct access to bvec table
Date: Tue, 27 Dec 2016 23:55:54 +0800
Message-Id: <1482854250-13481-6-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/buffer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d21771fcf7d3..63d2f40c21fd 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3060,8 +3060,13 @@ static void end_bio_bh_io_sync(struct bio *bio)
 void guard_bio_eod(int op, struct bio *bio)
 {
 	sector_t maxsector;
-	struct bio_vec *bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
 	unsigned truncated_bytes;
+	/*
+	 * It is safe to truncate the last bvec in the following way
+	 * even though multipage bvec is supported, but we need to
+	 * fix the parameters passed to zero_user().
+	 */
+	struct bio_vec *bvec = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
 	maxsector = i_size_read(bio->bi_bdev->bd_inode) >> 9;
 	if (!maxsector)
-- 
2.7.4

