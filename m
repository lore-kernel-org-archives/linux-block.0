Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170906101109.9270-2-hch@lst.de>
References: <20170906101109.9270-1-hch@lst.de> <20170906101109.9270-2-hch@lst.de>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 6 Sep 2017 18:59:39 +0800
Message-ID: <CACVXFVOqKUMvoURs0MXcoJaxG3u5n5D-6sxjUJ+m-Z9uTte61A@mail.gmail.com>
Subject: Re: [PATCH 1/2] scsi_transport_fc: fix NULL pointer dereference in fc_bsg_job_timeout
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Linux SCSI List <linux-scsi@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 6, 2017 at 6:11 PM, Christoph Hellwig <hch@lst.de> wrote:
> bsg-lib now embeddeds the job structure into the request, and req->special
> can't be used anymore.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Cc: stable@vger.kernel.org
> ---
>  drivers/scsi/scsi_transport_fc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
> index 3c6bc0081fcb..d8de46806a1e 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c
> @@ -3571,7 +3571,7 @@ fc_vport_sched_delete(struct work_struct *work)
>  static enum blk_eh_timer_return
>  fc_bsg_job_timeout(struct request *req)
>  {
> -       struct bsg_job *job = (void *) req->special;
> +       struct bsg_job *job = blk_mq_rq_to_pdu(req->special);

still req->special?


-- 
Ming Lei
