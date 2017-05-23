Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 23 May 2017 17:28:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jens Axboe <axboe@kernel.dk>, Will Drewry <wad@chromium.org>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] block: fix an error code in add_partition()
Message-ID: <20170523142836.GB28346@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

We don't set an error code on this path.  It means that we return NULL
instead of an error pointer and the caller does a NULL dereference.

Fixes: 6d1d8050b4bc ("block, partition: add partition_meta_info to hd_struct")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/block/partition-generic.c b/block/partition-generic.c
index ff07b9143ca4..c5ec8246e25e 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -320,8 +320,10 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
 
 	if (info) {
 		struct partition_meta_info *pinfo = alloc_part_info(disk);
-		if (!pinfo)
+		if (!pinfo) {
+			err = -ENOMEM;
 			goto out_free_stats;
+		}
 		memcpy(pinfo, info, sizeof(*info));
 		p->info = pinfo;
 	}
