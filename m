Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>,
	Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>
Subject: [PATCH V2 09/22] block, cfq: replace CFQ with the BFQ-v0 I/O scheduler
Date: Mon,  8 Aug 2016 13:15:04 +0200
Message-Id: <1470654917-4280-10-git-send-email-paolo.valente@linaro.org>
In-Reply-To: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
References: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This commit internally replaces CFQ with BFQ, leaving the field
elevator_name unchanged (i.e., the scheduler still advertises itself
as CFQ). More precisely, this commit replaces the engine of CFQ, i.e.,
what remains after the previous feature-stripping commits, with the
engine of BFQ.

We tag as v0 the version of BFQ containing only BFQ's engine plus
hierarchical support. BFQ's engine is introduced by this commit, while
hierarchical support is added by next commit. We use the v0 tag to
distinguish this minimal version of BFQ from the versions containing
also the features and the improvements added by next commits. BFQ-v0
coincides with the version of BFQ submitted a few years ago [1], apart
from the introduction of preemption, described below.

BFQ is a proportional-share I/O scheduler, whose general structure,
plus a lot of code, are borrowed from CFQ.

- Each process doing I/O on a device is associated with a weight and a
  (bfq_)queue.

- BFQ grants exclusive access to the device, for a while, to one queue
  (process) at a time, and implements this service model by
  associating every queue with a budget, measured in number of
  sectors.

  - After a queue is granted access to the device, the budget of the
    queue is decremented, on each request dispatch, by the size of the
    request.

  - The in-service queue is expired, i.e., its service is suspended,
    only if one of the following events occurs: 1) the queue finishes
    its budget, 2) the queue empties, 3) a "budget timeout" fires.

    - The budget timeout prevents processes doing random I/O from
      holding the device for too long and dramatically reducing
      throughput.

    - Actually, as in CFQ, a queue associated with a process issuing
      sync requests may not be expired immediately when it empties. In
      contrast, BFQ may idle the device for a short time interval,
      giving the process the chance to go on being served if it issues
      a new request in time. Device idling typically boosts the
      throughput on rotational devices, if processes do synchronous
      and sequential I/O. In addition, under BFQ, device idling is
      also instrumental in guaranteeing the desired throughput
      fraction to processes issuing sync requests (see [2] for
      details).

      - With respect to idling for service guarantees, if several
        processes are competing for the device at the same time, but
        all processes (and groups, after the following commit) have
        the same weight, then BFQ guarantees the expected throughput
        distribution without ever idling the device. Throughput is
        thus as high as possible in this common scenario.

  - Queues are scheduled according to a variant of WF2Q+, named
    B-WF2Q+, and implemented using an augmented rb-tree to preserve an
    O(log N) overall complexity.  See [2] for more details. B-WF2Q+ is
    also ready for hierarchical scheduling. However, for a cleaner
    logical breakdown, the code that enables and completes
    hierarchical support is provided in the next commit, which focuses
    exactly on this feature.

  - B-WF2Q+ guarantees a tight deviation with respect to an ideal,
    perfectly fair, and smooth service. In particular, B-WF2Q+
    guarantees that each queue receives a fraction of the device
    throughput proportional to its weight, even if the throughput
    fluctuates, and regardless of: the device parameters, the current
    workload and the budgets assigned to the queue.

  - The last, budget-independence, property (although probably
    counterintuitive in the first place) is definitely beneficial, for
    the following reasons:

    - First, with any proportional-share scheduler, the maximum
      deviation with respect to an ideal service is proportional to
      the maximum budget (slice) assigned to queues. As a consequence,
      BFQ can keep this deviation tight not only because of the
      accurate service of B-WF2Q+, but also because BFQ *does not*
      need to assign a larger budget to a queue to let the queue
      receive a higher fraction of the device throughput.

    - Second, BFQ is free to choose, for every process (queue), the
      budget that best fits the needs of the process, or best
      leverages the I/O pattern of the process. In particular, BFQ
      updates queue budgets with a simple feedback-loop algorithm that
      allows a high throughput to be achieved, while still providing
      tight latency guarantees to time-sensitive applications. When
      the in-service queue expires, this algorithm computes the next
      budget of the queue so as to:

      - Let large budgets be eventually assigned to the queues
        associated with I/O-bound applications performing sequential
        I/O: in fact, the longer these applications are served once
        got access to the device, the higher the throughput is.

      - Let small budgets be eventually assigned to the queues
        associated with time-sensitive applications (which typically
        perform sporadic and short I/O), because, the smaller the
        budget assigned to a queue waiting for service is, the sooner
        B-WF2Q+ will serve that queue (Subsec 3.3 in [2]).

- Weights can be assigned to processes only indirectly, through I/O
  priorities, and according to the relation: weight = IOPRIO_BE_NR -
  ioprio. The next patch provides, instead, a cgroups interface
  through which weights can be assigned explicitly.

- ioprio classes are served in strict priority order, i.e.,
  lower-priority queues are not served as long as there are
  higher-priority queues.  Among queues in the same class, the
  bandwidth is distributed in proportion to the weight of each
  queue. A very thin extra bandwidth is however guaranteed to the Idle
  class, to prevent it from starving.

[1] https://lkml.org/lkml/2008/4/1/234
    https://lkml.org/lkml/2008/11/11/148

[2] P. Valente and M. Andreolini, "Improving Application
    Responsiveness with the BFQ Disk I/O Scheduler", Proceedings of
    the 5th Annual International Systems and Storage Conference
    (SYSTOR '12), June 2012.
    Slightly extended version:
    http://algogroup.unimore.it/people/paolo/disk_sched/bfq-v1-suite-
							results.pdf

Signed-off-by: Fabio Checconi <fchecconi@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
---
 block/Kconfig.iosched |    8 +-
 block/cfq-iosched.c   | 4827 ++++++++++++++++++++++++++++++++-----------------
 2 files changed, 3168 insertions(+), 1667 deletions(-)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 8bd1051..92a8475 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -25,10 +25,10 @@ config IOSCHED_CFQ
 	tristate "CFQ I/O scheduler"
 	default y
 	---help---
-	  The CFQ I/O scheduler tries to distribute bandwidth equally
-	  among all processes in the system. It should provide a fair
-	  and low latency working environment, suitable for both desktop
-	  and server systems.
+	  The CFQ I/O scheduler, now internally replaced by BFQ, tries
+	  to distribute bandwidth among all processes according to
+	  their weights, regardless of the device parameters and with
+	  any workload.
 
 	  This is the default I/O scheduler.
 
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 69c7c75..56aec20 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -1,10 +1,61 @@
 /*
- *  CFQ, or complete fairness queueing, disk scheduler.
+ * Budget Fair Queueing (BFQ) I/O scheduler, which has replaced the
+ * CFQ I/O scheduler.
  *
- *  Based on ideas from a previously unfinished io
- *  scheduler (round robin per-process disk scheduling) and Andrea Arcangeli.
+ * Based on ideas and code from CFQ:
+ * Copyright (C) 2003 Jens Axboe <axboe@kernel.dk>
  *
- *  Copyright (C) 2003 Jens Axboe <axboe@kernel.dk>
+ * Copyright (C) 2008 Fabio Checconi <fabio@gandalf.sssup.it>
+ *		      Paolo Valente <paolo.valente@unimore.it>
+ *
+ * Copyright (C) 2010 Paolo Valente <paolo.valente@unimore.it>
+ *                    Arianna Avanzini <avanzini@google.com>
+ *
+ * Copyright (C) 2016 Paolo Valente <paolo.valente@linaro.org>
+ *
+ * Licensed under GPL-2.
+ *
+ * BFQ [1] is a proportional-share storage-I/O scheduling algorithm
+ * based, as CFQ, on a slice-by-slice service scheme. Yet, differently
+ * from CFQ, BFQ does not assign a time slice to each process doing
+ * I/O. Instead, BFQ assigns a budget, measured in number of sectors:
+ * once selected for service, a process is granted access to the
+ * device until it exhausts its assigned budget. This change from the
+ * time to the service domain enables BFQ to distribute the device
+ * throughput among processes as desired, without any distortion due
+ * to throughput fluctuations, or to device internal queueing.
+ *
+ * More precisely, BFQ associates an I/O-request queue with each process
+ * doing I/O, and uses an accurate internal scheduler, called B-WF2Q+,
+ * to schedule queues according to process budgets. Each process/queue
+ * is also assigned a user-configurable weight, and B-WF2Q+ guarantees
+ * that each queue receives a fraction of the throughput proportional
+ * to its weight. In addition, B-WF2Q+ enables BFQ to schedule queues
+ * in such a way to boost the throughput and at the same time
+ * guarantee a low latency to non-I/O bound processes (the latter
+ * often belong to time-sensitive applications).
+ *
+ * B-WF2Q+ is based on WF2Q+, which is described in [2], while the
+ * augmented tree used here to implement B-WF2Q+ with O(log N)
+ * complexity derives from the one introduced with EEVDF in [3].
+ *
+ * [1] P. Valente, A. Avanzini, "Evolution of the BFQ Storage I/O
+ *     Scheduler", Proceedings of the First Workshop on Mobile System
+ *     Technologies (MST-2015), May 2015.
+ *
+ * http://algogroup.unimore.it/people/paolo/disk_sched/mst-2015.pdf
+ *
+ * [2] Jon C.R. Bennett and H. Zhang, "Hierarchical Packet Fair Queueing
+ *     Algorithms", IEEE/ACM Transactions on Networking, 5(5):675-689,
+ *     Oct 1997.
+ *
+ * http://www.cs.cmu.edu/~hzhang/papers/TON-97-Oct.ps.gz
+ *
+ * [3] I. Stoica and H. Abdel-Wahab, "Earliest Eligible Virtual Deadline
+ *     First: A Flexible and Accurate Mechanism for Proportional Share
+ *     Resource Allocation", technical report.
+ *
+ * http://www.cs.berkeley.edu/~istoica/papers/eevdf-tr-95.pdf
  */
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -13,464 +64,1617 @@
 #include <linux/ktime.h>
 #include <linux/rbtree.h>
 #include <linux/ioprio.h>
-#include <linux/blktrace_api.h>
 #include "blk.h"
+#include <linux/blktrace_api.h>
+#include <linux/hrtimer.h>
+#include <linux/ioprio.h>
+#include <linux/blk-cgroup.h>
 
-/*
- * tunables
- */
-/* max queue in one round of service */
-static const int cfq_quantum = 8;
-static const u64 cfq_fifo_expire[2] = { NSEC_PER_SEC / 4, NSEC_PER_SEC / 8 };
-/* maximum backwards seek, in KiB */
-static const int cfq_back_max = 16 * 1024;
-/* penalty of a backwards seek */
-static const int cfq_back_penalty = 2;
-static const u64 cfq_slice_sync = NSEC_PER_SEC / 10;
-static u64 cfq_slice_async = NSEC_PER_SEC / 25;
-static const int cfq_slice_async_rq = 2;
-static u64 cfq_slice_idle = NSEC_PER_SEC / 125;
-static const int cfq_hist_divisor = 4;
+#define BFQ_IOPRIO_CLASSES	3
+#define BFQ_CL_IDLE_TIMEOUT	(HZ/5)
 
-/*
- * offset from end of service tree
+#define BFQ_MIN_WEIGHT			1
+#define BFQ_MAX_WEIGHT			1000
+#define BFQ_WEIGHT_CONVERSION_COEFF	10
+
+#define BFQ_DEFAULT_QUEUE_IOPRIO	4
+
+#define BFQ_DEFAULT_GRP_WEIGHT	10
+#define BFQ_DEFAULT_GRP_IOPRIO	0
+#define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
+
+struct bfq_entity;
+
+/**
+ * struct bfq_service_tree - per ioprio_class service tree.
+ *
+ * Each service tree represents a B-WF2Q+ scheduler on its own.  Each
+ * ioprio_class has its own independent scheduler, and so its own
+ * bfq_service_tree.  All the fields are protected by the queue lock
+ * of the containing bfqd.
  */
-#define CFQ_IDLE_DELAY		(NSEC_PER_SEC / 5)
+struct bfq_service_tree {
+	/* tree for active entities (i.e., those backlogged) */
+	struct rb_root active;
+	/* tree for idle entities (i.e., not backlogged, with V <= F_i)*/
+	struct rb_root idle;
+
+	struct bfq_entity *first_idle;	/* idle entity with minimum F_i */
+	struct bfq_entity *last_idle;	/* idle entity with maximum F_i */
+
+	u64 vtime; /* scheduler virtual time */
+	/* scheduler weight sum; active and idle entities contribute to it */
+	unsigned long wsum;
+};
 
-/*
- * below this threshold, we consider thinktime immediate
+/**
+ * struct bfq_sched_data - multi-class scheduler.
+ *
+ * bfq_sched_data is the basic scheduler queue.  It supports three
+ * ioprio_classes, and can be used either as a toplevel queue or as
+ * an intermediate queue on a hierarchical setup.
+ * @next_in_service points to the active entity of the sched_data
+ * service trees that will be scheduled next.
+ *
+ * The supported ioprio_classes are the same as in CFQ, in descending
+ * priority order, IOPRIO_CLASS_RT, IOPRIO_CLASS_BE, IOPRIO_CLASS_IDLE.
+ * Requests from higher priority queues are served before all the
+ * requests from lower priority queues; among requests of the same
+ * queue requests are served according to B-WF2Q+.
+ * All the fields are protected by the queue lock of the containing bfqd.
+ */
+struct bfq_sched_data {
+	struct bfq_entity *in_service_entity;  /* entity in service */
+	/* head-of-the-line entity in the scheduler */
+	struct bfq_entity *next_in_service;
+	/* array of service trees, one per ioprio_class */
+	struct bfq_service_tree service_tree[BFQ_IOPRIO_CLASSES];
+};
+
+/**
+ * struct bfq_entity - schedulable entity.
+ *
+ * A bfq_entity is used to represent a bfq_queue (leaf node in the upper
+ * level scheduler). Each entity belongs to the sched_data of the parent
+ * group hierarchy. Non-leaf entities have also their own sched_data,
+ * stored in @my_sched_data.
+ *
+ * Each entity stores independently its priority values; this would
+ * allow different weights on different devices, but this
+ * functionality is not exported to userspace by now.  Priorities and
+ * weights are updated lazily, first storing the new values into the
+ * new_* fields, then setting the @prio_changed flag.  As soon as
+ * there is a transition in the entity state that allows the priority
+ * update to take place the effective and the requested priority
+ * values are synchronized.
+ *
+ * The weight value is calculated from the ioprio to export the same
+ * interface as CFQ.  When dealing with  ``well-behaved'' queues (i.e.,
+ * queues that do not spend too much time to consume their budget
+ * and have true sequential behavior, and when there are no external
+ * factors breaking anticipation) the relative weights at each level
+ * of the hierarchy should be guaranteed.  All the fields are
+ * protected by the queue lock of the containing bfqd.
  */
-#define CFQ_MIN_TT		(2 * NSEC_PER_SEC / HZ)
+struct bfq_entity {
+	struct rb_node rb_node; /* service_tree member */
+
+	/*
+	 * flag, true if the entity is on a tree (either the active or
+	 * the idle one of its service_tree).
+	 */
+	int on_st;
 
-#define CFQ_SLICE_SCALE		(5)
-#define CFQ_HW_QUEUE_MIN	(5)
-#define CFQ_SERVICE_SHIFT       12
+	u64 finish; /* B-WF2Q+ finish timestamp (aka F_i) */
+	u64 start;  /* B-WF2Q+ start timestamp (aka S_i) */
 
-#define CFQQ_SEEK_THR		(sector_t)(8 * 100)
-#define CFQQ_CLOSE_THR		(sector_t)(8 * 1024)
-#define CFQQ_SEEKY(cfqq)	(hweight32(cfqq->seek_history) > 32/8)
+	/* tree the entity is enqueued into; %NULL if not on a tree */
+	struct rb_root *tree;
 
-#define RQ_CIC(rq)		icq_to_cic((rq)->elv.icq)
-#define RQ_CFQQ(rq)		(struct cfq_queue *) ((rq)->elv.priv[0])
+	/*
+	 * minimum start time of the (active) subtree rooted at this
+	 * entity; used for O(log N) lookups into active trees
+	 */
+	u64 min_start;
 
-static struct kmem_cache *cfq_pool;
+	/* amount of service received during the last service slot */
+	int service;
 
-#define CFQ_PRIO_LISTS		IOPRIO_BE_NR
-#define cfq_class_idle(cfqq)	((cfqq)->ioprio_class == IOPRIO_CLASS_IDLE)
-#define cfq_class_rt(cfqq)	((cfqq)->ioprio_class == IOPRIO_CLASS_RT)
+	/* budget, used also to calculate F_i: F_i = S_i + @budget / @weight */
+	int budget;
 
-#define sample_valid(samples)	((samples) > 80)
+	unsigned short weight;	/* weight of the queue */
+	unsigned short new_weight; /* next weight if a change is in progress */
 
-struct cfq_ttime {
-	u64 last_end_request;
+	/* original weight, used to implement weight boosting */
+	unsigned short orig_weight;
 
-	u64 ttime_total;
-	u64 ttime_mean;
-	unsigned long ttime_samples;
-};
+	/* parent entity, for hierarchical scheduling */
+	struct bfq_entity *parent;
 
-/*
- * Most of our rbtree usage is for sorting with min extraction, so
- * if we cache the leftmost node we don't have to walk down the tree
- * to find it. Idea borrowed from Ingo Molnars CFS scheduler. We should
- * move this into the elevator for the rq sorting as well.
- */
-struct cfq_rb_root {
-	struct rb_root rb;
-	struct rb_node *left;
-	unsigned count;
-	u64 min_vdisktime;
-	struct cfq_ttime ttime;
+	/*
+	 * For non-leaf nodes in the hierarchy, the associated
+	 * scheduler queue, %NULL on leaf nodes.
+	 */
+	struct bfq_sched_data *my_sched_data;
+	/* the scheduler queue this entity belongs to */
+	struct bfq_sched_data *sched_data;
+
+	/* flag, set to request a weight, ioprio or ioprio_class change  */
+	int prio_changed;
 };
-#define CFQ_RB_ROOT	(struct cfq_rb_root) { .rb = RB_ROOT, \
-			.ttime = {.last_end_request = ktime_get_ns(),},}
 
-/*
- * Per process-grouping structure
+/**
+ * struct bfq_queue - leaf schedulable entity.
+ *
+ * A bfq_queue is a leaf request queue; it can be associated with an
+ * io_context or more, if it is async.
  */
-struct cfq_queue {
-	/* reference count */
+struct bfq_queue {
+	/* reference counter */
 	int ref;
-	/* various state flags, see below */
-	unsigned int flags;
-	/* parent cfq_data */
-	struct cfq_data *cfqd;
-	/* service_tree member */
-	struct rb_node rb_node;
-	/* service_tree key */
-	u64 rb_key;
-	/* prio tree member */
-	struct rb_node p_node;
-	/* prio tree root we belong to, if any */
-	struct rb_root *p_root;
+	/* parent bfq_data */
+	struct bfq_data *bfqd;
+
+	/* current ioprio and ioprio class */
+	unsigned short ioprio, ioprio_class;
+	/* next ioprio and ioprio class if a change is in progress */
+	unsigned short new_ioprio, new_ioprio_class;
+
 	/* sorted list of pending requests */
 	struct rb_root sort_list;
 	/* if fifo isn't expired, next request to serve */
 	struct request *next_rq;
-	/* requests queued in sort_list */
+	/* number of sync and async requests queued */
 	int queued[2];
-	/* currently allocated requests */
+	/* number of sync and async requests currently allocated */
 	int allocated[2];
+	/* number of pending metadata requests */
+	int meta_pending;
 	/* fifo list of requests in sort_list */
 	struct list_head fifo;
 
-	/* time when queue got scheduled in to dispatch first request. */
-	u64 dispatch_start;
-	u64 allocated_slice;
-	u64 slice_dispatch;
-	/* time when first request from queue completed and slice started. */
-	u64 slice_start;
-	u64 slice_end;
-	s64 slice_resid;
-
-	/* pending priority requests */
-	int prio_pending;
-	/* number of requests that are on the dispatch list or inside driver */
+	/* entity representing this queue in the scheduler */
+	struct bfq_entity entity;
+
+	/* maximum budget allowed from the feedback mechanism */
+	int max_budget;
+	/* budget expiration (in jiffies) */
+	unsigned long budget_timeout;
+
+	/* number of requests on the dispatch list or inside driver */
 	int dispatched;
 
-	/* io prio of this group */
-	unsigned short ioprio, org_ioprio;
-	unsigned short ioprio_class, org_ioprio_class;
+	unsigned int flags; /* status flags.*/
 
-	pid_t pid;
+	/* node for active/idle bfqq list inside parent bfqd */
+	struct list_head bfqq_list;
 
+	/* bit vector: a 1 for each seeky requests in history */
 	u32 seek_history;
+	/* position of the last request enqueued */
 	sector_t last_request_pos;
 
-	struct cfq_rb_root *service_tree;
-	struct cfq_queue *new_cfqq;
-	/* Number of sectors dispatched from queue in single dispatch round */
-	unsigned long nr_sectors;
+	/* Number of consecutive pairs of request completion and
+	 * arrival, such that the queue becomes idle after the
+	 * completion, but the next request arrives within an idle
+	 * time slice; used only if the queue's IO_bound flag has been
+	 * cleared.
+	 */
+	unsigned int requests_within_timer;
+
+	/* pid of the process owning the queue, used for logging purposes */
+	pid_t pid;
 };
 
-/*
- * First index in the service_trees.
- * IDLE is handled separately, so it has negative index
- */
-enum wl_class_t {
-	BE_WORKLOAD = 0,
-	RT_WORKLOAD = 1,
-	IDLE_WORKLOAD = 2,
-	CFQ_PRIO_NR,
+/**
+ * struct bfq_ttime - per process thinktime stats.
+ */
+struct bfq_ttime {
+	u64 last_end_request; /* completion time of last request */
+
+	u64 ttime_total; /* total process thinktime */
+	unsigned long ttime_samples; /* number of thinktime samples */
+	u64 ttime_mean; /* average process thinktime */
+
 };
 
-struct cfq_io_cq {
-	struct io_cq		icq;		/* must be the first member */
-	struct cfq_queue	*cfqq[2];
-	struct cfq_ttime	ttime;
-	int			ioprio;		/* the current ioprio */
+/**
+ * struct bfq_io_cq - per (request_queue, io_context) structure.
+ */
+struct bfq_io_cq {
+	/* associated io_cq structure */
+	struct io_cq icq; /* must be the first member */
+	/* array of two process queues, the sync and the async */
+	struct bfq_queue *bfqq[2];
+	/* associated @bfq_ttime struct */
+	struct bfq_ttime ttime;
+	/* per (request_queue, blkcg) ioprio */
+	int ioprio;
 };
 
-/*
- * Per block device queue structure
+enum bfq_device_speed {
+	BFQ_BFQD_FAST,
+	BFQ_BFQD_SLOW,
+};
+
+/**
+ * struct bfq_data - per-device data structure.
+ *
+ * All the fields are protected by the @queue lock.
  */
-struct cfq_data {
+struct bfq_data {
+	/* request queue for the device */
 	struct request_queue *queue;
 
-	/*
-	 * rr lists of queues with requests. We maintain service trees for
-	 * RT and BE classes.
-	 * Counts are embedded in the cfq_rb_root
-	 */
-	struct cfq_rb_root service_trees[2];
-	struct cfq_rb_root service_tree_idle;
+	/* root @bfq_sched_data for the device */
+	struct bfq_sched_data sched_data;
 
 	/*
-	 * The priority currently being served
+	 * Number of bfq_queues containing requests (including the
+	 * queue in service, even if it is idling).
 	 */
-	enum wl_class_t serving_wl_class;
-	u64 workload_expires;
-
-	unsigned int busy_queues;
-	unsigned int busy_sync_queues;
-
+	int busy_queues;
+	/* number of queued requests */
+	int queued;
+	/* number of requests dispatched and waiting for completion */
 	int rq_in_driver;
-	int rq_in_flight[2];
 
 	/*
-	 * queue-depth detection
+	 * Maximum number of requests in driver in the last
+	 * @hw_tag_samples completed requests.
 	 */
-	int rq_queued;
+	int max_rq_in_driver;
+	/* number of samples used to calculate hw_tag */
+	int hw_tag_samples;
+	/* flag set to one if the driver is showing a queueing behavior */
 	int hw_tag;
-	/*
-	 * hw_tag can be
-	 * -1 => indeterminate, (cfq will behave as if NCQ is present, to allow better detection)
-	 *  1 => NCQ is present (hw_tag_est_depth is the estimated max depth)
-	 *  0 => no NCQ
-	 */
-	int hw_tag_est_depth;
-	unsigned int hw_tag_samples;
+
+	/* number of budgets assigned */
+	int budgets_assigned;
 
 	/*
-	 * idle window management
+	 * Timer set when idling (waiting) for the next request from
+	 * the queue in service.
 	 */
 	struct hrtimer idle_slice_timer;
+	/* delayed work to restart dispatching on the request queue */
 	struct work_struct unplug_work;
 
-	struct cfq_queue *active_queue;
-	struct cfq_io_cq *active_cic;
-
-	/* async queue for each priority case */
-	struct cfq_queue *async_cfqq[2][IOPRIO_BE_NR];
-	struct cfq_queue *async_idle_cfqq;
+	/* bfq_queue in service */
+	struct bfq_queue *in_service_queue;
+	/* bfq_io_cq (bic) associated with the @in_service_queue */
+	struct bfq_io_cq *in_service_bic;
 
+	/* on-disk position of the last served request */
 	sector_t last_position;
 
+	/* beginning of the last budget */
+	ktime_t last_budget_start;
+	/* beginning of the last idle slice */
+	ktime_t last_idling_start;
+	/* number of samples used to calculate @peak_rate */
+	int peak_rate_samples;
+	/* peak transfer rate observed for a budget */
+	u64 peak_rate;
+	/* maximum budget allotted to a bfq_queue before rescheduling */
+	int bfq_max_budget;
+
+	/* list of all the bfq_queues active on the device */
+	struct list_head active_list;
+	/* list of all the bfq_queues idle on the device */
+	struct list_head idle_list;
+
 	/*
-	 * tunables, see top of file
+	 * Timeout for async/sync requests; when it fires, requests
+	 * are served in fifo order.
 	 */
-	unsigned int cfq_quantum;
-	unsigned int cfq_back_penalty;
-	unsigned int cfq_back_max;
-	unsigned int cfq_slice_async_rq;
-	u64 cfq_fifo_expire[2];
-	u64 cfq_slice[2];
-	u64 cfq_slice_idle;
+	unsigned int bfq_fifo_expire[2];
+	/* weight of backward seeks wrt forward ones */
+	unsigned int bfq_back_penalty;
+	/* maximum allowed backward seek */
+	unsigned int bfq_back_max;
+	/* maximum idling time */
+	u64 bfq_slice_idle;
+	/* last time CLASS_IDLE was served */
+	u64 bfq_class_idle_last_service;
+
+	/* user-configured max budget value (0 for auto-tuning) */
+	int bfq_user_max_budget;
+	/*
+	 * Timeout for bfq_queues to consume their budget; used to
+	 * prevent seeky queues from imposing long latencies to
+	 * sequential or quasi-sequential ones (this also implies that
+	 * seeky queues cannot receive guarantees in the service
+	 * domain; after a timeout they are charged for the time they
+	 * have been in service, to preserve fairness among them, but
+	 * without service-domain guarantees).
+	 */
+	unsigned int bfq_timeout;
+
+	/*
+	 * Number of consecutive requests that must be issued within
+	 * the idle time slice to set again idling to a queue which
+	 * was marked as non-I/O-bound (see the definition of the
+	 * IO_bound flag for further details).
+	 */
+	unsigned int bfq_requests_within_timer;
 
 	/*
-	 * Fallback dummy cfqq for extreme OOM conditions
+	 * Force device idling whenever needed to provide accurate
+	 * service guarantees, without caring about throughput
+	 * issues. CAVEAT: this may even increase latencies, in case
+	 * of useless idling for processes that did stop doing I/O.
 	 */
-	struct cfq_queue oom_cfqq;
+	bool strict_guarantees;
 
-	u64 last_delayed_sync;
+	/* fallback dummy bfqq for extreme OOM conditions */
+	struct bfq_queue oom_bfqq;
 };
 
-enum cfqq_state_flags {
-	CFQ_CFQQ_FLAG_on_rr = 0,	/* on round-robin busy list */
-	CFQ_CFQQ_FLAG_wait_request,	/* waiting for a request */
-	CFQ_CFQQ_FLAG_must_dispatch,	/* must be allowed a dispatch */
-	CFQ_CFQQ_FLAG_must_alloc_slice,	/* per-slice must_alloc flag */
-	CFQ_CFQQ_FLAG_fifo_expire,	/* FIFO checked in this slice */
-	CFQ_CFQQ_FLAG_idle_window,	/* slice idling enabled */
-	CFQ_CFQQ_FLAG_prio_changed,	/* task priority has changed */
-	CFQ_CFQQ_FLAG_slice_new,	/* no requests dispatched in slice */
-	CFQ_CFQQ_FLAG_sync,		/* synchronous queue */
-	CFQ_CFQQ_FLAG_wait_busy,	/* Waiting for next request */
+enum bfqq_state_flags {
+	BFQ_BFQQ_FLAG_busy = 0,		/* has requests or is in service */
+	BFQ_BFQQ_FLAG_wait_request,	/* waiting for a request */
+	BFQ_BFQQ_FLAG_non_blocking_wait_rq, /*
+					     * waiting for a request
+					     * without idling the device
+					     */
+	BFQ_BFQQ_FLAG_must_alloc,	/* must be allowed rq alloc */
+	BFQ_BFQQ_FLAG_fifo_expire,	/* FIFO checked in this slice */
+	BFQ_BFQQ_FLAG_idle_window,	/* slice idling enabled */
+	BFQ_BFQQ_FLAG_sync,		/* synchronous queue */
+	BFQ_BFQQ_FLAG_budget_new,	/* no completion with this budget */
+	BFQ_BFQQ_FLAG_IO_bound,		/*
+					 * bfqq has timed-out at least once
+					 * having consumed at most 2/10 of
+					 * its budget
+					 */
 };
 
-#define CFQ_CFQQ_FNS(name)						\
-static inline void cfq_mark_cfqq_##name(struct cfq_queue *cfqq)		\
+#define BFQ_BFQQ_FNS(name)						\
+static void bfq_mark_bfqq_##name(struct bfq_queue *bfqq)		\
 {									\
-	(cfqq)->flags |= (1 << CFQ_CFQQ_FLAG_##name);			\
+	(bfqq)->flags |= (1 << BFQ_BFQQ_FLAG_##name);			\
 }									\
-static inline void cfq_clear_cfqq_##name(struct cfq_queue *cfqq)	\
+static void bfq_clear_bfqq_##name(struct bfq_queue *bfqq)		\
 {									\
-	(cfqq)->flags &= ~(1 << CFQ_CFQQ_FLAG_##name);			\
+	(bfqq)->flags &= ~(1 << BFQ_BFQQ_FLAG_##name);			\
 }									\
-static inline int cfq_cfqq_##name(const struct cfq_queue *cfqq)		\
+static int bfq_bfqq_##name(const struct bfq_queue *bfqq)		\
 {									\
-	return ((cfqq)->flags & (1 << CFQ_CFQQ_FLAG_##name)) != 0;	\
-}
-
-CFQ_CFQQ_FNS(on_rr);
-CFQ_CFQQ_FNS(wait_request);
-CFQ_CFQQ_FNS(must_dispatch);
-CFQ_CFQQ_FNS(must_alloc_slice);
-CFQ_CFQQ_FNS(fifo_expire);
-CFQ_CFQQ_FNS(idle_window);
-CFQ_CFQQ_FNS(prio_changed);
-CFQ_CFQQ_FNS(slice_new);
-CFQ_CFQQ_FNS(sync);
-CFQ_CFQQ_FNS(wait_busy);
-#undef CFQ_CFQQ_FNS
-
-#define cfq_log_cfqq(cfqd, cfqq, fmt, args...)	\
-	blk_add_trace_msg((cfqd)->queue, "cfq%d%c " fmt, (cfqq)->pid,	\
-			cfq_cfqq_sync((cfqq)) ? 'S' : 'A',		\
-				##args)
-
-#define cfq_log(cfqd, fmt, args...)	\
-	blk_add_trace_msg((cfqd)->queue, "cfq " fmt, ##args)
-
-/* Traverses through cfq service trees */
-#define for_each_st(cfqd, i, j, st) \
-	for (i = 0; i <= IDLE_WORKLOAD; i++) \
-		for (j = 0, st = i < IDLE_WORKLOAD ? &cfqd->service_trees[i]\
-			: &cfqd->service_tree_idle; \
-			(i < IDLE_WORKLOAD) || \
-			(i == IDLE_WORKLOAD); \
-			st = i < IDLE_WORKLOAD ? \
-			&cfqd->service_trees[i] : NULL) \
-
-static inline bool cfq_io_thinktime_big(struct cfq_data *cfqd,
-	struct cfq_ttime *ttime)
-{
-	u64 slice;
-	if (!sample_valid(ttime->ttime_samples))
-		return false;
-	slice = cfqd->cfq_slice_idle;
-	return ttime->ttime_mean > slice;
+	return ((bfqq)->flags & (1 << BFQ_BFQQ_FLAG_##name)) != 0;	\
+}
+
+BFQ_BFQQ_FNS(busy);
+BFQ_BFQQ_FNS(wait_request);
+BFQ_BFQQ_FNS(non_blocking_wait_rq);
+BFQ_BFQQ_FNS(must_alloc);
+BFQ_BFQQ_FNS(fifo_expire);
+BFQ_BFQQ_FNS(idle_window);
+BFQ_BFQQ_FNS(sync);
+BFQ_BFQQ_FNS(budget_new);
+BFQ_BFQQ_FNS(IO_bound);
+#undef BFQ_BFQQ_FNS
+
+/* Logging facilities. */
+#define bfq_log_bfqq(bfqd, bfqq, fmt, args...) \
+	blk_add_trace_msg((bfqd)->queue, "bfq%d " fmt, (bfqq)->pid, ##args)
+
+#define bfq_log(bfqd, fmt, args...) \
+	blk_add_trace_msg((bfqd)->queue, "bfq " fmt, ##args)
+
+/* Expiration reasons. */
+enum bfqq_expiration {
+	BFQ_BFQQ_TOO_IDLE = 0,		/*
+					 * queue has been idling for
+					 * too long
+					 */
+	BFQ_BFQQ_BUDGET_TIMEOUT,	/* budget took too long to be used */
+	BFQ_BFQQ_BUDGET_EXHAUSTED,	/* budget consumed */
+	BFQ_BFQQ_NO_MORE_REQUESTS,	/* the queue has no more requests */
+	BFQ_BFQQ_PREEMPTED		/* preemption in progress */
+};
+
+static struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
+
+static struct bfq_service_tree *
+bfq_entity_service_tree(struct bfq_entity *entity)
+{
+	struct bfq_sched_data *sched_data = entity->sched_data;
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+	unsigned int idx = bfqq ? bfqq->ioprio_class - 1 :
+				  BFQ_DEFAULT_GRP_CLASS - 1;
+
+	return sched_data->service_tree + idx;
+}
+
+static struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync)
+{
+	return bic->bfqq[is_sync];
 }
 
-static inline enum wl_class_t cfqq_class(struct cfq_queue *cfqq)
+static void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq,
+			 bool is_sync)
 {
-	if (cfq_class_idle(cfqq))
-		return IDLE_WORKLOAD;
-	if (cfq_class_rt(cfqq))
-		return RT_WORKLOAD;
-	return BE_WORKLOAD;
+	bic->bfqq[is_sync] = bfqq;
 }
 
-static void cfq_dispatch_insert(struct request_queue *, struct request *);
-static struct cfq_queue *cfq_get_queue(struct cfq_data *cfqd, bool is_sync,
-				       struct cfq_io_cq *cic, struct bio *bio);
+static struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic)
+{
+	return bic->icq.q->elevator->elevator_data;
+}
+
+static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio);
+static void bfq_put_queue(struct bfq_queue *bfqq);
+static void bfq_dispatch_insert(struct request_queue *q, struct request *rq);
+static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
+				       struct bio *bio, bool is_sync,
+				       struct bfq_io_cq *bic);
+static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq);
+
+/*
+ * Array of async queues for all the processes, one queue
+ * per ioprio value per ioprio_class.
+ */
+struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
+/* Async queue for the idle class (ioprio is ignored) */
+struct bfq_queue *async_idle_bfqq;
+
+/* Expiration time of sync (0) and async (1) requests, in ns. */
+static const u64 bfq_fifo_expire[2] = { NSEC_PER_SEC / 4, NSEC_PER_SEC / 8 };
+
+/* Maximum backwards seek, in KiB. */
+static const int bfq_back_max = 16 * 1024;
+
+/* Penalty of a backwards seek, in number of sectors. */
+static const int bfq_back_penalty = 2;
 
-static inline struct cfq_io_cq *icq_to_cic(struct io_cq *icq)
+/* Idling period duration, in ns. */
+static u64 bfq_slice_idle = NSEC_PER_SEC / 125;
+
+/* Minimum number of assigned budgets for which stats are safe to compute. */
+static const int bfq_stats_min_budgets = 194;
+
+/* Default maximum budget values, in sectors and number of requests. */
+static const int bfq_default_max_budget = 16 * 1024;
+
+/* Default timeout values, in jiffies, approximating CFQ defaults. */
+static const int bfq_timeout = HZ / 8;
+
+struct kmem_cache *bfq_pool;
+
+/* Below this threshold (in ms), we consider thinktime immediate. */
+#define BFQ_MIN_TT		(2 * NSEC_PER_MSEC)
+
+/* hw_tag detection: parallel requests threshold and min samples needed. */
+#define BFQ_HW_QUEUE_THRESHOLD	4
+#define BFQ_HW_QUEUE_SAMPLES	32
+
+#define BFQQ_SEEK_THR		(sector_t)(8 * 100)
+#define BFQQ_SEEKY(bfqq)	(hweight32(bfqq->seek_history) > 32/8)
+
+/* Budget feedback step. */
+#define BFQ_BUDGET_STEP         128
+
+/* Min samples used for peak rate estimation (for autotuning). */
+#define BFQ_PEAK_RATE_SAMPLES	32
+
+/* Shift used for peak rate fixed precision calculations. */
+#define BFQ_RATE_SHIFT		16
+
+#define BFQ_SERVICE_TREE_INIT	((struct bfq_service_tree)		\
+				{ RB_ROOT, RB_ROOT, NULL, NULL, 0, 0 })
+
+#define RQ_BIC(rq)		((struct bfq_io_cq *) (rq)->elv.priv[0])
+#define RQ_BFQQ(rq)		((rq)->elv.priv[1])
+
+static void bfq_schedule_dispatch(struct bfq_data *bfqd);
+
+/**
+ * icq_to_bic - convert iocontext queue structure to bfq_io_cq.
+ * @icq: the iocontext queue.
+ */
+static struct bfq_io_cq *icq_to_bic(struct io_cq *icq)
 {
-	/* cic->icq is the first member, %NULL will convert to %NULL */
-	return container_of(icq, struct cfq_io_cq, icq);
+	/* bic->icq is the first member, %NULL will convert to %NULL */
+	return container_of(icq, struct bfq_io_cq, icq);
 }
 
-static inline struct cfq_io_cq *cfq_cic_lookup(struct cfq_data *cfqd,
-					       struct io_context *ioc)
+/**
+ * bfq_bic_lookup - search into @ioc a bic associated to @bfqd.
+ * @bfqd: the lookup key.
+ * @ioc: the io_context of the process doing I/O.
+ *
+ * Queue lock must be held.
+ */
+static struct bfq_io_cq *bfq_bic_lookup(struct bfq_data *bfqd,
+					struct io_context *ioc)
 {
 	if (ioc)
-		return icq_to_cic(ioc_lookup_icq(ioc, cfqd->queue));
+		return icq_to_bic(ioc_lookup_icq(ioc, bfqd->queue));
 	return NULL;
 }
 
-static inline struct cfq_queue *cic_to_cfqq(struct cfq_io_cq *cic, bool is_sync)
+#define for_each_entity(entity)	\
+	for (; entity ; entity = NULL)
+
+#define for_each_entity_safe(entity, parent) \
+	for (parent = NULL; entity ; entity = parent)
+
+static int bfq_update_next_in_service(struct bfq_sched_data *sd)
 {
-	return cic->cfqq[is_sync];
+	return 0;
 }
 
-static inline void cic_set_cfqq(struct cfq_io_cq *cic, struct cfq_queue *cfqq,
-				bool is_sync)
+static void bfq_check_next_in_service(struct bfq_sched_data *sd,
+				      struct bfq_entity *entity)
 {
-	cic->cfqq[is_sync] = cfqq;
 }
 
-static inline struct cfq_data *cic_to_cfqd(struct cfq_io_cq *cic)
+static void bfq_update_budget(struct bfq_entity *next_in_service)
 {
-	return cic->icq.q->elevator->elevator_data;
 }
 
 /*
- * We regard a request as SYNC, if it's either a read or has the SYNC bit
- * set (in which case it could also be direct WRITE).
+ * Shift for timestamp calculations.  This actually limits the maximum
+ * service allowed in one timestamp delta (small shift values increase it),
+ * the maximum total weight that can be used for the queues in the system
+ * (big shift values increase it), and the period of virtual time
+ * wraparounds.
  */
-static inline bool cfq_bio_sync(struct bio *bio)
+#define WFQ_SERVICE_SHIFT	22
+
+/**
+ * bfq_gt - compare two timestamps.
+ * @a: first ts.
+ * @b: second ts.
+ *
+ * Return @a > @b, dealing with wrapping correctly.
+ */
+static int bfq_gt(u64 a, u64 b)
 {
-	return bio_data_dir(bio) == READ || (bio->bi_opf & REQ_SYNC);
+	return (s64)(a - b) > 0;
 }
 
-/*
- * scheduler run of queue, if there are requests pending and no one in the
- * driver that will restart queueing
+static struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = NULL;
+
+	if (!entity->my_sched_data)
+		bfqq = container_of(entity, struct bfq_queue, entity);
+
+	return bfqq;
+}
+
+
+/**
+ * bfq_delta - map service into the virtual time domain.
+ * @service: amount of service.
+ * @weight: scale factor (weight of an entity or weight sum).
+ */
+static u64 bfq_delta(unsigned long service, unsigned long weight)
+{
+	u64 d = (u64)service << WFQ_SERVICE_SHIFT;
+
+	do_div(d, weight);
+	return d;
+}
+
+/**
+ * bfq_calc_finish - assign the finish time to an entity.
+ * @entity: the entity to act upon.
+ * @service: the service to be charged to the entity.
+ */
+static void bfq_calc_finish(struct bfq_entity *entity, unsigned long service)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+
+	entity->finish = entity->start +
+		bfq_delta(service, entity->weight);
+
+	if (bfqq) {
+		bfq_log_bfqq(bfqq->bfqd, bfqq,
+			"calc_finish: serv %lu, w %d",
+			service, entity->weight);
+		bfq_log_bfqq(bfqq->bfqd, bfqq,
+			"calc_finish: start %llu, finish %llu, delta %llu",
+			entity->start, entity->finish,
+			bfq_delta(service, entity->weight));
+	}
+}
+
+/**
+ * bfq_entity_of - get an entity from a node.
+ * @node: the node field of the entity.
+ *
+ * Convert a node pointer to the relative entity.  This is used only
+ * to simplify the logic of some functions and not as the generic
+ * conversion mechanism because, e.g., in the tree walking functions,
+ * the check for a %NULL value would be redundant.
+ */
+static struct bfq_entity *bfq_entity_of(struct rb_node *node)
+{
+	struct bfq_entity *entity = NULL;
+
+	if (node)
+		entity = rb_entry(node, struct bfq_entity, rb_node);
+
+	return entity;
+}
+
+/**
+ * bfq_extract - remove an entity from a tree.
+ * @root: the tree root.
+ * @entity: the entity to remove.
+ */
+static void bfq_extract(struct rb_root *root, struct bfq_entity *entity)
+{
+	entity->tree = NULL;
+	rb_erase(&entity->rb_node, root);
+}
+
+/**
+ * bfq_idle_extract - extract an entity from the idle tree.
+ * @st: the service tree of the owning @entity.
+ * @entity: the entity being removed.
+ */
+static void bfq_idle_extract(struct bfq_service_tree *st,
+			     struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+	struct rb_node *next;
+
+	if (entity == st->first_idle) {
+		next = rb_next(&entity->rb_node);
+		st->first_idle = bfq_entity_of(next);
+	}
+
+	if (entity == st->last_idle) {
+		next = rb_prev(&entity->rb_node);
+		st->last_idle = bfq_entity_of(next);
+	}
+
+	bfq_extract(&st->idle, entity);
+
+	if (bfqq)
+		list_del(&bfqq->bfqq_list);
+}
+
+/**
+ * bfq_insert - generic tree insertion.
+ * @root: tree root.
+ * @entity: entity to insert.
+ *
+ * This is used for the idle and the active tree, since they are both
+ * ordered by finish time.
+ */
+static void bfq_insert(struct rb_root *root, struct bfq_entity *entity)
+{
+	struct bfq_entity *entry;
+	struct rb_node **node = &root->rb_node;
+	struct rb_node *parent = NULL;
+
+	while (*node) {
+		parent = *node;
+		entry = rb_entry(parent, struct bfq_entity, rb_node);
+
+		if (bfq_gt(entry->finish, entity->finish))
+			node = &parent->rb_left;
+		else
+			node = &parent->rb_right;
+	}
+
+	rb_link_node(&entity->rb_node, parent, node);
+	rb_insert_color(&entity->rb_node, root);
+
+	entity->tree = root;
+}
+
+/**
+ * bfq_update_min - update the min_start field of a entity.
+ * @entity: the entity to update.
+ * @node: one of its children.
+ *
+ * This function is called when @entity may store an invalid value for
+ * min_start due to updates to the active tree.  The function  assumes
+ * that the subtree rooted at @node (which may be its left or its right
+ * child) has a valid min_start value.
+ */
+static void bfq_update_min(struct bfq_entity *entity, struct rb_node *node)
+{
+	struct bfq_entity *child;
+
+	if (node) {
+		child = rb_entry(node, struct bfq_entity, rb_node);
+		if (bfq_gt(entity->min_start, child->min_start))
+			entity->min_start = child->min_start;
+	}
+}
+
+/**
+ * bfq_update_active_node - recalculate min_start.
+ * @node: the node to update.
+ *
+ * @node may have changed position or one of its children may have moved,
+ * this function updates its min_start value.  The left and right subtrees
+ * are assumed to hold a correct min_start value.
+ */
+static void bfq_update_active_node(struct rb_node *node)
+{
+	struct bfq_entity *entity = rb_entry(node, struct bfq_entity, rb_node);
+
+	entity->min_start = entity->start;
+	bfq_update_min(entity, node->rb_right);
+	bfq_update_min(entity, node->rb_left);
+}
+
+/**
+ * bfq_update_active_tree - update min_start for the whole active tree.
+ * @node: the starting node.
+ *
+ * @node must be the deepest modified node after an update.  This function
+ * updates its min_start using the values held by its children, assuming
+ * that they did not change, and then updates all the nodes that may have
+ * changed in the path to the root.  The only nodes that may have changed
+ * are the ones in the path or their siblings.
+ */
+static void bfq_update_active_tree(struct rb_node *node)
+{
+	struct rb_node *parent;
+
+up:
+	bfq_update_active_node(node);
+
+	parent = rb_parent(node);
+	if (!parent)
+		return;
+
+	if (node == parent->rb_left && parent->rb_right)
+		bfq_update_active_node(parent->rb_right);
+	else if (parent->rb_left)
+		bfq_update_active_node(parent->rb_left);
+
+	node = parent;
+	goto up;
+}
+
+/**
+ * bfq_active_insert - insert an entity in the active tree of its
+ *                     group/device.
+ * @st: the service tree of the entity.
+ * @entity: the entity being inserted.
+ *
+ * The active tree is ordered by finish time, but an extra key is kept
+ * per each node, containing the minimum value for the start times of
+ * its children (and the node itself), so it's possible to search for
+ * the eligible node with the lowest finish time in logarithmic time.
+ */
+static void bfq_active_insert(struct bfq_service_tree *st,
+			      struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+	struct rb_node *node = &entity->rb_node;
+
+	bfq_insert(&st->active, entity);
+
+	if (node->rb_left)
+		node = node->rb_left;
+	else if (node->rb_right)
+		node = node->rb_right;
+
+	bfq_update_active_tree(node);
+
+	if (bfqq)
+		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
+}
+
+/**
+ * bfq_ioprio_to_weight - calc a weight from an ioprio.
+ * @ioprio: the ioprio value to convert.
+ */
+static unsigned short bfq_ioprio_to_weight(int ioprio)
+{
+	return (IOPRIO_BE_NR - ioprio) * BFQ_WEIGHT_CONVERSION_COEFF;
+}
+
+/**
+ * bfq_weight_to_ioprio - calc an ioprio from a weight.
+ * @weight: the weight value to convert.
+ *
+ * To preserve as much as possible the old only-ioprio user interface,
+ * 0 is used as an escape ioprio value for weights (numerically) equal or
+ * larger than IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF.
+ */
+static unsigned short bfq_weight_to_ioprio(int weight)
+{
+	return IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight < 0 ?
+		0 : IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight;
+}
+
+static void bfq_get_entity(struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+
+	if (bfqq) {
+		bfqq->ref++;
+		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
+			     bfqq, bfqq->ref);
+	}
+}
+
+/**
+ * bfq_find_deepest - find the deepest node that an extraction can modify.
+ * @node: the node being removed.
+ *
+ * Do the first step of an extraction in an rb tree, looking for the
+ * node that will replace @node, and returning the deepest node that
+ * the following modifications to the tree can touch.  If @node is the
+ * last node in the tree return %NULL.
+ */
+static struct rb_node *bfq_find_deepest(struct rb_node *node)
+{
+	struct rb_node *deepest;
+
+	if (!node->rb_right && !node->rb_left)
+		deepest = rb_parent(node);
+	else if (!node->rb_right)
+		deepest = node->rb_left;
+	else if (!node->rb_left)
+		deepest = node->rb_right;
+	else {
+		deepest = rb_next(node);
+		if (deepest->rb_right)
+			deepest = deepest->rb_right;
+		else if (rb_parent(deepest) != node)
+			deepest = rb_parent(deepest);
+	}
+
+	return deepest;
+}
+
+/**
+ * bfq_active_extract - remove an entity from the active tree.
+ * @st: the service_tree containing the tree.
+ * @entity: the entity being removed.
+ */
+static void bfq_active_extract(struct bfq_service_tree *st,
+			       struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+	struct rb_node *node;
+
+	node = bfq_find_deepest(&entity->rb_node);
+	bfq_extract(&st->active, entity);
+
+	if (node)
+		bfq_update_active_tree(node);
+
+	if (bfqq)
+		list_del(&bfqq->bfqq_list);
+}
+
+/**
+ * bfq_idle_insert - insert an entity into the idle tree.
+ * @st: the service tree containing the tree.
+ * @entity: the entity to insert.
+ */
+static void bfq_idle_insert(struct bfq_service_tree *st,
+			    struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+	struct bfq_entity *first_idle = st->first_idle;
+	struct bfq_entity *last_idle = st->last_idle;
+
+	if (!first_idle || bfq_gt(first_idle->finish, entity->finish))
+		st->first_idle = entity;
+	if (!last_idle || bfq_gt(entity->finish, last_idle->finish))
+		st->last_idle = entity;
+
+	bfq_insert(&st->idle, entity);
+
+	if (bfqq)
+		list_add(&bfqq->bfqq_list, &bfqq->bfqd->idle_list);
+}
+
+/**
+ * bfq_forget_entity - remove an entity from the wfq trees.
+ * @st: the service tree.
+ * @entity: the entity being removed.
+ *
+ * Update the device status and forget everything about @entity, putting
+ * the device reference to it, if it is a queue.  Entities belonging to
+ * groups are not refcounted.
+ */
+static void bfq_forget_entity(struct bfq_service_tree *st,
+			      struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+	struct bfq_sched_data *sd;
+
+	entity->on_st = 0;
+	st->wsum -= entity->weight;
+	if (bfqq) {
+		sd = entity->sched_data;
+		bfq_log_bfqq(bfqq->bfqd, bfqq, "forget_entity: %p %d",
+			     bfqq, bfqq->ref);
+		bfq_put_queue(bfqq);
+	}
+}
+
+/**
+ * bfq_put_idle_entity - release the idle tree ref of an entity.
+ * @st: service tree for the entity.
+ * @entity: the entity being released.
+ */
+static void bfq_put_idle_entity(struct bfq_service_tree *st,
+				struct bfq_entity *entity)
+{
+	bfq_idle_extract(st, entity);
+	bfq_forget_entity(st, entity);
+}
+
+/**
+ * bfq_forget_idle - update the idle tree if necessary.
+ * @st: the service tree to act upon.
+ *
+ * To preserve the global O(log N) complexity we only remove one entry here;
+ * as the idle tree will not grow indefinitely this can be done safely.
+ */
+static void bfq_forget_idle(struct bfq_service_tree *st)
+{
+	struct bfq_entity *first_idle = st->first_idle;
+	struct bfq_entity *last_idle = st->last_idle;
+
+	if (RB_EMPTY_ROOT(&st->active) && last_idle &&
+	    !bfq_gt(last_idle->finish, st->vtime)) {
+		/*
+		 * Forget the whole idle tree, increasing the vtime past
+		 * the last finish time of idle entities.
+		 */
+		st->vtime = last_idle->finish;
+	}
+
+	if (first_idle && !bfq_gt(first_idle->finish, st->vtime))
+		bfq_put_idle_entity(st, first_idle);
+}
+
+static struct bfq_service_tree *
+__bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
+			 struct bfq_entity *entity)
+{
+	struct bfq_service_tree *new_st = old_st;
+
+	if (entity->prio_changed) {
+		struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+		unsigned short prev_weight, new_weight;
+		struct bfq_data *bfqd = NULL;
+
+		if (bfqq)
+			bfqd = bfqq->bfqd;
+
+		old_st->wsum -= entity->weight;
+
+		if (entity->new_weight != entity->orig_weight) {
+			if (entity->new_weight < BFQ_MIN_WEIGHT ||
+			    entity->new_weight > BFQ_MAX_WEIGHT) {
+				pr_crit("update_weight_prio: new_weight %d\n",
+					entity->new_weight);
+				if (entity->new_weight < BFQ_MIN_WEIGHT)
+					entity->new_weight = BFQ_MIN_WEIGHT;
+				else
+					entity->new_weight = BFQ_MAX_WEIGHT;
+			}
+			entity->orig_weight = entity->new_weight;
+			if (bfqq)
+				bfqq->ioprio =
+				  bfq_weight_to_ioprio(entity->orig_weight);
+		}
+
+		if (bfqq)
+			bfqq->ioprio_class = bfqq->new_ioprio_class;
+		entity->prio_changed = 0;
+
+		/*
+		 * NOTE: here we may be changing the weight too early,
+		 * this will cause unfairness.  The correct approach
+		 * would have required additional complexity to defer
+		 * weight changes to the proper time instants (i.e.,
+		 * when entity->finish <= old_st->vtime).
+		 */
+		new_st = bfq_entity_service_tree(entity);
+
+		prev_weight = entity->weight;
+		new_weight = entity->orig_weight;
+		entity->weight = new_weight;
+
+		new_st->wsum += entity->weight;
+
+		if (new_st != old_st)
+			entity->start = new_st->vtime;
+	}
+
+	return new_st;
+}
+
+/**
+ * bfq_bfqq_served - update the scheduler status after selection for
+ *                   service.
+ * @bfqq: the queue being served.
+ * @served: bytes to transfer.
+ *
+ * NOTE: this can be optimized, as the timestamps of upper level entities
+ * are synchronized every time a new bfqq is selected for service.  By now,
+ * we keep it to better check consistency.
+ */
+static void bfq_bfqq_served(struct bfq_queue *bfqq, int served)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+	struct bfq_service_tree *st;
+
+	for_each_entity(entity) {
+		st = bfq_entity_service_tree(entity);
+
+		entity->service += served;
+
+		st->vtime += bfq_delta(served, st->wsum);
+		bfq_forget_idle(st);
+	}
+	bfq_log_bfqq(bfqq->bfqd, bfqq, "bfqq_served %d secs", served);
+}
+
+/**
+ * bfq_bfqq_charge_full_budget - set the service to the entity budget.
+ * @bfqq: the queue that needs a service update.
+ *
+ * When it's not possible to be fair in the service domain, because
+ * a queue is not consuming its budget fast enough (the meaning of
+ * fast depends on the timeout parameter), we charge it a full
+ * budget.  In this way we should obtain a sort of time-domain
+ * fairness among all the seeky/slow queues.
+ */
+static void bfq_bfqq_charge_full_budget(struct bfq_queue *bfqq)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+
+	bfq_log_bfqq(bfqq->bfqd, bfqq, "charge_full_budget");
+
+	bfq_bfqq_served(bfqq, entity->budget - entity->service);
+}
+
+/**
+ * __bfq_activate_entity - activate an entity.
+ * @entity: the entity being activated.
+ * @non_blocking_wait_rq: true if this entity was waiting for a request
+ *
+ * Called whenever an entity is activated, i.e., it is not active and one
+ * of its children receives a new request, or has to be reactivated due to
+ * budget exhaustion.  It uses the current budget of the entity (and the
+ * service received if @entity is active) of the queue to calculate its
+ * timestamps.
+ */
+static void __bfq_activate_entity(struct bfq_entity *entity,
+				  bool non_blocking_wait_rq)
+{
+	struct bfq_sched_data *sd = entity->sched_data;
+	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
+	bool backshifted = false;
+
+	if (entity == sd->in_service_entity) {
+		/*
+		 * If we are requeueing the current entity we have
+		 * to take care of not charging to it service it has
+		 * not received.
+		 */
+		bfq_calc_finish(entity, entity->service);
+		entity->start = entity->finish;
+		sd->in_service_entity = NULL;
+	} else if (entity->tree == &st->active) {
+		/*
+		 * Requeueing an entity due to a change of some
+		 * next_in_service entity below it.  We reuse the
+		 * old start time.
+		 */
+		bfq_active_extract(st, entity);
+	} else {
+		unsigned long long min_vstart;
+
+		/* See comments on bfq_fqq_update_budg_for_activation */
+		if (non_blocking_wait_rq && bfq_gt(st->vtime, entity->finish)) {
+			backshifted = true;
+			min_vstart = entity->finish;
+		} else
+			min_vstart = st->vtime;
+
+		if (entity->tree == &st->idle) {
+			/*
+			 * Must be on the idle tree, bfq_idle_extract() will
+			 * check for that.
+			 */
+			bfq_idle_extract(st, entity);
+			entity->start = bfq_gt(min_vstart, entity->finish) ?
+				min_vstart : entity->finish;
+		} else {
+			/*
+			 * The finish time of the entity may be invalid, and
+			 * it is in the past for sure, otherwise the queue
+			 * would have been on the idle tree.
+			 */
+			entity->start = min_vstart;
+			st->wsum += entity->weight;
+			bfq_get_entity(entity);
+
+			entity->on_st = 1;
+		}
+	}
+
+	st = __bfq_entity_update_weight_prio(st, entity);
+	bfq_calc_finish(entity, entity->budget);
+
+	/*
+	 * If some queues enjoy backshifting for a while, then their
+	 * (virtual) finish timestamps may happen to become lower and
+	 * lower than the system virtual time.	In particular, if
+	 * these queues often happen to be idle for short time
+	 * periods, and during such time periods other queues with
+	 * higher timestamps happen to be busy, then the backshifted
+	 * timestamps of the former queues can become much lower than
+	 * the system virtual time. In fact, to serve the queues with
+	 * higher timestamps while the ones with lower timestamps are
+	 * idle, the system virtual time may be pushed-up to much
+	 * higher values than the finish timestamps of the idle
+	 * queues. As a consequence, the finish timestamps of all new
+	 * or newly activated queues may end up being much larger than
+	 * those of lucky queues with backshifted timestamps. The
+	 * latter queues may then monopolize the device for a lot of
+	 * time. This would simply break service guarantees.
+	 *
+	 * To reduce this problem, push up a little bit the
+	 * backshifted timestamps of the queue associated with this
+	 * entity (only a queue can happen to have the backshifted
+	 * flag set): just enough to let the finish timestamp of the
+	 * queue be equal to the current value of the system virtual
+	 * time. This may introduce a little unfairness among queues
+	 * with backshifted timestamps, but it does not break
+	 * worst-case fairness guarantees.
+	 */
+	if (backshifted && bfq_gt(st->vtime, entity->finish)) {
+		unsigned long delta = st->vtime - entity->finish;
+
+		entity->start += delta;
+		entity->finish += delta;
+	}
+
+	bfq_active_insert(st, entity);
+}
+
+/**
+ * bfq_activate_entity - activate an entity and its ancestors if necessary.
+ * @entity: the entity to activate.
+ * @non_blocking_wait_rq: true if this entity was waiting for a request
+ *
+ * Activate @entity and all the entities on the path from it to the root.
+ */
+static void bfq_activate_entity(struct bfq_entity *entity,
+				bool non_blocking_wait_rq)
+{
+	struct bfq_sched_data *sd;
+
+	for_each_entity(entity) {
+		__bfq_activate_entity(entity, non_blocking_wait_rq);
+
+		sd = entity->sched_data;
+		if (!bfq_update_next_in_service(sd))
+			/*
+			 * No need to propagate the activation to the
+			 * upper entities, as they will be updated when
+			 * the in-service entity is rescheduled.
+			 */
+			break;
+	}
+}
+
+/**
+ * __bfq_deactivate_entity - deactivate an entity from its service tree.
+ * @entity: the entity to deactivate.
+ * @requeue: if false, the entity will not be put into the idle tree.
+ *
+ * Deactivate an entity, independently from its previous state.  If the
+ * entity was not on a service tree just return, otherwise if it is on
+ * any scheduler tree, extract it from that tree, and if necessary
+ * and if the caller did not specify @requeue, put it on the idle tree.
+ *
+ * Return %1 if the caller should update the entity hierarchy, i.e.,
+ * if the entity was in service or if it was the next_in_service for
+ * its sched_data; return %0 otherwise.
+ */
+static int __bfq_deactivate_entity(struct bfq_entity *entity, int requeue)
+{
+	struct bfq_sched_data *sd = entity->sched_data;
+	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
+	int was_in_service = entity == sd->in_service_entity;
+	int ret = 0;
+
+	if (!entity->on_st)
+		return 0;
+
+	if (was_in_service) {
+		bfq_calc_finish(entity, entity->service);
+		sd->in_service_entity = NULL;
+	} else if (entity->tree == &st->active)
+		bfq_active_extract(st, entity);
+	else if (entity->tree == &st->idle)
+		bfq_idle_extract(st, entity);
+
+	if (was_in_service || sd->next_in_service == entity)
+		ret = bfq_update_next_in_service(sd);
+
+	if (!requeue || !bfq_gt(entity->finish, st->vtime))
+		bfq_forget_entity(st, entity);
+	else
+		bfq_idle_insert(st, entity);
+
+	return ret;
+}
+
+/**
+ * bfq_deactivate_entity - deactivate an entity.
+ * @entity: the entity to deactivate.
+ * @requeue: true if the entity can be put on the idle tree
+ */
+static void bfq_deactivate_entity(struct bfq_entity *entity, int requeue)
+{
+	struct bfq_sched_data *sd;
+	struct bfq_entity *parent;
+
+	for_each_entity_safe(entity, parent) {
+		sd = entity->sched_data;
+
+		if (!__bfq_deactivate_entity(entity, requeue))
+			/*
+			 * The parent entity is still backlogged, and
+			 * we don't need to update it as it is still
+			 * in service.
+			 */
+			break;
+
+		if (sd->next_in_service)
+			/*
+			 * The parent entity is still backlogged and
+			 * the budgets on the path towards the root
+			 * need to be updated.
+			 */
+			goto update;
+
+		/*
+		 * If we get here, then the parent is no more backlogged and
+		 * we want to propagate the deactivation upwards.
+		 */
+		requeue = 1;
+	}
+
+	return;
+
+update:
+	entity = parent;
+	for_each_entity(entity) {
+		__bfq_activate_entity(entity, false);
+
+		sd = entity->sched_data;
+		if (!bfq_update_next_in_service(sd))
+			break;
+	}
+}
+
+/**
+ * bfq_update_vtime - update vtime if necessary.
+ * @st: the service tree to act upon.
+ *
+ * If necessary update the service tree vtime to have at least one
+ * eligible entity, skipping to its start time.  Assumes that the
+ * active tree of the device is not empty.
+ *
+ * NOTE: this hierarchical implementation updates vtimes quite often,
+ * we may end up with reactivated processes getting timestamps after a
+ * vtime skip done because we needed a ->first_active entity on some
+ * intermediate node.
+ */
+static void bfq_update_vtime(struct bfq_service_tree *st)
+{
+	struct bfq_entity *entry;
+	struct rb_node *node = st->active.rb_node;
+
+	entry = rb_entry(node, struct bfq_entity, rb_node);
+	if (bfq_gt(entry->min_start, st->vtime)) {
+		st->vtime = entry->min_start;
+		bfq_forget_idle(st);
+	}
+}
+
+/**
+ * bfq_first_active_entity - find the eligible entity with
+ *                           the smallest finish time
+ * @st: the service tree to select from.
+ *
+ * This function searches the first schedulable entity, starting from the
+ * root of the tree and going on the left every time on this side there is
+ * a subtree with at least one eligible (start >= vtime) entity. The path on
+ * the right is followed only if a) the left subtree contains no eligible
+ * entities and b) no eligible entity has been found yet.
+ */
+static struct bfq_entity *bfq_first_active_entity(struct bfq_service_tree *st)
+{
+	struct bfq_entity *entry, *first = NULL;
+	struct rb_node *node = st->active.rb_node;
+
+	while (node) {
+		entry = rb_entry(node, struct bfq_entity, rb_node);
+left:
+		if (!bfq_gt(entry->start, st->vtime))
+			first = entry;
+
+		if (node->rb_left) {
+			entry = rb_entry(node->rb_left,
+					 struct bfq_entity, rb_node);
+			if (!bfq_gt(entry->min_start, st->vtime)) {
+				node = node->rb_left;
+				goto left;
+			}
+		}
+		if (first)
+			break;
+		node = node->rb_right;
+	}
+
+	return first;
+}
+
+/**
+ * __bfq_lookup_next_entity - return the first eligible entity in @st.
+ * @st: the service tree.
+ *
+ * Update the virtual time in @st and return the first eligible entity
+ * it contains.
+ */
+static struct bfq_entity *__bfq_lookup_next_entity(struct bfq_service_tree *st,
+						   bool force)
+{
+	struct bfq_entity *entity, *new_next_in_service = NULL;
+
+	if (RB_EMPTY_ROOT(&st->active))
+		return NULL;
+
+	bfq_update_vtime(st);
+	entity = bfq_first_active_entity(st);
+
+	/*
+	 * If the chosen entity does not match with the sched_data's
+	 * next_in_service and we are forcedly serving the IDLE priority
+	 * class tree, bubble up budget update.
+	 */
+	if (unlikely(force && entity != entity->sched_data->next_in_service)) {
+		new_next_in_service = entity;
+		for_each_entity(new_next_in_service)
+			bfq_update_budget(new_next_in_service);
+	}
+
+	return entity;
+}
+
+/**
+ * bfq_lookup_next_entity - return the first eligible entity in @sd.
+ * @sd: the sched_data.
+ * @extract: if true the returned entity will be also extracted from @sd.
+ *
+ * NOTE: since we cache the next_in_service entity at each level of the
+ * hierarchy, the complexity of the lookup can be decreased with
+ * absolutely no effort just returning the cached next_in_service value;
+ * we prefer to do full lookups to test the consistency of the data
+ * structures.
  */
-static inline void cfq_schedule_dispatch(struct cfq_data *cfqd)
+static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data *sd,
+						 int extract,
+						 struct bfq_data *bfqd)
 {
-	if (cfqd->busy_queues) {
-		cfq_log(cfqd, "schedule dispatch");
-		kblockd_schedule_work(&cfqd->unplug_work);
+	struct bfq_service_tree *st = sd->service_tree;
+	struct bfq_entity *entity;
+	int i = 0;
+
+	/*
+	 * Choose from idle class, if needed to guarantee a minimum
+	 * bandwidth to this class. This should also mitigate
+	 * priority-inversion problems in case a low priority task is
+	 * holding file system resources.
+	 */
+	if (bfqd &&
+	    jiffies - bfqd->bfq_class_idle_last_service >
+	    BFQ_CL_IDLE_TIMEOUT) {
+		entity = __bfq_lookup_next_entity(st + BFQ_IOPRIO_CLASSES - 1,
+						  true);
+		if (entity) {
+			i = BFQ_IOPRIO_CLASSES - 1;
+			bfqd->bfq_class_idle_last_service = jiffies;
+			sd->next_in_service = entity;
+		}
 	}
+	for (; i < BFQ_IOPRIO_CLASSES; i++) {
+		entity = __bfq_lookup_next_entity(st + i, false);
+		if (entity) {
+			if (extract) {
+				bfq_check_next_in_service(sd, entity);
+				bfq_active_extract(st + i, entity);
+				sd->in_service_entity = entity;
+				sd->next_in_service = NULL;
+			}
+			break;
+		}
+	}
+
+	return entity;
+}
+
+static bool next_queue_may_preempt(struct bfq_data *bfqd)
+{
+	struct bfq_sched_data *sd = &bfqd->sched_data;
+
+	return sd->next_in_service != sd->in_service_entity;
 }
 
+
 /*
- * Scale schedule slice based on io priority. Use the sync time slice only
- * if a queue is marked sync and has sync io queued. A sync queue with async
- * io only, should not get full sync slice length.
+ * Get next queue for service.
  */
-static inline u64 cfq_prio_slice(struct cfq_data *cfqd, bool sync,
-				 unsigned short prio)
+static struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd)
 {
-	u64 base_slice = cfqd->cfq_slice[sync];
-	u64 slice = div_u64(base_slice, CFQ_SLICE_SCALE);
+	struct bfq_entity *entity = NULL;
+	struct bfq_sched_data *sd;
+	struct bfq_queue *bfqq;
+
+	if (bfqd->busy_queues == 0)
+		return NULL;
+
+	sd = &bfqd->sched_data;
+	for (; sd ; sd = entity->my_sched_data) {
+		entity = bfq_lookup_next_entity(sd, 1, bfqd);
+		entity->service = 0;
+	}
+
+	bfqq = bfq_entity_to_bfqq(entity);
+
+	return bfqq;
+}
 
-	WARN_ON(prio >= IOPRIO_BE_NR);
+static void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
+{
+	if (bfqd->in_service_bic) {
+		put_io_context(bfqd->in_service_bic->icq.ioc);
+		bfqd->in_service_bic = NULL;
+	}
 
-	return base_slice + (slice * (4 - prio));
+	bfqd->in_service_queue = NULL;
+	hrtimer_try_to_cancel(&bfqd->idle_slice_timer);
 }
 
-static inline u64
-cfq_prio_to_slice(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+static void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+				int requeue)
 {
-	return cfq_prio_slice(cfqd, cfq_cfqq_sync(cfqq), cfqq->ioprio);
+	struct bfq_entity *entity = &bfqq->entity;
+
+	bfq_deactivate_entity(entity, requeue);
 }
 
-static inline u64 max_vdisktime(u64 min_vdisktime, u64 vdisktime)
+static void bfq_activate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
-	s64 delta = (s64)(vdisktime - min_vdisktime);
-	if (delta > 0)
-		min_vdisktime = vdisktime;
+	struct bfq_entity *entity = &bfqq->entity;
 
-	return min_vdisktime;
+	bfq_activate_entity(entity, bfq_bfqq_non_blocking_wait_rq(bfqq));
+	bfq_clear_bfqq_non_blocking_wait_rq(bfqq);
 }
 
-static inline u64 min_vdisktime(u64 min_vdisktime, u64 vdisktime)
+/*
+ * Called when the bfqq no longer has requests pending, remove it from
+ * the service tree.
+ */
+static void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+			      int requeue)
 {
-	s64 delta = (s64)(vdisktime - min_vdisktime);
-	if (delta < 0)
-		min_vdisktime = vdisktime;
+	bfq_log_bfqq(bfqd, bfqq, "del from busy");
+
+	bfq_clear_bfqq_busy(bfqq);
+
+	bfqd->busy_queues--;
 
-	return min_vdisktime;
+	bfq_deactivate_bfqq(bfqd, bfqq, requeue);
 }
 
-static inline u64
-cfq_scaled_cfqq_slice(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+/*
+ * Called when an inactive queue receives a new request.
+ */
+static void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
-	return cfq_prio_to_slice(cfqd, cfqq);
+	bfq_log_bfqq(bfqd, bfqq, "add to busy");
+
+	bfq_activate_bfqq(bfqd, bfqq);
+
+	bfq_mark_bfqq_busy(bfqq);
+	bfqd->busy_queues++;
 }
 
-static inline void
-cfq_set_prio_slice(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+static void bfq_init_entity(struct bfq_entity *entity)
 {
-	u64 slice = cfq_scaled_cfqq_slice(cfqd, cfqq);
-	u64 now = ktime_get_ns();
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 
-	cfqq->slice_start = now;
-	cfqq->slice_end = now + slice;
-	cfqq->allocated_slice = slice;
-	cfq_log_cfqq(cfqd, cfqq, "set_slice=%llu", cfqq->slice_end - now);
+	entity->weight = entity->new_weight;
+	entity->orig_weight = entity->new_weight;
+
+	bfqq->ioprio = bfqq->new_ioprio;
+	bfqq->ioprio_class = bfqq->new_ioprio_class;
+
+	entity->sched_data = &bfqq->bfqd->sched_data;
 }
 
+#define bfq_class_idle(bfqq)	((bfqq)->ioprio_class == IOPRIO_CLASS_IDLE)
+#define bfq_class_rt(bfqq)	((bfqq)->ioprio_class == IOPRIO_CLASS_RT)
+
+#define bfq_sample_valid(samples)	((samples) > 80)
+
 /*
- * We need to wrap this check in cfq_cfqq_slice_new(), since ->slice_end
- * isn't valid until the first request from the dispatch is activated
- * and the slice time set.
+ * We regard a request as SYNC, if either it's a read or has the SYNC bit
+ * set (in which case it could also be a direct WRITE).
  */
-static inline bool cfq_slice_used(struct cfq_queue *cfqq)
+static bool bfq_bio_sync(struct bio *bio)
 {
-	if (cfq_cfqq_slice_new(cfqq))
-		return false;
-	if (ktime_get_ns() < cfqq->slice_end)
-		return false;
+	return bio_data_dir(bio) == READ || (bio->bi_opf & REQ_SYNC);
+}
 
-	return true;
+/*
+ * Scheduler run of queue, if there are requests pending and no one in the
+ * driver that will restart queueing.
+ */
+static void bfq_schedule_dispatch(struct bfq_data *bfqd)
+{
+	if (bfqd->queued != 0) {
+		bfq_log(bfqd, "schedule dispatch");
+		kblockd_schedule_work(&bfqd->unplug_work);
+	}
 }
 
 /*
  * Lifted from AS - choose which of rq1 and rq2 that is best served now.
- * We choose the request that is closest to the head right now. Distance
+ * We choose the request that is closesr to the head right now.  Distance
  * behind the head is penalized and only allowed to a certain extent.
  */
-static struct request *
-cfq_choose_req(struct cfq_data *cfqd, struct request *rq1, struct request *rq2, sector_t last)
+static struct request *bfq_choose_req(struct bfq_data *bfqd,
+				      struct request *rq1,
+				      struct request *rq2,
+				      sector_t last)
 {
 	sector_t s1, s2, d1 = 0, d2 = 0;
 	unsigned long back_max;
-#define CFQ_RQ1_WRAP	0x01 /* request 1 wraps */
-#define CFQ_RQ2_WRAP	0x02 /* request 2 wraps */
+#define BFQ_RQ1_WRAP	0x01 /* request 1 wraps */
+#define BFQ_RQ2_WRAP	0x02 /* request 2 wraps */
 	unsigned wrap = 0; /* bit mask: requests behind the disk head? */
 
-	if (rq1 == NULL || rq1 == rq2)
+	if (!rq1 || rq1 == rq2)
 		return rq2;
-	if (rq2 == NULL)
+	if (!rq2)
 		return rq1;
 
-	if (rq_is_sync(rq1) != rq_is_sync(rq2))
-		return rq_is_sync(rq1) ? rq1 : rq2;
-
-	if ((rq1->cmd_flags ^ rq2->cmd_flags) & REQ_PRIO)
-		return rq1->cmd_flags & REQ_PRIO ? rq1 : rq2;
+	if (rq_is_sync(rq1) && !rq_is_sync(rq2))
+		return rq1;
+	else if (rq_is_sync(rq2) && !rq_is_sync(rq1))
+		return rq2;
+	if ((rq1->cmd_flags & REQ_META) && !(rq2->cmd_flags & REQ_META))
+		return rq1;
+	else if ((rq2->cmd_flags & REQ_META) && !(rq1->cmd_flags & REQ_META))
+		return rq2;
 
 	s1 = blk_rq_pos(rq1);
 	s2 = blk_rq_pos(rq2);
 
 	/*
-	 * by definition, 1KiB is 2 sectors
+	 * By definition, 1KiB is 2 sectors.
 	 */
-	back_max = cfqd->cfq_back_max * 2;
+	back_max = bfqd->bfq_back_max * 2;
 
 	/*
 	 * Strict one way elevator _except_ in the case where we allow
@@ -480,16 +1684,16 @@ cfq_choose_req(struct cfq_data *cfqd, struct request *rq1, struct request *rq2,
 	if (s1 >= last)
 		d1 = s1 - last;
 	else if (s1 + back_max >= last)
-		d1 = (last - s1) * cfqd->cfq_back_penalty;
+		d1 = (last - s1) * bfqd->bfq_back_penalty;
 	else
-		wrap |= CFQ_RQ1_WRAP;
+		wrap |= BFQ_RQ1_WRAP;
 
 	if (s2 >= last)
 		d2 = s2 - last;
 	else if (s2 + back_max >= last)
-		d2 = (last - s2) * cfqd->cfq_back_penalty;
+		d2 = (last - s2) * bfqd->bfq_back_penalty;
 	else
-		wrap |= CFQ_RQ2_WRAP;
+		wrap |= BFQ_RQ2_WRAP;
 
 	/* Found required data */
 
@@ -509,11 +1713,11 @@ cfq_choose_req(struct cfq_data *cfqd, struct request *rq1, struct request *rq2,
 		else
 			return rq2;
 
-	case CFQ_RQ2_WRAP:
+	case BFQ_RQ2_WRAP:
 		return rq1;
-	case CFQ_RQ1_WRAP:
+	case BFQ_RQ1_WRAP:
 		return rq2;
-	case (CFQ_RQ1_WRAP|CFQ_RQ2_WRAP): /* both rqs wrapped */
+	case (BFQ_RQ1_WRAP|BFQ_RQ2_WRAP): /* both rqs wrapped */
 	default:
 		/*
 		 * Since both rqs are wrapped,
@@ -528,44 +1732,9 @@ cfq_choose_req(struct cfq_data *cfqd, struct request *rq1, struct request *rq2,
 	}
 }
 
-/*
- * The below is leftmost cache rbtree addon
- */
-static struct cfq_queue *cfq_rb_first(struct cfq_rb_root *root)
-{
-	/* Service tree is empty */
-	if (!root->count)
-		return NULL;
-
-	if (!root->left)
-		root->left = rb_first(&root->rb);
-
-	if (root->left)
-		return rb_entry(root->left, struct cfq_queue, rb_node);
-
-	return NULL;
-}
-
-static void rb_erase_init(struct rb_node *n, struct rb_root *root)
-{
-	rb_erase(n, root);
-	RB_CLEAR_NODE(n);
-}
-
-static void cfq_rb_erase(struct rb_node *n, struct cfq_rb_root *root)
-{
-	if (root->left == n)
-		root->left = NULL;
-	rb_erase_init(n, &root->rb);
-	--root->count;
-}
-
-/*
- * would be nice to take fifo expire time into account as well
- */
-static struct request *
-cfq_find_next_rq(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-		  struct request *last)
+static struct request *bfq_find_next_rq(struct bfq_data *bfqd,
+					struct bfq_queue *bfqq,
+					struct request *last)
 {
 	struct rb_node *rbnext = rb_next(&last->rb_node);
 	struct rb_node *rbprev = rb_prev(&last->rb_node);
@@ -577,311 +1746,368 @@ cfq_find_next_rq(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 	if (rbnext)
 		next = rb_entry_rq(rbnext);
 	else {
-		rbnext = rb_first(&cfqq->sort_list);
+		rbnext = rb_first(&bfqq->sort_list);
 		if (rbnext && rbnext != &last->rb_node)
 			next = rb_entry_rq(rbnext);
 	}
 
-	return cfq_choose_req(cfqd, next, prev, blk_rq_pos(last));
+	return bfq_choose_req(bfqd, next, prev, blk_rq_pos(last));
 }
 
-static unsigned long cfq_slice_offset(struct cfq_data *cfqd,
-				      struct cfq_queue *cfqq)
+static unsigned long bfq_serv_to_charge(struct request *rq,
+					struct bfq_queue *bfqq)
 {
-	/*
-	 * just an approximation, should be ok.
-	 */
-	return (cfqd->busy_queues - 1) * (cfq_prio_slice(cfqd, 1, 0) -
-		       cfq_prio_slice(cfqd, cfq_cfqq_sync(cfqq), cfqq->ioprio));
+	return blk_rq_sectors(rq);
 }
 
-static inline u64 cfq_cfqq_slice_usage(struct cfq_queue *cfqq,
-				       u64 *unaccounted_time)
+/**
+ * bfq_updated_next_req - update the queue after a new next_rq selection.
+ * @bfqd: the device data the queue belongs to.
+ * @bfqq: the queue to update.
+ *
+ * If the first request of a queue changes we make sure that the queue
+ * has enough budget to serve at least its first request (if the
+ * request has grown).  We do this because if the queue has not enough
+ * budget for its first request, it has to go through two dispatch
+ * rounds to actually get it dispatched.
+ */
+static void bfq_updated_next_req(struct bfq_data *bfqd,
+				 struct bfq_queue *bfqq)
 {
-	u64 slice_used;
-	u64 now = ktime_get_ns();
-
-	/*
-	 * Queue got expired before even a single request completed or
-	 * got expired immediately after first request completion.
-	 */
-	if (!cfqq->slice_start || cfqq->slice_start == now) {
-		/*
-		 * Also charge the seek time incurred to the group, otherwise
-		 * if there are multiple queues in the group, each can dispatch
-		 * a single request on seeky media and cause lots of seek time
-		 * and group will never know it.
-		 */
-		slice_used = max_t(u64, (now - cfqq->dispatch_start),
-					jiffies_to_nsecs(1));
-	} else {
-		slice_used = now - cfqq->slice_start;
-		if (slice_used > cfqq->allocated_slice) {
-			*unaccounted_time = slice_used - cfqq->allocated_slice;
-			slice_used = cfqq->allocated_slice;
-		}
-		if (cfqq->slice_start > cfqq->dispatch_start)
-			*unaccounted_time += cfqq->slice_start -
-					cfqq->dispatch_start;
-	}
-
-	return slice_used;
-}
+	struct bfq_entity *entity = &bfqq->entity;
+	struct request *next_rq = bfqq->next_rq;
+	unsigned long new_budget;
 
-/*
- * The cfqd->service_trees holds all pending cfq_queue's that have
- * requests waiting to be processed. It is sorted in the order that
- * we will service the queues.
- */
-static void cfq_service_tree_add(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-				 bool add_front)
-{
-	struct rb_node **p, *parent;
-	struct cfq_queue *__cfqq;
-	u64 rb_key;
-	struct cfq_rb_root *st;
-	int left;
-	int new_cfqq = 1;
-	u64 now = ktime_get_ns();
-
-	st = &cfqd->service_trees[cfqq_class(cfqq)];
-	if (cfq_class_idle(cfqq)) {
-		rb_key = CFQ_IDLE_DELAY;
-		parent = rb_last(&st->rb);
-		if (parent && parent != &cfqq->rb_node) {
-			__cfqq = rb_entry(parent, struct cfq_queue, rb_node);
-			rb_key += __cfqq->rb_key;
-		} else
-			rb_key += now;
-	} else if (!add_front) {
-		/*
-		 * Get our rb key offset. Subtract any residual slice
-		 * value carried from last service. A negative resid
-		 * count indicates slice overrun, and this should position
-		 * the next service time further away in the tree.
-		 */
-		rb_key = cfq_slice_offset(cfqd, cfqq) + now;
-		rb_key -= cfqq->slice_resid;
-		cfqq->slice_resid = 0;
-	} else {
-		rb_key = -NSEC_PER_SEC;
-		__cfqq = cfq_rb_first(st);
-		rb_key += __cfqq ? __cfqq->rb_key : now;
-	}
+	if (!next_rq)
+		return;
 
-	if (!RB_EMPTY_NODE(&cfqq->rb_node)) {
-		new_cfqq = 0;
+	if (bfqq == bfqd->in_service_queue)
 		/*
-		 * same position, nothing more to do
+		 * In order not to break guarantees, budgets cannot be
+		 * changed after an entity has been selected.
 		 */
-		if (rb_key == cfqq->rb_key && cfqq->service_tree == st)
-			return;
-
-		cfq_rb_erase(&cfqq->rb_node, cfqq->service_tree);
-		cfqq->service_tree = NULL;
-	}
-
-	left = 1;
-	parent = NULL;
-	cfqq->service_tree = st;
-	p = &st->rb.rb_node;
-	while (*p) {
-		parent = *p;
-		__cfqq = rb_entry(parent, struct cfq_queue, rb_node);
+		return;
 
-		/*
-		 * sort by key, that represents service time.
-		 */
-		if (rb_key < __cfqq->rb_key)
-			p = &parent->rb_left;
-		else {
-			p = &parent->rb_right;
-			left = 0;
-		}
+	new_budget = max_t(unsigned long, bfqq->max_budget,
+			   bfq_serv_to_charge(next_rq, bfqq));
+	if (entity->budget != new_budget) {
+		entity->budget = new_budget;
+		bfq_log_bfqq(bfqd, bfqq, "updated next rq: new budget %lu",
+					 new_budget);
+		bfq_activate_bfqq(bfqd, bfqq);
 	}
+}
 
-	if (left)
-		st->left = &cfqq->rb_node;
+static int bfq_bfqq_budget_left(struct bfq_queue *bfqq)
+{
+	struct bfq_entity *entity = &bfqq->entity;
 
-	cfqq->rb_key = rb_key;
-	rb_link_node(&cfqq->rb_node, parent, p);
-	rb_insert_color(&cfqq->rb_node, &st->rb);
-	st->count++;
-	if (add_front || !new_cfqq)
-		return;
+	return entity->budget - entity->service;
 }
 
 /*
- * Update cfqq's position in the service tree.
+ * If enough samples have been computed, return the current max budget
+ * stored in bfqd, which is dynamically updated according to the
+ * estimated disk peak rate; otherwise return the default max budget
  */
-static void cfq_resort_rr_list(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+static int bfq_max_budget(struct bfq_data *bfqd)
 {
-	/*
-	 * Resorting requires the cfqq to be on the RR list already.
-	 */
-	if (cfq_cfqq_on_rr(cfqq))
-		cfq_service_tree_add(cfqd, cfqq, 0);
+	if (bfqd->budgets_assigned < bfq_stats_min_budgets)
+		return bfq_default_max_budget;
+	else
+		return bfqd->bfq_max_budget;
 }
 
 /*
- * add to busy list of queues for service, trying to be fair in ordering
- * the pending list according to last request service
+ * Return min budget, which is a fraction of the current or default
+ * max budget (trying with 1/32)
  */
-static void cfq_add_cfqq_rr(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+static int bfq_min_budget(struct bfq_data *bfqd)
 {
-	cfq_log_cfqq(cfqd, cfqq, "add_to_rr");
-	BUG_ON(cfq_cfqq_on_rr(cfqq));
-	cfq_mark_cfqq_on_rr(cfqq);
-	cfqd->busy_queues++;
-	if (cfq_cfqq_sync(cfqq))
-		cfqd->busy_sync_queues++;
-
-	cfq_resort_rr_list(cfqd, cfqq);
+	if (bfqd->budgets_assigned < bfq_stats_min_budgets)
+		return bfq_default_max_budget / 32;
+	else
+		return bfqd->bfq_max_budget / 32;
 }
 
+static void bfq_bfqq_expire(struct bfq_data *bfqd,
+			    struct bfq_queue *bfqq,
+			    bool compensate,
+			    enum bfqq_expiration reason);
+
 /*
- * Called when the cfqq no longer has requests pending, remove it from
- * the service tree.
+ * The next function, invoked after the input queue bfqq switches from
+ * idle to busy, updates the budget of bfqq. The function also tells
+ * whether the in-service queue should be expired, by returning
+ * true. The purpose of expiring the in-service queue is to give bfqq
+ * the chance to possibly preempt the in-service queue, and the reason
+ * for preempting the in-service queue is to achieve the following
+ * goal: guarantee to bfqq its reserved bandwidth even if bfqq has
+ * expired because it has remained idle.
+ *
+ * In particular, bfqq may have expired for one of the following two
+ * reasons:
+ *
+ * - BFQ_BFQQ_NO_MORE_REQUESTS bfqq did not enjoy any device idling
+ *   and did not make it to issue a new request before its last
+ *   request was served;
+ *
+ * - BFQ_BFQQ_TOO_IDLE bfqq did enjoy device idling, but did not issue
+ *   a new request before the expiration of the idling-time.
+ *
+ * Even if bfqq has expired for one of the above reasons, the process
+ * associated with the queue may be however issuing requests greedily,
+ * and thus be sensitive to the bandwidth it receives (bfqq may have
+ * remained idle for other reasons: CPU high load, bfqq not enjoying
+ * idling, I/O throttling somewhere in the path from the process to
+ * the I/O scheduler, ...). But if, after every expiration for one of
+ * the above two reasons, bfqq has to wait for the service of at least
+ * one full budget of another queue before being served again, then
+ * bfqq is likely to get a much lower bandwidth or resource time than
+ * its reserved ones. To address this issue, two countermeasures need
+ * to be taken.
+ *
+ * First, the budget and the timestamps of bfqq need to be updated in
+ * a special way on bfqq reactivation: they need to be updated as if
+ * bfqq did not remain idle and did not expire. In fact, if they are
+ * computed as if bfqq expired and remained idle until reactivation,
+ * then the process associated with bfqq is treated as if, instead of
+ * being greedy, it stopped issuing requests when bfqq remained idle,
+ * and restarts issuing requests only on this reactivation. In other
+ * words, the scheduler does not help the process recover the "service
+ * hole" between bfqq expiration and reactivation. As a consequence,
+ * the process receives a lower bandwidth than its reserved one. In
+ * contrast, to recover this hole, the budget must be updated as if
+ * bfqq was not expired at all before this reactivation, i.e., it must
+ * be set to the value of the remaining budget when bfqq was
+ * expired. Along the same line, timestamps need to be assigned the
+ * value they had the last time bfqq was selected for service, i.e.,
+ * before last expiration. Thus timestamps need to be back-shifted
+ * with respect to their normal computation (see [1] for more details
+ * on this tricky aspect).
+ *
+ * Secondly, to allow the process to recover the hole, the in-service
+ * queue must be expired too, to give bfqq the chance to preempt it
+ * immediately. In fact, if bfqq has to wait for a full budget of the
+ * in-service queue to be completed, then it may become impossible to
+ * let the process recover the hole, even if the back-shifted
+ * timestamps of bfqq are lower than those of the in-service queue. If
+ * this happens for most or all of the holes, then the process may not
+ * receive its reserved bandwidth. In this respect, it is worth noting
+ * that, being the service of outstanding requests unpreemptible, a
+ * little fraction of the holes may however be unrecoverable, thereby
+ * causing a little loss of bandwidth.
+ *
+ * The last important point is detecting whether bfqq does need this
+ * bandwidth recovery. In this respect, the next function deems the
+ * process associated with bfqq greedy, and thus allows it to recover
+ * the hole, if: 1) the process is waiting for the arrival of a new
+ * request (which implies that bfqq expired for one of the above two
+ * reasons), and 2) such a request has arrived soon. The first
+ * condition is controlled through the flag non_blocking_wait_rq,
+ * while the second through the flag arrived_in_time. If both
+ * conditions hold, then the function computes the budget in the
+ * above-described special way, and signals that the in-service queue
+ * should be expired. Timestamp back-shifting is done later in
+ * __bfq_activate_entity.
  */
-static void cfq_del_cfqq_rr(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+static bool bfq_bfqq_update_budg_for_activation(struct bfq_data *bfqd,
+						struct bfq_queue *bfqq,
+						bool arrived_in_time)
 {
-	cfq_log_cfqq(cfqd, cfqq, "del_from_rr");
-	BUG_ON(!cfq_cfqq_on_rr(cfqq));
-	cfq_clear_cfqq_on_rr(cfqq);
+	struct bfq_entity *entity = &bfqq->entity;
 
-	if (!RB_EMPTY_NODE(&cfqq->rb_node)) {
-		cfq_rb_erase(&cfqq->rb_node, cfqq->service_tree);
-		cfqq->service_tree = NULL;
-	}
-	if (cfqq->p_root) {
-		rb_erase(&cfqq->p_node, cfqq->p_root);
-		cfqq->p_root = NULL;
+	if (bfq_bfqq_non_blocking_wait_rq(bfqq) && arrived_in_time) {
+		/*
+		 * We do not clear the flag non_blocking_wait_rq here, as
+		 * the latter is used in bfq_activate_bfqq to signal
+		 * that timestamps need to be back-shifted (and is
+		 * cleared right after).
+		 */
+
+		/*
+		 * In next assignment we rely on that either
+		 * entity->service or entity->budget are not updated
+		 * on expiration if bfqq is empty (see
+		 * __bfq_bfqq_recalc_budget). Thus both quantities
+		 * remain unchanged after such an expiration, and the
+		 * following statement therefore assigns to
+		 * entity->budget the remaining budget on such an
+		 * expiration. For clarity, entity->service is not
+		 * updated on expiration in any case, and, in normal
+		 * operation, is reset only when bfqq is selected for
+		 * service (see bfq_get_next_queue).
+		 */
+		entity->budget = min_t(unsigned long,
+				       bfq_bfqq_budget_left(bfqq),
+				       bfqq->max_budget);
+
+		return true;
 	}
 
-	BUG_ON(!cfqd->busy_queues);
-	cfqd->busy_queues--;
-	if (cfq_cfqq_sync(cfqq))
-		cfqd->busy_sync_queues--;
+	entity->budget = max_t(unsigned long, bfqq->max_budget,
+			       bfq_serv_to_charge(bfqq->next_rq, bfqq));
+	bfq_clear_bfqq_non_blocking_wait_rq(bfqq);
+	return false;
 }
 
-/*
- * rb tree support functions
- */
-static void cfq_del_rq_rb(struct request *rq)
+static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
+					     struct bfq_queue *bfqq,
+					     struct request *rq)
 {
-	struct cfq_queue *cfqq = RQ_CFQQ(rq);
-	const int sync = rq_is_sync(rq);
-
-	BUG_ON(!cfqq->queued[sync]);
-	cfqq->queued[sync]--;
-
-	elv_rb_del(&cfqq->sort_list, rq);
-
-	if (cfq_cfqq_on_rr(cfqq) && RB_EMPTY_ROOT(&cfqq->sort_list)) {
+	bool bfqq_wants_to_preempt,
 		/*
-		 * Queue will be deleted from service tree when we actually
-		 * expire it later. Right now just remove it from prio tree
-		 * as it is empty.
+		 * See the comments on
+		 * bfq_bfqq_update_budg_for_activation for
+		 * details on the usage of the next variable.
 		 */
-		if (cfqq->p_root) {
-			rb_erase(&cfqq->p_node, cfqq->p_root);
-			cfqq->p_root = NULL;
-		}
+		arrived_in_time = ktime_get_ns() <=
+			RQ_BIC(rq)->ttime.last_end_request +
+			bfqd->bfq_slice_idle * 3;
+
+	/*
+	 * Update budget and check whether bfqq may want to preempt
+	 * the in-service queue.
+	 */
+	bfqq_wants_to_preempt =
+		bfq_bfqq_update_budg_for_activation(bfqd, bfqq,
+						    arrived_in_time);
+
+	if (!bfq_bfqq_IO_bound(bfqq)) {
+		if (arrived_in_time) {
+			bfqq->requests_within_timer++;
+			if (bfqq->requests_within_timer >=
+			    bfqd->bfq_requests_within_timer)
+				bfq_mark_bfqq_IO_bound(bfqq);
+		} else
+			bfqq->requests_within_timer = 0;
 	}
+
+	bfq_add_bfqq_busy(bfqd, bfqq);
+
+	/*
+	 * Expire in-service queue only if preemption may be needed
+	 * for guarantees. In this respect, the function
+	 * next_queue_may_preempt just checks a simple, necessary
+	 * condition, and not a sufficient condition based on
+	 * timestamps. In fact, for the latter condition to be
+	 * evaluated, timestamps would need first to be updated, and
+	 * this operation is quite costly (see the comments on the
+	 * function bfq_bfqq_update_budg_for_activation).
+	 */
+	if (bfqd->in_service_queue && bfqq_wants_to_preempt &&
+	    next_queue_may_preempt(bfqd))
+		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
+				false, BFQ_BFQQ_PREEMPTED);
 }
 
-static void cfq_add_rq_rb(struct request *rq)
+static void bfq_add_request(struct request *rq)
 {
-	struct cfq_queue *cfqq = RQ_CFQQ(rq);
-	struct cfq_data *cfqd = cfqq->cfqd;
-	struct request *prev;
-
-	cfqq->queued[rq_is_sync(rq)]++;
+	struct bfq_queue *bfqq = RQ_BFQQ(rq);
+	struct bfq_data *bfqd = bfqq->bfqd;
+	struct request *next_rq, *prev;
 
-	elv_rb_add(&cfqq->sort_list, rq);
+	bfq_log_bfqq(bfqd, bfqq, "add_request %d", rq_is_sync(rq));
+	bfqq->queued[rq_is_sync(rq)]++;
+	bfqd->queued++;
 
-	if (!cfq_cfqq_on_rr(cfqq))
-		cfq_add_cfqq_rr(cfqd, cfqq);
+	elv_rb_add(&bfqq->sort_list, rq);
 
 	/*
-	 * check if this request is a better next-serve candidate
+	 * Check if this request is a better next-serve candidate.
 	 */
-	prev = cfqq->next_rq;
-	cfqq->next_rq = cfq_choose_req(cfqd, cfqq->next_rq, rq, cfqd->last_position);
-
-	BUG_ON(!cfqq->next_rq);
-}
+	prev = bfqq->next_rq;
+	next_rq = bfq_choose_req(bfqd, bfqq->next_rq, rq, bfqd->last_position);
+	bfqq->next_rq = next_rq;
 
-static void cfq_reposition_rq_rb(struct cfq_queue *cfqq, struct request *rq)
-{
-	elv_rb_del(&cfqq->sort_list, rq);
-	cfqq->queued[rq_is_sync(rq)]--;
-	cfq_add_rq_rb(rq);
+	if (!bfq_bfqq_busy(bfqq)) /* switching to busy ... */
+		bfq_bfqq_handle_idle_busy_switch(bfqd, bfqq, rq);
+	else if (prev != bfqq->next_rq)
+		bfq_updated_next_req(bfqd, bfqq);
 }
 
-static struct request *
-cfq_find_rq_fmerge(struct cfq_data *cfqd, struct bio *bio)
+static struct request *bfq_find_rq_fmerge(struct bfq_data *bfqd,
+					  struct bio *bio)
 {
 	struct task_struct *tsk = current;
-	struct cfq_io_cq *cic;
-	struct cfq_queue *cfqq;
+	struct bfq_io_cq *bic;
+	struct bfq_queue *bfqq;
 
-	cic = cfq_cic_lookup(cfqd, tsk->io_context);
-	if (!cic)
+	bic = bfq_bic_lookup(bfqd, tsk->io_context);
+	if (!bic)
 		return NULL;
 
-	cfqq = cic_to_cfqq(cic, cfq_bio_sync(bio));
-	if (cfqq)
-		return elv_rb_find(&cfqq->sort_list, bio_end_sector(bio));
+	bfqq = bic_to_bfqq(bic, bfq_bio_sync(bio));
+	if (bfqq)
+		return elv_rb_find(&bfqq->sort_list, bio_end_sector(bio));
 
 	return NULL;
 }
 
-static void cfq_activate_request(struct request_queue *q, struct request *rq)
+static void bfq_activate_request(struct request_queue *q, struct request *rq)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
-
-	cfqd->rq_in_driver++;
-	cfq_log_cfqq(cfqd, RQ_CFQQ(rq), "activate rq, drv=%d",
-						cfqd->rq_in_driver);
+	struct bfq_data *bfqd = q->elevator->elevator_data;
 
-	cfqd->last_position = blk_rq_pos(rq) + blk_rq_sectors(rq);
+	bfqd->rq_in_driver++;
+	bfqd->last_position = blk_rq_pos(rq) + blk_rq_sectors(rq);
+	bfq_log(bfqd, "activate_request: new bfqd->last_position %llu",
+		(unsigned long long)bfqd->last_position);
 }
 
-static void cfq_deactivate_request(struct request_queue *q, struct request *rq)
+static void bfq_deactivate_request(struct request_queue *q, struct request *rq)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct bfq_data *bfqd = q->elevator->elevator_data;
 
-	WARN_ON(!cfqd->rq_in_driver);
-	cfqd->rq_in_driver--;
-	cfq_log_cfqq(cfqd, RQ_CFQQ(rq), "deactivate rq, drv=%d",
-						cfqd->rq_in_driver);
+	bfqd->rq_in_driver--;
 }
 
-static void cfq_remove_request(struct request *rq)
+static void bfq_remove_request(struct request *rq)
 {
-	struct cfq_queue *cfqq = RQ_CFQQ(rq);
-
-	if (cfqq->next_rq == rq)
-		cfqq->next_rq = cfq_find_next_rq(cfqq->cfqd, cfqq, rq);
+	struct bfq_queue *bfqq = RQ_BFQQ(rq);
+	struct bfq_data *bfqd = bfqq->bfqd;
+	const int sync = rq_is_sync(rq);
 
-	list_del_init(&rq->queuelist);
-	cfq_del_rq_rb(rq);
+	if (bfqq->next_rq == rq) {
+		bfqq->next_rq = bfq_find_next_rq(bfqd, bfqq, rq);
+		bfq_updated_next_req(bfqd, bfqq);
+	}
 
-	cfqq->cfqd->rq_queued--;
-	if (rq->cmd_flags & REQ_PRIO) {
-		WARN_ON(!cfqq->prio_pending);
-		cfqq->prio_pending--;
+	if (rq->queuelist.prev != &rq->queuelist)
+		list_del_init(&rq->queuelist);
+	bfqq->queued[sync]--;
+	bfqd->queued--;
+	elv_rb_del(&bfqq->sort_list, rq);
+
+	if (RB_EMPTY_ROOT(&bfqq->sort_list)) {
+		if (bfq_bfqq_busy(bfqq) && bfqq != bfqd->in_service_queue) {
+			bfq_del_bfqq_busy(bfqd, bfqq, 1);
+
+			/* bfqq emptied. In normal operation, when
+			 * bfqq is empty, bfqq->entity.service and
+			 * bfqq->entity.budget must contain,
+			 * respectively, the service received and the
+			 * budget used last time bfqq emptied. These
+			 * facts do not hold in this case, as at least
+			 * this last removal occurred while bfqq is
+			 * not in service. To avoid inconsistencies,
+			 * reset both bfqq->entity.service and
+			 * bfqq->entity.budget.
+			 */
+			bfqq->entity.budget = bfqq->entity.service = 0;
+		}
 	}
+
+	if (rq->cmd_flags & REQ_META)
+		bfqq->meta_pending--;
 }
 
-static int cfq_merge(struct request_queue *q, struct request **req,
+static int bfq_merge(struct request_queue *q, struct request **req,
 		     struct bio *bio)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct bfq_data *bfqd = q->elevator->elevator_data;
 	struct request *__rq;
 
-	__rq = cfq_find_rq_fmerge(cfqd, bio);
+	__rq = bfq_find_rq_fmerge(bfqd, bio);
 	if (__rq && elv_bio_merge_ok(__rq, bio)) {
 		*req = __rq;
 		return ELEVATOR_FRONT_MERGE;
@@ -890,1546 +2116,1748 @@ static int cfq_merge(struct request_queue *q, struct request **req,
 	return ELEVATOR_NO_MERGE;
 }
 
-static void cfq_merged_request(struct request_queue *q, struct request *req,
+static void bfq_merged_request(struct request_queue *q, struct request *req,
 			       int type)
 {
-	if (type == ELEVATOR_FRONT_MERGE) {
-		struct cfq_queue *cfqq = RQ_CFQQ(req);
-
-		cfq_reposition_rq_rb(cfqq, req);
+	if (type == ELEVATOR_FRONT_MERGE &&
+	    rb_prev(&req->rb_node) &&
+	    blk_rq_pos(req) <
+	    blk_rq_pos(container_of(rb_prev(&req->rb_node),
+				    struct request, rb_node))) {
+		struct bfq_queue *bfqq = RQ_BFQQ(req);
+		struct bfq_data *bfqd = bfqq->bfqd;
+		struct request *prev, *next_rq;
+
+		/* Reposition request in its sort_list */
+		elv_rb_del(&bfqq->sort_list, req);
+		elv_rb_add(&bfqq->sort_list, req);
+		/* Choose next request to be served for bfqq */
+		prev = bfqq->next_rq;
+		next_rq = bfq_choose_req(bfqd, bfqq->next_rq, req,
+					 bfqd->last_position);
+		bfqq->next_rq = next_rq;
+		/*
+		 * If next_rq changes, update the queue's budget to fit
+		 * the new request.
+		 */
+		if (prev != bfqq->next_rq)
+			bfq_updated_next_req(bfqd, bfqq);
 	}
 }
 
-static void
-cfq_merged_requests(struct request_queue *q, struct request *rq,
-		    struct request *next)
+static void bfq_merged_requests(struct request_queue *q, struct request *rq,
+				struct request *next)
 {
-	struct cfq_queue *cfqq = RQ_CFQQ(rq);
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct bfq_queue *bfqq = RQ_BFQQ(rq), *next_bfqq = RQ_BFQQ(next);
 
 	/*
-	 * reposition in fifo if next is older than rq
+	 * If next and rq belong to the same bfq_queue and next is older
+	 * than rq, then reposition rq in the fifo (by substituting next
+	 * with rq). Otherwise, if next and rq belong to different
+	 * bfq_queues, never reposition rq: in fact, we would have to
+	 * reposition it with respect to next's position in its own fifo,
+	 * which would most certainly be too expensive with respect to
+	 * the benefits.
 	 */
-	if (!list_empty(&rq->queuelist) && !list_empty(&next->queuelist) &&
-	    next->fifo_time < rq->fifo_time &&
-	    cfqq == RQ_CFQQ(next)) {
-		list_move(&rq->queuelist, &next->queuelist);
+	if (bfqq == next_bfqq &&
+	    !list_empty(&rq->queuelist) && !list_empty(&next->queuelist) &&
+	    next->fifo_time < rq->fifo_time) {
+		list_del_init(&rq->queuelist);
+		list_replace_init(&next->queuelist, &rq->queuelist);
 		rq->fifo_time = next->fifo_time;
 	}
 
-	if (cfqq->next_rq == next)
-		cfqq->next_rq = rq;
-	cfq_remove_request(next);
+	if (bfqq->next_rq == next)
+		bfqq->next_rq = rq;
 
-	cfqq = RQ_CFQQ(next);
-	/*
-	 * all requests of this queue are merged to other queues, delete it
-	 * from the service tree. If it's the active_queue,
-	 * cfq_dispatch_requests() will choose to expire it or do idle
-	 */
-	if (cfq_cfqq_on_rr(cfqq) && RB_EMPTY_ROOT(&cfqq->sort_list) &&
-	    cfqq != cfqd->active_queue)
-		cfq_del_cfqq_rr(cfqd, cfqq);
+	bfq_remove_request(next);
 }
 
-static int cfq_allow_bio_merge(struct request_queue *q, struct request *rq,
+static int bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
 			       struct bio *bio)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
-	struct cfq_io_cq *cic;
-	struct cfq_queue *cfqq;
+	struct bfq_data *bfqd = q->elevator->elevator_data;
+	struct bfq_io_cq *bic;
+	struct bfq_queue *bfqq;
 
 	/*
 	 * Disallow merge of a sync bio into an async request.
 	 */
-	if (cfq_bio_sync(bio) && !rq_is_sync(rq))
+	if (bfq_bio_sync(bio) && !rq_is_sync(rq))
 		return false;
 
 	/*
-	 * Lookup the cfqq that this bio will be queued with and allow
+	 * Lookup the bfqq that this bio will be queued with. Allow
 	 * merge only if rq is queued there.
+	 * Queue lock is held here.
 	 */
-	cic = cfq_cic_lookup(cfqd, current->io_context);
-	if (!cic)
+	bic = bfq_bic_lookup(bfqd, current->io_context);
+	if (!bic)
 		return false;
 
-	cfqq = cic_to_cfqq(cic, cfq_bio_sync(bio));
-	return cfqq == RQ_CFQQ(rq);
-}
+	bfqq = bic_to_bfqq(bic, bfq_bio_sync(bio));
 
-static int cfq_allow_rq_merge(struct request_queue *q, struct request *rq,
-			      struct request *next)
-{
-	return RQ_CFQQ(rq) == RQ_CFQQ(next);
+	return bfqq == RQ_BFQQ(rq);
 }
 
-static inline void cfq_del_timer(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+static int bfq_allow_rq_merge(struct request_queue *q, struct request *rq,
+			      struct request *next)
 {
-	hrtimer_try_to_cancel(&cfqd->idle_slice_timer);
+	return RQ_BFQQ(rq) == RQ_BFQQ(next);
 }
 
-static void __cfq_set_active_queue(struct cfq_data *cfqd,
-				   struct cfq_queue *cfqq)
+static void __bfq_set_in_service_queue(struct bfq_data *bfqd,
+				       struct bfq_queue *bfqq)
 {
-	if (cfqq) {
-		cfq_log_cfqq(cfqd, cfqq, "set_active wl_class:%d",
-				cfqd->serving_wl_class);
-		cfqq->slice_start = 0;
-		cfqq->dispatch_start = ktime_get_ns();
-		cfqq->allocated_slice = 0;
-		cfqq->slice_end = 0;
-		cfqq->slice_dispatch = 0;
-		cfqq->nr_sectors = 0;
+	if (bfqq) {
+		bfq_mark_bfqq_must_alloc(bfqq);
+		bfq_mark_bfqq_budget_new(bfqq);
+		bfq_clear_bfqq_fifo_expire(bfqq);
 
-		cfq_clear_cfqq_wait_request(cfqq);
-		cfq_clear_cfqq_must_dispatch(cfqq);
-		cfq_clear_cfqq_must_alloc_slice(cfqq);
-		cfq_clear_cfqq_fifo_expire(cfqq);
-		cfq_mark_cfqq_slice_new(cfqq);
+		bfqd->budgets_assigned = (bfqd->budgets_assigned*7 + 256) / 8;
 
-		cfq_del_timer(cfqd, cfqq);
+		bfq_log_bfqq(bfqd, bfqq,
+			     "set_in_service_queue, cur-budget = %d",
+			     bfqq->entity.budget);
 	}
 
-	cfqd->active_queue = cfqq;
+	bfqd->in_service_queue = bfqq;
 }
 
 /*
- * current cfqq expired its slice (or was too idle), select new one
+ * Get and set a new queue for service.
  */
-static void
-__cfq_slice_expired(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-		    bool timed_out)
+static struct bfq_queue *bfq_set_in_service_queue(struct bfq_data *bfqd)
 {
-	cfq_log_cfqq(cfqd, cfqq, "slice expired t=%d", timed_out);
+	struct bfq_queue *bfqq = bfq_get_next_queue(bfqd);
 
-	if (cfq_cfqq_wait_request(cfqq))
-		cfq_del_timer(cfqd, cfqq);
+	__bfq_set_in_service_queue(bfqd, bfqq);
+	return bfqq;
+}
 
-	cfq_clear_cfqq_wait_request(cfqq);
-	cfq_clear_cfqq_wait_busy(cfqq);
+/*
+ * bfq_default_budget - return the default budget for @bfqq on @bfqd.
+ * @bfqd: the device descriptor.
+ * @bfqq: the queue to consider.
+ *
+ * We use 3/4 of the @bfqd maximum budget as the default value
+ * for the max_budget field of the queues.  This lets the feedback
+ * mechanism to start from some middle ground, then the behavior
+ * of the process will drive the heuristics towards high values, if
+ * it behaves as a greedy sequential reader, or towards small values
+ * if it shows a more intermittent behavior.
+ */
+static unsigned long bfq_default_budget(struct bfq_data *bfqd,
+					struct bfq_queue *bfqq)
+{
+	unsigned long budget;
 
 	/*
-	 * store what was left of this slice, if the queue idled/timed out
+	 * When we need an estimate of the peak rate we need to avoid
+	 * to give budgets that are too short due to previous measurements.
+	 * So, in the first 10 assignments use a ``safe'' budget value.
 	 */
-	if (timed_out) {
-		if (cfq_cfqq_slice_new(cfqq))
-			cfqq->slice_resid = cfq_scaled_cfqq_slice(cfqd, cfqq);
-		else
-			cfqq->slice_resid = cfqq->slice_end - ktime_get_ns();
-		cfq_log_cfqq(cfqd, cfqq, "resid=%lld", cfqq->slice_resid);
-	}
+	if (bfqd->budgets_assigned < 194 && bfqd->bfq_user_max_budget == 0)
+		budget = bfq_default_max_budget;
+	else
+		budget = bfqd->bfq_max_budget;
 
-	if (cfq_cfqq_on_rr(cfqq) && RB_EMPTY_ROOT(&cfqq->sort_list))
-		cfq_del_cfqq_rr(cfqd, cfqq);
+	return budget - budget / 4;
+}
 
-	cfq_resort_rr_list(cfqd, cfqq);
+static void bfq_arm_slice_timer(struct bfq_data *bfqd)
+{
+	struct bfq_queue *bfqq = bfqd->in_service_queue;
+	struct bfq_io_cq *bic;
+	unsigned long sl;
 
-	if (cfqq == cfqd->active_queue)
-		cfqd->active_queue = NULL;
+	/* Processes have exited, don't wait. */
+	bic = bfqd->in_service_bic;
+	if (!bic || atomic_read(&bic->icq.ioc->active_ref) == 0)
+		return;
 
-	if (cfqd->active_cic) {
-		put_io_context(cfqd->active_cic->icq.ioc);
-		cfqd->active_cic = NULL;
-	}
-}
+	bfq_mark_bfqq_wait_request(bfqq);
 
-static inline void cfq_slice_expired(struct cfq_data *cfqd, bool timed_out)
-{
-	struct cfq_queue *cfqq = cfqd->active_queue;
+	/*
+	 * We don't want to idle for seeks, but we do want to allow
+	 * fair distribution of slice time for a process doing back-to-back
+	 * seeks. So allow a little bit of time for him to submit a new rq.
+	 */
+	sl = bfqd->bfq_slice_idle;
+	/*
+	 * Grant only minimum idle time if the queue is seeky.
+	 */
+	if (BFQQ_SEEKY(bfqq))
+		sl = min_t(u64, sl, BFQ_MIN_TT);
 
-	if (cfqq)
-		__cfq_slice_expired(cfqd, cfqq, timed_out);
+	bfqd->last_idling_start = ktime_get();
+	hrtimer_start(&bfqd->idle_slice_timer, ns_to_ktime(sl),
+		      HRTIMER_MODE_REL);
 }
 
 /*
- * Get next queue for service.
+ * Set the maximum time for the in-service queue to consume its
+ * budget. This prevents seeky processes from lowering the disk
+ * throughput (always guaranteed with a time slice scheme as in CFQ).
  */
-static struct cfq_queue *cfq_get_next_queue(struct cfq_data *cfqd)
+static void bfq_set_budget_timeout(struct bfq_data *bfqd)
 {
-	struct cfq_rb_root *st = &cfqd->service_trees[cfqd->serving_wl_class];
+	struct bfq_queue *bfqq = bfqd->in_service_queue;
+	unsigned int timeout_coeff = bfqq->entity.weight /
+				     bfqq->entity.orig_weight;
 
-	if (!cfqd->rq_queued)
-		return NULL;
+	bfqd->last_budget_start = ktime_get();
 
-	/* There is nothing to dispatch */
-	if (!st)
-		return NULL;
-	if (RB_EMPTY_ROOT(&st->rb))
-		return NULL;
-	return cfq_rb_first(st);
+	bfq_clear_bfqq_budget_new(bfqq);
+	bfqq->budget_timeout = jiffies +
+		bfqd->bfq_timeout * timeout_coeff;
+
+	bfq_log_bfqq(bfqd, bfqq, "set budget_timeout %u",
+		jiffies_to_msecs(bfqd->bfq_timeout * timeout_coeff));
 }
 
-static struct cfq_queue *cfq_get_next_queue_forced(struct cfq_data *cfqd)
+/*
+ * Move request from internal lists to the request queue dispatch list.
+ */
+static void bfq_dispatch_insert(struct request_queue *q, struct request *rq)
 {
-	struct cfq_queue *cfqq;
-	int i, j;
-	struct cfq_rb_root *st;
+	struct bfq_queue *bfqq = RQ_BFQQ(rq);
 
-	if (!cfqd->rq_queued)
-		return NULL;
+	/*
+	 * For consistency, the next instruction should have been executed
+	 * after removing the request from the queue and dispatching it.
+	 * We execute instead this instruction before bfq_remove_request()
+	 * (and hence introduce a temporary inconsistency), for efficiency.
+	 * In fact, in a forced_dispatch, this prevents two counters related
+	 * to bfqq->dispatched to risk to be uselessly decremented if bfqq
+	 * is not in service, and then to be incremented again after
+	 * incrementing bfqq->dispatched.
+	 */
+	bfqq->dispatched++;
 
-	for_each_st(cfqd, i, j, st)
-		if ((cfqq = cfq_rb_first(st)) != NULL)
-			return cfqq;
-	return NULL;
+	bfq_remove_request(rq);
+	elv_dispatch_sort(q, rq);
 }
 
 /*
- * Get and set a new active queue for service.
+ * Return expired entry, or NULL to just start from scratch in rbtree.
  */
-static struct cfq_queue *cfq_set_active_queue(struct cfq_data *cfqd,
-					      struct cfq_queue *cfqq)
+static struct request *bfq_check_fifo(struct bfq_queue *bfqq)
 {
-	if (!cfqq)
-		cfqq = cfq_get_next_queue(cfqd);
+	struct request *rq = NULL;
 
-	__cfq_set_active_queue(cfqd, cfqq);
-	return cfqq;
+	if (bfq_bfqq_fifo_expire(bfqq))
+		return NULL;
+
+	bfq_mark_bfqq_fifo_expire(bfqq);
+
+	if (list_empty(&bfqq->fifo))
+		return NULL;
+
+	rq = rq_entry_fifo(bfqq->fifo.next);
+
+	if (ktime_get_ns() < rq->fifo_time)
+		return NULL;
+
+	return rq;
 }
 
-static inline sector_t cfq_dist_from_last(struct cfq_data *cfqd,
-					  struct request *rq)
+static void __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
-	if (blk_rq_pos(rq) >= cfqd->last_position)
-		return blk_rq_pos(rq) - cfqd->last_position;
+	__bfq_bfqd_reset_in_service(bfqd);
+
+	if (RB_EMPTY_ROOT(&bfqq->sort_list))
+		bfq_del_bfqq_busy(bfqd, bfqq, 1);
 	else
-		return cfqd->last_position - blk_rq_pos(rq);
+		bfq_activate_bfqq(bfqd, bfqq);
 }
 
-/*
- * Determine whether we should enforce idle window for this queue.
+/**
+ * __bfq_bfqq_recalc_budget - try to adapt the budget to the @bfqq behavior.
+ * @bfqd: device data.
+ * @bfqq: queue to update.
+ * @reason: reason for expiration.
+ *
+ * Handle the feedback on @bfqq budget at queue expiration.
+ * See the body for detailed comments.
  */
-
-static bool cfq_should_idle(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+static void __bfq_bfqq_recalc_budget(struct bfq_data *bfqd,
+				     struct bfq_queue *bfqq,
+				     enum bfqq_expiration reason)
 {
-	enum wl_class_t wl_class = cfqq_class(cfqq);
-	struct cfq_rb_root *st = cfqq->service_tree;
+	struct request *next_rq;
+	int budget, min_budget;
 
-	BUG_ON(!st);
-	BUG_ON(!st->count);
+	budget = bfqq->max_budget;
+	min_budget = bfq_min_budget(bfqd);
 
-	if (!cfqd->cfq_slice_idle)
-		return false;
+	bfq_log_bfqq(bfqd, bfqq, "recalc_budg: last budg %d, budg left %d",
+		bfqq->entity.budget, bfq_bfqq_budget_left(bfqq));
+	bfq_log_bfqq(bfqd, bfqq, "recalc_budg: last max_budg %d, min budg %d",
+		budget, bfq_min_budget(bfqd));
+	bfq_log_bfqq(bfqd, bfqq, "recalc_budg: sync %d, seeky %d",
+		bfq_bfqq_sync(bfqq), BFQQ_SEEKY(bfqd->in_service_queue));
 
-	/* We never do for idle class queues. */
-	if (wl_class == IDLE_WORKLOAD)
-		return false;
+	if (bfq_bfqq_sync(bfqq)) {
+		switch (reason) {
+		/*
+		 * Caveat: in all the following cases we trade latency
+		 * for throughput.
+		 */
+		case BFQ_BFQQ_TOO_IDLE:
+			if (budget > min_budget + BFQ_BUDGET_STEP)
+				budget -= BFQ_BUDGET_STEP;
+			else
+				budget = min_budget;
+			break;
+		case BFQ_BFQQ_BUDGET_TIMEOUT:
+			budget = bfq_default_budget(bfqd, bfqq);
+			break;
+		case BFQ_BFQQ_BUDGET_EXHAUSTED:
+			/*
+			 * The process still has backlog, and did not
+			 * let either the budget timeout or the disk
+			 * idling timeout expire. Hence it is not
+			 * seeky, has a short thinktime and may be
+			 * happy with a higher budget too. So
+			 * definitely increase the budget of this good
+			 * candidate to boost the disk throughput.
+			 */
+			budget = min(budget + 8 * BFQ_BUDGET_STEP,
+				     bfqd->bfq_max_budget);
+			break;
+		case BFQ_BFQQ_NO_MORE_REQUESTS:
+			/*
+			 * For queues that expire for this reason, it
+			 * is particularly important to keep the
+			 * budget close to the actual service they
+			 * need. Doing so reduces the timestamp
+			 * misalignment problem described in the
+			 * comments in the body of
+			 * __bfq_activate_entity. In fact, suppose
+			 * that a queue systematically expires for
+			 * BFQ_BFQQ_NO_MORE_REQUESTS and presents a
+			 * new request in time to enjoy timestamp
+			 * back-shifting. The larger the budget of the
+			 * queue is with respect to the service the
+			 * queue actually requests in each service
+			 * slot, the more times the queue can be
+			 * reactivated with the same virtual finish
+			 * time. It follows that, even if this finish
+			 * time is pushed to the system virtual time
+			 * to reduce the consequent timestamp
+			 * misalignment, the queue unjustly enjoys for
+			 * many re-activations a lower finish time
+			 * than all newly activated queues.
+			 *
+			 * The service needed by bfqq is measured
+			 * quite precisely by bfqq->entity.service.
+			 * Since bfqq does not enjoy device idling,
+			 * bfqq->entity.service is equal to the number
+			 * of sectors that the process associated with
+			 * bfqq requested to read/write before waiting
+			 * for request completions, or blocking for
+			 * other reasons.
+			 */
+			budget = max_t(int, bfqq->entity.service, min_budget);
+			break;
+		default:
+			return;
+		}
+	} else
+		/*
+		 * Async queues get always the maximum possible
+		 * budget, as for them we do not care about latency
+		 * (in addition, their ability to dispatch is limited
+		 * by the charging factor).
+		 */
+		budget = bfqd->bfq_max_budget;
 
-	/* We do for queues that were marked with idle window flag. */
-	if (cfq_cfqq_idle_window(cfqq))
-		return true;
+	bfqq->max_budget = budget;
+
+	if (bfqd->budgets_assigned >= bfq_stats_min_budgets &&
+	    !bfqd->bfq_user_max_budget)
+		bfqq->max_budget = min(bfqq->max_budget, bfqd->bfq_max_budget);
 
 	/*
-	 * Otherwise, we do only if they are the last ones
-	 * in their service tree.
+	 * If there is still backlog, then assign a new budget, making
+	 * sure that it is large enough for the next request.  Since
+	 * the finish time of bfqq must be kept in sync with the
+	 * budget, be sure to call __bfq_bfqq_expire() *after* this
+	 * update.
+	 *
+	 * If there is no backlog, then no need to update the budget;
+	 * it will be updated on the arrival of a new request.
 	 */
-	if (st->count == 1 && cfq_cfqq_sync(cfqq) &&
-	   !cfq_io_thinktime_big(cfqd, &st->ttime))
-		return true;
-	cfq_log_cfqq(cfqd, cfqq, "Not idling. st->count:%d", st->count);
-	return false;
+	next_rq = bfqq->next_rq;
+	if (next_rq)
+		bfqq->entity.budget = max_t(unsigned long, bfqq->max_budget,
+					    bfq_serv_to_charge(next_rq, bfqq));
+
+	bfq_log_bfqq(bfqd, bfqq, "head sect: %u, new budget %d",
+			next_rq ? blk_rq_sectors(next_rq) : 0,
+			bfqq->entity.budget);
 }
 
-static void cfq_arm_slice_timer(struct cfq_data *cfqd)
+static unsigned long bfq_calc_max_budget(u64 peak_rate, u64 timeout)
 {
-	struct cfq_queue *cfqq = cfqd->active_queue;
-	struct cfq_io_cq *cic;
-	u64 sl;
-	u64 now = ktime_get_ns();
-
-	WARN_ON(!RB_EMPTY_ROOT(&cfqq->sort_list));
-	WARN_ON(cfq_cfqq_slice_new(cfqq));
+	unsigned long max_budget;
 
 	/*
-	 * still active requests from this queue, don't idle
+	 * The max_budget calculated when autotuning is equal to the
+	 * amount of sectors transferred in timeout at the
+	 * estimated peak rate.
 	 */
-	if (cfqq->dispatched)
-		return;
+	max_budget = (unsigned long)(peak_rate * 1000 *
+				     timeout >> BFQ_RATE_SHIFT);
+
+	return max_budget;
+}
+
+/*
+ * In addition to updating the peak rate, checks whether the process
+ * is "slow", and returns 1 if so. This slow flag is used, in addition
+ * to the budget timeout, to reduce the amount of service provided to
+ * seeky processes, and hence reduce their chances to lower the
+ * throughput. See the code for more details.
+ */
+static bool bfq_update_peak_rate(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+				 bool compensate)
+{
+	u64 bw, usecs, expected, timeout;
+	ktime_t delta;
+	int update = 0;
+
+	if (!bfq_bfqq_sync(bfqq) || bfq_bfqq_budget_new(bfqq))
+		return false;
+
+	if (compensate)
+		delta = bfqd->last_idling_start;
+	else
+		delta = ktime_get();
+	delta = ktime_sub(delta, bfqd->last_budget_start);
+	usecs = ktime_to_us(delta);
+
+	/* Don't trust short/unrealistic values. */
+	if (usecs < 100 || usecs >= LONG_MAX)
+		return false;
 
 	/*
-	 * task has exited, don't wait
+	 * Calculate the bandwidth for the last slice.  We use a 64 bit
+	 * value to store the peak rate, in sectors per usec in fixed
+	 * point math.  We do so to have enough precision in the estimate
+	 * and to avoid overflows.
 	 */
-	cic = cfqd->active_cic;
-	if (!cic || !atomic_read(&cic->icq.ioc->active_ref))
-		return;
+	bw = (u64)bfqq->entity.service << BFQ_RATE_SHIFT;
+	do_div(bw, (unsigned long)usecs);
+
+	timeout = jiffies_to_msecs(bfqd->bfq_timeout);
 
 	/*
-	 * If our average think time is larger than the remaining time
-	 * slice, then don't idle. This avoids overrunning the allotted
-	 * time slice.
+	 * Use only long (> 20ms) intervals to filter out spikes for
+	 * the peak rate estimation.
 	 */
-	if (sample_valid(cic->ttime.ttime_samples) &&
-	    (cfqq->slice_end - now < cic->ttime.ttime_mean)) {
-		cfq_log_cfqq(cfqd, cfqq, "Not idling. think_time:%llu",
-			     cic->ttime.ttime_mean);
-		return;
-	}
+	if (usecs > 20000) {
+		if (bw > bfqd->peak_rate) {
+			bfqd->peak_rate = bw;
+			update = 1;
+			bfq_log(bfqd, "new peak_rate=%llu", bw);
+		}
 
-	cfq_mark_cfqq_wait_request(cfqq);
+		update |= bfqd->peak_rate_samples == BFQ_PEAK_RATE_SAMPLES - 1;
 
-	sl = cfqd->cfq_slice_idle;
+		if (bfqd->peak_rate_samples < BFQ_PEAK_RATE_SAMPLES)
+			bfqd->peak_rate_samples++;
 
-	hrtimer_start(&cfqd->idle_slice_timer, ns_to_ktime(sl),
-		      HRTIMER_MODE_REL);
-	cfq_log_cfqq(cfqd, cfqq, "arm_idle: %llu", sl);
-}
+		if (bfqd->peak_rate_samples == BFQ_PEAK_RATE_SAMPLES &&
+		    update && bfqd->bfq_user_max_budget == 0) {
+			bfqd->bfq_max_budget =
+				bfq_calc_max_budget(bfqd->peak_rate,
+						    timeout);
+			bfq_log(bfqd, "new max_budget=%d",
+				bfqd->bfq_max_budget);
+		}
+	}
 
-static inline int cfq_busy_queues_wl(enum wl_class_t wl_class,
-				     struct cfq_data *cfqd)
-{
-	if (wl_class == IDLE_WORKLOAD)
-		return cfqd->service_tree_idle.count;
+	/*
+	 * A process is considered ``slow'' (i.e., seeky, so that we
+	 * cannot treat it fairly in the service domain, as it would
+	 * slow down too much the other processes) if, when a slice
+	 * ends for whatever reason, it has received service at a
+	 * rate that would not be high enough to complete the budget
+	 * before the budget timeout expiration.
+	 */
+	expected = bw * 1000 * timeout >> BFQ_RATE_SHIFT;
 
-	return cfqd->service_trees[wl_class].count;
+	/*
+	 * Caveat: processes doing IO in the slower disk zones will
+	 * tend to be slow(er) even if not seeky. And the estimated
+	 * peak rate will actually be an average over the disk
+	 * surface. Hence, to not be too harsh with unlucky processes,
+	 * we keep a budget/3 margin of safety before declaring a
+	 * process slow.
+	 */
+	return expected > (4 * bfqq->entity.budget) / 3;
 }
 
 /*
- * Move request from internal lists to the request queue dispatch list.
+ * Return the farthest past time instant according to jiffies
+ * macros.
  */
-static void cfq_dispatch_insert(struct request_queue *q, struct request *rq)
+static unsigned long bfq_smallest_from_now(void)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
-	struct cfq_queue *cfqq = RQ_CFQQ(rq);
-
-	cfq_log_cfqq(cfqd, cfqq, "dispatch_insert");
-
-	cfqq->next_rq = cfq_find_next_rq(cfqd, cfqq, rq);
-	cfq_remove_request(rq);
-	cfqq->dispatched++;
-	elv_dispatch_sort(q, rq);
-
-	cfqd->rq_in_flight[cfq_cfqq_sync(cfqq)]++;
-	cfqq->nr_sectors += blk_rq_sectors(rq);
+	return jiffies - MAX_JIFFY_OFFSET;
 }
 
-/*
- * return expired entry, or NULL to just start from scratch in rbtree
+/**
+ * bfq_bfqq_expire - expire a queue.
+ * @bfqd: device owning the queue.
+ * @bfqq: the queue to expire.
+ * @compensate: if true, compensate for the time spent idling.
+ * @reason: the reason causing the expiration.
+ *
+ *
+ * If the process associated with the queue is slow (i.e., seeky), or
+ * in case of budget timeout, or, finally, if it is async, we
+ * artificially charge it an entire budget (independently of the
+ * actual service it received). As a consequence, the queue will get
+ * higher timestamps than the correct ones upon reactivation, and
+ * hence it will be rescheduled as if it had received more service
+ * than what it actually received. In the end, this class of processes
+ * will receive less service in proportion to how slowly they consume
+ * their budgets (and hence how seriously they tend to lower the
+ * throughput).
+ *
+ * In contrast, when a queue expires because it has been idling for
+ * too much or because it exhausted its budget, we do not touch the
+ * amount of service it has received. Hence when the queue will be
+ * reactivated and its timestamps updated, the latter will be in sync
+ * with the actual service received by the queue until expiration.
+ *
+ * Charging a full budget to the first type of queues and the exact
+ * service to the others has the effect of using the WF2Q+ policy to
+ * schedule the former on a timeslice basis, without violating the
+ * service domain guarantees of the latter.
  */
-static struct request *cfq_check_fifo(struct cfq_queue *cfqq)
+static void bfq_bfqq_expire(struct bfq_data *bfqd,
+			    struct bfq_queue *bfqq,
+			    bool compensate,
+			    enum bfqq_expiration reason)
 {
-	struct request *rq = NULL;
+	bool slow;
 
-	if (cfq_cfqq_fifo_expire(cfqq))
-		return NULL;
+	/*
+	 * Update device peak rate for autotuning and check whether the
+	 * process is slow (see bfq_update_peak_rate).
+	 */
+	slow = bfq_update_peak_rate(bfqd, bfqq, compensate);
 
-	cfq_mark_cfqq_fifo_expire(cfqq);
+	/*
+	 * As above explained, 'punish' slow (i.e., seeky), timed-out
+	 * and async queues, to favor sequential sync workloads.
+	 */
+	if (slow || reason == BFQ_BFQQ_BUDGET_TIMEOUT)
+		bfq_bfqq_charge_full_budget(bfqq);
 
-	if (list_empty(&cfqq->fifo))
-		return NULL;
+	if (reason == BFQ_BFQQ_TOO_IDLE &&
+	    bfqq->entity.service <= 2 * bfqq->entity.budget / 10)
+		bfq_clear_bfqq_IO_bound(bfqq);
 
-	rq = rq_entry_fifo(cfqq->fifo.next);
-	if (ktime_get_ns() < rq->fifo_time)
-		rq = NULL;
+	bfq_log_bfqq(bfqd, bfqq,
+		"expire (%d, slow %d, num_disp %d, idle_win %d)", reason,
+		slow, bfqq->dispatched, bfq_bfqq_idle_window(bfqq));
 
-	cfq_log_cfqq(cfqq->cfqd, cfqq, "fifo=%p", rq);
-	return rq;
+	/*
+	 * Increase, decrease or leave budget unchanged according to
+	 * reason.
+	 */
+	__bfq_bfqq_recalc_budget(bfqd, bfqq, reason);
+	__bfq_bfqq_expire(bfqd, bfqq);
+
+	if (!bfq_bfqq_busy(bfqq) &&
+	    reason != BFQ_BFQQ_BUDGET_TIMEOUT &&
+	    reason != BFQ_BFQQ_BUDGET_EXHAUSTED)
+		bfq_mark_bfqq_non_blocking_wait_rq(bfqq);
 }
 
-static inline int
-cfq_prio_to_maxrq(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+/*
+ * Budget timeout is not implemented through a dedicated timer, but
+ * just checked on request arrivals and completions, as well as on
+ * idle timer expirations.
+ */
+static bool bfq_bfqq_budget_timeout(struct bfq_queue *bfqq)
 {
-	const int base_rq = cfqd->cfq_slice_async_rq;
+	if (bfq_bfqq_budget_new(bfqq) ||
+	    time_before(jiffies, bfqq->budget_timeout))
+		return false;
+	return true;
+}
 
-	WARN_ON(cfqq->ioprio >= IOPRIO_BE_NR);
+/*
+ * If we expire a queue that is actively waiting (i.e., with the
+ * device idled) for the arrival of a new request, then we may incur
+ * the timestamp misalignment problem described in the body of the
+ * function __bfq_activate_entity. Hence we return true only if this
+ * condition does not hold, or if the queue is slow enough to deserve
+ * only to be kicked off for preserving a high throughput.
+ */
+static bool bfq_may_expire_for_budg_timeout(struct bfq_queue *bfqq)
+{
+	bfq_log_bfqq(bfqq->bfqd, bfqq,
+		"may_budget_timeout: wait_request %d left %d timeout %d",
+		bfq_bfqq_wait_request(bfqq),
+			bfq_bfqq_budget_left(bfqq) >=  bfqq->entity.budget / 3,
+		bfq_bfqq_budget_timeout(bfqq));
 
-	return 2 * base_rq * (IOPRIO_BE_NR - cfqq->ioprio);
+	return (!bfq_bfqq_wait_request(bfqq) ||
+		bfq_bfqq_budget_left(bfqq) >=  bfqq->entity.budget / 3)
+		&&
+		bfq_bfqq_budget_timeout(bfqq);
 }
 
-static void
-choose_wl_class_and_type(struct cfq_data *cfqd)
-{
-	u64 slice;
-	unsigned count;
-	struct cfq_rb_root *st;
-	enum wl_class_t original_class = cfqd->serving_wl_class;
-	u64 now = ktime_get_ns();
-
-	/* Choose next priority. RT > BE > IDLE */
-	if (cfq_busy_queues_wl(RT_WORKLOAD, cfqd))
-		cfqd->serving_wl_class = RT_WORKLOAD;
-	else if (cfq_busy_queues_wl(BE_WORKLOAD, cfqd))
-		cfqd->serving_wl_class = BE_WORKLOAD;
-	else {
-		cfqd->serving_wl_class = IDLE_WORKLOAD;
-		cfqd->workload_expires = now + jiffies_to_nsecs(1);
-		return;
-	}
+/*
+ * For a queue that becomes empty, device idling is allowed only if
+ * this function returns true for the queue. And this function returns
+ * true only if idling is beneficial for throughput.
+ */
+static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
+{
+	struct bfq_data *bfqd = bfqq->bfqd;
+	bool idling_boosts_thr;
 
-	if (original_class != cfqd->serving_wl_class)
-		goto new_workload;
+	if (bfqd->strict_guarantees)
+		return true;
 
-	st = &cfqd->service_trees[cfqd->serving_wl_class];
-	count = st->count;
+	/*
+	 * The value of the next variable is computed considering that
+	 * idling is usually beneficial for the throughput if:
+	 * (a) the device is not NCQ-capable, or
+	 * (b) regardless of the presence of NCQ, the request pattern
+	 *     for bfqq is I/O-bound (possible throughput losses
+	 *     caused by granting idling to seeky queues are mitigated
+	 *     by the fact that, in all scenarios where boosting
+	 *     throughput is the best thing to do, i.e., in all
+	 *     symmetric scenarios, only a minimal idle time is
+	 *     allowed to seeky queues).
+	 */
+	idling_boosts_thr = !bfqd->hw_tag || bfq_bfqq_IO_bound(bfqq);
 
 	/*
-	 * check workload expiration, and that we still have other queues ready
+	 * We have now the components we need to compute the return
+	 * value of the function, which is true only if both the
+	 * following conditions hold:
+	 * 1) bfqq is sync, because idling make sense only for sync queues;
+	 * 2) idling boosts the throughput.
 	 */
-	if (count && !(now > cfqd->workload_expires))
-		return;
+	return bfq_bfqq_sync(bfqq) && idling_boosts_thr;
+}
 
-new_workload:
-	st = &cfqd->service_trees[cfqd->serving_wl_class];
-	count = st->count;
+/*
+ * If the in-service queue is empty but the function bfq_bfqq_may_idle
+ * returns true, then:
+ * 1) the queue must remain in service and cannot be expired, and
+ * 2) the device must be idled to wait for the possible arrival of a new
+ *    request for the queue.
+ * See the comments on the function bfq_bfqq_may_idle for the reasons
+ * why performing device idling is the best choice to boost the throughput
+ * and preserve service guarantees when bfq_bfqq_may_idle itself
+ * returns true.
+ */
+static bool bfq_bfqq_must_idle(struct bfq_queue *bfqq)
+{
+	struct bfq_data *bfqd = bfqq->bfqd;
 
-	/* sync workload slice is at least 2 * cfq_slice_idle */
-	slice = max_t(u64, 2 * cfqd->cfq_slice_idle, CFQ_MIN_TT);
-	cfq_log(cfqd, "workload slice:%llu", slice);
-	cfqd->workload_expires = now + slice;
+	return RB_EMPTY_ROOT(&bfqq->sort_list) && bfqd->bfq_slice_idle != 0 &&
+	       bfq_bfqq_may_idle(bfqq);
 }
 
 /*
- * Select a queue for service. If we have a current active queue,
+ * Select a queue for service.  If we have a current queue in service,
  * check whether to continue servicing it, or retrieve and set a new one.
  */
-static struct cfq_queue *cfq_select_queue(struct cfq_data *cfqd)
+static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 {
-	struct cfq_queue *cfqq, *new_cfqq = NULL;
-	u64 now = ktime_get_ns();
+	struct bfq_queue *bfqq;
+	struct request *next_rq;
+	enum bfqq_expiration reason = BFQ_BFQQ_BUDGET_TIMEOUT;
 
-	cfqq = cfqd->active_queue;
-	if (!cfqq)
+	bfqq = bfqd->in_service_queue;
+	if (!bfqq)
 		goto new_queue;
 
-	if (!cfqd->rq_queued)
-		return NULL;
+	bfq_log_bfqq(bfqd, bfqq, "select_queue: already in-service queue");
 
-	if (cfq_cfqq_wait_busy(cfqq) && !RB_EMPTY_ROOT(&cfqq->sort_list))
+	if (bfq_may_expire_for_budg_timeout(bfqq) &&
+	    !hrtimer_active(&bfqd->idle_slice_timer) &&
+	    !bfq_bfqq_must_idle(bfqq))
 		goto expire;
 
+	next_rq = bfqq->next_rq;
 	/*
-	 * The active queue has run out of time, expire it and select new.
+	 * If bfqq has requests queued and it has enough budget left to
+	 * serve them, keep the queue, otherwise expire it.
 	 */
-	if (cfq_slice_used(cfqq) && !cfq_cfqq_must_dispatch(cfqq)) {
-		/*
-		 * If slice had not expired at the completion of last request
-		 * we might not have turned on wait_busy flag. Don't expire
-		 * the queue yet. Allow the device to get backlogged.
-		 *
-		 * The very fact that we have used the slice, that means we
-		 * have been idling all along on this queue and it should be
-		 * ok to wait for this request to complete.
-		 */
-		if (cfqd->busy_queues == 1 && RB_EMPTY_ROOT(&cfqq->sort_list)
-		    && cfqq->dispatched && cfq_should_idle(cfqd, cfqq)) {
-			cfqq = NULL;
+	if (next_rq) {
+		if (bfq_serv_to_charge(next_rq, bfqq) >
+			bfq_bfqq_budget_left(bfqq)) {
+			reason = BFQ_BFQQ_BUDGET_EXHAUSTED;
+			goto expire;
+		} else {
+			/*
+			 * The idle timer may be pending because we may
+			 * not disable disk idling even when a new request
+			 * arrives.
+			 */
+			if (hrtimer_active(&bfqd->idle_slice_timer)) {
+				/*
+				 * If we get here: 1) at least a new request
+				 * has arrived but we have not disabled the
+				 * timer because the request was too small,
+				 * 2) then the block layer has unplugged
+				 * the device, causing the dispatch to be
+				 * invoked.
+				 *
+				 * Since the device is unplugged, now the
+				 * requests are probably large enough to
+				 * provide a reasonable throughput.
+				 * So we disable idling.
+				 */
+				bfq_clear_bfqq_wait_request(bfqq);
+				hrtimer_try_to_cancel(&bfqd->idle_slice_timer);
+			}
 			goto keep_queue;
 		}
 	}
 
 	/*
-	 * The active queue has requests and isn't expired, allow it to
-	 * dispatch.
-	 */
-	if (!RB_EMPTY_ROOT(&cfqq->sort_list))
-		goto keep_queue;
-
-	/*
-	 * No requests pending. If the active queue still has requests in
-	 * flight or is idling for a new request, allow either of these
-	 * conditions to happen (or time out) before selecting a new queue.
+	 * No requests pending. However, if the in-service queue is idling
+	 * for a new request, or has requests waiting for a completion and
+	 * may idle after their completion, then keep it anyway.
 	 */
-	if (hrtimer_active(&cfqd->idle_slice_timer)) {
-		cfqq = NULL;
-		goto keep_queue;
-	}
-
-	/*
-	 * The device is much faster than the queue can deliver: don't idle
-	 **/
-	if (CFQQ_SEEKY(cfqq) && cfq_cfqq_idle_window(cfqq) &&
-	    (cfq_cfqq_slice_new(cfqq) ||
-	     (cfqq->slice_end - now > now - cfqq->slice_start)))
-		cfq_clear_cfqq_idle_window(cfqq);
-
-	if (cfqq->dispatched && cfq_should_idle(cfqd, cfqq)) {
-		cfqq = NULL;
+	if (hrtimer_active(&bfqd->idle_slice_timer) ||
+	    (bfqq->dispatched != 0 && bfq_bfqq_may_idle(bfqq))) {
+		bfqq = NULL;
 		goto keep_queue;
 	}
 
+	reason = BFQ_BFQQ_NO_MORE_REQUESTS;
 expire:
-	cfq_slice_expired(cfqd, 0);
+	bfq_bfqq_expire(bfqd, bfqq, false, reason);
 new_queue:
-	/*
-	 * Current queue expired. Check if we have to switch to a new
-	 * service tree
-	 */
-	if (!new_cfqq)
-		choose_wl_class_and_type(cfqd);
-
-	cfqq = cfq_set_active_queue(cfqd, new_cfqq);
+	bfqq = bfq_set_in_service_queue(bfqd);
+	bfq_log(bfqd, "select_queue: new queue %d returned",
+		bfqq ? bfqq->pid : 0);
 keep_queue:
-	return cfqq;
-}
-
-static int __cfq_forced_dispatch_cfqq(struct cfq_queue *cfqq)
-{
-	int dispatched = 0;
-
-	while (cfqq->next_rq) {
-		cfq_dispatch_insert(cfqq->cfqd->queue, cfqq->next_rq);
-		dispatched++;
-	}
-
-	BUG_ON(!list_empty(&cfqq->fifo));
-
-	/* By default cfqq is not expired if it is empty. Do it explicitly */
-	__cfq_slice_expired(cfqq->cfqd, cfqq, 0);
-	return dispatched;
+	return bfqq;
 }
 
 /*
- * Drain our current requests. Used for barriers and when switching
- * io schedulers on-the-fly.
+ * Dispatch one request from bfqq, moving it to the request queue
+ * dispatch list.
  */
-static int cfq_forced_dispatch(struct cfq_data *cfqd)
+static int bfq_dispatch_request(struct bfq_data *bfqd,
+				struct bfq_queue *bfqq)
 {
-	struct cfq_queue *cfqq;
 	int dispatched = 0;
+	struct request *rq;
+	unsigned long service_to_charge;
 
-	/* Expire the timeslice of the current active queue first */
-	cfq_slice_expired(cfqd, 0);
-	while ((cfqq = cfq_get_next_queue_forced(cfqd)) != NULL) {
-		__cfq_set_active_queue(cfqd, cfqq);
-		dispatched += __cfq_forced_dispatch_cfqq(cfqq);
-	}
-
-	BUG_ON(cfqd->busy_queues);
-
-	cfq_log(cfqd, "forced_dispatch=%d", dispatched);
-	return dispatched;
-}
-
-static inline bool cfq_slice_used_soon(struct cfq_data *cfqd,
-	struct cfq_queue *cfqq)
-{
-	u64 now = ktime_get_ns();
-
-	/* the queue hasn't finished any request, can't estimate */
-	if (cfq_cfqq_slice_new(cfqq))
-		return true;
-	if (now + cfqd->cfq_slice_idle * cfqq->dispatched > cfqq->slice_end)
-		return true;
-
-	return false;
-}
-
-static bool cfq_may_dispatch(struct cfq_data *cfqd, struct cfq_queue *cfqq)
-{
-	unsigned int max_dispatch;
-
-	/*
-	 * Drain async requests before we start sync IO
-	 */
-	if (cfq_should_idle(cfqd, cfqq) && cfqd->rq_in_flight[BLK_RW_ASYNC])
-		return false;
-
-	/*
-	 * If this is an async queue and we have sync IO in flight, let it wait
-	 */
-	if (cfqd->rq_in_flight[BLK_RW_SYNC] && !cfq_cfqq_sync(cfqq))
-		return false;
-
-	max_dispatch = max_t(unsigned int, cfqd->cfq_quantum / 2, 1);
-	if (cfq_class_idle(cfqq))
-		max_dispatch = 1;
+	/* Follow expired path, else get first next available. */
+	rq = bfq_check_fifo(bfqq);
+	if (!rq)
+		rq = bfqq->next_rq;
+	service_to_charge = bfq_serv_to_charge(rq, bfqq);
 
-	/*
-	 * Does this cfqq already have too much IO in flight?
-	 */
-	if (cfqq->dispatched >= max_dispatch) {
-		bool promote_sync = false;
+	if (service_to_charge > bfq_bfqq_budget_left(bfqq)) {
 		/*
-		 * idle queue must always only have a single IO in flight
+		 * This may happen if the next rq is chosen in fifo order
+		 * instead of sector order. The budget is properly
+		 * dimensioned to be always sufficient to serve the next
+		 * request only if it is chosen in sector order. The reason
+		 * is that it would be quite inefficient and little useful
+		 * to always make sure that the budget is large enough to
+		 * serve even the possible next rq in fifo order.
+		 * In fact, requests are seldom served in fifo order.
+		 *
+		 * Expire the queue for budget exhaustion, and make sure
+		 * that the next act_budget is enough to serve the next
+		 * request, even if it comes from the fifo expired path.
 		 */
-		if (cfq_class_idle(cfqq))
-			return false;
-
+		bfqq->next_rq = rq;
 		/*
-		 * If there is only one sync queue
-		 * we can ignore async queue here and give the sync
-		 * queue no dispatch limit. The reason is a sync queue can
-		 * preempt async queue, limiting the sync queue doesn't make
-		 * sense. This is useful for aiostress test.
+		 * Since this dispatch is failed, make sure that
+		 * a new one will be performed
 		 */
-		if (cfq_cfqq_sync(cfqq) && cfqd->busy_sync_queues == 1)
-			promote_sync = true;
+		if (!bfqd->rq_in_driver)
+			bfq_schedule_dispatch(bfqd);
+		goto expire;
+	}
 
-		/*
-		 * We have other queues, don't allow more IO from this one
-		 */
-		if (cfqd->busy_queues > 1 && cfq_slice_used_soon(cfqd, cfqq) &&
-				!promote_sync)
-			return false;
+	/* Finally, insert request into driver dispatch list. */
+	bfq_bfqq_served(bfqq, service_to_charge);
+	bfq_dispatch_insert(bfqd->queue, rq);
 
-		/*
-		 * Sole queue user, no limit
-		 */
-		if (cfqd->busy_queues == 1 || promote_sync)
-			max_dispatch = -1;
-		else
-			/*
-			 * Normally we start throttling cfqq when cfq_quantum/2
-			 * requests have been dispatched. But we can drive
-			 * deeper queue depths at the beginning of slice
-			 * subjected to upper limit of cfq_quantum.
-			 * */
-			max_dispatch = cfqd->cfq_quantum;
+	bfq_log_bfqq(bfqd, bfqq,
+			"dispatched %u sec req (%llu), budg left %d",
+			blk_rq_sectors(rq),
+			(unsigned long long)blk_rq_pos(rq),
+			bfq_bfqq_budget_left(bfqq));
+
+	dispatched++;
+
+	if (!bfqd->in_service_bic) {
+		atomic_long_inc(&RQ_BIC(rq)->icq.ioc->refcount);
+		bfqd->in_service_bic = RQ_BIC(rq);
 	}
 
-	/*
-	 * Async queues must wait a bit before being allowed dispatch.
-	 * We also ramp up the dispatch depth gradually for async IO,
-	 * based on the last sync IO we serviced
-	 */
-	if (!cfq_cfqq_sync(cfqq)) {
-		u64 last_sync = ktime_get_ns() - cfqd->last_delayed_sync;
-		unsigned int depth;
+	if (bfqd->busy_queues > 1 && bfq_class_idle(bfqq))
+		goto expire;
+
+	return dispatched;
+
+expire:
+	bfq_bfqq_expire(bfqd, bfqq, false, BFQ_BFQQ_BUDGET_EXHAUSTED);
+	return dispatched;
+}
+
+static int __bfq_forced_dispatch_bfqq(struct bfq_queue *bfqq)
+{
+	int dispatched = 0;
 
-		depth = div64_u64(last_sync, cfqd->cfq_slice[1]);
-		if (!depth && !cfqq->dispatched)
-			depth = 1;
-		if (depth < max_dispatch)
-			max_dispatch = depth;
+	while (bfqq->next_rq) {
+		bfq_dispatch_insert(bfqq->bfqd->queue, bfqq->next_rq);
+		dispatched++;
 	}
 
-	/*
-	 * If we're below the current max, allow a dispatch
-	 */
-	return cfqq->dispatched < max_dispatch;
+	return dispatched;
 }
 
 /*
- * Dispatch a request from cfqq, moving them to the request queue
- * dispatch list.
+ * Drain our current requests.
+ * Used for barriers and when switching io schedulers on-the-fly.
  */
-static bool cfq_dispatch_request(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+static int bfq_forced_dispatch(struct bfq_data *bfqd)
 {
-	struct request *rq;
-
-	BUG_ON(RB_EMPTY_ROOT(&cfqq->sort_list));
+	struct bfq_queue *bfqq, *n;
+	struct bfq_service_tree *st;
+	int dispatched = 0;
 
-	if (!cfq_may_dispatch(cfqd, cfqq))
-		return false;
+	bfqq = bfqd->in_service_queue;
+	if (bfqq)
+		__bfq_bfqq_expire(bfqd, bfqq);
 
 	/*
-	 * follow expired path, else get first next available
+	 * Loop through classes, and be careful to leave the scheduler
+	 * in a consistent state, as feedback mechanisms and vtime
+	 * updates cannot be disabled during the process.
 	 */
-	rq = cfq_check_fifo(cfqq);
-	if (!rq)
-		rq = cfqq->next_rq;
+	list_for_each_entry_safe(bfqq, n, &bfqd->active_list, bfqq_list) {
+		st = bfq_entity_service_tree(&bfqq->entity);
 
-	/*
-	 * insert request into driver dispatch list
-	 */
-	cfq_dispatch_insert(cfqd->queue, rq);
+		dispatched += __bfq_forced_dispatch_bfqq(bfqq);
 
-	if (!cfqd->active_cic) {
-		struct cfq_io_cq *cic = RQ_CIC(rq);
+		bfqq->max_budget = bfq_max_budget(bfqd);
 
-		atomic_long_inc(&cic->icq.ioc->refcount);
-		cfqd->active_cic = cic;
+		bfq_forget_idle(st);
 	}
 
-	return true;
+	return dispatched;
 }
 
-/*
- * Find the cfqq that we need to service and move a request from that to the
- * dispatch list
- */
-static int cfq_dispatch_requests(struct request_queue *q, int force)
+static int bfq_dispatch_requests(struct request_queue *q, int force)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
-	struct cfq_queue *cfqq;
+	struct bfq_data *bfqd = q->elevator->elevator_data;
+	struct bfq_queue *bfqq;
 
-	if (!cfqd->busy_queues)
+	bfq_log(bfqd, "dispatch requests: %d busy queues", bfqd->busy_queues);
+
+	if (bfqd->busy_queues == 0)
 		return 0;
 
 	if (unlikely(force))
-		return cfq_forced_dispatch(cfqd);
+		return bfq_forced_dispatch(bfqd);
 
-	cfqq = cfq_select_queue(cfqd);
-	if (!cfqq)
+	bfqq = bfq_select_queue(bfqd);
+	if (!bfqq)
 		return 0;
 
-	/*
-	 * Dispatch a request from this cfqq, if it is allowed
-	 */
-	if (!cfq_dispatch_request(cfqd, cfqq))
-		return 0;
+	bfq_clear_bfqq_wait_request(bfqq);
 
-	cfqq->slice_dispatch++;
-	cfq_clear_cfqq_must_dispatch(cfqq);
+	if (!bfq_dispatch_request(bfqd, bfqq))
+		return 0;
 
-	/*
-	 * expire an async queue immediately if it has used up its slice. idle
-	 * queue always expire after 1 dispatch round.
-	 */
-	if (cfqd->busy_queues > 1 && ((!cfq_cfqq_sync(cfqq) &&
-	    cfqq->slice_dispatch >= cfq_prio_to_maxrq(cfqd, cfqq)) ||
-	    cfq_class_idle(cfqq))) {
-		cfqq->slice_end = ktime_get_ns() + 1;
-		cfq_slice_expired(cfqd, 0);
-	}
+	bfq_log_bfqq(bfqd, bfqq, "dispatched %s request",
+			bfq_bfqq_sync(bfqq) ? "sync" : "async");
 
-	cfq_log_cfqq(cfqd, cfqq, "dispatched a request");
 	return 1;
 }
 
 /*
- * task holds one reference to the queue, dropped when task exits. each rq
+ * Task holds one reference to the queue, dropped when task exits.  Each rq
  * in-flight on this queue also holds a reference, dropped when rq is freed.
  *
  * Queue lock must be held here.
  */
-static void cfq_put_queue(struct cfq_queue *cfqq)
+static void bfq_put_queue(struct bfq_queue *bfqq)
 {
-	struct cfq_data *cfqd = cfqq->cfqd;
-
-	BUG_ON(cfqq->ref <= 0);
-
-	cfqq->ref--;
-	if (cfqq->ref)
+	bfqq->ref--;
+	if (bfqq->ref)
 		return;
 
-	cfq_log_cfqq(cfqd, cfqq, "put_queue");
-	BUG_ON(rb_first(&cfqq->sort_list));
-	BUG_ON(cfqq->allocated[READ] + cfqq->allocated[WRITE]);
-
-	if (unlikely(cfqd->active_queue == cfqq)) {
-		__cfq_slice_expired(cfqd, cfqq, 0);
-		cfq_schedule_dispatch(cfqd);
-	}
-
-	BUG_ON(cfq_cfqq_on_rr(cfqq));
-	kmem_cache_free(cfq_pool, cfqq);
+	kmem_cache_free(bfq_pool, bfqq);
 }
 
-static void cfq_exit_cfqq(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
-	if (unlikely(cfqq == cfqd->active_queue)) {
-		__cfq_slice_expired(cfqd, cfqq, 0);
-		cfq_schedule_dispatch(cfqd);
+	if (bfqq == bfqd->in_service_queue) {
+		__bfq_bfqq_expire(bfqd, bfqq);
+		bfq_schedule_dispatch(bfqd);
 	}
 
-	cfq_put_queue(cfqq);
+	bfq_log_bfqq(bfqd, bfqq, "exit_bfqq: %p, %d", bfqq, bfqq->ref);
+
+	bfq_put_queue(bfqq);
 }
 
-static void cfq_init_icq(struct io_cq *icq)
+static void bfq_init_icq(struct io_cq *icq)
 {
-	struct cfq_io_cq *cic = icq_to_cic(icq);
-
-	cic->ttime.last_end_request = ktime_get_ns();
+	icq_to_bic(icq)->ttime.last_end_request = ktime_get_ns() - (1ULL<<32);
 }
 
-static void cfq_exit_icq(struct io_cq *icq)
+static void bfq_exit_icq(struct io_cq *icq)
 {
-	struct cfq_io_cq *cic = icq_to_cic(icq);
-	struct cfq_data *cfqd = cic_to_cfqd(cic);
+	struct bfq_io_cq *bic = icq_to_bic(icq);
+	struct bfq_data *bfqd = bic_to_bfqd(bic);
 
-	if (cic_to_cfqq(cic, false)) {
-		cfq_exit_cfqq(cfqd, cic_to_cfqq(cic, false));
-		cic_set_cfqq(cic, NULL, false);
+	if (bic_to_bfqq(bic, false)) {
+		bfq_exit_bfqq(bfqd, bic_to_bfqq(bic, false));
+		bic_set_bfqq(bic, NULL, false);
 	}
 
-	if (cic_to_cfqq(cic, true)) {
-		cfq_exit_cfqq(cfqd, cic_to_cfqq(cic, true));
-		cic_set_cfqq(cic, NULL, true);
+	if (bic_to_bfqq(bic, true)) {
+		bfq_exit_bfqq(bfqd, bic->bfqq[BLK_RW_SYNC]);
+		bic->bfqq[BLK_RW_SYNC] = NULL;
 	}
 }
 
-static void cfq_init_prio_data(struct cfq_queue *cfqq, struct cfq_io_cq *cic)
+/*
+ * Update the entity prio values; note that the new values will not
+ * be used until the next (re)activation.
+ */
+static void
+bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 {
 	struct task_struct *tsk = current;
 	int ioprio_class;
 
-	if (!cfq_cfqq_prio_changed(cfqq))
-		return;
-
-	ioprio_class = IOPRIO_PRIO_CLASS(cic->ioprio);
+	ioprio_class = IOPRIO_PRIO_CLASS(bic->ioprio);
 	switch (ioprio_class) {
 	default:
-		printk(KERN_ERR "cfq: bad prio %x\n", ioprio_class);
+		dev_err(bfqq->bfqd->queue->backing_dev_info.dev,
+			"bfq: bad prio class %d\n", ioprio_class);
 	case IOPRIO_CLASS_NONE:
 		/*
-		 * no prio set, inherit CPU scheduling settings
+		 * No prio set, inherit CPU scheduling settings.
 		 */
-		cfqq->ioprio = task_nice_ioprio(tsk);
-		cfqq->ioprio_class = task_nice_ioclass(tsk);
+		bfqq->new_ioprio = task_nice_ioprio(tsk);
+		bfqq->new_ioprio_class = task_nice_ioclass(tsk);
 		break;
 	case IOPRIO_CLASS_RT:
-		cfqq->ioprio = IOPRIO_PRIO_DATA(cic->ioprio);
-		cfqq->ioprio_class = IOPRIO_CLASS_RT;
+		bfqq->new_ioprio = IOPRIO_PRIO_DATA(bic->ioprio);
+		bfqq->new_ioprio_class = IOPRIO_CLASS_RT;
 		break;
 	case IOPRIO_CLASS_BE:
-		cfqq->ioprio = IOPRIO_PRIO_DATA(cic->ioprio);
-		cfqq->ioprio_class = IOPRIO_CLASS_BE;
+		bfqq->new_ioprio = IOPRIO_PRIO_DATA(bic->ioprio);
+		bfqq->new_ioprio_class = IOPRIO_CLASS_BE;
 		break;
 	case IOPRIO_CLASS_IDLE:
-		cfqq->ioprio_class = IOPRIO_CLASS_IDLE;
-		cfqq->ioprio = 7;
-		cfq_clear_cfqq_idle_window(cfqq);
+		bfqq->new_ioprio_class = IOPRIO_CLASS_IDLE;
+		bfqq->new_ioprio = 7;
+		bfq_clear_bfqq_idle_window(bfqq);
 		break;
 	}
 
-	/*
-	 * keep track of original prio settings in case we have to temporarily
-	 * elevate the priority of this queue
-	 */
-	cfqq->org_ioprio = cfqq->ioprio;
-	cfqq->org_ioprio_class = cfqq->ioprio_class;
-	cfq_clear_cfqq_prio_changed(cfqq);
+	if (bfqq->new_ioprio >= IOPRIO_BE_NR) {
+		pr_crit("bfq_set_next_ioprio_data: new_ioprio %d\n",
+			bfqq->new_ioprio);
+		bfqq->new_ioprio = IOPRIO_BE_NR;
+	}
+
+	bfqq->entity.new_weight = bfq_ioprio_to_weight(bfqq->new_ioprio);
+	bfqq->entity.prio_changed = 1;
 }
 
-static void check_ioprio_changed(struct cfq_io_cq *cic, struct bio *bio)
+static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
 {
-	int ioprio = cic->icq.ioc->ioprio;
-	struct cfq_data *cfqd = cic_to_cfqd(cic);
-	struct cfq_queue *cfqq;
+	struct bfq_data *bfqd = bic_to_bfqd(bic);
+	struct bfq_queue *bfqq;
+	int ioprio = bic->icq.ioc->ioprio;
 
 	/*
-	 * Check whether ioprio has changed.  The condition may trigger
-	 * spuriously on a newly created cic but there's no harm.
+	 * This condition may trigger on a newly created bic, be sure to
+	 * drop the lock before returning.
 	 */
-	if (unlikely(!cfqd) || likely(cic->ioprio == ioprio))
+	if (unlikely(!bfqd) || likely(bic->ioprio == ioprio))
 		return;
 
-	cfqq = cic_to_cfqq(cic, false);
-	if (cfqq) {
-		cfq_put_queue(cfqq);
-		cfqq = cfq_get_queue(cfqd, BLK_RW_ASYNC, cic, bio);
-		cic_set_cfqq(cic, cfqq, false);
-	}
+	bic->ioprio = ioprio;
 
-	cfqq = cic_to_cfqq(cic, true);
-	if (cfqq)
-		cfq_mark_cfqq_prio_changed(cfqq);
+	bfqq = bic_to_bfqq(bic, false);
+	if (bfqq) {
+		bfq_put_queue(bfqq);
+		bfqq = bfq_get_queue(bfqd, bio, BLK_RW_ASYNC, bic);
+		bic_set_bfqq(bic, bfqq, false);
+	}
 
-	cic->ioprio = ioprio;
+	bfqq = bic_to_bfqq(bic, true);
+	if (bfqq)
+		bfq_set_next_ioprio_data(bfqq, bic);
 }
 
-static void cfq_init_cfqq(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-			  pid_t pid, bool is_sync)
+static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+			  struct bfq_io_cq *bic, pid_t pid, int is_sync)
 {
-	RB_CLEAR_NODE(&cfqq->rb_node);
-	RB_CLEAR_NODE(&cfqq->p_node);
-	INIT_LIST_HEAD(&cfqq->fifo);
+	RB_CLEAR_NODE(&bfqq->entity.rb_node);
+	INIT_LIST_HEAD(&bfqq->fifo);
 
-	cfqq->ref = 0;
-	cfqq->cfqd = cfqd;
+	bfqq->ref = 0;
+	bfqq->bfqd = bfqd;
 
-	cfq_mark_cfqq_prio_changed(cfqq);
+	if (bic)
+		bfq_set_next_ioprio_data(bfqq, bic);
 
 	if (is_sync) {
-		if (!cfq_class_idle(cfqq))
-			cfq_mark_cfqq_idle_window(cfqq);
-		cfq_mark_cfqq_sync(cfqq);
-	}
-	cfqq->pid = pid;
+		if (!bfq_class_idle(bfqq))
+			bfq_mark_bfqq_idle_window(bfqq);
+		bfq_mark_bfqq_sync(bfqq);
+	} else
+		bfq_clear_bfqq_sync(bfqq);
+	bfq_mark_bfqq_IO_bound(bfqq);
+
+	bfqq->pid = pid;
+
+	/* Tentative initial value to trade off between thr and lat */
+	bfqq->max_budget = bfq_default_budget(bfqd, bfqq);
+	bfqq->budget_timeout = bfq_smallest_from_now();
+	bfqq->pid = pid;
+
+	/* first request is almost certainly seeky */
+	bfqq->seek_history = 1;
 }
 
-static struct cfq_queue **
-cfq_async_queue_prio(struct cfq_data *cfqd, int ioprio_class, int ioprio)
+static struct bfq_queue **bfq_async_queue_prio(struct bfq_data *bfqd,
+					       int ioprio_class, int ioprio)
 {
 	switch (ioprio_class) {
 	case IOPRIO_CLASS_RT:
-		return &cfqd->async_cfqq[0][ioprio];
+		return &async_bfqq[0][ioprio];
 	case IOPRIO_CLASS_NONE:
 		ioprio = IOPRIO_NORM;
 		/* fall through */
 	case IOPRIO_CLASS_BE:
-		return &cfqd->async_cfqq[1][ioprio];
+		return &async_bfqq[1][ioprio];
 	case IOPRIO_CLASS_IDLE:
-		return &cfqd->async_idle_cfqq;
+		return &async_idle_bfqq;
 	default:
-		BUG();
+		return NULL;
 	}
 }
 
-static struct cfq_queue *
-cfq_get_queue(struct cfq_data *cfqd, bool is_sync, struct cfq_io_cq *cic,
-	      struct bio *bio)
+static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
+				       struct bio *bio, bool is_sync,
+				       struct bfq_io_cq *bic)
 {
-	int ioprio_class = IOPRIO_PRIO_CLASS(cic->ioprio);
-	int ioprio = IOPRIO_PRIO_DATA(cic->ioprio);
-	struct cfq_queue **async_cfqq = NULL;
-	struct cfq_queue *cfqq;
+	const int ioprio = IOPRIO_PRIO_DATA(bic->ioprio);
+	const int ioprio_class = IOPRIO_PRIO_CLASS(bic->ioprio);
+	struct bfq_queue **async_bfqq = NULL;
+	struct bfq_queue *bfqq;
 
 	rcu_read_lock();
 
 	if (!is_sync) {
-		if (!ioprio_valid(cic->ioprio)) {
-			struct task_struct *tsk = current;
-			ioprio = task_nice_ioprio(tsk);
-			ioprio_class = task_nice_ioclass(tsk);
-		}
-		async_cfqq = cfq_async_queue_prio(cfqd, ioprio_class, ioprio);
-		cfqq = *async_cfqq;
-		if (cfqq)
+		async_bfqq = bfq_async_queue_prio(bfqd, ioprio_class,
+						  ioprio);
+		bfqq = *async_bfqq;
+		if (bfqq)
 			goto out;
 	}
 
-	cfqq = kmem_cache_alloc_node(cfq_pool, GFP_NOWAIT | __GFP_ZERO,
-				     cfqd->queue->node);
-	if (!cfqq) {
-		cfqq = &cfqd->oom_cfqq;
+	bfqq = kmem_cache_alloc_node(bfq_pool, GFP_NOWAIT | __GFP_ZERO,
+				     bfqd->queue->node);
+
+	if (bfqq) {
+		bfq_init_bfqq(bfqd, bfqq, bic, current->pid,
+			      is_sync);
+		bfq_init_entity(&bfqq->entity);
+		bfq_log_bfqq(bfqd, bfqq, "allocated");
+	} else {
+		bfqq = &bfqd->oom_bfqq;
+		bfq_log_bfqq(bfqd, bfqq, "using oom bfqq");
 		goto out;
 	}
 
-	cfq_init_cfqq(cfqd, cfqq, current->pid, is_sync);
-	cfq_init_prio_data(cfqq, cic);
-	cfq_log_cfqq(cfqd, cfqq, "alloced");
-
-	if (async_cfqq) {
-		/* a new async queue is created, pin and remember */
-		cfqq->ref++;
-		*async_cfqq = cfqq;
+	/*
+	 * Pin the queue now that it's allocated, scheduler exit will
+	 * prune it.
+	 */
+	if (async_bfqq) {
+		bfqq->ref++;
+		bfq_log_bfqq(bfqd, bfqq,
+			     "get_queue, bfqq not in async: %p, %d",
+			     bfqq, bfqq->ref);
+		*async_bfqq = bfqq;
 	}
+
 out:
-	cfqq->ref++;
+	bfqq->ref++;
+	bfq_log_bfqq(bfqd, bfqq, "get_queue, at end: %p, %d", bfqq, bfqq->ref);
 	rcu_read_unlock();
-	return cfqq;
+	return bfqq;
 }
 
-static void
-__cfq_update_io_thinktime(struct cfq_ttime *ttime, u64 slice_idle)
+static void bfq_update_io_thinktime(struct bfq_data *bfqd,
+				    struct bfq_io_cq *bic)
 {
-	u64 elapsed = ktime_get_ns() - ttime->last_end_request;
-	elapsed = min(elapsed, 2UL * slice_idle);
+	struct bfq_ttime *ttime = &bic->ttime;
+	u64 elapsed = ktime_get_ns() - bic->ttime.last_end_request;
+
+	elapsed = min(elapsed, 2UL * bfqd->bfq_slice_idle);
 
-	ttime->ttime_samples = (7*ttime->ttime_samples + 256) / 8;
+	ttime->ttime_samples = (7*bic->ttime.ttime_samples + 256) / 8;
 	ttime->ttime_total = div_u64(7*ttime->ttime_total + 256*elapsed,  8);
 	ttime->ttime_mean = div64_ul(ttime->ttime_total + 128,
 				     ttime->ttime_samples);
 }
 
 static void
-cfq_update_io_thinktime(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-			struct cfq_io_cq *cic)
-{
-	if (cfq_cfqq_sync(cfqq)) {
-		__cfq_update_io_thinktime(&cic->ttime, cfqd->cfq_slice_idle);
-		__cfq_update_io_thinktime(&cfqq->service_tree->ttime,
-			cfqd->cfq_slice_idle);
-	}
-}
-
-static void
-cfq_update_io_seektime(struct cfq_data *cfqd, struct cfq_queue *cfqq,
+bfq_update_io_seektime(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		       struct request *rq)
 {
 	sector_t sdist = 0;
-	if (cfqq->last_request_pos) {
-		if (cfqq->last_request_pos < blk_rq_pos(rq))
-			sdist = blk_rq_pos(rq) - cfqq->last_request_pos;
+
+	if (bfqq->last_request_pos) {
+		if (bfqq->last_request_pos < blk_rq_pos(rq))
+			sdist = blk_rq_pos(rq) - bfqq->last_request_pos;
 		else
-			sdist = cfqq->last_request_pos - blk_rq_pos(rq);
+			sdist = bfqq->last_request_pos - blk_rq_pos(rq);
 	}
 
-	cfqq->seek_history <<= 1;
-	cfqq->seek_history |= (sdist > CFQQ_SEEK_THR);
+	bfqq->seek_history <<= 1;
+	bfqq->seek_history |= (sdist > BFQQ_SEEK_THR);
 }
 
 /*
  * Disable idle window if the process thinks too long or seeks so much that
- * it doesn't matter
+ * it doesn't matter.
  */
-static void
-cfq_update_idle_window(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-		       struct cfq_io_cq *cic)
+static void bfq_update_idle_window(struct bfq_data *bfqd,
+				   struct bfq_queue *bfqq,
+				   struct bfq_io_cq *bic)
 {
-	int old_idle, enable_idle;
+	int enable_idle;
 
-	/*
-	 * Don't idle for async or idle io prio class
-	 */
-	if (!cfq_cfqq_sync(cfqq) || cfq_class_idle(cfqq))
+	/* Don't idle for async or idle io prio class. */
+	if (!bfq_bfqq_sync(bfqq) || bfq_class_idle(bfqq))
 		return;
 
-	enable_idle = old_idle = cfq_cfqq_idle_window(cfqq);
+	enable_idle = bfq_bfqq_idle_window(bfqq);
 
-	if (cfqq->next_rq && (cfqq->next_rq->cmd_flags & REQ_NOIDLE))
-		enable_idle = 0;
-	else if (!atomic_read(&cic->icq.ioc->active_ref) ||
-		 !cfqd->cfq_slice_idle || CFQQ_SEEKY(cfqq))
+	if (atomic_read(&bic->icq.ioc->active_ref) == 0 ||
+	    bfqd->bfq_slice_idle == 0 ||
+		(bfqd->hw_tag && BFQQ_SEEKY(bfqq)))
 		enable_idle = 0;
-	else if (sample_valid(cic->ttime.ttime_samples)) {
-		if (cic->ttime.ttime_mean > cfqd->cfq_slice_idle)
+	else if (bfq_sample_valid(bic->ttime.ttime_samples)) {
+		if (bic->ttime.ttime_mean > bfqd->bfq_slice_idle)
 			enable_idle = 0;
 		else
 			enable_idle = 1;
 	}
+	bfq_log_bfqq(bfqd, bfqq, "update_idle_window: enable_idle %d",
+		enable_idle);
 
-	if (old_idle != enable_idle) {
-		cfq_log_cfqq(cfqd, cfqq, "idle=%d", enable_idle);
-		if (enable_idle)
-			cfq_mark_cfqq_idle_window(cfqq);
-		else
-			cfq_clear_cfqq_idle_window(cfqq);
-	}
+	if (enable_idle)
+		bfq_mark_bfqq_idle_window(bfqq);
+	else
+		bfq_clear_bfqq_idle_window(bfqq);
 }
 
 /*
- * Called when a new fs request (rq) is added (to cfqq). Check if there's
- * something we should do about it
+ * Called when a new fs request (rq) is added to bfqq.  Check if there's
+ * something we should do about it.
  */
-static void
-cfq_rq_enqueued(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-		struct request *rq)
+static void bfq_rq_enqueued(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+			    struct request *rq)
 {
-	struct cfq_io_cq *cic = RQ_CIC(rq);
+	struct bfq_io_cq *bic = RQ_BIC(rq);
+
+	if (rq->cmd_flags & REQ_META)
+		bfqq->meta_pending++;
+
+	bfq_update_io_thinktime(bfqd, bic);
+	bfq_update_io_seektime(bfqd, bfqq, rq);
+	if (bfqq->entity.service > bfq_max_budget(bfqd) / 8 ||
+	    !BFQQ_SEEKY(bfqq))
+		bfq_update_idle_window(bfqd, bfqq, bic);
 
-	cfqd->rq_queued++;
-	if (rq->cmd_flags & REQ_PRIO)
-		cfqq->prio_pending++;
+	bfq_log_bfqq(bfqd, bfqq,
+		     "rq_enqueued: idle_window=%d (seeky %d)",
+		     bfq_bfqq_idle_window(bfqq), BFQQ_SEEKY(bfqq));
 
-	cfq_update_io_thinktime(cfqd, cfqq, cic);
-	cfq_update_io_seektime(cfqd, cfqq, rq);
-	cfq_update_idle_window(cfqd, cfqq, cic);
+	bfqq->last_request_pos = blk_rq_pos(rq) + blk_rq_sectors(rq);
 
-	cfqq->last_request_pos = blk_rq_pos(rq) + blk_rq_sectors(rq);
+	if (bfqq == bfqd->in_service_queue && bfq_bfqq_wait_request(bfqq)) {
+		bool small_req = bfqq->queued[rq_is_sync(rq)] == 1 &&
+				 blk_rq_sectors(rq) < 32;
+		bool budget_timeout = bfq_bfqq_budget_timeout(bfqq);
 
-	if (cfqq == cfqd->active_queue) {
 		/*
-		 * Remember that we saw a request from this process, but
-		 * don't start queuing just yet. Otherwise we risk seeing lots
-		 * of tiny requests, because we disrupt the normal plugging
-		 * and merging. If the request is already larger than a single
-		 * page, let it rip immediately. For that case we assume that
-		 * merging is already done. Ditto for a busy system that
-		 * has other work pending, don't risk delaying until the
-		 * idle timer unplug to continue working.
+		 * There is just this request queued: if the request
+		 * is small and the queue is not to be expired, then
+		 * just exit.
+		 *
+		 * In this way, if the device is being idled to wait
+		 * for a new request from the in-service queue, we
+		 * avoid unplugging the device and committing the
+		 * device to serve just a small request. On the
+		 * contrary, we wait for the block layer to decide
+		 * when to unplug the device: hopefully, new requests
+		 * will be merged to this one quickly, then the device
+		 * will be unplugged and larger requests will be
+		 * dispatched.
 		 */
-		if (cfq_cfqq_wait_request(cfqq)) {
-			if (blk_rq_bytes(rq) > PAGE_SIZE ||
-			    cfqd->busy_queues > 1) {
-				cfq_del_timer(cfqd, cfqq);
-				cfq_clear_cfqq_wait_request(cfqq);
-				__blk_run_queue(cfqd->queue);
-			} else
-				cfq_mark_cfqq_must_dispatch(cfqq);
-		}
-	}
-}
+		if (small_req && !budget_timeout)
+			return;
 
-static void cfq_insert_request(struct request_queue *q, struct request *rq)
-{
-	struct cfq_data *cfqd = q->elevator->elevator_data;
-	struct cfq_queue *cfqq = RQ_CFQQ(rq);
+		/*
+		 * A large enough request arrived, or the queue is to
+		 * be expired: in both cases disk idling is to be
+		 * stopped, so clear wait_request flag and reset
+		 * timer.
+		 */
+		bfq_clear_bfqq_wait_request(bfqq);
+		hrtimer_try_to_cancel(&bfqd->idle_slice_timer);
 
-	cfq_log_cfqq(cfqd, cfqq, "insert_request");
-	cfq_init_prio_data(cfqq, RQ_CIC(rq));
+		/*
+		 * The queue is not empty, because a new request just
+		 * arrived. Hence we can safely expire the queue, in
+		 * case of budget timeout, without risking that the
+		 * timestamps of the queue are not updated correctly.
+		 * See [1] for more details.
+		 */
+		if (budget_timeout)
+			bfq_bfqq_expire(bfqd, bfqq, false,
+					BFQ_BFQQ_BUDGET_TIMEOUT);
 
-	rq->fifo_time = ktime_get_ns() + cfqd->cfq_fifo_expire[rq_is_sync(rq)];
-	list_add_tail(&rq->queuelist, &cfqq->fifo);
-	cfq_add_rq_rb(rq);
-	cfq_rq_enqueued(cfqd, cfqq, rq);
+		/*
+		 * Let the request rip immediately, or let a new queue be
+		 * selected if bfqq has just been expired.
+		 */
+		__blk_run_queue(bfqd->queue);
+	}
 }
 
-/*
- * Update hw_tag based on peak queue depth over 50 samples under
- * sufficient load.
- */
-static void cfq_update_hw_tag(struct cfq_data *cfqd)
+static void bfq_insert_request(struct request_queue *q, struct request *rq)
 {
-	struct cfq_queue *cfqq = cfqd->active_queue;
-
-	if (cfqd->rq_in_driver > cfqd->hw_tag_est_depth)
-		cfqd->hw_tag_est_depth = cfqd->rq_in_driver;
+	struct bfq_data *bfqd = q->elevator->elevator_data;
+	struct bfq_queue *bfqq = RQ_BFQQ(rq);
 
-	if (cfqd->hw_tag == 1)
-		return;
-
-	if (cfqd->rq_queued <= CFQ_HW_QUEUE_MIN &&
-	    cfqd->rq_in_driver <= CFQ_HW_QUEUE_MIN)
-		return;
+	assert_spin_locked(bfqd->queue->queue_lock);
 
-	/*
-	 * If active queue hasn't enough requests and can idle, cfq might not
-	 * dispatch sufficient requests to hardware. Don't zero hw_tag in this
-	 * case
-	 */
-	if (cfqq && cfq_cfqq_idle_window(cfqq) &&
-	    cfqq->dispatched + cfqq->queued[0] + cfqq->queued[1] <
-	    CFQ_HW_QUEUE_MIN && cfqd->rq_in_driver < CFQ_HW_QUEUE_MIN)
-		return;
+	bfq_add_request(rq);
 
-	if (cfqd->hw_tag_samples++ < 50)
-		return;
+	rq->fifo_time = ktime_get_ns() + bfqd->bfq_fifo_expire[rq_is_sync(rq)];
+	list_add_tail(&rq->queuelist, &bfqq->fifo);
 
-	if (cfqd->hw_tag_est_depth >= CFQ_HW_QUEUE_MIN)
-		cfqd->hw_tag = 1;
-	else
-		cfqd->hw_tag = 0;
+	bfq_rq_enqueued(bfqd, bfqq, rq);
 }
 
-static bool cfq_should_wait_busy(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+static void bfq_update_hw_tag(struct bfq_data *bfqd)
 {
-	struct cfq_io_cq *cic = cfqd->active_cic;
-	u64 now = ktime_get_ns();
+	bfqd->max_rq_in_driver = max_t(int, bfqd->max_rq_in_driver,
+				       bfqd->rq_in_driver);
 
-	/* If the queue already has requests, don't wait */
-	if (!RB_EMPTY_ROOT(&cfqq->sort_list))
-		return false;
-
-	if (cfq_slice_used(cfqq))
-		return true;
-
-	/* if slice left is less than think time, wait busy */
-	if (cic && sample_valid(cic->ttime.ttime_samples)
-	    && (cfqq->slice_end - now < cic->ttime.ttime_mean))
-		return true;
+	if (bfqd->hw_tag == 1)
+		return;
 
 	/*
-	 * If think times is less than a jiffy than ttime_mean=0 and above
-	 * will not be true. It might happen that slice has not expired yet
-	 * but will expire soon (4-5 ns) during select_queue(). To cover the
-	 * case where think time is less than a jiffy, mark the queue wait
-	 * busy if only 1 jiffy is left in the slice.
+	 * This sample is valid if the number of outstanding requests
+	 * is large enough to allow a queueing behavior.  Note that the
+	 * sum is not exact, as it's not taking into account deactivated
+	 * requests.
 	 */
-	if (cfqq->slice_end - now <= jiffies_to_nsecs(1))
-		return true;
+	if (bfqd->rq_in_driver + bfqd->queued < BFQ_HW_QUEUE_THRESHOLD)
+		return;
 
-	return false;
+	if (bfqd->hw_tag_samples++ < BFQ_HW_QUEUE_SAMPLES)
+		return;
+
+	bfqd->hw_tag = bfqd->max_rq_in_driver > BFQ_HW_QUEUE_THRESHOLD;
+	bfqd->max_rq_in_driver = 0;
+	bfqd->hw_tag_samples = 0;
 }
 
-static void cfq_completed_request(struct request_queue *q, struct request *rq)
+static void bfq_completed_request(struct request_queue *q, struct request *rq)
 {
-	struct cfq_queue *cfqq = RQ_CFQQ(rq);
-	struct cfq_data *cfqd = cfqq->cfqd;
-	const int sync = rq_is_sync(rq);
-	u64 now = ktime_get_ns();
-
-	cfq_log_cfqq(cfqd, cfqq, "complete rqnoidle %d",
-		     !!(rq->cmd_flags & REQ_NOIDLE));
-
-	cfq_update_hw_tag(cfqd);
-
-	WARN_ON(!cfqd->rq_in_driver);
-	WARN_ON(!cfqq->dispatched);
-	cfqd->rq_in_driver--;
-	cfqq->dispatched--;
-
-	cfqd->rq_in_flight[cfq_cfqq_sync(cfqq)]--;
+	struct bfq_queue *bfqq = RQ_BFQQ(rq);
+	struct bfq_data *bfqd = bfqq->bfqd;
 
-	if (sync) {
-		struct cfq_rb_root *st;
+	bfq_update_hw_tag(bfqd);
 
-		RQ_CIC(rq)->ttime.last_end_request = now;
+	bfqd->rq_in_driver--;
+	bfqq->dispatched--;
 
-		if (cfq_cfqq_on_rr(cfqq))
-			st = cfqq->service_tree;
-		else
-			st = &cfqd->service_trees[cfqq_class(cfqq)];
-
-		st->ttime.last_end_request = now;
-		/*
-		 * We have to do this check in jiffies since start_time is in
-		 * jiffies and it is not trivial to convert to ns. If
-		 * cfq_fifo_expire[1] ever comes close to 1 jiffie, this test
-		 * will become problematic but so far we are fine (the default
-		 * is 128 ms).
-		 */
-		if (!time_after(rq->start_time +
-				  nsecs_to_jiffies(cfqd->cfq_fifo_expire[1]),
-				jiffies))
-			cfqd->last_delayed_sync = now;
-	}
+	RQ_BIC(rq)->ttime.last_end_request = ktime_get_ns();
 
 	/*
-	 * If this is the active queue, check if it needs to be expired,
+	 * If this is the in-service queue, check if it needs to be expired,
 	 * or if we want to idle in case it has no pending requests.
 	 */
-	if (cfqd->active_queue == cfqq) {
-		const bool cfqq_empty = RB_EMPTY_ROOT(&cfqq->sort_list);
-
-		if (cfq_cfqq_slice_new(cfqq)) {
-			cfq_set_prio_slice(cfqd, cfqq);
-			cfq_clear_cfqq_slice_new(cfqq);
-		}
-
-		/*
-		 * Should we wait for next request to come in before we expire
-		 * the queue.
-		 */
-		if (cfq_should_wait_busy(cfqd, cfqq)) {
-			u64 extend_sl = cfqd->cfq_slice_idle;
-			cfqq->slice_end = now + extend_sl;
-			cfq_mark_cfqq_wait_busy(cfqq);
-			cfq_log_cfqq(cfqd, cfqq, "will busy wait");
-		}
+	if (bfqd->in_service_queue == bfqq) {
+		if (bfq_bfqq_budget_new(bfqq))
+			bfq_set_budget_timeout(bfqd);
 
-		/*
-		 * Idling is not enabled on:
-		 * - expired queues
-		 * - idle-priority queues
-		 * - async queues
-		 * - queues with still some requests queued
-		 */
-		if (cfq_slice_used(cfqq) || cfq_class_idle(cfqq))
-			cfq_slice_expired(cfqd, 1);
-		else if (sync && cfqq_empty)
-			cfq_arm_slice_timer(cfqd);
+		if (bfq_bfqq_must_idle(bfqq)) {
+			bfq_arm_slice_timer(bfqd);
+			goto out;
+		} else if (bfq_may_expire_for_budg_timeout(bfqq))
+			bfq_bfqq_expire(bfqd, bfqq, false,
+					BFQ_BFQQ_BUDGET_TIMEOUT);
+		else if (RB_EMPTY_ROOT(&bfqq->sort_list) &&
+			 (bfqq->dispatched == 0 ||
+			  !bfq_bfqq_may_idle(bfqq)))
+			bfq_bfqq_expire(bfqd, bfqq, false,
+					BFQ_BFQQ_NO_MORE_REQUESTS);
 	}
 
-	if (!cfqd->rq_in_driver)
-		cfq_schedule_dispatch(cfqd);
-}
+	if (!bfqd->rq_in_driver)
+		bfq_schedule_dispatch(bfqd);
 
-static void cfqq_boost_on_prio(struct cfq_queue *cfqq, int op_flags)
-{
-	/*
-	 * If REQ_PRIO is set, boost class and prio level, if it's below
-	 * BE/NORM. If prio is not set, restore the potentially boosted
-	 * class/prio level.
-	 */
-	if (!(op_flags & REQ_PRIO)) {
-		cfqq->ioprio_class = cfqq->org_ioprio_class;
-		cfqq->ioprio = cfqq->org_ioprio;
-	} else {
-		if (cfq_class_idle(cfqq))
-			cfqq->ioprio_class = IOPRIO_CLASS_BE;
-		if (cfqq->ioprio > IOPRIO_NORM)
-			cfqq->ioprio = IOPRIO_NORM;
-	}
+out:
+	return;
 }
 
-static inline int __cfq_may_queue(struct cfq_queue *cfqq)
+static int __bfq_may_queue(struct bfq_queue *bfqq)
 {
-	if (cfq_cfqq_wait_request(cfqq) && !cfq_cfqq_must_alloc_slice(cfqq)) {
-		cfq_mark_cfqq_must_alloc_slice(cfqq);
+	if (bfq_bfqq_wait_request(bfqq) && bfq_bfqq_must_alloc(bfqq)) {
+		bfq_clear_bfqq_must_alloc(bfqq);
 		return ELV_MQUEUE_MUST;
 	}
 
 	return ELV_MQUEUE_MAY;
 }
 
-static int cfq_may_queue(struct request_queue *q, int op, int op_flags)
+static int bfq_may_queue(struct request_queue *q, int op, int op_flags)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
+	struct bfq_data *bfqd = q->elevator->elevator_data;
 	struct task_struct *tsk = current;
-	struct cfq_io_cq *cic;
-	struct cfq_queue *cfqq;
+	struct bfq_io_cq *bic;
+	struct bfq_queue *bfqq;
 
 	/*
-	 * don't force setup of a queue from here, as a call to may_queue
-	 * does not necessarily imply that a request actually will be queued.
-	 * so just lookup a possibly existing queue, or return 'may queue'
-	 * if that fails
+	 * Don't force setup of a queue from here, as a call to may_queue
+	 * does not necessarily imply that a request actually will be
+	 * queued. So just lookup a possibly existing queue, or return
+	 * 'may queue' if that fails.
 	 */
-	cic = cfq_cic_lookup(cfqd, tsk->io_context);
-	if (!cic)
+	bic = bfq_bic_lookup(bfqd, tsk->io_context);
+	if (!bic)
 		return ELV_MQUEUE_MAY;
 
-	cfqq = cic_to_cfqq(cic, rw_is_sync(op, op_flags));
-	if (cfqq) {
-		cfq_init_prio_data(cfqq, cic);
-		cfqq_boost_on_prio(cfqq, op_flags);
-
-		return __cfq_may_queue(cfqq);
-	}
+	bfqq = bic_to_bfqq(bic, rw_is_sync(op, op_flags));
+	if (bfqq)
+		return __bfq_may_queue(bfqq);
 
 	return ELV_MQUEUE_MAY;
 }
 
 /*
- * queue lock held here
+ * Queue lock held here.
  */
-static void cfq_put_request(struct request *rq)
+static void bfq_put_request(struct request *rq)
 {
-	struct cfq_queue *cfqq = RQ_CFQQ(rq);
+	struct bfq_queue *bfqq = RQ_BFQQ(rq);
 
-	if (cfqq) {
+	if (bfqq) {
 		const int rw = rq_data_dir(rq);
 
-		BUG_ON(!cfqq->allocated[rw]);
-		cfqq->allocated[rw]--;
+		bfqq->allocated[rw]--;
 
 		rq->elv.priv[0] = NULL;
 		rq->elv.priv[1] = NULL;
 
-		cfq_put_queue(cfqq);
+		bfq_log_bfqq(bfqq->bfqd, bfqq, "put_request %p, %d",
+			     bfqq, bfqq->ref);
+		bfq_put_queue(bfqq);
 	}
 }
 
 /*
- * Allocate cfq data structures associated with this request.
+ * Allocate bfq data structures associated with this request.
  */
-static int
-cfq_set_request(struct request_queue *q, struct request *rq, struct bio *bio,
-		gfp_t gfp_mask)
+static int bfq_set_request(struct request_queue *q, struct request *rq,
+			   struct bio *bio, gfp_t gfp_mask)
 {
-	struct cfq_data *cfqd = q->elevator->elevator_data;
-	struct cfq_io_cq *cic = icq_to_cic(rq->elv.icq);
+	struct bfq_data *bfqd = q->elevator->elevator_data;
+	struct bfq_io_cq *bic = icq_to_bic(rq->elv.icq);
 	const int rw = rq_data_dir(rq);
-	const bool is_sync = rq_is_sync(rq);
-	struct cfq_queue *cfqq;
+	const int is_sync = rq_is_sync(rq);
+	struct bfq_queue *bfqq;
+	unsigned long flags;
 
-	spin_lock_irq(q->queue_lock);
+	spin_lock_irqsave(q->queue_lock, flags);
+
+	bfq_check_ioprio_change(bic, bio);
 
-	check_ioprio_changed(cic, bio);
+	if (!bic)
+		goto queue_fail;
 
-	cfqq = cic_to_cfqq(cic, is_sync);
-	if (!cfqq || cfqq == &cfqd->oom_cfqq) {
-		if (cfqq)
-			cfq_put_queue(cfqq);
-		cfqq = cfq_get_queue(cfqd, is_sync, cic, bio);
-		cic_set_cfqq(cic, cfqq, is_sync);
+	bfqq = bic_to_bfqq(bic, is_sync);
+	if (!bfqq || bfqq == &bfqd->oom_bfqq) {
+		if (bfqq)
+			bfq_put_queue(bfqq);
+		bfqq = bfq_get_queue(bfqd, bio, is_sync, bic);
+		bic_set_bfqq(bic, bfqq, is_sync);
 	}
 
-	cfqq->allocated[rw]++;
+	bfqq->allocated[rw]++;
+	bfqq->ref++;
+	bfq_log_bfqq(bfqd, bfqq, "set_request: bfqq %p, %d", bfqq, bfqq->ref);
+
+	rq->elv.priv[0] = bic;
+	rq->elv.priv[1] = bfqq;
+
+	spin_unlock_irqrestore(q->queue_lock, flags);
 
-	cfqq->ref++;
-	rq->elv.priv[0] = cfqq;
-	spin_unlock_irq(q->queue_lock);
 	return 0;
+
+queue_fail:
+	bfq_schedule_dispatch(bfqd);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	return 1;
 }
 
-static void cfq_kick_queue(struct work_struct *work)
+static void bfq_kick_queue(struct work_struct *work)
 {
-	struct cfq_data *cfqd =
-		container_of(work, struct cfq_data, unplug_work);
-	struct request_queue *q = cfqd->queue;
+	struct bfq_data *bfqd =
+		container_of(work, struct bfq_data, unplug_work);
+	struct request_queue *q = bfqd->queue;
 
 	spin_lock_irq(q->queue_lock);
-	__blk_run_queue(cfqd->queue);
+	__blk_run_queue(q);
 	spin_unlock_irq(q->queue_lock);
 }
 
 /*
- * Timer running if the active_queue is currently idling inside its time slice
+ * Handler of the expiration of the timer running if the in-service queue
+ * is idling inside its time slice.
  */
-static enum hrtimer_restart cfq_idle_slice_timer(struct hrtimer *timer)
+static enum hrtimer_restart bfq_idle_slice_timer(struct hrtimer *timer)
 {
-	struct cfq_data *cfqd = container_of(timer, struct cfq_data,
+	struct bfq_data *bfqd = container_of(timer, struct bfq_data,
 					     idle_slice_timer);
-	struct cfq_queue *cfqq;
+	struct bfq_queue *bfqq;
 	unsigned long flags;
-	int timed_out = 1;
+	enum bfqq_expiration reason;
 
-	cfq_log(cfqd, "idle timer fired");
+	spin_lock_irqsave(bfqd->queue->queue_lock, flags);
 
-	spin_lock_irqsave(cfqd->queue->queue_lock, flags);
+	bfqq = bfqd->in_service_queue;
+	/*
+	 * Theoretical race here: the in-service queue can be NULL or
+	 * different from the queue that was idling if the timer handler
+	 * spins on the queue_lock and a new request arrives for the
+	 * current queue and there is a full dispatch cycle that changes
+	 * the in-service queue.  This can hardly happen, but in the worst
+	 * case we just expire a queue too early.
+	 */
+	if (bfqq) {
+		bfq_log_bfqq(bfqd, bfqq, "slice_timer expired");
+		if (bfq_bfqq_budget_timeout(bfqq))
+			/*
+			 * Also here the queue can be safely expired
+			 * for budget timeout without wasting
+			 * guarantees
+			 */
+			reason = BFQ_BFQQ_BUDGET_TIMEOUT;
+		else if (bfqq->queued[0] == 0 && bfqq->queued[1] == 0)
+			/*
+			 * The queue may not be empty upon timer expiration,
+			 * because we may not disable the timer when the
+			 * first request of the in-service queue arrives
+			 * during disk idling.
+			 */
+			reason = BFQ_BFQQ_TOO_IDLE;
+		else
+			goto schedule_dispatch;
 
-	cfqq = cfqd->active_queue;
-	if (cfqq) {
-		timed_out = 0;
+		bfq_bfqq_expire(bfqd, bfqq, true, reason);
+	}
 
-		/*
-		 * We saw a request before the queue expired, let it through
-		 */
-		if (cfq_cfqq_must_dispatch(cfqq))
-			goto out_kick;
+schedule_dispatch:
+	bfq_schedule_dispatch(bfqd);
 
-		/*
-		 * expired
-		 */
-		if (cfq_slice_used(cfqq))
-			goto expire;
+	spin_unlock_irqrestore(bfqd->queue->queue_lock, flags);
+	return HRTIMER_NORESTART;
+}
 
-		/*
-		 * only expire and reinvoke request handler, if there are
-		 * other queues with pending requests
-		 */
-		if (!cfqd->busy_queues)
-			goto out_cont;
+static void bfq_shutdown_timer_wq(struct bfq_data *bfqd)
+{
+	hrtimer_cancel(&bfqd->idle_slice_timer);
+	cancel_work_sync(&bfqd->unplug_work);
+}
 
-		/*
-		 * not expired and it has a request pending, let it dispatch
-		 */
-		if (!RB_EMPTY_ROOT(&cfqq->sort_list))
-			goto out_kick;
+static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
+					struct bfq_queue **bfqq_ptr)
+{
+	struct bfq_queue *bfqq = *bfqq_ptr;
+
+	bfq_log(bfqd, "put_async_bfqq: %p", bfqq);
+	if (bfqq) {
+		bfq_log_bfqq(bfqd, bfqq, "put_async_bfqq: putting %p, %d",
+			     bfqq, bfqq->ref);
+		bfq_put_queue(bfqq);
+		*bfqq_ptr = NULL;
 	}
-expire:
-	cfq_slice_expired(cfqd, timed_out);
-out_kick:
-	cfq_schedule_dispatch(cfqd);
-out_cont:
-	spin_unlock_irqrestore(cfqd->queue->queue_lock, flags);
-	return HRTIMER_NORESTART;
 }
 
-static void cfq_shutdown_timer_wq(struct cfq_data *cfqd)
+/*
+ * Release the extra reference of the async queues as the device
+ * goes away.
+ */
+static void bfq_put_async_queues(struct bfq_data *bfqd)
 {
-	hrtimer_cancel(&cfqd->idle_slice_timer);
-	cancel_work_sync(&cfqd->unplug_work);
+	int i, j;
+
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < IOPRIO_BE_NR; j++)
+			__bfq_put_async_bfqq(bfqd, &async_bfqq[i][j]);
+
+	__bfq_put_async_bfqq(bfqd, &async_idle_bfqq);
 }
 
-static void cfq_exit_queue(struct elevator_queue *e)
+static void bfq_exit_queue(struct elevator_queue *e)
 {
-	struct cfq_data *cfqd = e->elevator_data;
-	struct request_queue *q = cfqd->queue;
+	struct bfq_data *bfqd = e->elevator_data;
+	struct request_queue *q = bfqd->queue;
+	struct bfq_queue *bfqq, *n;
 
-	cfq_shutdown_timer_wq(cfqd);
+	bfq_shutdown_timer_wq(bfqd);
 
 	spin_lock_irq(q->queue_lock);
 
-	if (cfqd->active_queue)
-		__cfq_slice_expired(cfqd, cfqd->active_queue, 0);
+	list_for_each_entry_safe(bfqq, n, &bfqd->idle_list, bfqq_list)
+		bfq_deactivate_bfqq(bfqd, bfqq, 0);
 
+	bfq_put_async_queues(bfqd);
 	spin_unlock_irq(q->queue_lock);
 
-	cfq_shutdown_timer_wq(cfqd);
+	bfq_shutdown_timer_wq(bfqd);
 
-	kfree(cfqd);
+	kfree(bfqd);
 }
 
-static int cfq_init_queue(struct request_queue *q, struct elevator_type *e)
+static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
-	struct cfq_data *cfqd;
+	struct bfq_data *bfqd;
 	struct elevator_queue *eq;
+	int i;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
 		return -ENOMEM;
 
-	cfqd = kzalloc_node(sizeof(*cfqd), GFP_KERNEL, q->node);
-	if (!cfqd) {
+	bfqd = kzalloc_node(sizeof(*bfqd), GFP_KERNEL, q->node);
+	if (!bfqd) {
 		kobject_put(&eq->kobj);
 		return -ENOMEM;
 	}
-	eq->elevator_data = cfqd;
-
-	cfqd->queue = q;
-	spin_lock_irq(q->queue_lock);
-	q->elevator = eq;
-	spin_unlock_irq(q->queue_lock);
+	eq->elevator_data = bfqd;
 
 	/*
-	 * Our fallback cfqq if cfq_get_queue() runs into OOM issues.
+	 * Our fallback bfqq if bfq_find_alloc_queue() runs into OOM issues.
 	 * Grab a permanent reference to it, so that the normal code flow
 	 * will not attempt to free it.
 	 */
-	cfq_init_cfqq(cfqd, &cfqd->oom_cfqq, 1, 0);
-	cfqd->oom_cfqq.ref++;
+	bfq_init_bfqq(bfqd, &bfqd->oom_bfqq, NULL, 1, 0);
+	bfqd->oom_bfqq.ref++;
+	bfqd->oom_bfqq.new_ioprio = BFQ_DEFAULT_QUEUE_IOPRIO;
+	bfqd->oom_bfqq.new_ioprio_class = IOPRIO_CLASS_BE;
+	bfqd->oom_bfqq.entity.new_weight =
+		bfq_ioprio_to_weight(bfqd->oom_bfqq.new_ioprio);
+	/*
+	 * Trigger weight initialization, according to ioprio, at the
+	 * oom_bfqq's first activation. The oom_bfqq's ioprio and ioprio
+	 * class won't be changed any more.
+	 */
+	bfqd->oom_bfqq.entity.prio_changed = 1;
+
+	bfqd->queue = q;
 
 	spin_lock_irq(q->queue_lock);
+	q->elevator = eq;
 	spin_unlock_irq(q->queue_lock);
 
-	hrtimer_init(&cfqd->idle_slice_timer, CLOCK_MONOTONIC,
+	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++)
+		bfqd->sched_data.service_tree[i] = BFQ_SERVICE_TREE_INIT;
+
+	hrtimer_init(&bfqd->idle_slice_timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL);
-	cfqd->idle_slice_timer.function = cfq_idle_slice_timer;
-
-	INIT_WORK(&cfqd->unplug_work, cfq_kick_queue);
-
-	cfqd->cfq_quantum = cfq_quantum;
-	cfqd->cfq_fifo_expire[0] = cfq_fifo_expire[0];
-	cfqd->cfq_fifo_expire[1] = cfq_fifo_expire[1];
-	cfqd->cfq_back_max = cfq_back_max;
-	cfqd->cfq_back_penalty = cfq_back_penalty;
-	cfqd->cfq_slice[0] = cfq_slice_async;
-	cfqd->cfq_slice[1] = cfq_slice_sync;
-	cfqd->cfq_slice_async_rq = cfq_slice_async_rq;
-	cfqd->cfq_slice_idle = cfq_slice_idle;
-	cfqd->hw_tag = -1;
-	/*
-	 * we optimistically start assuming sync ops weren't delayed in last
-	 * second, in order to have larger depth for async operations.
-	 */
-	cfqd->last_delayed_sync = ktime_get_ns() - NSEC_PER_SEC;
+	bfqd->idle_slice_timer.function = bfq_idle_slice_timer;
+
+	INIT_WORK(&bfqd->unplug_work, bfq_kick_queue);
+
+	INIT_LIST_HEAD(&bfqd->active_list);
+	INIT_LIST_HEAD(&bfqd->idle_list);
+
+	bfqd->hw_tag = -1;
+
+	bfqd->bfq_max_budget = bfq_default_max_budget;
+
+	bfqd->bfq_fifo_expire[0] = bfq_fifo_expire[0];
+	bfqd->bfq_fifo_expire[1] = bfq_fifo_expire[1];
+	bfqd->bfq_back_max = bfq_back_max;
+	bfqd->bfq_back_penalty = bfq_back_penalty;
+	bfqd->bfq_slice_idle = bfq_slice_idle;
+	bfqd->bfq_class_idle_last_service = 0;
+	bfqd->bfq_timeout = bfq_timeout;
+
+	bfqd->bfq_requests_within_timer = 120;
+
 	return 0;
 }
 
-static void cfq_registered_queue(struct request_queue *q)
+static void bfq_slab_kill(void)
 {
-	struct elevator_queue *e = q->elevator;
-	struct cfq_data *cfqd = e->elevator_data;
+	kmem_cache_destroy(bfq_pool);
+}
 
-	/*
-	 * Default to IOPS mode with no idling for SSDs
-	 */
-	if (blk_queue_nonrot(q))
-		cfqd->cfq_slice_idle = 0;
+static int __init bfq_slab_setup(void)
+{
+	bfq_pool = KMEM_CACHE(bfq_queue, 0);
+	if (!bfq_pool)
+		return -ENOMEM;
+	return 0;
 }
 
-/*
- * sysfs parts below -->
- */
-static ssize_t
-cfq_var_show(unsigned int var, char *page)
+static ssize_t bfq_var_show(unsigned int var, char *page)
 {
 	return sprintf(page, "%u\n", var);
 }
 
-static ssize_t
-cfq_var_store(unsigned int *var, const char *page, size_t count)
+static ssize_t bfq_var_store(unsigned long *var, const char *page,
+			     size_t count)
 {
-	char *p = (char *) page;
+	unsigned long new_val;
+	int ret = kstrtoul(page, 10, &new_val);
+
+	if (ret == 0)
+		*var = new_val;
 
-	*var = simple_strtoul(p, &p, 10);
 	return count;
 }
 
+static ssize_t bfq_weights_show(struct elevator_queue *e, char *page)
+{
+	struct bfq_queue *bfqq;
+	struct bfq_data *bfqd = e->elevator_data;
+	ssize_t num_char = 0;
+
+	num_char += sprintf(page + num_char, "Tot reqs queued %d\n\n",
+			    bfqd->queued);
+
+	spin_lock_irq(bfqd->queue->queue_lock);
+
+	num_char += sprintf(page + num_char, "Active:\n");
+	list_for_each_entry(bfqq, &bfqd->active_list, bfqq_list) {
+		num_char += sprintf(page + num_char,
+				    "pid%d: weight %hu, nr_queued %d %d\n",
+				    bfqq->pid,
+				    bfqq->entity.weight,
+				    bfqq->queued[0],
+				    bfqq->queued[1]);
+	}
+
+	num_char += sprintf(page + num_char, "Idle:\n");
+	list_for_each_entry(bfqq, &bfqd->idle_list, bfqq_list) {
+		num_char += sprintf(page + num_char,
+				    "pid%d: weight %hu\n",
+				    bfqq->pid,
+				    bfqq->entity.weight);
+	}
+
+	spin_unlock_irq(bfqd->queue->queue_lock);
+
+	return num_char;
+}
+
 #define SHOW_FUNCTION(__FUNC, __VAR, __CONV)				\
 static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
 {									\
-	struct cfq_data *cfqd = e->elevator_data;			\
+	struct bfq_data *bfqd = e->elevator_data;			\
 	u64 __data = __VAR;						\
-	if (__CONV)							\
-		__data = div_u64(__data, NSEC_PER_MSEC);			\
-	return cfq_var_show(__data, (page));				\
-}
-SHOW_FUNCTION(cfq_quantum_show, cfqd->cfq_quantum, 0);
-SHOW_FUNCTION(cfq_fifo_expire_sync_show, cfqd->cfq_fifo_expire[1], 1);
-SHOW_FUNCTION(cfq_fifo_expire_async_show, cfqd->cfq_fifo_expire[0], 1);
-SHOW_FUNCTION(cfq_back_seek_max_show, cfqd->cfq_back_max, 0);
-SHOW_FUNCTION(cfq_back_seek_penalty_show, cfqd->cfq_back_penalty, 0);
-SHOW_FUNCTION(cfq_slice_idle_show, cfqd->cfq_slice_idle, 1);
-SHOW_FUNCTION(cfq_slice_sync_show, cfqd->cfq_slice[1], 1);
-SHOW_FUNCTION(cfq_slice_async_show, cfqd->cfq_slice[0], 1);
-SHOW_FUNCTION(cfq_slice_async_rq_show, cfqd->cfq_slice_async_rq, 0);
+	if (__CONV == 1)						\
+		__data = jiffies_to_msecs(__data);			\
+	else if (__CONV == 2)						\
+		__data = div_u64(__data, NSEC_PER_MSEC);		\
+	return bfq_var_show(__data, (page));				\
+}
+SHOW_FUNCTION(bfq_fifo_expire_sync_show, bfqd->bfq_fifo_expire[1], 2);
+SHOW_FUNCTION(bfq_fifo_expire_async_show, bfqd->bfq_fifo_expire[0], 2);
+SHOW_FUNCTION(bfq_back_seek_max_show, bfqd->bfq_back_max, 0);
+SHOW_FUNCTION(bfq_back_seek_penalty_show, bfqd->bfq_back_penalty, 0);
+SHOW_FUNCTION(bfq_slice_idle_show, bfqd->bfq_slice_idle, 2);
+SHOW_FUNCTION(bfq_max_budget_show, bfqd->bfq_user_max_budget, 0);
+SHOW_FUNCTION(bfq_timeout_sync_show, bfqd->bfq_timeout, 1);
+SHOW_FUNCTION(bfq_strict_guarantees_show, bfqd->strict_guarantees, 0);
 #undef SHOW_FUNCTION
 
 #define USEC_SHOW_FUNCTION(__FUNC, __VAR)				\
 static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
 {									\
-	struct cfq_data *cfqd = e->elevator_data;			\
+	struct bfq_data *bfqd = e->elevator_data;			\
 	u64 __data = __VAR;						\
 	__data = div_u64(__data, NSEC_PER_USEC);			\
-	return cfq_var_show(__data, (page));				\
+	return bfq_var_show(__data, (page));				\
 }
-USEC_SHOW_FUNCTION(cfq_slice_idle_us_show, cfqd->cfq_slice_idle);
-USEC_SHOW_FUNCTION(cfq_slice_sync_us_show, cfqd->cfq_slice[1]);
-USEC_SHOW_FUNCTION(cfq_slice_async_us_show, cfqd->cfq_slice[0]);
+USEC_SHOW_FUNCTION(bfq_slice_idle_us_show, bfqd->bfq_slice_idle);
 #undef USEC_SHOW_FUNCTION
 
 #define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, __CONV)			\
-static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)	\
+static ssize_t								\
+__FUNC(struct elevator_queue *e, const char *page, size_t count)	\
 {									\
-	struct cfq_data *cfqd = e->elevator_data;			\
-	unsigned int __data;						\
-	int ret = cfq_var_store(&__data, (page), count);		\
+	struct bfq_data *bfqd = e->elevator_data;			\
+	unsigned long uninitialized_var(__data);			\
+	int ret = bfq_var_store(&__data, (page), count);		\
 	if (__data < (MIN))						\
 		__data = (MIN);						\
 	else if (__data > (MAX))					\
 		__data = (MAX);						\
-	if (__CONV)							\
+	if (__CONV == 1)						\
+		*(__PTR) = msecs_to_jiffies(__data);			\
+	else if (__CONV == 2)						\
 		*(__PTR) = (u64)__data * NSEC_PER_MSEC;			\
 	else								\
 		*(__PTR) = __data;					\
 	return ret;							\
 }
-STORE_FUNCTION(cfq_quantum_store, &cfqd->cfq_quantum, 1, UINT_MAX, 0);
-STORE_FUNCTION(cfq_fifo_expire_sync_store, &cfqd->cfq_fifo_expire[1], 1,
-		UINT_MAX, 1);
-STORE_FUNCTION(cfq_fifo_expire_async_store, &cfqd->cfq_fifo_expire[0], 1,
-		UINT_MAX, 1);
-STORE_FUNCTION(cfq_back_seek_max_store, &cfqd->cfq_back_max, 0, UINT_MAX, 0);
-STORE_FUNCTION(cfq_back_seek_penalty_store, &cfqd->cfq_back_penalty, 1,
-		UINT_MAX, 0);
-STORE_FUNCTION(cfq_slice_idle_store, &cfqd->cfq_slice_idle, 0, UINT_MAX, 1);
-STORE_FUNCTION(cfq_slice_sync_store, &cfqd->cfq_slice[1], 1, UINT_MAX, 1);
-STORE_FUNCTION(cfq_slice_async_store, &cfqd->cfq_slice[0], 1, UINT_MAX, 1);
-STORE_FUNCTION(cfq_slice_async_rq_store, &cfqd->cfq_slice_async_rq, 1,
-		UINT_MAX, 0);
+STORE_FUNCTION(bfq_fifo_expire_sync_store, &bfqd->bfq_fifo_expire[1], 1,
+		INT_MAX, 2);
+STORE_FUNCTION(bfq_fifo_expire_async_store, &bfqd->bfq_fifo_expire[0], 1,
+		INT_MAX, 2);
+STORE_FUNCTION(bfq_back_seek_max_store, &bfqd->bfq_back_max, 0, INT_MAX, 0);
+STORE_FUNCTION(bfq_back_seek_penalty_store, &bfqd->bfq_back_penalty, 1,
+		INT_MAX, 0);
+STORE_FUNCTION(bfq_slice_idle_store, &bfqd->bfq_slice_idle, 0, INT_MAX, 2);
 #undef STORE_FUNCTION
 
 #define USEC_STORE_FUNCTION(__FUNC, __PTR, MIN, MAX)			\
 static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)	\
 {									\
-	struct cfq_data *cfqd = e->elevator_data;			\
-	unsigned int __data;						\
-	int ret = cfq_var_store(&__data, (page), count);		\
+	struct bfq_data *bfqd = e->elevator_data;			\
+	unsigned long __data;						\
+	int ret = bfq_var_store(&__data, (page), count);		\
 	if (__data < (MIN))						\
 		__data = (MIN);						\
 	else if (__data > (MAX))					\
@@ -2437,108 +3865,181 @@ static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)
 	*(__PTR) = (u64)__data * NSEC_PER_USEC;				\
 	return ret;							\
 }
-USEC_STORE_FUNCTION(cfq_slice_idle_us_store, &cfqd->cfq_slice_idle, 0, UINT_MAX);
-USEC_STORE_FUNCTION(cfq_slice_sync_us_store, &cfqd->cfq_slice[1], 1, UINT_MAX);
-USEC_STORE_FUNCTION(cfq_slice_async_us_store, &cfqd->cfq_slice[0], 1, UINT_MAX);
+USEC_STORE_FUNCTION(bfq_slice_idle_us_store, &bfqd->bfq_slice_idle, 0,
+		    UINT_MAX);
 #undef USEC_STORE_FUNCTION
 
-static ssize_t cfq_fake_lat_show(struct elevator_queue *e, char *page)
+static ssize_t bfq_fake_lat_show(struct elevator_queue *e, char *page)
 {
-	pr_warn_once("CFQ I/O SCHED: tried to read removed latency tunable");
+	pr_warn_once("BFQ I/O SCHED: tried to read removed latency tunable");
 	return sprintf(page, "0\n");
 }
 
 static ssize_t
-cfq_fake_lat_store(struct elevator_queue *e, const char *page, size_t count)
+bfq_fake_lat_store(struct elevator_queue *e, const char *page, size_t count)
+{
+	pr_warn_once("BFQ I/O SCHED: tried to write removed latency tunable");
+	return count;
+}
+
+/* do nothing for the moment */
+static ssize_t bfq_weights_store(struct elevator_queue *e,
+				    const char *page, size_t count)
 {
-	pr_warn_once("CFQ I/O SCHED: tried to write removed latency tunable");
 	return count;
 }
 
-#define CFQ_ATTR(name) \
-	__ATTR(name, S_IRUGO|S_IWUSR, cfq_##name##_show, cfq_##name##_store)
-
-#define CFQ_FAKE_LAT_ATTR(name) \
-	__ATTR(name, S_IRUGO|S_IWUSR, cfq_fake_lat_show, cfq_fake_lat_store)
-
-static struct elv_fs_entry cfq_attrs[] = {
-	CFQ_ATTR(quantum),
-	CFQ_ATTR(fifo_expire_sync),
-	CFQ_ATTR(fifo_expire_async),
-	CFQ_ATTR(back_seek_max),
-	CFQ_ATTR(back_seek_penalty),
-	CFQ_ATTR(slice_sync),
-	CFQ_ATTR(slice_sync_us),
-	CFQ_ATTR(slice_async),
-	CFQ_ATTR(slice_async_us),
-	CFQ_ATTR(slice_async_rq),
-	CFQ_ATTR(slice_idle),
-	CFQ_ATTR(slice_idle_us),
-	CFQ_FAKE_LAT_ATTR(low_latency),
-	CFQ_FAKE_LAT_ATTR(target_latency),
-	CFQ_FAKE_LAT_ATTR(target_latency_us),
+static unsigned long bfq_estimated_max_budget(struct bfq_data *bfqd)
+{
+	u64 timeout = jiffies_to_msecs(bfqd->bfq_timeout);
+
+	if (bfqd->peak_rate_samples >= BFQ_PEAK_RATE_SAMPLES)
+		return bfq_calc_max_budget(bfqd->peak_rate, timeout);
+	else
+		return bfq_default_max_budget;
+}
+
+static ssize_t bfq_max_budget_store(struct elevator_queue *e,
+				    const char *page, size_t count)
+{
+	struct bfq_data *bfqd = e->elevator_data;
+	unsigned long uninitialized_var(__data);
+	int ret = bfq_var_store(&__data, (page), count);
+
+	if (__data == 0)
+		bfqd->bfq_max_budget = bfq_estimated_max_budget(bfqd);
+	else {
+		if (__data > INT_MAX)
+			__data = INT_MAX;
+		bfqd->bfq_max_budget = __data;
+	}
+
+	bfqd->bfq_user_max_budget = __data;
+
+	return ret;
+}
+
+/*
+ * Leaving this name to preserve name compatibility with cfq
+ * parameters, but this timeout is used for both sync and async.
+ */
+static ssize_t bfq_timeout_sync_store(struct elevator_queue *e,
+				      const char *page, size_t count)
+{
+	struct bfq_data *bfqd = e->elevator_data;
+	unsigned long uninitialized_var(__data);
+	int ret = bfq_var_store(&__data, (page), count);
+
+	if (__data < 1)
+		__data = 1;
+	else if (__data > INT_MAX)
+		__data = INT_MAX;
+
+	bfqd->bfq_timeout = msecs_to_jiffies(__data);
+	if (bfqd->bfq_user_max_budget == 0)
+		bfqd->bfq_max_budget = bfq_estimated_max_budget(bfqd);
+
+	return ret;
+}
+
+static ssize_t bfq_strict_guarantees_store(struct elevator_queue *e,
+				     const char *page, size_t count)
+{
+	struct bfq_data *bfqd = e->elevator_data;
+	unsigned long uninitialized_var(__data);
+	int ret = bfq_var_store(&__data, (page), count);
+
+	if (__data > 1)
+		__data = 1;
+	if (!bfqd->strict_guarantees && __data == 1
+	    && bfqd->bfq_slice_idle < msecs_to_jiffies(8))
+		bfqd->bfq_slice_idle = msecs_to_jiffies(8);
+
+	bfqd->strict_guarantees = __data;
+
+	return ret;
+}
+
+#define BFQ_ATTR(name) \
+	__ATTR(name, S_IRUGO|S_IWUSR, bfq_##name##_show, bfq_##name##_store)
+
+#define BFQ_FAKE_LAT_ATTR(name) \
+	__ATTR(name, S_IRUGO|S_IWUSR, bfq_fake_lat_show, bfq_fake_lat_store)
+
+static struct elv_fs_entry bfq_attrs[] = {
+	BFQ_ATTR(fifo_expire_sync),
+	BFQ_ATTR(fifo_expire_async),
+	BFQ_ATTR(back_seek_max),
+	BFQ_ATTR(back_seek_penalty),
+	BFQ_ATTR(slice_idle),
+	BFQ_ATTR(slice_idle_us),
+	BFQ_ATTR(max_budget),
+	BFQ_ATTR(timeout_sync),
+	BFQ_ATTR(strict_guarantees),
+	BFQ_ATTR(weights),
+	BFQ_FAKE_LAT_ATTR(low_latency),
+	BFQ_FAKE_LAT_ATTR(target_latency),
+	BFQ_FAKE_LAT_ATTR(target_latency_us),
 	__ATTR_NULL
 };
 
-static struct elevator_type iosched_cfq = {
+static struct elevator_type iosched_bfq = {
 	.ops = {
-		.elevator_merge_fn = 		cfq_merge,
-		.elevator_merged_fn =		cfq_merged_request,
-		.elevator_merge_req_fn =	cfq_merged_requests,
-		.elevator_allow_bio_merge_fn =	cfq_allow_bio_merge,
-		.elevator_allow_rq_merge_fn =	cfq_allow_rq_merge,
-		.elevator_dispatch_fn =		cfq_dispatch_requests,
-		.elevator_add_req_fn =		cfq_insert_request,
-		.elevator_activate_req_fn =	cfq_activate_request,
-		.elevator_deactivate_req_fn =	cfq_deactivate_request,
-		.elevator_completed_req_fn =	cfq_completed_request,
+		.elevator_merge_fn =		bfq_merge,
+		.elevator_merged_fn =		bfq_merged_request,
+		.elevator_merge_req_fn =	bfq_merged_requests,
+		.elevator_allow_bio_merge_fn =	bfq_allow_bio_merge,
+		.elevator_allow_rq_merge_fn =	bfq_allow_rq_merge,
+		.elevator_dispatch_fn =		bfq_dispatch_requests,
+		.elevator_add_req_fn =		bfq_insert_request,
+		.elevator_activate_req_fn =	bfq_activate_request,
+		.elevator_deactivate_req_fn =	bfq_deactivate_request,
+		.elevator_completed_req_fn =	bfq_completed_request,
 		.elevator_former_req_fn =	elv_rb_former_request,
 		.elevator_latter_req_fn =	elv_rb_latter_request,
-		.elevator_init_icq_fn =		cfq_init_icq,
-		.elevator_exit_icq_fn =		cfq_exit_icq,
-		.elevator_set_req_fn =		cfq_set_request,
-		.elevator_put_req_fn =		cfq_put_request,
-		.elevator_may_queue_fn =	cfq_may_queue,
-		.elevator_init_fn =		cfq_init_queue,
-		.elevator_exit_fn =		cfq_exit_queue,
-		.elevator_registered_fn =	cfq_registered_queue,
+		.elevator_init_icq_fn =		bfq_init_icq,
+		.elevator_exit_icq_fn =		bfq_exit_icq,
+		.elevator_set_req_fn =		bfq_set_request,
+		.elevator_put_req_fn =		bfq_put_request,
+		.elevator_may_queue_fn =	bfq_may_queue,
+		.elevator_init_fn =		bfq_init_queue,
+		.elevator_exit_fn =		bfq_exit_queue,
 	},
-	.icq_size	=	sizeof(struct cfq_io_cq),
-	.icq_align	=	__alignof__(struct cfq_io_cq),
-	.elevator_attrs =	cfq_attrs,
-	.elevator_name	=	"cfq",
+	.icq_size =		sizeof(struct bfq_io_cq),
+	.icq_align =		__alignof__(struct bfq_io_cq),
+	.elevator_attrs =	bfq_attrs,
+	.elevator_name =	"cfq",
 	.elevator_owner =	THIS_MODULE,
 };
 
-static int __init cfq_init(void)
+static int __init bfq_init(void)
 {
 	int ret;
 
 	ret = -ENOMEM;
-	cfq_pool = KMEM_CACHE(cfq_queue, 0);
-	if (!cfq_pool)
-		return ret;
+	if (bfq_slab_setup())
+		goto err_pol_unreg;
 
-	ret = elv_register(&iosched_cfq);
+	ret = elv_register(&iosched_bfq);
 	if (ret)
-		goto err_free_pool;
+		goto err_pol_unreg;
+
+	pr_info("BFQ I/O-scheduler: v0");
 
 	return 0;
 
-err_free_pool:
-	kmem_cache_destroy(cfq_pool);
+err_pol_unreg:
 	return ret;
 }
 
-static void __exit cfq_exit(void)
+static void __exit bfq_exit(void)
 {
-	elv_unregister(&iosched_cfq);
-	kmem_cache_destroy(cfq_pool);
+	elv_unregister(&iosched_bfq);
+	bfq_slab_kill();
 }
 
-module_init(cfq_init);
-module_exit(cfq_exit);
+module_init(bfq_init);
+module_exit(bfq_exit);
 
-MODULE_AUTHOR("Jens Axboe");
+MODULE_AUTHOR("Arianna Avanzini, Fabio Checconi, Paolo Valente");
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Completely Fair Queueing IO scheduler");
-- 
1.9.1
