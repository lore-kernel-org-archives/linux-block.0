Return-Path: <prvs=590d2a92c=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Omar Sandoval <osandov@fb.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 2/2] blk-mq-debugfs: Show zone locking information
Date: Tue, 27 Feb 2018 16:32:14 -0800
Message-Id: <20180228003214.3194-3-bart.vanassche@wdc.com>
In-Reply-To: <20180228003214.3194-1-bart.vanassche@wdc.com>
References: <20180228003214.3194-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

When debugging the ZBC code in the mq-deadline scheduler it is very
important to know which zones are locked and which zones are not
locked. Hence this patch that exports the zone locking information
through debugfs.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq-debugfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index eaf282e239b0..1be2116e09b5 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -206,11 +206,27 @@ static ssize_t queue_write_hint_store(void *data, const char __user *buf,
 	return count;
 }
 
+static int queue_zone_wlock_show(void *data, struct seq_file *m)
+{
+	struct request_queue *q = data;
+	unsigned int i;
+
+	if (!q->seq_zones_wlock)
+		return 0;
+
+	for (i = 0; i < blk_queue_nr_zones(q); i++)
+		if (test_bit(i, q->seq_zones_wlock))
+			seq_printf(m, "%u\n", i);
+
+	return 0;
+}
+
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
 	{ "poll_stat", 0400, queue_poll_stat_show },
 	{ "requeue_list", 0400, .seq_ops = &queue_requeue_list_seq_ops },
 	{ "state", 0600, queue_state_show, queue_state_write },
 	{ "write_hints", 0600, queue_write_hint_show, queue_write_hint_store },
+	{ "zone_wlock", 0400, queue_zone_wlock_show, NULL },
 	{ },
 };
 
-- 
2.16.2
