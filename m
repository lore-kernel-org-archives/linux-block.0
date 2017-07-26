Return-Path: <dan.j.williams@intel.com>
Subject: [PATCH] brd: fix brd_rw_page() vs copy_to_brd_setup errors
From: Dan Williams <dan.j.williams@intel.com>
To: axboe@fb.com
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Ross Zwisler <ross.zwisler@linux.intel.com>,
 Matthew Wilcox <mawilcox@microsoft.com>
Date: Tue, 25 Jul 2017 18:02:29 -0700
Message-ID: <150103091559.7874.16803761117298861951.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

As is done in zram_rw_page, pmem_rw_page, and btt_rw_page, don't
call page_endio in the error case since do_mpage_readpage and
__mpage_writepage will resubmit on error. Calling page_endio in the
error case leads to double completion.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Noticed this while looking at unrelated brd code...

 drivers/block/brd.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 104b71c0490d..055255ea131d 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -327,7 +327,13 @@ static int brd_rw_page(struct block_device *bdev, sector_t sector,
 {
 	struct brd_device *brd = bdev->bd_disk->private_data;
 	int err = brd_do_bvec(brd, page, PAGE_SIZE, 0, is_write, sector);
-	page_endio(page, is_write, err);
+
+	/*
+	 * In the error case we expect the upper layer to retry, so we
+	 * can't trigger page_endio yet.
+	 */
+	if (err == 0)
+		page_endio(page, is_write, 0);
 	return err;
 }
 
