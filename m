Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751704AbdFZMLj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 08:11:39 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 01/51] block: drbd: comment on direct access bvec table
Date: Mon, 26 Jun 2017 20:09:44 +0800
Message-Id: <20170626121034.3051-2-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/drbd/drbd_bitmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 809fd245c3dc..70890d950dc9 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -953,6 +953,7 @@ static void drbd_bm_endio(struct bio *bio)
 	struct drbd_bm_aio_ctx *ctx = bio->bi_private;
 	struct drbd_device *device = ctx->device;
 	struct drbd_bitmap *b = device->bitmap;
+	/* single page bio, safe for multipage bvec */
 	unsigned int idx = bm_page_to_idx(bio->bi_io_vec[0].bv_page);
 
 	if ((ctx->flags & BM_AIO_COPY_PAGES) == 0 &&
-- 
2.9.4
