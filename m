Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44920 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753193AbdFREk4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2017 00:40:56 -0400
From: NeilBrown <neilb@suse.com>
To: Jens Axboe <axboe@fb.com>
Date: Sun, 18 Jun 2017 14:38:59 +1000
Subject: [PATCH 11/13] bcache: use kmalloc to allocate bio in
 bch_data_verify()
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <149776073913.23258.16726702836366837284.stgit@noble>
In-Reply-To: <149776047907.23258.8058071140236879834.stgit@noble>
References: <149776047907.23258.8058071140236879834.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This function allocates a bio, then a collection
of pages.  It copes with failure.

It currently uses a mempool() to allocate the bio,
but alloc_page() to allocate the pages.  These fail
in different ways, so the usage is inconsistent.

Change the bio_clone() to bio_clone_kmalloc()
so that no pool is used either for the bio or the pages.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by : Ming Lei <ming.lei@redhat.com>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/md/bcache/debug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 06f55056aaae..35a5a7210e51 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -110,7 +110,7 @@ void bch_data_verify(struct cached_dev *dc, struct bio *bio)
 	struct bio_vec bv, cbv;
 	struct bvec_iter iter, citer = { 0 };
 
-	check = bio_clone(bio, GFP_NOIO);
+	check = bio_clone_kmalloc(bio, GFP_NOIO);
 	if (!check)
 		return;
 	check->bi_opf = REQ_OP_READ;
