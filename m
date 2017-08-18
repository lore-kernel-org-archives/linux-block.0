Return-Path: <prvs=396ff485d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2] blk-mq-debugfs: Add names for recently added flags
Date: Fri, 18 Aug 2017 15:52:54 -0700
Message-Id: <20170818225254.30706-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The symbolic constants QUEUE_FLAG_SCSI_PASSTHROUGH, QUEUE_FLAG_QUIESCED
and REQ_NOWAIT are missing from blk-mq-debugfs.c. Add these to
blk-mq-debugfs.c such that these appear as names in debugfs instead of
as numbers.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---

v2: changed "PASSTHROUGH" into "SCSI_PASSTHROUGH".

 block/blk-mq-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index e53b6129ca5a..980e73095643 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -73,6 +73,8 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(STATS),
 	QUEUE_FLAG_NAME(POLL_STATS),
 	QUEUE_FLAG_NAME(REGISTERED),
+	QUEUE_FLAG_NAME(SCSI_PASSTHROUGH),
+	QUEUE_FLAG_NAME(QUIESCED),
 };
 #undef QUEUE_FLAG_NAME
 
@@ -263,6 +265,7 @@ static const char *const cmd_flag_name[] = {
 	CMD_FLAG_NAME(RAHEAD),
 	CMD_FLAG_NAME(BACKGROUND),
 	CMD_FLAG_NAME(NOUNMAP),
+	CMD_FLAG_NAME(NOWAIT),
 };
 #undef CMD_FLAG_NAME
 
-- 
2.14.0
