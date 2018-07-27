Return-Path: <prvs=7391cfe80=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Keith Busch <keith.busch@intel.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 2/5] block: Remove a superfluous #include directive
Date: Fri, 27 Jul 2018 15:56:17 -0700
Message-Id: <20180727225620.17855-3-bart.vanassche@wdc.com>
In-Reply-To: <20180727225620.17855-1-bart.vanassche@wdc.com>
References: <20180727225620.17855-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Commit 12f5b9314545 ("blk-mq: Remove generation seqeunce") removed the
only u64_stats_sync instance from <linux/blkdev.h> but did not remove
the corresponding #include directive. Since the #include directive is
no longer needed, remove it.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blkdev.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8f924fba80b9..9aeda7e982c4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -28,7 +28,6 @@
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
 #include <linux/seqlock.h>
-#include <linux/u64_stats_sync.h>
 
 struct module;
 struct scsi_ioctl_command;
-- 
2.18.0
