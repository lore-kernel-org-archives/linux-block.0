Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/11] block: add definition for support data write life times
Date: Tue, 13 Jun 2017 11:15:14 -0600
Message-Id: <1497374123-15286-3-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/blk_types.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1940876a7fa7..16c4e657807f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -314,6 +314,19 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+/*
+ * Data life time definitions for writes. These are relative within a
+ * given device, no absolute meaning is attached to them.
+ */
+enum {
+	WRITE_LIFE_UNKNOWN	= 0,
+	WRITE_LIFE_SHORT,
+	WRITE_LIFE_MEDIUM,
+	WRITE_LIFE_LONG,
+	WRITE_LIFE_EXTREME,
+	WRITE_LIFE_NR,
+};
+
 static inline void bio_set_streamid(struct bio *bio, unsigned int stream)
 {
 	bio->bi_stream = stream;
-- 
2.7.4
