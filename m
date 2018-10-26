Return-Path: <hare@suse.de>
Subject: Re: [PATCH 05/28] IB/srp: remove old request_fn_active check
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>, Parav Pandit <parav@mellanox.com>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-6-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e643e59f-9569-812f-7d24-871d2a5c3106@suse.de>
Date: Fri, 26 Oct 2018 09:08:43 +0200
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-6-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> This check is only viable for non scsi-mq. Since that is going away,
> kill this legacy check.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Parav Pandit <parav@mellanox.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/infiniband/ulp/srp/ib_srp.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index 0b34e909505f..5a79444c2f3c 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -1334,13 +1334,6 @@ static void srp_terminate_io(struct srp_rport *rport)
>   	struct scsi_device *sdev;
>   	int i, j;
>   
> -	/*
> -	 * Invoking srp_terminate_io() while srp_queuecommand() is running
> -	 * is not safe. Hence the warning statement below.
> -	 */
> -	shost_for_each_device(sdev, shost)
> -		WARN_ON_ONCE(sdev->request_queue->request_fn_active);
> -
>   	for (i = 0; i < target->ch_count; i++) {
>   		ch = &target->ch[i];
>   
> 
I _think_ I've already killed that one; please do check the latest tree 
from Doug Ledford.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
