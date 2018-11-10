Return-Path: <hare@suse.de>
Subject: Re: [PATCH 1/6] fnic: fix fnic_scsi_host_{start,end}_tag
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20181109183208.19879-1-hch@lst.de>
 <20181109183208.19879-2-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <913fa7d5-7e3b-6a1e-0306-7d89b304a125@suse.de>
Date: Sat, 10 Nov 2018 13:56:13 +0100
MIME-Version: 1.0
In-Reply-To: <20181109183208.19879-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/9/18 7:32 PM, Christoph Hellwig wrote:
> They way these functions abuse ->special to try to store the dummy
> request looks completely broken, given that it actually stores the
> original scsi command.
> 
> Instead switch to ->host_scribble and store the actual dummy command.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/fnic/fnic_scsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
> index 96acfcecd540..cafbcfb85bfa 100644
> --- a/drivers/scsi/fnic/fnic_scsi.c
> +++ b/drivers/scsi/fnic/fnic_scsi.c
> @@ -2274,7 +2274,7 @@ fnic_scsi_host_start_tag(struct fnic *fnic, struct scsi_cmnd *sc)
>  		return SCSI_NO_TAG;
>  
>  	sc->tag = sc->request->tag = dummy->tag;
> -	sc->request->special = sc;
> +	sc->host_scribble = (unsigned char *)dummy;
>  
>  	return dummy->tag;
>  }
> @@ -2286,7 +2286,7 @@ fnic_scsi_host_start_tag(struct fnic *fnic, struct scsi_cmnd *sc)
>  static inline void
>  fnic_scsi_host_end_tag(struct fnic *fnic, struct scsi_cmnd *sc)
>  {
> -	struct request *dummy = sc->request->special;
> +	struct request *dummy = (struct request *)sc->host_scribble;
>  
>  	blk_mq_free_request(dummy);
>  }
> 
The entire device_reset for fnic should be redone; which reminds me to
redo my scsi-eh rework rebased.

But until then:

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
