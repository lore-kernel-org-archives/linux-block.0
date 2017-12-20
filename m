Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46731 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755573AbdLTRaM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Dec 2017 12:30:12 -0500
Received: by mail-lf0-f67.google.com with SMTP id r143so24893279lfe.13
        for <linux-block@vger.kernel.org>; Wed, 20 Dec 2017 09:30:11 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: remove some unnecessary NULL checks
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20171106114843.7rs6myhgxgij3jh7@mwanda>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <da6f66b4-a9df-d032-4604-c8d621d57cd1@lightnvm.io>
Date: Wed, 20 Dec 2017 18:30:08 +0100
MIME-Version: 1.0
In-Reply-To: <20171106114843.7rs6myhgxgij3jh7@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/06/2017 12:48 PM, Dan Carpenter wrote:
> Smatch complains that flush_workqueue() dereferences the work queue
> pointer but then we check if it's NULL on the next line when it's too
> late.  These NULL checks can be removed because the module won't load if
> we can't allocate the work queues.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 00d5698d64a9..aaba2049a135 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -669,12 +669,10 @@ void pblk_gc_exit(struct pblk *pblk)
>   		kthread_stop(gc->gc_reader_ts);
>   
>   	flush_workqueue(gc->gc_reader_wq);
> -	if (gc->gc_reader_wq)
> -		destroy_workqueue(gc->gc_reader_wq);
> +	destroy_workqueue(gc->gc_reader_wq);
>   
>   	flush_workqueue(gc->gc_line_reader_wq);
> -	if (gc->gc_line_reader_wq)
> -		destroy_workqueue(gc->gc_line_reader_wq);
> +	destroy_workqueue(gc->gc_line_reader_wq);
>   
>   	if (gc->gc_writer_ts)
>   		kthread_stop(gc->gc_writer_ts);
> 

Thanks Dan. I've applied it for 4.16.
