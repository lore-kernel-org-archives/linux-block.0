Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Wakko Warner <wakko@animx.eu.org>,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	target-devel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"Nicholas A. Bellinger" <nab@linux-iscsi.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] target: fix crash with iscsi target and dvd
Date: Mon, 16 Apr 2018 17:48:41 +0800
Message-Id: <20180416094841.30212-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

When the current page can't be added to bio, one new bio should be
created for adding this page again, instead of ignoring this page.

This patch fixes kernel crash with iscsi target and dvd, as reported
by Wakko.

Cc: Wakko Warner <wakko@animx.eu.org>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: target-devel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: Christoph Hellwig <hch@lst.de>
Fixes: 84c8590646d5b35804 ("target: avoid accessing .bi_vcnt directly")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/target/target_core_pscsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 0d99b242e82e..6cb933ecc084 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -890,6 +890,7 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 			bytes = min(bytes, data_len);
 
 			if (!bio) {
+new_bio:
 				nr_vecs = min_t(int, BIO_MAX_PAGES, nr_pages);
 				nr_pages -= nr_vecs;
 				/*
@@ -931,6 +932,7 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 				 * be allocated with pscsi_get_bio() above.
 				 */
 				bio = NULL;
+				goto new_bio;
 			}
 
 			data_len -= bytes;
-- 
2.9.5
