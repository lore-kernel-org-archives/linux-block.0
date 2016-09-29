Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36833 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932329AbcI2KD7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2016 06:03:59 -0400
Received: by mail-yw0-f195.google.com with SMTP id v2so2739003ywg.3
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2016 03:03:59 -0700 (PDT)
Date: Thu, 29 Sep 2016 12:03:52 +0200
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blkcg: Unlock blkcg_pol_mutex once if cpd == NULL
Message-ID: <20160929100352.GC24034@mtj.duckdns.org>
References: <db0c6205-9ca2-d80e-26fc-6cff0d84d73c@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <db0c6205-9ca2-d80e-26fc-6cff0d84d73c@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

On Mon, Sep 26, 2016 at 03:36:25PM -0700, Bart Van Assche wrote:
> Unlocking a mutex twice is wrong. Hence modify blkcg_policy_register()
> such that blkcg_pol_mutex is unlocked once if cpd == NULL. This patch
> avoids that smatch reports the following error:
> 
> block/blk-cgroup.c:1378: blkcg_policy_register() error: double unlock 'mutex:&blkcg_pol_mutex'
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: <stable@vger.kernel.org>
> ---
>  block/blk-cgroup.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index dd38e5c..cdbca1c 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1327,8 +1327,10 @@ int blkcg_policy_register(struct blkcg_policy *pol)
>  	for (i = 0; i < BLKCG_MAX_POLS; i++)
>  		if (!blkcg_policy[i])
>  			break;
> -	if (i >= BLKCG_MAX_POLS)
> +	if (i >= BLKCG_MAX_POLS) {
> +		mutex_unlock(&blkcg_pol_mutex);
>  		goto err_unlock;
> +	}

Wouldn't it be better to drop explicit mutx_unlock(&blkcg_pol_mutex)
on "if (!cpd)"?

Thanks.

-- 
tejun
