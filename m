Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180804000325.3610-3-bart.vanassche@wdc.com>
References: <20180804000325.3610-1-bart.vanassche@wdc.com> <20180804000325.3610-3-bart.vanassche@wdc.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 4 Aug 2018 09:16:17 +0800
Message-ID: <CACVXFVO3Ge7LRQdSvRMzAgSrQVFcHZGMAMnt_duNqX6X7Z=Dvw@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] block, scsi: Give RQF_PREEMPT back its original meaning
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>, Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>, Johannes Thumshirn <jthumshirn@suse.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sat, Aug 4, 2018 at 8:03 AM, Bart Van Assche <bart.vanassche@wdc.com> wrote:
> In kernel v2.6.18 RQF_PREEMPT was only set for IDE preempt requests.
> Later on the SCSI core was modified such that RQF_PREEMPT requests
> was set for all requests submitted by __scsi_execute(), including
> power management requests. RQF_PREEMPT requests are the only requests
> processed in the SDEV_QUIESCE state. Instead of setting RQF_PREEMPT
> for all requests submitted by __scsi_execute(), only set RQF_PM for
> power management requests. Modify blk_get_request() such that it

Looks a big change, since this patch only allows PM command  instead of
all other admin commands to be handled when device is in quiesce state,
we should be careful about this change.

> blocks in pm-only mode on non-RQF_PM requests. Leave the code out
> from scsi_prep_state_check() that is no longer reachable.
>
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-core.c        |  9 +++++----
>  drivers/scsi/scsi_lib.c | 28 ++++++++++++----------------
>  include/linux/blk-mq.h  |  2 ++
>  include/linux/blkdev.h  |  6 ++----
>  4 files changed, 21 insertions(+), 24 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b83798c03ca8..3378fe478e67 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -908,11 +908,11 @@ EXPORT_SYMBOL(blk_alloc_queue);
>  /**
>   * blk_queue_enter() - try to increase q->q_usage_counter
>   * @q: request queue pointer
> - * @flags: BLK_MQ_REQ_NOWAIT and/or BLK_MQ_REQ_PREEMPT
> + * @flags: BLK_MQ_REQ_NOWAIT, BLK_MQ_REQ_PREEMPT and/or BLK_MQ_REQ_PM
>   */
>  int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>  {
> -       const bool pm = flags & BLK_MQ_REQ_PREEMPT;
> +       const bool pm = flags & BLK_MQ_REQ_PM;
>
>         while (true) {
>                 bool success = false;
> @@ -1570,7 +1570,7 @@ static struct request *get_request(struct request_queue *q, unsigned int op,
>         goto retry;
>  }
>
> -/* flags: BLK_MQ_REQ_PREEMPT and/or BLK_MQ_REQ_NOWAIT. */
> +/* flags: BLK_MQ_REQ_PREEMPT, BLK_MQ_REQ_PM and/or BLK_MQ_REQ_NOWAIT. */
>  static struct request *blk_old_get_request(struct request_queue *q,
>                                 unsigned int op, blk_mq_req_flags_t flags)
>  {
> @@ -1613,7 +1613,8 @@ struct request *blk_get_request(struct request_queue *q, unsigned int op,
>         struct request *req;
>
>         WARN_ON_ONCE(op & REQ_NOWAIT);
> -       WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PREEMPT));
> +       WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PREEMPT |
> +                              BLK_MQ_REQ_PM));
>
>         if (q->mq_ops) {
>                 req = blk_mq_alloc_request(q, op, flags);
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 007bb2bc817d..481158ab5081 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -248,8 +248,8 @@ void scsi_queue_insert(struct scsi_cmnd *cmd, int reason)
>   * @sshdr:     optional decoded sense header
>   * @timeout:   request timeout in seconds
>   * @retries:   number of times to retry request
> - * @flags:     flags for ->cmd_flags
> - * @rq_flags:  flags for ->rq_flags
> + * @flags:     REQ_* flags for ->cmd_flags
> + * @rq_flags:  RQF_* flags for ->rq_flags
>   * @resid:     optional residual length
>   *
>   * Returns the scsi_cmnd result field if a command was executed, or a negative
> @@ -267,7 +267,8 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
>
>         req = blk_get_request(sdev->request_queue,
>                         data_direction == DMA_TO_DEVICE ?
> -                       REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, BLK_MQ_REQ_PREEMPT);
> +                       REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN,
> +                       rq_flags & RQF_PM ? BLK_MQ_REQ_PM : 0);

The above change will cause regression on SPI transport, please see
spi_dv_device(), where non-PM command is sent to device via
scsi_execute() after the device is put to QUIESCE.


Thanks,
Ming Lei
