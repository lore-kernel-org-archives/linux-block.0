Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44061 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754015AbdCOVfZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2017 17:35:25 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "tom.leiming@gmail.com" <tom.leiming@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "yizhan@redhat.com" <yizhan@redhat.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] blk-mq: don't complete un-started request in
 timeout handler
Date: Wed, 15 Mar 2017 21:35:03 +0000
Message-ID: <1489613678.2660.9.camel@sandisk.com>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
         <1489064578-17305-3-git-send-email-tom.leiming@gmail.com>
         <1489536441.2676.21.camel@sandisk.com> <20170315121851.GA15807@ming.t460p>
         <20170315124024.GA16549@ming.t460p> <1489592177.2660.1.camel@sandisk.com>
         <20170315162158.GA18768@ming.t460p>
In-Reply-To: <20170315162158.GA18768@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-03-16 at 00:22 +0800, Ming Lei wrote:
> On Wed, Mar 15, 2017 at 03:36:31PM +0000, Bart Van Assche wrote:
> > Please have another look at __blk_mq_requeue_request(). In that functio=
n
> > the following code occurs: if (test_and_clear_bit(REQ_ATOM_STARTED,
> > &rq->atomic_flags)) { ... }
> >=20
> > I think the=A0REQ_ATOM_STARTED check in blk_mq_check_expired() races wi=
th the
> > test_and_clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags) call in
> > __blk_mq_requeue_request().
>=20
> OK, this race should only exist in case that the requeue happens after di=
spatch
> busy, because COMPLETE flag isn't set. And if the requeue is from io comp=
letion,
> no such race because COMPLETE flag is set.
>=20
> One solution I thought of is to call blk_mark_rq_complete() before requeu=
ing
> when dispatch busy happened, but that looks a bit silly. Another way is t=
o
> set STARTED flag just after .queue_rq returns BLK_MQ_RQ_QUEUE_OK, which l=
ooks
> reasonable too. Any comments on the 2nd solution?

Sorry but I don't think that would be sufficient. There are several other
scenarios that have not been mentioned above, e.g. that a tag gets freed an=
d
reused after the blk_mq_check_expired() call started and before that functi=
on
has had the chance to examine any members of struct request. What is needed=
 in
blk_mq_check_expired() is the following as a single atomic operation:
* Check whether REQ_ATOM_STARTED has been set.
* Check whether REQ_ATOM_COMPLETE has not yet been set.
* If both conditions have been met, set REQ_ATOM_COMPLETE.

I don't think there is another solution than using a single state variable =
to
represent the REQ_ATOM_STARTED and REQ_ATOM_COMPLETE states instead of two
independent bits. How about the patch below?

Thanks,

Bart.


[PATCH] blk-mq: Fix request state manipulation races

Use a single state variable instead of two separate bits
REQ_ATOM_STARTED and REQ_ATOM_COMPLETE. For blk-mq, make
__blk_mq_finish_request() perform the transition from "complete" to
"not complete" instead of blk_mq_start_request(). Make sure that
blk_mq_check_expired() uses a single atomic operation to test the
"started" and "complete" states and to set the "complete" state.
---
=A0block/blk-core.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A06 +++--
=A0block/blk-mq.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0| 67 ++++++++++++++=
+++-----------------------------
=A0block/blk-timeout.c=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A02 +-
=A0block/blk.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0| 21 ++++++++=
++-----
=A0drivers/scsi/virtio_scsi.c |=A0=A02 +-
=A0include/linux/blkdev.h=A0=A0=A0=A0=A0|=A0=A01 +
=A06 files changed, 47 insertions(+), 52 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 0eeb99ef654f..dff857d2b86b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1305,7 +1305,7 @@ EXPORT_SYMBOL(blk_get_request);
=A0void blk_requeue_request(struct request_queue *q, struct request *rq)
=A0{
=A0	blk_delete_timer(rq);
-	blk_clear_rq_complete(rq);
+	atomic_set(&rq->state, REQ_NOT_STARTED);
=A0	trace_block_rq_requeue(q, rq);
=A0	wbt_requeue(q->rq_wb, &rq->issue_stat);
=A0
@@ -2477,7 +2477,9 @@ void blk_start_request(struct request *req)
=A0		wbt_issue(req->q->rq_wb, &req->issue_stat);
=A0	}
=A0
-	BUG_ON(test_bit(REQ_ATOM_COMPLETE, &req->atomic_flags));
+	WARN_ONCE(atomic_read(&req->state) !=3D REQ_NOT_STARTED,
+		=A0=A0"unexpected request state %d !=3D %d\n",
+		=A0=A0atomic_read(&req->state), REQ_NOT_STARTED);
=A0	blk_add_timer(req);
=A0}
=A0EXPORT_SYMBOL(blk_start_request);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 159187a28d66..fe73d5a1ffc3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -343,7 +343,7 @@ void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx=
, struct blk_mq_ctx *ctx,
=A0	wbt_done(q->rq_wb, &rq->issue_stat);
=A0	rq->rq_flags =3D 0;
=A0
-	clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
+	atomic_set(&rq->state, REQ_NOT_STARTED);
=A0	clear_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
=A0	if (rq->tag !=3D -1)
=A0		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
@@ -479,7 +479,7 @@ EXPORT_SYMBOL(blk_mq_complete_request);
=A0
=A0int blk_mq_request_started(struct request *rq)
=A0{
-	return test_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
+	return atomic_read(&rq->state) =3D=3D REQ_STARTED;
=A0}
=A0EXPORT_SYMBOL_GPL(blk_mq_request_started);
=A0
@@ -505,16 +505,10 @@ void blk_mq_start_request(struct request *rq)
=A0	=A0*/
=A0	smp_mb__before_atomic();
=A0
-	/*
-	=A0* Mark us as started and clear complete. Complete might have been
-	=A0* set if requeue raced with timeout, which then marked it as
-	=A0* complete. So be sure to clear complete again when we start
-	=A0* the request, otherwise we'll ignore the completion event.
-	=A0*/
-	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
-		set_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
-	if (test_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags))
-		clear_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags);
+	WARN_ONCE(atomic_read(&rq->state) !=3D REQ_NOT_STARTED,
+		=A0=A0"unexpected request state %d !=3D %d\n",
+		=A0=A0atomic_read(&rq->state), REQ_NOT_STARTED);
+	atomic_set(&rq->state, REQ_STARTED);
=A0
=A0	if (q->dma_drain_size && blk_rq_bytes(rq)) {
=A0		/*
@@ -530,12 +524,14 @@ EXPORT_SYMBOL(blk_mq_start_request);
=A0static void __blk_mq_requeue_request(struct request *rq)
=A0{
=A0	struct request_queue *q =3D rq->q;
+	enum rq_state prev;
=A0
=A0	trace_block_rq_requeue(q, rq);
=A0	wbt_requeue(q->rq_wb, &rq->issue_stat);
=A0	blk_mq_sched_requeue_request(rq);
=A0
-	if (test_and_clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
+	prev =3D atomic_xchg(&rq->state, REQ_NOT_STARTED);
+	if (prev !=3D REQ_NOT_STARTED) {
=A0		if (q->dma_drain_size && blk_rq_bytes(rq))
=A0			rq->nr_phys_segments--;
=A0	}
@@ -661,17 +657,7 @@ void blk_mq_rq_timed_out(struct request *req, bool res=
erved)
=A0	const struct blk_mq_ops *ops =3D req->q->mq_ops;
=A0	enum blk_eh_timer_return ret =3D BLK_EH_RESET_TIMER;
=A0
-	/*
-	=A0* We know that complete is set at this point. If STARTED isn't set
-	=A0* anymore, then the request isn't active and the "timeout" should
-	=A0* just be ignored. This can happen due to the bitflag ordering.
-	=A0* Timeout first checks if STARTED is set, and if it is, assumes
-	=A0* the request is active. But if we race with completion, then
-	=A0* we both flags will get cleared. So check here again, and ignore
-	=A0* a timeout event with a request that isn't active.
-	=A0*/
-	if (!test_bit(REQ_ATOM_STARTED, &req->atomic_flags))
-		return;
+	WARN_ON_ONCE(atomic_read(&req->state) !=3D REQ_COMPLETE);
=A0
=A0	if (ops->timeout)
=A0		ret =3D ops->timeout(req, reserved);
@@ -682,7 +668,7 @@ void blk_mq_rq_timed_out(struct request *req, bool rese=
rved)
=A0		break;
=A0	case BLK_EH_RESET_TIMER:
=A0		blk_add_timer(req);
-		blk_clear_rq_complete(req);
+		atomic_set(&req->state, REQ_STARTED);
=A0		break;
=A0	case BLK_EH_NOT_HANDLED:
=A0		break;
@@ -692,27 +678,24 @@ void blk_mq_rq_timed_out(struct request *req, bool re=
served)
=A0	}
=A0}
=A0
+/*
+ * Check whether or not a request has expired. This function can execute
+ * concurrently with other functions that change the request state. This c=
an
+ * result in returning a deadline (blk_mq_timeout_data.next) that occurs
+ * before a request times out. However, this is harmless because the next
+ * call of blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &data) will
+ * yield the correct timeout, unless the same race occurs again.
+ */
=A0static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
=A0		struct request *rq, void *priv, bool reserved)
=A0{
=A0	struct blk_mq_timeout_data *data =3D priv;
=A0
-	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
-		/*
-		=A0* If a request wasn't started before the queue was
-		=A0* marked dying, kill it here or it'll go unnoticed.
-		=A0*/
-		if (unlikely(blk_queue_dying(rq->q))) {
-			rq->errors =3D -EIO;
-			blk_mq_end_request(rq, rq->errors);
-		}
-		return;
-	}
-
-	if (time_after_eq(jiffies, rq->deadline)) {
-		if (!blk_mark_rq_complete(rq))
-			blk_mq_rq_timed_out(rq, reserved);
-	} else if (!data->next_set || time_after(data->next, rq->deadline)) {
+	if (time_after_eq(jiffies, rq->deadline) &&
+	=A0=A0=A0=A0!blk_mark_rq_complete_if_started(rq)) {
+		blk_mq_rq_timed_out(rq, reserved);
+	} else if ((!data->next_set || time_after(data->next, rq->deadline)) &&
+		=A0=A0=A0blk_mq_request_started(rq)) {
=A0		data->next =3D rq->deadline;
=A0		data->next_set =3D 1;
=A0	}
@@ -2821,7 +2804,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_q=
ueue *q,
=A0
=A0	hrtimer_init_sleeper(&hs, current);
=A0	do {
-		if (test_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags))
+		if (atomic_read(&rq->state) =3D=3D REQ_COMPLETE)
=A0			break;
=A0		set_current_state(TASK_UNINTERRUPTIBLE);
=A0		hrtimer_start_expires(&hs.timer, mode);
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index a30441a200c0..9a8b44ebfb99 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -94,7 +94,7 @@ static void blk_rq_timed_out(struct request *req)
=A0		break;
=A0	case BLK_EH_RESET_TIMER:
=A0		blk_add_timer(req);
-		blk_clear_rq_complete(req);
+		atomic_set(&req->state, REQ_NOT_STARTED);
=A0		break;
=A0	case BLK_EH_NOT_HANDLED:
=A0		/*
diff --git a/block/blk.h b/block/blk.h
index d1ea4bd9b9a3..8af5fe21e85f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -115,23 +115,32 @@ void blk_account_io_done(struct request *req);
=A0 * Internal atomic flags for request handling
=A0 */
=A0enum rq_atomic_flags {
-	REQ_ATOM_COMPLETE =3D 0,
-	REQ_ATOM_STARTED,
=A0	REQ_ATOM_POLL_SLEPT,
=A0};
=A0
=A0/*
+ * Request states. Note: REQ_STARTED is only used by the blk-mq code.
+ */
+enum rq_state {
+	REQ_NOT_STARTED,
+	REQ_STARTED,
+	REQ_COMPLETE,
+};
+
+/*
=A0 * EH timer and IO completion will both attempt to 'grab' the request, m=
ake
- * sure that only one of them succeeds
+ * sure that only one of them succeeds. The return value 0 means that this
+ * function changed the request state from "not complete" into "complete".
=A0 */
=A0static inline int blk_mark_rq_complete(struct request *rq)
=A0{
-	return test_and_set_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags);
+	return atomic_xchg(&rq->state, REQ_COMPLETE) =3D=3D REQ_COMPLETE;
=A0}
=A0
-static inline void blk_clear_rq_complete(struct request *rq)
+static inline int blk_mark_rq_complete_if_started(struct request *rq)
=A0{
-	clear_bit(REQ_ATOM_COMPLETE, &rq->atomic_flags);
+	return atomic_cmpxchg(&rq->state, REQ_STARTED, REQ_COMPLETE) !=3D
+		REQ_STARTED;
=A0}
=A0
=A0/*
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 939c47df73fa..136379097131 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -672,7 +672,7 @@ static int virtscsi_tmf(struct virtio_scsi *vscsi, stru=
ct virtio_scsi_cmd *cmd)
=A0	=A0*
=A0	=A0* In the abort case, sc->scsi_done will do nothing, because
=A0	=A0* the block layer must have detected a timeout and as a result
-	=A0* REQ_ATOM_COMPLETE has been set.
+	=A0* rq->state =3D=3D REQ_COMPLETED.
=A0	=A0*/
=A0	virtscsi_poll_requests(vscsi);
=A0
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5a7da607ca04..b286887b095e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -142,6 +142,7 @@ struct request {
=A0
=A0	int internal_tag;
=A0
+	atomic_t state;
=A0	unsigned long atomic_flags;
=A0
=A0	/* the following two fields are internal, NEVER access directly */
--=A0
2.12.0
