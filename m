Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93EDC32792
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 21:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7024D218DE
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 21:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbfI3VJI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:09:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59660 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbfI3VJI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 17:09:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 8F1172608AC
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 1/1] blk-mq: fill header with kernel-doc
Date:   Mon, 30 Sep 2019 16:48:46 -0300
Message-Id: <20190930194846.23141-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Insert documentation for structs, enums and functions at header file.
Format existing and new comments at struct blk_mq_ops as
kernel-doc comments.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Hello,

This patch is an effort to enhance the documentation of the multiqueue
API. To check if the comments are confirming to kernel-doc format, you
first need to apply a patch[1] solving a bug around the `__cacheline...`
directive. Then, just run

./scripts/kernel-doc -none include/linux/blk-mq.h

to check that there is no warning at this documentation. I've done my
best at the source to check the purpose of each struct and its members,
but please let me know if I get something wrong.

[1] https://lkml.org/lkml/2019/9/17/820
---
 include/linux/blk-mq.h | 243 ++++++++++++++++++++++++++++++++---------
 1 file changed, 194 insertions(+), 49 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0bf056de5cc3..d0aab34972b7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -11,12 +11,85 @@ struct blk_flush_queue;
 
 /**
  * struct blk_mq_hw_ctx - State for a hardware queue facing the hardware block device
+ *
+ * @lock:	Lock for accessing dispatch queue
+ * @dispatch:	Queue of dispatched requests, waiting for workers to send them
+ *		to the hardware.
+ * @state:	BLK_MQ_S_* flags. Define the state of the hw queue (active,
+ *		scheduled to restart, stopped).
+ *
+ * @run_work:		Worker for dispatch scheduled requests to hardware.
+ *			BLK_MQ_CPU_WORK_BATCH workers will be assigned to a CPU,
+ *			then the following ones will be assigned to
+ *			the next_cpu.
+ * @cpumask:		Map of available CPUs.
+ * @next_cpu:		Index of CPU/workqueue to be used in the next batch
+ *			of workers.
+ * @next_cpu_batch:	Counter of how many works letf in the batch before
+ *			changing to the next CPU. A batch has the size of
+ *			BLK_MQ_CPU_WORK_BATCH.
+ *
+ * @flags:	BLK_MQ_F_* flags. Define the behaviour of the queue.
+ *
+ * @sched_data: Data to support schedulers.
+ * @queue:	Queue of request to be dispatched.
+ * @fq:		Queue of requests to be flushed from memory to storage.
+ *
+ * @driver_data: Device driver specific queue.
+ *
+ * @ctx_map:	Bitmap for each software queue. If bit is on, there is a
+ *		pending request.
+ *
+ * @dispatch_from: Queue to be used when there is no scheduler was selected.
+ * @dispatch_busy: Number used by blk_mq_update_dispatch_busy() to decide
+ *		   if the hw_queue is busy using Exponential Weighted Moving
+ *		   Average algorithm.
+ *
+ * @type:	HCTX_TYPE_* flags. Type of hardware queue.
+ * @nr_ctx:	Number of software queues.
+ * @ctxs:	Array of software queues.
+ *
+ * @dispatch_wait_lock: Lock for dispatch_wait queue.
+ * @dispatch_wait:	Waitqueue for dispatched requests. Request here will
+ *			be processed when
+ *			percpu_ref_is_zero(&q->q_usage_counter) evaluates true
+ *			for q as a request_queue.
+ * @wait_index:		Index of next wait queue to be used.
+ *
+ * @tags:	Request tags.
+ * @sched_tags:	Request tags for schedulers.
+ *
+ * @queued:	Number of queued requests.
+ * @run:	Number of dispatched requests.
+ * @dispatched:	Number of dispatch requests by queue.
+ *
+ * @numa_node:	NUMA node index of this hardware queue.
+ * @queue_num:	Index of this hardware queue.
+ *
+ * @nr_active:	Number of active tags.
+ *
+ * @cpuhp_dead:	List to store request if some CPU die.
+ * @kobj:	Kernel object for sysfs.
+ *
+ * @poll_considered:	Count times blk_poll() was called.
+ * @poll_invoked:	Count how many requests blk_poll() polled.
+ * @poll_success:	Count how many polled requests were completed.
+ *
+ * @debugfs_dir:	debugfs directory for this hardware queue. Named
+ *			as cpu<cpu_number>.
+ * @sched_debugfs_dir:	debugfs directory for the scheduler.
+ *
+ * @hctx_list:		List of all hardware queues.
+ *
+ * @srcu:	Sleepable RCU. Use as lock when type of the hardware queue is
+ *		blocking (BLK_MQ_F_BLOCKING). Must be the last member - see
+ *		also blk_mq_hw_ctx_size().
  */
 struct blk_mq_hw_ctx {
 	struct {
 		spinlock_t		lock;
 		struct list_head	dispatch;
-		unsigned long		state;		/* BLK_MQ_S_* flags */
+		unsigned long		state;
 	} ____cacheline_aligned_in_smp;
 
 	struct delayed_work	run_work;
@@ -24,7 +97,7 @@ struct blk_mq_hw_ctx {
 	int			next_cpu;
 	int			next_cpu_batch;
 
-	unsigned long		flags;		/* BLK_MQ_F_* flags */
+	unsigned long		flags;
 
 	void			*sched_data;
 	struct request_queue	*queue;
@@ -72,41 +145,73 @@ struct blk_mq_hw_ctx {
 
 	struct list_head	hctx_list;
 
-	/* Must be the last member - see also blk_mq_hw_ctx_size(). */
 	struct srcu_struct	srcu[0];
 };
 
+/**
+ * struct blk_mq_queue_map - Map software queues to hardware queues
+ * @mq_map:		Array mapping sw queues to hw queues.
+ *			For a given sw queue index, works like this:
+ *			``mq_map[sw_idx] = hw_idx``
+ * @nr_queues:		Number of hardware queues.
+ * @queue_offset:	Memory offset of this struct, relative to the address
+ *			of struct blk_mq_tag_set.
+ */
 struct blk_mq_queue_map {
 	unsigned int *mq_map;
 	unsigned int nr_queues;
 	unsigned int queue_offset;
 };
 
+/**
+ * enum hctx_type - Type of hardware queue
+ * @HCTX_TYPE_DEFAULT:	All I/O not otherwise accounted for.
+ * @HCTX_TYPE_READ:	Just for READ I/O.
+ * @HCTX_TYPE_POLL:	Polled I/O of any kind.
+ * @HCTX_MAX_TYPES:	Number of types of hctx.
+ */
 enum hctx_type {
-	HCTX_TYPE_DEFAULT,	/* all I/O not otherwise accounted for */
-	HCTX_TYPE_READ,		/* just for READ I/O */
-	HCTX_TYPE_POLL,		/* polled I/O of any kind */
+	HCTX_TYPE_DEFAULT,
+	HCTX_TYPE_READ,
+	HCTX_TYPE_POLL,
 
 	HCTX_MAX_TYPES,
 };
 
+/**
+ * struct blk_mq_tag_set - desc
+ * @map:	Map[] holds ctx -> hctx mappings, one map exists for each type
+ *		that the driver wishes to support. There are no restrictions on
+ *		maps being of the same size, and it's perfectly legal to share
+ *		maps between types.
+ * @nr_maps:	Number of entries in map[].
+ * @ops:	Callback functions for blk-mq operations.
+ * @nr_hw_queues: Number of hardware queues across maps.
+ * @queue_depth:  Max number of tags supported by a queue.
+ * @reserved_tags: Number of reserved tags.
+ * @cmd_size:	Per-request extra data.
+ * @numa_node:	NUMA node index of this tag set.
+ * @timeout:	Time to a request expire.
+ * @flags:	BLK_MQ_F_* flags. Define the behaviour of the queue.
+ *
+ * @driver_data: Device driver specific data.
+ *
+ * @tags:	Array of tags for hardware queues.
+ *
+ * @tag_list_lock: Lock for tag_list.
+ * @tag_list:      List of struct request_queues.
+ */
 struct blk_mq_tag_set {
-	/*
-	 * map[] holds ctx -> hctx mappings, one map exists for each type
-	 * that the driver wishes to support. There are no restrictions
-	 * on maps being of the same size, and it's perfectly legal to
-	 * share maps between types.
-	 */
 	struct blk_mq_queue_map	map[HCTX_MAX_TYPES];
-	unsigned int		nr_maps;	/* nr entries in map[] */
+	unsigned int		nr_maps;
 	const struct blk_mq_ops	*ops;
-	unsigned int		nr_hw_queues;	/* nr hw queues across maps */
-	unsigned int		queue_depth;	/* max hw supported */
+	unsigned int		nr_hw_queues;
+	unsigned int		queue_depth;
 	unsigned int		reserved_tags;
-	unsigned int		cmd_size;	/* per-request extra data */
+	unsigned int		cmd_size;
 	int			numa_node;
 	unsigned int		timeout;
-	unsigned int		flags;		/* BLK_MQ_F_* */
+	unsigned int		flags;
 	void			*driver_data;
 
 	struct blk_mq_tags	**tags;
@@ -115,6 +220,12 @@ struct blk_mq_tag_set {
 	struct list_head	tag_list;
 };
 
+/**
+ * struct blk_mq_queue_data - Data about a request inserted in a queue
+ *
+ * @rq:   Data about the block IO request.
+ * @last: If it is the last request in the queue.
+ */
 struct blk_mq_queue_data {
 	struct request *rq;
 	bool last;
@@ -142,81 +253,100 @@ typedef bool (busy_fn)(struct request_queue *);
 typedef void (complete_fn)(struct request *);
 typedef void (cleanup_rq_fn)(struct request *);
 
-
+/**
+ * struct blk_mq_ops - list of callback functions for blk-mq drivers
+ */
 struct blk_mq_ops {
-	/*
-	 * Queue request
+	/**
+	 * @queue_rq: Queue a new request from block IO.
 	 */
 	queue_rq_fn		*queue_rq;
 
-	/*
-	 * If a driver uses bd->last to judge when to submit requests to
-	 * hardware, it must define this function. In case of errors that
-	 * make us stop issuing further requests, this hook serves the
+	/**
+	 * @commit_rqs: If a driver uses bd->last to judge when to submit
+	 * requests to hardware, it must define this function. In case of errors
+	 * that make us stop issuing further requests, this hook serves the
 	 * purpose of kicking the hardware (which the last request otherwise
 	 * would have done).
 	 */
 	commit_rqs_fn		*commit_rqs;
 
-	/*
-	 * Reserve budget before queue request, once .queue_rq is
+	/**
+	 * @get_budget: Reserve budget before queue request, once .queue_rq is
 	 * run, it is driver's responsibility to release the
 	 * reserved budget. Also we have to handle failure case
 	 * of .get_budget for avoiding I/O deadlock.
 	 */
 	get_budget_fn		*get_budget;
+	/**
+	 * @put_budget: Release the reserved budget.
+	 */
 	put_budget_fn		*put_budget;
 
-	/*
-	 * Called on request timeout
+	/**
+	 * @timeout: Called on request timeout.
 	 */
 	timeout_fn		*timeout;
 
-	/*
-	 * Called to poll for completion of a specific tag.
+	/**
+	 * @poll: Called to poll for completion of a specific tag.
 	 */
 	poll_fn			*poll;
 
+	/**
+	 * @complete: Mark the request as complete.
+	 */
 	complete_fn		*complete;
 
-	/*
-	 * Called when the block layer side of a hardware queue has been
-	 * set up, allowing the driver to allocate/init matching structures.
-	 * Ditto for exit/teardown.
+	/**
+	 * @init_hctx: Called when the block layer side of a hardware queue has
+	 * been set up, allowing the driver to allocate/init matching
+	 * structures.
 	 */
 	init_hctx_fn		*init_hctx;
+	/**
+	 * @exit_hctx: Ditto for exit/teardown.
+	 */
 	exit_hctx_fn		*exit_hctx;
 
-	/*
-	 * Called for every command allocated by the block layer to allow
-	 * the driver to set up driver specific data.
+	/**
+	 * @init_request: Called for every command allocated by the block layer
+	 * to allow the driver to set up driver specific data.
 	 *
 	 * Tag greater than or equal to queue_depth is for setting up
 	 * flush request.
-	 *
-	 * Ditto for exit/teardown.
 	 */
 	init_request_fn		*init_request;
+	/**
+	 * @exit_request: Ditto for exit/teardown.
+	 */
 	exit_request_fn		*exit_request;
-	/* Called from inside blk_get_request() */
+
+	/**
+	 * @initialize_rq_fn: Called from inside blk_get_request().
+	 */
 	void (*initialize_rq_fn)(struct request *rq);
 
-	/*
-	 * Called before freeing one request which isn't completed yet,
-	 * and usually for freeing the driver private data
+	/**
+	 * @cleanup_rq: Called before freeing one request which isn't completed
+	 * yet, and usually for freeing the driver private data.
 	 */
 	cleanup_rq_fn		*cleanup_rq;
 
-	/*
-	 * If set, returns whether or not this queue currently is busy
+	/**
+	 * @busy: If set, returns whether or not this queue currently is busy.
 	 */
 	busy_fn			*busy;
 
+	/**
+	 * @map_queues: This allows drivers specify their own queue mapping by
+	 * overriding the setup-time function that builds the mq_map.
+	 */
 	map_queues_fn		*map_queues;
 
 #ifdef CONFIG_BLK_DEBUG_FS
-	/*
-	 * Used by the debugfs implementation to show driver-specific
+	/**
+	 * @show_rq: Used by the debugfs implementation to show driver-specific
 	 * information about a request.
 	 */
 	void (*show_rq)(struct seq_file *m, struct request *rq);
@@ -343,14 +473,29 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
 
-/*
+/**
+ * blk_mq_rq_from_pdu - cast a PDU to a request
+ * @pdu: the PDU (protocol unit request) to be casted
+ *
+ * Return: request
+ *
  * Driver command data is immediately after the request. So subtract request
- * size to get back to the original request, add request size to get the PDU.
+ * size to get back to the original request.
  */
 static inline struct request *blk_mq_rq_from_pdu(void *pdu)
 {
 	return pdu - sizeof(struct request);
 }
+
+/**
+ * blk_mq_rq_to_pdu - cast a request to a PDU
+ * @rq: the request to be casted
+ *
+ * Return: pointer to the PDU
+ *
+ * Driver command data is immediately after the request. So add request to get
+ * the PDU.
+ */
 static inline void *blk_mq_rq_to_pdu(struct request *rq)
 {
 	return rq + 1;
-- 
2.23.0

