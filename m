Return-Path: <tom.leiming@gmail.com>
Return-Path: <tom.leiming@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	Mike Christie <mchristi@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH 28/60] block: introduce QUEUE_FLAG_SPLIT_MP
Date: Sat, 29 Oct 2016 16:08:27 +0800
Message-Id: <1477728600-12938-29-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Some drivers(such as dm) should be capable of dealing with multipage
bvec, but the incoming bio may be too big, such as, a new singlepage bvec
bio can't be cloned from the bio, or can't be allocated to singlepage
bvec with same size.

At least crypt dm, log writes and bcache have this kind of issue.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-merge.c      | 4 ++++
 include/linux/blkdev.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2642e5fc8b69..266c94d1d82f 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -79,6 +79,10 @@ static inline unsigned get_max_io_size(struct request_queue *q,
 	/* aligned to logical block size */
 	sectors &= ~(mask >> 9);
 
+	/* some queues can't handle bigger bio even it is ready for mp bvecs */
+	if (blk_queue_split_mp(q) && sectors > BIO_SP_MAX_SECTORS)
+		sectors = BIO_SP_MAX_SECTORS;
+
 	return sectors;
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e4dd25361bd6..7cee0179c9e6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -506,6 +506,7 @@ struct request_queue {
 #define QUEUE_FLAG_FLUSH_NQ    25	/* flush not queueuable */
 #define QUEUE_FLAG_DAX         26	/* device supports DAX */
 #define QUEUE_FLAG_NO_MP       27	/* multipage bvecs isn't ready */
+#define QUEUE_FLAG_SPLIT_MP    28	/* split MP bvecs if too bigger */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
@@ -597,6 +598,7 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
 	(test_bit(QUEUE_FLAG_SECERASE, &(q)->queue_flags))
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
 #define blk_queue_no_mp(q)	test_bit(QUEUE_FLAG_NO_MP, &(q)->queue_flags)
+#define blk_queue_split_mp(q)	test_bit(QUEUE_FLAG_SPLIT_MP, &(q)->queue_flags)
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
-- 
2.7.4
