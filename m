Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33310 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755406AbdDMTfn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2017 15:35:43 -0400
Received: by mail-lf0-f67.google.com with SMTP id r36so8056120lfi.0
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2017 12:35:42 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk-gc: fix an error pointer dereference in
 init
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <20170413193241.GA591@mwanda>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <79438233-5e3e-eff3-2918-4c63557eb07f@bjorling.me>
Date: Thu, 13 Apr 2017 21:35:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170413193241.GA591@mwanda>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/13/2017 09:32 PM, Dan Carpenter wrote:
> These labels are reversed so we could end up dereferencing an error
> pointer or leaking.
>
> Fixes: 7f347ba6bb3a ("lightnvm: physical block device (pblk) target")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 9b147cfd8a41..f173fd4ea947 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -527,10 +527,10 @@ int pblk_gc_init(struct pblk *pblk)
>
>  	return 0;
>
> -fail_free_main_kthread:
> -	kthread_stop(gc->gc_ts);
>  fail_free_writer_kthread:
>  	kthread_stop(gc->gc_writer_ts);
> +fail_free_main_kthread:
> +	kthread_stop(gc->gc_ts);
>
>  	return ret;
>  }
>

Thanks Dan. I've applied it for 4.12.
