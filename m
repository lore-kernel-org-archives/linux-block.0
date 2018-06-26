Return-Path: <mb@lightnvm.io>
Return-Path: <mb@lightnvm.io>
Subject: Re: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2
 devices
Cc: hans.ml.holmberg@owltronix.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
To: axboe@kernel.dk
Message-ID: <3d09296d-ace3-f025-b6d9-5d99ce6b9fc8@lightnvm.io>
Date: Tue, 26 Jun 2018 14:10:34 +0200
MIME-Version: 1.0
In-Reply-To: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/19/2018 11:06 AM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> We can't know if a block is closed or not on 1.2 devices, so assume
> closed state to make sure that blocks are erased before writing.
> 
> Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> 
> This patch applies on:
> ssh://github.com/OpenChannelSSD/linux branch for-4.19/core
> 
>   drivers/lightnvm/pblk-init.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index aa24264..3b8aa4a 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -717,10 +717,11 @@ static int pblk_setup_line_meta_12(struct pblk *pblk, struct pblk_line *line,
>   
>   		/*
>   		 * In 1.2 spec. chunk state is not persisted by the device. Thus
> -		 * some of the values are reset each time pblk is instantiated.
> +		 * some of the values are reset each time pblk is instantiated,
> +		 * so we have to assume that the block is closed.
>   		 */
>   		if (lun_bb_meta[line->id] == NVM_BLK_T_FREE)
> -			chunk->state =  NVM_CHK_ST_FREE;
> +			chunk->state =  NVM_CHK_ST_CLOSED;
>   		else
>   			chunk->state = NVM_CHK_ST_OFFLINE;
>   
> 

Hi Jens,

Would it be possible to pick this patch up for 4.18? It is a temporary 
fix that lets pblk continue to work with 1.2 OCSSD drives that has open 
blocks on initialization. Without it, writes will fail, as pblk assumes 
that the blocks are free.

A proper fix that scans the block state on initialization will be ready 
for 4.19.

Thank you,
Matias
