Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH] blktrace: display failfast and driver-specific flags
Date: Thu,  7 Jun 2018 10:30:09 +0200
Message-Id: <20180607083009.41793-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 kernel/trace/blktrace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 987d9a9ae283..238e16211a5c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1922,6 +1922,14 @@ void blk_fill_rwbs(char *rwbs, unsigned int op, int bytes)
 		rwbs[i++] = 'S';
 	if (op & REQ_META)
 		rwbs[i++] = 'M';
+	if (op & REQ_FAILFAST_DEV)
+		rwbs[i++] = 'd';
+	if (op & REQ_FAILFAST_TRANSPORT)
+		rwbs[i++] = 't';
+	if (op & REQ_FAILFAST_DRIVER)
+		rwbs[i++] = 'v';
+	if (op & REQ_DRV)
+		rwbs[i++] = 'V';
 
 	rwbs[i] = '\0';
 }
-- 
2.12.3
