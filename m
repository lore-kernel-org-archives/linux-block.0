Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 04/60] block: floppy: use bio_add_page()
Date: Sat, 29 Oct 2016 16:08:03 +0800
Message-Id: <1477728600-12938-5-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/floppy.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index cdc916a95137..999099d9509d 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3807,11 +3807,6 @@ static int __floppy_read_block_0(struct block_device *bdev, int drive)
 	cbdata.drive = drive;
 
 	bio_init_with_vec_table(&bio, &bio_vec, 1);
-	bio_vec.bv_page = page;
-	bio_vec.bv_len = size;
-	bio_vec.bv_offset = 0;
-	bio.bi_vcnt = 1;
-	bio.bi_iter.bi_size = size;
 	bio.bi_bdev = bdev;
 	bio.bi_iter.bi_sector = 0;
 	bio.bi_flags |= (1 << BIO_QUIET);
@@ -3819,6 +3814,8 @@ static int __floppy_read_block_0(struct block_device *bdev, int drive)
 	bio.bi_end_io = floppy_rb0_cb;
 	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
 
+	bio_add_page(&bio, page, size, 0);
+
 	submit_bio(&bio);
 	process_fd_request();
 
-- 
2.7.4

