Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 19/60] fs/buffer: comment on direct access to bvec table
Date: Sat, 29 Oct 2016 16:08:18 +0800
Message-Id: <1477728600-12938-20-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 fs/buffer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b205a629001d..81c3793948b4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3018,8 +3018,13 @@ static void end_bio_bh_io_sync(struct bio *bio)
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

