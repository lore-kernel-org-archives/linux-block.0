Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15076 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbeG0RnU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jul 2018 13:43:20 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@intel.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/5] block: Remove a superfluous #include directive
Date: Fri, 27 Jul 2018 09:20:39 -0700
Message-Id: <20180727162042.13425-3-bart.vanassche@wdc.com>
In-Reply-To: <20180727162042.13425-1-bart.vanassche@wdc.com>
References: <20180727162042.13425-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

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
index d5d31b7b6ba8..8244a5a1aa5b 100644
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
