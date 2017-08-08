Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 05/49] fs/buffer: comment on direct access to bvec table
Date: Tue,  8 Aug 2017 16:45:04 +0800
Message-Id: <20170808084548.18963-6-ming.lei@redhat.com>
In-Reply-To: <20170808084548.18963-1-ming.lei@redhat.com>
References: <20170808084548.18963-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/buffer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 5715dac7821f..c821ed6a6f0e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3054,8 +3054,13 @@ static void end_bio_bh_io_sync(struct bio *bio)
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
2.9.4
