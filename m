Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/6] genhd: Fix leaked module reference for NVME devices
Date: Mon, 26 Feb 2018 13:01:37 +0100
Message-Id: <20180226120142.25786-2-jack@suse.cz>
In-Reply-To: <20180226120142.25786-1-jack@suse.cz>
References: <20180226120142.25786-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Commit 8ddcd653257c "block: introduce GENHD_FL_HIDDEN" added handling of
hidden devices to get_gendisk() but forgot to drop module reference
which is also acquired by get_disk(). Drop the reference as necessary.

Arguably the function naming here is misleading as put_disk() is *not*
the counterpart of get_disk() but let's fix that in the follow up
commit since that will be more intrusive.

Fixes: 8ddcd653257c18a669fcb75ee42c37054908e0d6
CC: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/genhd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 88a53c188cb7..5098bffe6ba6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -817,7 +817,10 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 	}
 
 	if (disk && unlikely(disk->flags & GENHD_FL_HIDDEN)) {
+		struct module *owner = disk->fops->owner;
+
 		put_disk(disk);
+		module_put(owner);
 		disk = NULL;
 	}
 	return disk;
-- 
2.13.6
