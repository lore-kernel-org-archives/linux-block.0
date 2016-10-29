Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com (open list:DRBD DRIVER)
Subject: [PATCH 03/60] block: drbd: remove impossible failure handling
Date: Sat, 29 Oct 2016 16:08:02 +0800
Message-Id: <1477728600-12938-4-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

For a non-cloned bio, bio_add_page() only returns failure when
the io vec table is full, but in that case, bio->bi_vcnt can't
be zero at all.

So remove the impossible failure handling.

Acked-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/drbd/drbd_receiver.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 942384f34e22..c537e3bd09eb 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1648,20 +1648,8 @@ int drbd_submit_peer_request(struct drbd_device *device,
 
 	page_chain_for_each(page) {
 		unsigned len = min_t(unsigned, data_size, PAGE_SIZE);
-		if (!bio_add_page(bio, page, len, 0)) {
-			/* A single page must always be possible!
-			 * But in case it fails anyways,
-			 * we deal with it, and complain (below). */
-			if (bio->bi_vcnt == 0) {
-				drbd_err(device,
-					"bio_add_page failed for len=%u, "
-					"bi_vcnt=0 (bi_sector=%llu)\n",
-					len, (uint64_t)bio->bi_iter.bi_sector);
-				err = -ENOSPC;
-				goto fail;
-			}
+		if (!bio_add_page(bio, page, len, 0))
 			goto next_bio;
-		}
 		data_size -= len;
 		sector += len >> 9;
 		--nr_pages;
-- 
2.7.4

