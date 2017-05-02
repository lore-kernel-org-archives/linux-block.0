Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43798 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750767AbdEBGPe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 May 2017 02:15:34 -0400
Subject: Re: [PATCH 7/7] Revert "mtip32xx: pass BLK_MQ_F_NO_SCHED"
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
References: <1493391340-24629-1-git-send-email-axboe@fb.com>
 <1493391340-24629-8-git-send-email-axboe@fb.com>
Cc: ming.lei@redhat.com, hch@lst.de
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d0dbd814-671e-0d29-a5bf-e290f2f2f5a1@suse.de>
Date: Tue, 2 May 2017 08:15:32 +0200
MIME-Version: 1.0
In-Reply-To: <1493391340-24629-8-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/28/2017 04:55 PM, Jens Axboe wrote:
> This reverts commit 4981d04dd8f1ab19e2cce008da556d7f099b6e68.
> 
> The driver has been converted to using the proper infrastructure
> for issuing internal commands. This means it's now safe to use with
> the scheduling infrastruture, so we can now revert the change
> that turned off scheduling for mtip32xx.
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  drivers/block/mtip32xx/mtip32xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
> index 9780c4d3697c..c598c5ac2fd0 100644
> --- a/drivers/block/mtip32xx/mtip32xx.c
> +++ b/drivers/block/mtip32xx/mtip32xx.c
> @@ -3964,7 +3964,7 @@ static int mtip_block_initialize(struct driver_data *dd)
>  	dd->tags.reserved_tags = 1;
>  	dd->tags.cmd_size = sizeof(struct mtip_cmd);
>  	dd->tags.numa_node = dd->numa_node;
> -	dd->tags.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED;
> +	dd->tags.flags = BLK_MQ_F_SHOULD_MERGE;
>  	dd->tags.driver_data = dd;
>  	dd->tags.timeout = MTIP_NCQ_CMD_TIMEOUT_MS;
>  
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
