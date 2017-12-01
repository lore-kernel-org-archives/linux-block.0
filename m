Return-Path: <ming.lei@redhat.com>
Date: Fri, 1 Dec 2017 23:33:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Ivan Kozik <ivan@ludios.org>
Cc: axboe@kernel.dk, paolo.valente@linaro.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, oleksandr@natalenko.name
Subject: Re: blk-mq + bfq IO hangs after writing partition table
Message-ID: <20171201153300.GA22048@ming.t460p>
References: <87fu8v7xe2.fsf@ksca2.i-did-not-set--mail-host-address--so-tickle-me>
 <20171201085051.GA1308@ming.t460p>
 <CAKynti+h_-MuR7YXsiYHqTv7xCiy1QhRUyu=zCcb9brwR2ByxQ@mail.gmail.com>
 <20171201133546.GA11483@ming.t460p>
 <CAKyntiKzyPK7MVg-WqOhzLsVx5o2zw+OMp1Bw_wTCWa8-T5kdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
In-Reply-To: <CAKyntiKzyPK7MVg-WqOhzLsVx5o2zw+OMp1Bw_wTCWa8-T5kdQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2017 at 02:46:39PM +0000, Ivan Kozik wrote:
> On Fri, Dec 1, 2017 at 1:35 PM, Ming Lei <ming.lei@redhat.com> wrote:
> > Basically all IO hang happen inside get_request(), and seems this issue
> > isn't related with recent change in V4.15, could you run V4.14 to see if
> > there is such issue?
> 
> I tried several times and I could not reproduce the problem on linus's v4.14.
> 
> Also, while testing, I noticed that udev rules can switch out the IO
> scheduler after gdisk writes partitions, but this appears to be
> unrelated to the problem, just something to remember when testing.


Now I can reproduce the issue on usb-storage.

After applying the attached debug patch, the log[1] can be generated.
>From the log, there are requests inserted to BFQ queue, but these requests
can't be retrieved by e->type->ops.mq.dispatch_request() in
blk_mq_do_dispatch_sched(), then IO hang is caused.

Not see this issue on mq-deadline, looks a BFQ specific issue.


[1] http://people.redhat.com/minlei/tests/logs/bfq-trace


-- 
Ming

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="us-bfq.patch"

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index bcb6d21baf12..2db8ac732fba 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4362,6 +4362,10 @@ static void bfq_insert_requests(struct blk_mq_hw_ctx *hctx,
 
 		rq = list_first_entry(list, struct request, queuelist);
 		list_del_init(&rq->queuelist);
+
+		if (hctx->queue->tag_set->flags & 0x8)
+			trace_printk("insert rq->%d\n", rq->internal_tag);
+
 		bfq_insert_request(hctx, rq, at_head);
 	}
 }
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c117bd8fd1f6..62efca331797 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -107,8 +107,16 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 
 		rq = e->type->ops.mq.dispatch_request(hctx);
 		if (!rq) {
+			if (q->tag_set->flags & 0x8)
+				trace_printk("not get rq, %d\n",
+						e->type->ops.mq.has_work(hctx));
 			blk_mq_put_dispatch_budget(hctx);
 			break;
+		} else {
+			if (q->tag_set->flags & 0x8)
+				trace_printk("get rq->%d, %d\n",
+						rq->internal_tag,
+						e->type->ops.mq.has_work(hctx));
 		}
 
 		/*
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1cbc497e00bd..db9556662e27 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2268,6 +2268,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 	shost->tag_set.cmd_size = cmd_size;
 	shost->tag_set.numa_node = NUMA_NO_NODE;
 	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
+	if (!strcmp(shost->hostt->name, "usb-storage"))
+		shost->tag_set.flags |= 0x8;
 	shost->tag_set.flags |=
 		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
 	shost->tag_set.driver_data = shost;

--NzB8fVQJ5HfG6fxh--
