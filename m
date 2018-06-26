Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:32883 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752810AbeFZImA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jun 2018 04:42:00 -0400
Received: by mail-it0-f68.google.com with SMTP id k17-v6so14696936ita.0
        for <linux-block@vger.kernel.org>; Tue, 26 Jun 2018 01:42:00 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2
 devices
To: hans.ml.holmberg@owltronix.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <a2bb1959-5244-f8af-b747-6d87e8d456a4@lightnvm.io>
Date: Tue, 26 Jun 2018 10:41:54 +0200
MIME-Version: 1.0
In-Reply-To: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

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

pblk should scan (or the lightnvm subsystem) the blocks for their state, 
such that it doesn't have to reinitialize a full drive if it is already 
in a closed state. If marking closed, it does a full erase cycle on 
initialization, which should be avoided since it is a limited resource.
