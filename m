Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34258 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeIDOe2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Sep 2018 10:34:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id c29-v6so2494722lfj.1
        for <linux-block@vger.kernel.org>; Tue, 04 Sep 2018 03:10:02 -0700 (PDT)
Subject: Re: [PATCH 2/4] lightnvm: assign block address before slba
To: javier@javigon.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
 <1535722477-31288-3-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <daf2443d-8d31-359e-02e7-f553eeca7b73@lightnvm.io>
Date: Tue, 4 Sep 2018 12:09:59 +0200
MIME-Version: 1.0
In-Reply-To: <1535722477-31288-3-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/31/2018 03:34 PM, Javier González wrote:
> In 1.2, the chunk slba is set to the physical representation of the
> block. Thus, assigning the block to the ppa must occur before the slba
> is assign.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index e9f14c67f4f3..efb976a863d2 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -945,6 +945,8 @@ static int nvm_bb_to_chunk(struct nvm_dev *dev, struct ppa_addr ppa,
>   			}
>   		}
>   
> +		ppa.g.blk = blk;
> +
>   		meta->wp = 0;
>   		meta->type = NVM_CHK_TP_W_SEQ;
>   		meta->wi = 0;
> @@ -952,7 +954,6 @@ static int nvm_bb_to_chunk(struct nvm_dev *dev, struct ppa_addr ppa,
>   		meta->cnlb = dev->geo.clba;
>   
>   		if (blktype == NVM_BLK_T_FREE) {
> -			ppa.a.blk = blk;
>   			ret = nvm_bb_chunk_scan(dev, ppa, meta);
>   			if (ret)
>   				return ret;
> 

Thanks. I've folded 1 & 2 into the bb patch.
