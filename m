Return-Path: <kashyap.desai@broadcom.com>
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <20180227100750.32299-1-ming.lei@redhat.com> <20180227100750.32299-9-ming.lei@redhat.com>
In-Reply-To: <20180227100750.32299-9-ming.lei@redhat.com>
MIME-Version: 1.0
Date: Wed, 28 Feb 2018 20:28:48 +0530
Message-ID: <8113cfe7e8db7060db920ab29e230a89@mail.gmail.com>
Subject: RE: [PATCH V3 8/8] scsi: megaraid: improve scsi_mq performance via .host_tagset
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@redhat.com>
Cc: linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	Arun Easi <arun.easi@cavium.com>, Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>, Christoph Hellwig <hch@lst.de>,
	Don Brace <don.brace@microsemi.com>, Peter Rivera <peter.rivera@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Ming -

Quick testing on my setup -  Performance slightly degraded (4-5% drop)for
megaraid_sas driver with this patch. (From 1610K IOPS it goes to 1544K)
I confirm that after applying this patch, we have #queue = #numa node.

ls -l
/sys/devices/pci0000:80/0000:80:02.0/0000:83:00.0/host10/target10:2:23/10:
2:23:0/block/sdy/mq
total 0
drwxr-xr-x. 18 root root 0 Feb 28 09:53 0
drwxr-xr-x. 18 root root 0 Feb 28 09:53 1


I would suggest to skip megaraid_sas driver changes using shared_tagset
until and unless there is obvious gain. If overall interface of using
shared_tagset is commit in kernel tree, we will investigate (megaraid_sas
driver) in future about real benefit of using it.

Without patch -

  4.64%  [megaraid_sas]           [k] complete_cmd_fusion
   3.23%  [kernel]                 [k] irq_entries_start
   3.18%  [kernel]                 [k] _raw_spin_lock
   3.06%  [kernel]                 [k] syscall_return_via_sysret
   2.74%  [kernel]                 [k] bt_iter
   2.55%  [kernel]                 [k] scsi_queue_rq
   2.21%  [megaraid_sas]           [k] megasas_build_io_fusion
   1.80%  [megaraid_sas]           [k] megasas_queue_command
   1.59%  [kernel]                 [k] __audit_syscall_exit
   1.55%  [kernel]                 [k] _raw_spin_lock_irqsave
   1.38%  [megaraid_sas]           [k] megasas_build_and_issue_cmd_fusion
   1.34%  [kernel]                 [k] do_io_submit
   1.33%  [kernel]                 [k] gup_pgd_range
   1.26%  [kernel]                 [k] scsi_softirq_done
   1.20%  fio                      [.] __fio_gettime
   1.20%  [kernel]                 [k] switch_mm_irqs_off
   1.00%  [megaraid_sas]           [k] megasas_build_ldio_fusion
   0.97%  fio                      [.] get_io_u
   0.89%  [kernel]                 [k] lookup_ioctx
   0.80%  [kernel]                 [k] scsi_dec_host_busy
   0.78%  [kernel]                 [k] blkdev_direct_IO
   0.78%  [megaraid_sas]           [k] MR_GetPhyParams
   0.73%  [kernel]                 [k] aio_read_events
   0.70%  [megaraid_sas]           [k] MR_BuildRaidContext
   0.64%  [kernel]                 [k] blk_mq_complete_request
   0.64%  fio                      [.] thread_main
   0.63%  [kernel]                 [k] blk_queue_split
   0.63%  [kernel]                 [k] blk_mq_get_request
   0.61%  [kernel]                 [k] read_tsc
   0.59%  [kernel]                 [k] kmem_cache_a


With patch -

   4.36%  [megaraid_sas]           [k] complete_cmd_fusion
   3.24%  [kernel]                 [k] irq_entries_start
   3.00%  [kernel]                 [k] syscall_return_via_sysret
   2.41%  [kernel]                 [k] scsi_queue_rq
   2.41%  [kernel]                 [k] _raw_spin_lock
   2.22%  [megaraid_sas]           [k] megasas_build_io_fusion
   1.92%  [kernel]                 [k] bt_iter
   1.74%  [megaraid_sas]           [k] megasas_queue_command
   1.48%  [kernel]                 [k] gup_pgd_range
   1.44%  [kernel]                 [k] __audit_syscall_exit
   1.33%  [megaraid_sas]           [k] megasas_build_and_issue_cmd_fusion
   1.29%  [kernel]                 [k] _raw_spin_lock_irqsave
   1.25%  fio                      [.] get_io_u
   1.24%  fio                      [.] __fio_gettime
   1.22%  [kernel]                 [k] do_io_submit
   1.18%  [megaraid_sas]           [k] megasas_build_ldio_fusion
   1.02%  [kernel]                 [k] blk_mq_get_request
   0.91%  [kernel]                 [k] lookup_ioctx
   0.91%  [kernel]                 [k] scsi_softirq_done
   0.88%  [kernel]                 [k] scsi_dec_host_busy
   0.87%  [kernel]                 [k] blkdev_direct_IO
   0.77%  [megaraid_sas]           [k] MR_BuildRaidContext
   0.76%  [megaraid_sas]           [k] MR_GetPhyParams
   0.73%  [kernel]                 [k] __fget
   0.70%  [kernel]                 [k] switch_mm_irqs_off
   0.70%  fio                      [.] thread_main
   0.69%  [kernel]                 [k] aio_read_events
   0.68%  [kernel]                 [k] note_interrupt
   0.65%  [kernel]                 [k] do_syscal

Kashyap

> -----Original Message-----
> From: Ming Lei [mailto:ming.lei@redhat.com]
> Sent: Tuesday, February 27, 2018 3:38 PM
> To: Jens Axboe; linux-block@vger.kernel.org; Christoph Hellwig; Mike
Snitzer
> Cc: linux-scsi@vger.kernel.org; Hannes Reinecke; Arun Easi; Omar
Sandoval;
> Martin K . Petersen; James Bottomley; Christoph Hellwig; Don Brace;
Kashyap
> Desai; Peter Rivera; Laurence Oberman; Ming Lei
> Subject: [PATCH V3 8/8] scsi: megaraid: improve scsi_mq performance via
> .host_tagset
>
> It is observed on null_blk that IOPS can be improved much by simply
making
> hw queue per NUMA node, so this patch applies the introduced
.host_tagset
> for improving performance.
>
> In reality, .can_queue is quite big, and NUMA node number is often
small, so
> each hw queue's depth should be high enough to saturate device.
>
> Cc: Arun Easi <arun.easi@cavium.com>
> Cc: Omar Sandoval <osandov@fb.com>,
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
> Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: Don Brace <don.brace@microsemi.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Peter Rivera <peter.rivera@broadcom.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c
> b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 065956cb2aeb..0b46f97cbfdb 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -3177,6 +3177,7 @@ static struct scsi_host_template megasas_template
> = {
>  	.use_clustering = ENABLE_CLUSTERING,
>  	.change_queue_depth = scsi_change_queue_depth,
>  	.no_write_same = 1,
> +	.host_tagset = 1,
>  };
>
>  /**
> @@ -5947,6 +5948,8 @@ static int megasas_start_aen(struct
> megasas_instance *instance)  static int megasas_io_attach(struct
> megasas_instance *instance)  {
>  	struct Scsi_Host *host = instance->host;
> +	/* 256 tags should be high enough to saturate device */
> +	int max_queues = DIV_ROUND_UP(host->can_queue, 256);
>
>  	/*
>  	 * Export parameters required by SCSI mid-layer @@ -5987,6 +5990,9
> @@ static int megasas_io_attach(struct megasas_instance *instance)
>  	host->max_lun = MEGASAS_MAX_LUN;
>  	host->max_cmd_len = 16;
>
> +	/* per NUMA node hw queue */
> +	host->nr_hw_queues = min_t(int, nr_node_ids, max_queues);
> +
>  	/*
>  	 * Notify the mid-layer about the new controller
>  	 */
> --
> 2.9.5
