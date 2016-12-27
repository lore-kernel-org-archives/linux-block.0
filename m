Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32952 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753020AbcL0P7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 10:59:51 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Christie <mchristi@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Damien Le Moal <damien.lemoal@hgst.com>
Subject: [PATCH v1 10/54] block: introduce flag QUEUE_FLAG_NO_MP
Date: Tue, 27 Dec 2016 23:55:59 +0800
Message-Id: <1482854250-13481-11-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

MD(especially raid1 and raid10) is a bit difficult to support
multipage bvec, so introduce this flag for not enabling multipage
bvec, then MD can still accept singlepage bvec only, and once
direct access to bvec table in MD are cleanuped, the flag can be
removed.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 include/linux/blkdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 83695641bd5e..0c02d9778965 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -600,6 +600,7 @@ struct request_queue {
 #define QUEUE_FLAG_FLUSH_NQ    25	/* flush not queueuable */
 #define QUEUE_FLAG_DAX         26	/* device supports DAX */
 #define QUEUE_FLAG_STATS       27	/* track rq completion times */
+#define QUEUE_FLAG_NO_MP       28	/* multipage bvecs isn't ready */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
@@ -690,6 +691,7 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
 #define blk_queue_secure_erase(q) \
 	(test_bit(QUEUE_FLAG_SECERASE, &(q)->queue_flags))
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
+#define blk_queue_no_mp(q)	test_bit(QUEUE_FLAG_NO_MP, &(q)->queue_flags)
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
-- 
2.7.4

