Return-Path: <prvs=752cffea0=Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Keith Busch <keith.busch@intel.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] block: Remove two superfluous #include directives
Date: Thu,  9 Aug 2018 07:47:28 -0700
Message-Id: <20180809144728.5218-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

Commit 12f5b9314545 ("blk-mq: Remove generation seqeunce") removed the
only seqcount_t and u64_stats_sync instances from <linux/blkdev.h> but
did not remove the corresponding #include directives. Since these
include directives are no longer needed, remove them.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>,
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 include/linux/blkdev.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 050d599f5ea9..d6869e0e2b64 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -27,8 +27,6 @@
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
-#include <linux/seqlock.h>
-#include <linux/u64_stats_sync.h>
 
 struct module;
 struct scsi_ioctl_command;
-- 
2.18.0
