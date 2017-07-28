Return-Path: <axboe@kernel.dk>
Subject: Re: blk_mq_sched_insert_request: inconsistent {SOFTIRQ-ON-W} ->
 {IN-SOFTIRQ-W} usage
To: Michael Ellerman <mpe@ellerman.id.au>,
 Bart Van Assche <Bart.VanAssche@wdc.com>, Brian J King <bjking1@us.ibm.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <87a83qfosu.fsf@concordia.ellerman.id.au>
 <073ed79c-11ce-e86c-a905-91fd28675d47@kernel.dk>
 <1501166846.2516.1.camel@wdc.com>
 <5b85a365-faa1-3987-9b6b-270399c30686@kernel.dk>
 <87lgn9dqx3.fsf@concordia.ellerman.id.au>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <92379297-9667-ae52-b05c-6c8a0ce4751c@kernel.dk>
Date: Fri, 28 Jul 2017 08:25:48 -0600
MIME-Version: 1.0
In-Reply-To: <87lgn9dqx3.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/28/2017 12:19 AM, Michael Ellerman wrote:
> Jens Axboe <axboe@kernel.dk> writes:
>> On 07/27/2017 08:47 AM, Bart Van Assche wrote:
>>> On Thu, 2017-07-27 at 08:02 -0600, Jens Axboe wrote:
>>>> The bug looks like SCSI running the queue inline from IRQ
>>>> context, that's not a good idea.
> ...
>>>
>>> scsi_run_queue() works fine if no scheduler is configured. Additionally, that
>>> code predates the introduction of blk-mq I/O schedulers. I think it is
>>> nontrivial for block driver authors to figure out that a queue has to be run
>>> from process context if a scheduler has been configured that does not support
>>> to be run from interrupt context.
>>
>> No it doesn't, you could never run the queue from interrupt context with
>> async == false. So I don't think that's confusing at all, you should
>> always be aware of the context.
>>
>>> How about adding WARN_ON_ONCE(in_interrupt()) to
>>> blk_mq_start_hw_queue() or replacing the above patch by the following:
>>
>> No, I hate having dependencies like that, because they always just catch
>> one of them. Looks like the IPR path that hits this should just offload
>> to a workqueue or similar, you don't have to make any scsi_run_queue()
>> async.
> 
> OK, so the resolution is "fix it in IPR" ?

I'll leave that to the SCSI crew. But at least one bug is in IPR, if you
look at the call trace:

- timer function triggers, runs ipr_reset_timer_done(), which grabs the
  host lock AND disables interrupts.
- further down in the call path, ipr_ioa_bringdown_done() uncondtionally
  enables interrupts:

                spin_unlock_irq(ioa_cfg->host->host_lock);
                scsi_unblock_requests(ioa_cfg->host);
                spin_lock_irq(ioa_cfg->host->host_lock); 

And the call to scsi_unblock_requests() is the one that ultimately runs
the queue. The IRQ issue aside here, scsi_unblock_requests() could run
the queue async, and we could retain the normal sync run otherwise.

Can you try the below fix? Should be more palatable than the previous
one. Brian, maybe you can take a look at the IRQ issue mentioned above?

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index f6097b89d5d3..dfb89596af81 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -481,13 +481,14 @@ static void scsi_starved_list_run(struct Scsi_Host *shost)
  * Purpose:    Select a proper request queue to serve next
  *
  * Arguments:  q       - last request's queue
+ *             async   - run queues async, if we need to
  *
  * Returns:     Nothing
  *
  * Notes:      The previous command was completely finished, start
  *             a new one if possible.
  */
-static void scsi_run_queue(struct request_queue *q)
+static void scsi_run_queue(struct request_queue *q, bool async)
 {
 	struct scsi_device *sdev = q->queuedata;
 
@@ -497,7 +498,7 @@ static void scsi_run_queue(struct request_queue *q)
 		scsi_starved_list_run(sdev->host);
 
 	if (q->mq_ops)
-		blk_mq_run_hw_queues(q, false);
+		blk_mq_run_hw_queues(q, async);
 	else
 		blk_run_queue(q);
 }
@@ -509,7 +510,7 @@ void scsi_requeue_run_queue(struct work_struct *work)
 
 	sdev = container_of(work, struct scsi_device, requeue_work);
 	q = sdev->request_queue;
-	scsi_run_queue(q);
+	scsi_run_queue(q, false);
 }
 
 /*
@@ -543,17 +544,22 @@ static void scsi_requeue_command(struct request_queue *q, struct scsi_cmnd *cmd)
 	blk_requeue_request(q, req);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
-	scsi_run_queue(q);
+	scsi_run_queue(q, true);
 
 	put_device(&sdev->sdev_gendev);
 }
 
-void scsi_run_host_queues(struct Scsi_Host *shost)
+static void __scsi_run_host_queues(struct Scsi_Host *shost, bool async)
 {
 	struct scsi_device *sdev;
 
 	shost_for_each_device(sdev, shost)
-		scsi_run_queue(sdev->request_queue);
+		scsi_run_queue(sdev->request_queue, async);
+}
+
+void scsi_run_host_queues(struct Scsi_Host *shost)
+{
+	__scsi_run_host_queues(shost, false);
 }
 
 static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
@@ -671,7 +677,7 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 		blk_finish_request(req, error);
 		spin_unlock_irqrestore(q->queue_lock, flags);
 
-		scsi_run_queue(q);
+		scsi_run_queue(q, false);
 	}
 
 	put_device(&sdev->sdev_gendev);
@@ -2293,7 +2299,7 @@ EXPORT_SYMBOL(scsi_block_requests);
 void scsi_unblock_requests(struct Scsi_Host *shost)
 {
 	shost->host_self_blocked = 0;
-	scsi_run_host_queues(shost);
+	__scsi_run_host_queues(shost, true);
 }
 EXPORT_SYMBOL(scsi_unblock_requests);
 
@@ -2897,10 +2903,10 @@ scsi_device_quiesce(struct scsi_device *sdev)
 	if (err)
 		return err;
 
-	scsi_run_queue(sdev->request_queue);
+	scsi_run_queue(sdev->request_queue, false);
 	while (atomic_read(&sdev->device_busy)) {
 		msleep_interruptible(200);
-		scsi_run_queue(sdev->request_queue);
+		scsi_run_queue(sdev->request_queue, false);
 	}
 	return 0;
 }
@@ -2924,7 +2930,7 @@ void scsi_device_resume(struct scsi_device *sdev)
 	mutex_lock(&sdev->state_mutex);
 	if (sdev->sdev_state == SDEV_QUIESCE &&
 	    scsi_device_set_state(sdev, SDEV_RUNNING) == 0)
-		scsi_run_queue(sdev->request_queue);
+		scsi_run_queue(sdev->request_queue, false);
 	mutex_unlock(&sdev->state_mutex);
 }
 EXPORT_SYMBOL(scsi_device_resume);

-- 
Jens Axboe
