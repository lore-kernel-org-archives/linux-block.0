Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57139 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932845AbeEWNah (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 May 2018 09:30:37 -0400
Subject: Re: [PATCH 07/14] scsi_transport_fc: complete requests from ->timeout
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Rafael David Tinoco <rafael.tinoco@canonical.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180523121941.8632-1-hch@lst.de>
 <20180523121941.8632-8-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e63b1aeb-d428-ea24-4b1d-31a37314dd79@suse.de>
Date: Wed, 23 May 2018 15:30:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180523121941.8632-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/23/2018 02:19 PM, Christoph Hellwig wrote:
> By completing the request entirely in the driver we can remove the
> BLK_EH_HANDLED return value and thus the split responsibility between the
> driver and the block layer that has been causing trouble.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/scsi_transport_fc.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
> index 90075a0ddcfe..7a9a65588a1b 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c
> @@ -3591,10 +3591,9 @@ fc_bsg_job_timeout(struct request *req)
>   	}
>   
>   	/* the blk_end_sync_io() doesn't check the error */
> -	if (!inflight)
> -		return BLK_EH_DONE;
> -	else
> -		return BLK_EH_HANDLED;
> +	if (inflight)
> +		blk_mq_complete_request(req);
> +	return BLK_EH_DONE;
>   }
>   
>   /**
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
