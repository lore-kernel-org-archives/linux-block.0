Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:35207 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbdBTLNe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Feb 2017 06:13:34 -0500
Received: by mail-wr0-f181.google.com with SMTP id s27so15064182wrb.2
        for <linux-block@vger.kernel.org>; Mon, 20 Feb 2017 03:13:34 -0800 (PST)
Subject: Re: [PATCH] lightnvm: Fix error handling
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20170219140928.12968-1-christophe.jaillet@wanadoo.fr>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <19ff1456-8890-125c-d999-d0ceb04e2224@lightnvm.io>
Date: Mon, 20 Feb 2017 12:13:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170219140928.12968-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/19/2017 03:09 PM, Christophe JAILLET wrote:
> According to error handling in this function, it is likely that going to
> 'out' was expected here.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/lightnvm/rrpc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
> index e00b1d7b976f..e68efbcf1188 100644
> --- a/drivers/lightnvm/rrpc.c
> +++ b/drivers/lightnvm/rrpc.c
> @@ -1275,8 +1275,10 @@ static int rrpc_bb_discovery(struct nvm_tgt_dev *dev, struct rrpc_lun *rlun)
>  	}
>
>  	nr_blks = nvm_bb_tbl_fold(dev->parent, blks, nr_blks);
> -	if (nr_blks < 0)
> -		return nr_blks;
> +	if (nr_blks < 0) {
> +		ret = nr_blks;
> +		goto out;
> +	}
>
>  	for (i = 0; i < nr_blks; i++) {
>  		if (blks[i] == NVM_BLK_T_FREE)
>

Thanks Christophe. Applied for 4.12.
