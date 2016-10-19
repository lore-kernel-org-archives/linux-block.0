Return-Path: <linux-scsi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <595d4b59-3892-ef24-ef91-b7cab6611af7@sandisk.com>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com> <595d4b59-3892-ef24-ef91-b7cab6611af7@sandisk.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 20 Oct 2016 07:48:44 +0800
Message-ID: <CACVXFVP+q94tZHSf8L2Qo1QdAtH8g2ZoAORzPQEPwZvZmRDpOA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] blk-mq: Do not invoke .queue_rq() for a stopped queue
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lin <ming.l@ssi.samsung.com>,
        Laurence Oberman <loberman@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 19, 2016 at 5:48 AM, Bart Van Assche
<bart.vanassche@sandisk.com> wrote:
> The meaning of the BLK_MQ_S_STOPPED flag is "do not call
> .queue_rq()". Hence modify blk_mq_make_request() such that requests
> are queued instead of issued if a queue has been stopped.
>
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

> ---
>  block/blk-mq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ddc2eed..b5dcafb 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1332,9 +1332,9 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>                 blk_mq_put_ctx(data.ctx);
>                 if (!old_rq)
>                         goto done;
> -               if (!blk_mq_direct_issue_request(old_rq, &cookie))
> -                       goto done;
> -               blk_mq_insert_request(old_rq, false, true, true);
> +               if (test_bit(BLK_MQ_S_STOPPED, &data.hctx->state) ||
> +                   blk_mq_direct_issue_request(old_rq, &cookie) != 0)
> +                       blk_mq_insert_request(old_rq, false, true, true);
>                 goto done;
>         }
>
> --
> 2.10.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Ming Lei
