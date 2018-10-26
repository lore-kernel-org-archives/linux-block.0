Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40220 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbeJ0D1m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Oct 2018 23:27:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so2075270lji.7
        for <linux-block@vger.kernel.org>; Fri, 26 Oct 2018 11:49:32 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: fix chunk close trace event check
To: hans@owltronix.com
Cc: linux-block@vger.kernel.org, javier@cnexlabs.com,
        linux-kernel@vger.kernel.org, hans.holmberg@cnexlabs.com
References: <1540541544-7761-1-git-send-email-hans.holmberg@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e884c6c9-d875-e282-59dd-f1733ffc38fb@lightnvm.io>
Date: Fri, 26 Oct 2018 20:49:29 +0200
MIME-Version: 1.0
In-Reply-To: <1540541544-7761-1-git-send-email-hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/26/2018 10:12 AM, Hans Holmberg wrote:
> The check for chunk closes suffers from an off-by-one issue, leading
> to chunk close events not being traced. Fix this.
> 
> Fixes: 4c44abf43d00 ("lightnvm: pblk: add trace events for chunk states")
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> 
>   drivers/lightnvm/pblk-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 6944aac43b01..6581c35f51ee 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -531,7 +531,7 @@ void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd)
>   		if (caddr == 0)
>   			trace_pblk_chunk_state(pblk_disk_name(pblk),
>   							ppa, NVM_CHK_ST_OPEN);
> -		else if (caddr == chunk->cnlb)
> +		else if (caddr == (chunk->cnlb - 1))
>   			trace_pblk_chunk_state(pblk_disk_name(pblk),
>   							ppa, NVM_CHK_ST_CLOSED);
>   	}
> 

Thanks Hans, Applied for 4.21/5.1. Note that you're sending from your 
owntronix email account. Checkpatch complains that sender and author 
doesn't match.
