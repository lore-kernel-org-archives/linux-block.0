Return-Path: <prvs=590d2a92c=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 10/11] block: Complain if queue_flag_(set|clear)_unlocked() is abused
Date: Wed, 28 Feb 2018 11:28:22 -0800
Message-Id: <20180228192823.5191-11-bart.vanassche@wdc.com>
In-Reply-To: <20180228192823.5191-1-bart.vanassche@wdc.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since it is not safe to use queue_flag_(set|clear)_unlocked()
without holding the queue lock after the sysfs entries for a
queue have been created, complain if this happens.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blkdev.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index eca31d0ef2df..1f3ec9a7fbc7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -726,12 +726,18 @@ static inline void queue_lockdep_assert_held(struct request_queue *q)
 static inline void queue_flag_set_unlocked(unsigned int flag,
 					   struct request_queue *q)
 {
+	if (test_bit(QUEUE_FLAG_INIT_DONE, &q->queue_flags) &&
+	    kref_read(&q->kobj.kref))
+		lockdep_assert_held(q->queue_lock);
 	__set_bit(flag, &q->queue_flags);
 }
 
 static inline void queue_flag_clear_unlocked(unsigned int flag,
 					     struct request_queue *q)
 {
+	if (test_bit(QUEUE_FLAG_INIT_DONE, &q->queue_flags) &&
+	    kref_read(&q->kobj.kref))
+		lockdep_assert_held(q->queue_lock);
 	__clear_bit(flag, &q->queue_flags);
 }
 
-- 
2.16.2
