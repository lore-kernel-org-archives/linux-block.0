Return-Path: <hare@suse.de>
Subject: Re: [PATCH 09/14] libiscsi: don't try to bypass SCSI EH
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Ming Lei <ming.lei@redhat.com>,
 Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180523121941.8632-1-hch@lst.de>
 <20180523121941.8632-10-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d0fa12e3-b0b9-9442-2779-df8abb3b66b6@suse.de>
Date: Wed, 23 May 2018 15:35:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180523121941.8632-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/23/2018 02:19 PM, Christoph Hellwig wrote:
> libiscsi is the only SCSI code that return BLK_EH_HANDLED, thus trying to
> bypass the normal SCSI EH code.  We are going to remove this return value
> at the block layer, and at least from a quick look it doesn't look too
> harmful to try to send an abort for these cases, especially as the first
> one should not actually be possible.  If this doesn't work out iscsi
> will probably need its own eh_strategy_handler instead to just do the
> right thing.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/libiscsi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
> index eee43ba83a60..71bdc0b52cf9 100644
> --- a/drivers/scsi/libiscsi.c
> +++ b/drivers/scsi/libiscsi.c
> @@ -1982,7 +1982,7 @@ enum blk_eh_timer_return iscsi_eh_cmd_timed_out(struct scsi_cmnd *sc)
>   		 * Raced with completion. Blk layer has taken ownership
>   		 * so let timeout code complete it now.
>   		 */
> -		rc = BLK_EH_HANDLED;
> +		rc = BLK_EH_DONE;
>   		goto done;
>   	}
>   
> @@ -1997,7 +1997,7 @@ enum blk_eh_timer_return iscsi_eh_cmd_timed_out(struct scsi_cmnd *sc)
>   		if (unlikely(system_state != SYSTEM_RUNNING)) {
>   			sc->result = DID_NO_CONNECT << 16;
>   			ISCSI_DBG_EH(session, "sc on shutdown, handled\n");
> -			rc = BLK_EH_HANDLED;
> +			rc = BLK_EH_DONE;
>   			goto done;
>   		}
>   		/*
> 
That should be okay, as these two returns are the pathological case 
where the command has already completed before the timeout handler got 
invoked.
IE the very same issue which triggered this patchset in the first place.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
