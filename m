Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752477AbeBFQFm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Feb 2018 11:05:42 -0500
From: Jan Kara <jack@suse.cz>
To: <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Hou Tao <houtao1@huawei.com>,
        Eric Biggers <ebiggers3@gmail.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/6] genhd: Fix leaked module reference for NVME devices
Date: Tue,  6 Feb 2018 17:05:24 +0100
Message-Id: <20180206160529.20713-2-jack@suse.cz>
In-Reply-To: <20180206160529.20713-1-jack@suse.cz>
References: <20180206160529.20713-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

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
index 96a66f671720..22f4fc340a3a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -802,7 +802,10 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
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
