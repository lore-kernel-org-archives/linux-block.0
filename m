Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 03/25] bdi: Export bdi_alloc_node() and bdi_put()
Date: Wed, 12 Apr 2017 12:24:27 +0200
Message-Id: <20170412102449.16901-4-jack@suse.cz>
In-Reply-To: <20170412102449.16901-1-jack@suse.cz>
References: <20170412102449.16901-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

MTD will want to call bdi_alloc_node() and bdi_put() directly. Export
these functions.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/backing-dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 164ccc93690f..3dd175986390 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -855,6 +855,7 @@ struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id)
 	}
 	return bdi;
 }
+EXPORT_SYMBOL(bdi_alloc_node);
 
 int bdi_register_va(struct backing_dev_info *bdi, struct device *parent,
 		const char *fmt, va_list args)
@@ -971,6 +972,7 @@ void bdi_put(struct backing_dev_info *bdi)
 {
 	kref_put(&bdi->refcnt, release_bdi);
 }
+EXPORT_SYMBOL(bdi_put);
 
 void bdi_destroy(struct backing_dev_info *bdi)
 {
-- 
2.12.0
