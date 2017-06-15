Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/11] block: add helpers for setting/checking write hint validity
Date: Wed, 14 Jun 2017 21:45:06 -0600
Message-Id: <1497498312-17704-6-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We map the RWF_WRITE_* life time flags to the internal flags.
Drivers can then, in turn, map those flags to a suitable stream
type.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c               | 16 ++++++++++++++++
 include/linux/bio.h       |  1 +
 include/linux/blk_types.h |  5 +++++
 3 files changed, 22 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 888e7801c638..8804439945b2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2082,6 +2082,22 @@ void bio_clone_blkcg_association(struct bio *dst, struct bio *src)
 
 #endif /* CONFIG_BLK_CGROUP */
 
+static const unsigned int rwf_write_to_opf_flag[] = {
+	0, REQ_WRITE_SHORT, REQ_WRITE_MEDIUM, REQ_WRITE_LONG, REQ_WRITE_EXTREME
+};
+
+/*
+ * 'stream_flags' is one of RWF_WRITE_LIFE_* values
+ */
+unsigned int bio_op_write_hint(unsigned int rwf_flags)
+{
+	if (WARN_ON_ONCE(rwf_flags >= ARRAY_SIZE(rwf_write_to_opf_flag)))
+		return 0;
+
+	return rwf_write_to_opf_flag[rwf_flags];
+}
+EXPORT_SYMBOL_GPL(bio_op_write_hint);
+
 static void __init biovec_init_slabs(void)
 {
 	int i;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d1b04b0e99cf..debd60d641dd 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -443,6 +443,7 @@ extern struct bio *bio_copy_kern(struct request_queue *, void *, unsigned int,
 				 gfp_t, int);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
+extern unsigned int bio_op_write_hint(unsigned int rwf_flags);
 
 void generic_start_io_acct(int rw, unsigned long sectors,
 			   struct hd_struct *part);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 57d1eb530799..23646eb433e7 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -323,4 +323,9 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+static inline bool op_write_hint_valid(unsigned int opf)
+{
+	return (opf & REQ_WRITE_LIFE_MASK) != 0;
+}
+
 #endif /* __LINUX_BLK_TYPES_H */
-- 
2.7.4
