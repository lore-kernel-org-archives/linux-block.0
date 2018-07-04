Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36827 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933698AbeGDIHM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jul 2018 04:07:12 -0400
Received: by mail-lf0-f67.google.com with SMTP id n24-v6so3664316lfh.3
        for <linux-block@vger.kernel.org>; Wed, 04 Jul 2018 01:07:11 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: mark expected switch fall-through
To: gustavo@embeddedor.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180703212125.GA29262@embeddedor.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <79636e4b-0932-791d-bd06-9f7bbf6d00f3@lightnvm.io>
Date: Wed, 4 Jul 2018 10:07:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180703212125.GA29262@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/03/2018 11:21 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/lightnvm/pblk-core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index ed9cc97..9c93334 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -264,6 +264,7 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
>   	switch (type) {
>   	case PBLK_WRITE:
>   		kfree(((struct pblk_c_ctx *)nvm_rq_to_pdu(rqd))->lun_bitmap);
> +		/* fall through */
>   	case PBLK_WRITE_INT:
>   		pool = &pblk->w_rq_pool;
>   		break;
> 

Thanks Gustavo. Applied for 4.19.
