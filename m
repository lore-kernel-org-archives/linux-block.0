Return-Path: <hare@suse.de>
Subject: Re: [PATCH v4 05/12] block: Change argument type of scsi_req_init()
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>
References: <20170619220801.12557-1-bart.vanassche@wdc.com>
 <20170619220801.12557-6-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6dd05865-9c3b-7d8e-1e65-9be766de85be@suse.de>
Date: Tue, 20 Jun 2017 08:38:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170619220801.12557-6-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 12:07 AM, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> 
> Since scsi_req_init() works on a struct scsi_request, change the
> argument type into struct scsi_request *.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>  block/scsi_ioctl.c                | 10 +++++++---
>  drivers/ide/ide-atapi.c           |  2 +-
>  drivers/ide/ide-probe.c           |  2 +-
>  drivers/scsi/scsi_lib.c           |  4 +++-
>  drivers/scsi/scsi_transport_sas.c |  2 +-
>  include/scsi/scsi_request.h       |  2 +-
>  6 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> index f96c51f5df40..7440de44dd85 100644
> --- a/block/scsi_ioctl.c
> +++ b/block/scsi_ioctl.c
> @@ -741,10 +741,14 @@ int scsi_cmd_blk_ioctl(struct block_device *bd, fmode_t mode,
>  }
>  EXPORT_SYMBOL(scsi_cmd_blk_ioctl);
>  
> -void scsi_req_init(struct request *rq)
> +/**
> + * scsi_req_init - initialize certain fields of a scsi_request structure
> + * @req: Pointer to a scsi_request structure.
> + * Initializes .__cmd[], .cmd, .cmd_len and .sense_len but no other members
> + * of struct scsi_request.
> + */
> +void scsi_req_init(struct scsi_request *req)
>  {
> -	struct scsi_request *req = scsi_req(rq);
> -
>  	memset(req->__cmd, 0, sizeof(req->__cmd));
>  	req->cmd = req->__cmd;
>  	req->cmd_len = BLK_MAX_CDB;
> diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
> index 37f61acf5a35..14d1e7d9a1d6 100644
> --- a/drivers/ide/ide-atapi.c
> +++ b/drivers/ide/ide-atapi.c
> @@ -199,7 +199,7 @@ void ide_prep_sense(ide_drive_t *drive, struct request *rq)
>  	memset(sense, 0, sizeof(*sense));
>  
>  	blk_rq_init(rq->q, sense_rq);
> -	scsi_req_init(sense_rq);
> +	scsi_req_init(req);
>  
>  	err = blk_rq_map_kern(drive->queue, sense_rq, sense, sense_len,
>  			      GFP_NOIO);
> diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> index c60e5ffc9231..01b2adfd8226 100644
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
> @@ -745,7 +745,7 @@ static void ide_initialize_rq(struct request *rq)
>  {
>  	struct ide_request *req = blk_mq_rq_to_pdu(rq);
>  
> -	scsi_req_init(rq);
> +	scsi_req_init(&req->sreq);
>  	req->sreq.sense = req->sense;
>  }
>  
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 5e7895d76998..5323505e4770 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1119,7 +1119,9 @@ EXPORT_SYMBOL(scsi_init_io);
>  /* Called from inside blk_get_request() */
>  static void scsi_initialize_rq(struct request *rq)
>  {
> -	scsi_req_init(rq);
> +	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
> +
> +	scsi_req_init(&cmd->req);
>  }
>  
>  /* Called after a request has been started. */
> diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
> index ae55be2b2385..d5bc7dc39be3 100644
> --- a/drivers/scsi/scsi_transport_sas.c
> +++ b/drivers/scsi/scsi_transport_sas.c
> @@ -215,7 +215,7 @@ static void sas_host_release(struct device *dev)
>  
>  static void sas_initialize_rq(struct request *rq)
>  {
> -	scsi_req_init(rq);
> +	scsi_req_init(scsi_req(rq));
>  }
>  
>  static int sas_bsg_initialize(struct Scsi_Host *shost, struct sas_rphy *rphy)
Hmm. As mentioned in the previous patch:
Why do you treat the SAS and the SCSI version different?

Other than that:

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
