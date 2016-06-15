Return-Path: <openosd@gmail.com>
Return-Path: <openosd@gmail.com>
Message-ID: <5761266F.1030704@electrozaur.com>
Date: Wed, 15 Jun 2016 12:57:03 +0300
From: Boaz Harrosh <ooo@electrozaur.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
CC: mst@redhat.com, bhalevy@primarydata.com, nab@linux-iscsi.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 3/7] block: ensure bios return from blk_get_request are
 properly initialized
References: <1465831278-23653-1-git-send-email-hch@lst.de> <1465831278-23653-4-git-send-email-hch@lst.de>
In-Reply-To: <1465831278-23653-4-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/13/2016 06:21 PM, Christoph Hellwig wrote:
> blk_get_request is used for BLOCK_PC and similar pass through requests.
> Currently we always need to call blk_rq_set_block_pc or an opencoded
> version of it to allow appending bios using the request mapping helpers
> later on, which is a somewhat awkward API.  Instead move the
> initialization part of blk_rq_set_block_pc into blk_get_request, so that
> we always have a safe to use request.  blk_rq_set_block_pc now goes away
> in favor of just setting cmd_type to REQ_TYPE_BLOCK_PC, or nothing in case
> it was overriden with a different type a little later (or earlier in case
> of the SCSI OSD code..)
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Is good thanks.
Review-by: Boaz harrosh <ooo@electrozaur.com>

<>
> diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
> index daa4dc1..868ae29d 100644
> --- a/drivers/scsi/osd/osd_initiator.c
> +++ b/drivers/scsi/osd/osd_initiator.c
> @@ -1567,7 +1567,7 @@ static struct request *_make_request(struct request_queue *q, bool has_write,
>  		if (IS_ERR(req))
>  			return req;
>  
> -		blk_rq_set_block_pc(req);
> +		req->cmd_type = REQ_TYPE_BLOCK_PC;
>  		return req;
>  	}
>  }
> @@ -1605,7 +1605,6 @@ static int _init_blk_request(struct osd_request *or,
>  				ret = PTR_ERR(req);
>  				goto out;
>  			}
> -			blk_rq_set_block_pc(req);
>  			or->in.req = or->request->next_rq = req;

Yes this is the bidi part of the request it need not be of any type.
Only properly initialized.

>  		}
>  	} else if (has_in)
<>
