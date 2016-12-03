Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55694 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751937AbcLCEC7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Dec 2016 23:02:59 -0500
Subject: Re: [PATCHSET/RFC] Make legacy IO schedulers work with blk-mq
To: <linux-block@vger.kernel.org>
References: <1480734921-23701-1-git-send-email-axboe@fb.com>
CC: <paolo.valente@linaro.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <f38ccf7c-34bb-dead-eff7-660c87ae216d@fb.com>
Date: Fri, 2 Dec 2016 21:02:33 -0700
MIME-Version: 1.0
In-Reply-To: <1480734921-23701-1-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/02/2016 08:15 PM, Jens Axboe wrote:
> This is by no means done, but it seems to work well enough that
> I thought I'd send it out for others to take a look at and play
> with.
> 
> Basically this allows blk-mq managed devices to run the legacy
> IO schedulers, unmodified. The only requirement is that the
> blk-mq device has to be single queue for now, though that
> limitation would be rather simple to lift.
> 
> Since this is a debug patch, the default scheduler is deadline.
> You can switch that to the other configured schedulers, as you
> would with non-mq devices. Here's an example of a scsi-mq device
> that is running deadline, and being switched to CFQ online:
> 
> root@leopard:~# cat /sys/block/sda/mq/0/tags 
> nr_tags=31, reserved_tags=0, bits_per_word=4
> nr_free=31, nr_reserved=0
> active_queues=0
> 
> root@leopard:~# cat /sys/block/sda/queue/scheduler 
> noop [deadline] cfq 
> 
> root@leopard:~# echo cfq > /sys/block/sda/queue/scheduler 
> root@leopard:~# cat /sys/block/sda/queue/scheduler 
> noop deadline [cfq] 
> 
> Testing welcome. There's certainly room for improvement here, so
> I'm mostly interested in grave performance issues or crashes, if any.
> 
> Can also be viewed/fetched via git:
> 
> git://git.kernel.dk/linux-block for-4.11/blk-mq-legacy-sched

BTW, didn't include the patch for SCSI. You need the below to enable
scheduling on SCSI devices.

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index aedcec3..47a5c87 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2121,7 +2121,7 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 	shost->tag_set.queue_depth = shost->can_queue;
 	shost->tag_set.cmd_size = cmd_size;
 	shost->tag_set.numa_node = NUMA_NO_NODE;
-	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE | BLK_MQ_F_SQ_SCHED;
+	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
 	shost->tag_set.flags |=
 		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
 	shost->tag_set.driver_data = shost;

-- 
Jens Axboe
