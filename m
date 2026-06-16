Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B2947A0D1
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628607; cv=none; b=UkVJ2gqz4caFc5Ls2jE/JRNNHBjN/2FVJTCnbljdFnMp+QQejhU600b7HE1Q7cs0eZXJ++kf8BoLVJEIUx7U0RE9cgjL1XD4fFUURL0clOb+82Gvfqt0Twn4fAtWNZuMypfLwl+L7xPlHtPjys0KZRY94XrCizrsfEVhLTUJrIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628607; c=relaxed/simple;
	bh=qH1REposY/vkap/PpdBJI139eXdCCEzXcTca8g46ZJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2qemKAVpwOWW0OsKG2x3NuaU3MGxNvleRpsRgVfCxQApYeDoO500gf+l3Py3oIRrSA/xy94rOwv4Anetbh+Jnk6pD4Wwh5ycOignpG9070hDhhKwFXUUzotgPx04SynpRX/P+BYKU6/4TxXHWol0x7UNyAKFMpwGbRS93meecM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFJaoSdc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFJaoSdc"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84229481d44so2426928b3a.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781628605; x=1782233405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnLBkKiTFM9IdGpuO3vRcsVvlePjixksYNezzzUDvlo=;
        b=oFJaoSdcxXbftAoQaiV2ONa+ezgh4uMN+soqn0Knl9dsn3K7CxscyI2YTcARPYvjBC
         iAoc4jE32Dzd6yP90m85uVOttLl1koauMnWgKXwrckS+BPSb4fE2TUE0lcpgchQj99wB
         TVD6/OOOvnDtTf0wYdxKzA2TBr0zaxzEgKDFNqjKL53AX8cpS4V4oqgN5iVzdsIp76CY
         7fMSLFn5LquGLMrt29xqmO1uC3fbmRzdp05W2z1a8BdNzejqT6GPYE+tV+bcqEUL0WP9
         xWfvIKVy2fnm+788PtTRDTyd9T5qCCFYIH6lWSW694w8yVDCdKp/ts29C6pU27Za/cv4
         mw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628605; x=1782233405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnLBkKiTFM9IdGpuO3vRcsVvlePjixksYNezzzUDvlo=;
        b=bf5Y4IzUjIvQUhAw7Va4CclzFPzlVhjAWZdcqQYoGWIGT8vBhuRYroOXgILy3t0HLf
         yrHFbxNJEFd+y4U49sdZfAGUxoAuiWf90AT5d2v340KrCtkscuzFbo6YViy9B08oco2t
         DaK7S2xW95o83O81ZHPN+s9JfXLG6Q/2qq27pVQuKxmaFP0fJctVVXnczptRcA6IZCTX
         PzcYyoQ62hx/qexGIgWfOHKYiQzwhIX50V3YLmOYwn0NmzNJOqtcgdbDDIc4eRVaqNPX
         PwCp7xQ7qT7EdWh293dFaUgh5ymHasti/Ss3z1ASNOX9drWImXwiC7E127uOtJybF/Pw
         DlDA==
X-Forwarded-Encrypted: i=1; AFNElJ91bONjmsvdDEBsUhpXz18TrPVctkQ3fwNxvtnzFJNEvjVkCBjr+7UmnvcMyAoCheLnCH1Hu5X0NnaSiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxW3qJ1clPAqNfP2jiliVbWaUVfjPiqSaiXtN4AUaQnTjxNH2HQ
	0DlXDU4ECC7B8nz3jO5MPt9cvnUsRtQOxfLQT5ORvqgn1HaDCjsYBquw
X-Gm-Gg: Acq92OGyRQtexEm6jC0OAQ1+/J3VETk0erJEJDb17/WtEAzvh4XASTcc8JZzhMSWq8N
	BiXT56zg/VQ9mj5b0xWegpnlqP2vLC3/iulGxL3zDcucmMHc8OFeaci/5lXFSPYDqdvyRq0YLxF
	2ZC3bVUTM+au76MGzUPfruMS6wA7tneSBExO8kAHUKWP8d90nypaOlaJqk1fqVNeeOm1FDilrXJ
	BB5ALSOuZC7yoTXXvlba3WbpYMxqanLh02iHO3xnQkqJKKO+0mZTFiwTs2gaAxegVA5AflSfANv
	l0/aJcM/8xT8dEY8i3Ep/GobGmtw6O+AApq/9Rn0/+hTII7xbGl5zcTdPhtkZXssXj/pS3mAI3B
	JkROegqGr3jGgSBLmTJqAMbrJNZfs44PoZRwsel0+eev5krN0auROA0wFJxvTTy7jGg94lxwM3x
	XJrhVkSAOwbjrantRixomk3h+bBqvtzA1+0BwiOCRECm/IebyueCXd3w1RaYRFcnjsUFc7WAZ8Q
	+bkYkjxHU9y+8YuuvUqMceQew==
X-Received: by 2002:a05:6a00:1146:b0:831:7f71:c810 with SMTP id d2e1a72fcca58-844e1a75b45mr16326686b3a.35.1781628604768;
        Tue, 16 Jun 2026 09:50:04 -0700 (PDT)
Received: from ?IPV6:2400:79e0:1203:64b0:8460:77be:58ac:5bd9? ([2400:79e0:1203:64b0:8460:77be:58ac:5bd9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9c4c0sm12310480b3a.3.2026.06.16.09.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 09:50:04 -0700 (PDT)
Message-ID: <774f145f-cec0-4408-9557-5db196302ebd@gmail.com>
Date: Wed, 17 Jun 2026 00:50:01 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] blk-cgroup: defer blkcg css_put until blkg is unlinked
 from queue
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, linux-block@vger.kernel.org
Cc: cgroups@vger.kernel.org, yangerkun@huawei.com, chengzhihao1@huawei.com,
 houtao1@huawei.com, yukuai@fygo.io
References: <20260616011746.2451461-1-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <20260616011746.2451461-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/6/26 9:17 am, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> [BUG]
> Our fuzz testing triggered a blkcg use-after-free issue:
> 
>   BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x75/0xe0
>   Call Trace:
>   ...
>   blkcg_deactivate_policy+0x244/0x4d0
>   ioc_rqos_exit+0x44/0xe0
>   rq_qos_exit+0xba/0x120
>   __del_gendisk+0x50b/0x800
>   del_gendisk+0xff/0x190
>   ...
> 
> [CAUSE]
> process1						process2
> cgroup_rmdir
> ...
>   css_killed_work_fn
>     offline_css
>     ...
>       blkcg_destroy_blkgs
>       ...
>         __blkg_release
> 	  css_put(&blkg->blkcg->css)
>           blkg_free
> 	    INIT_WORK(xxx, blkg_free_workfn)
> 	    schedule_work
>     css_put
>     ...
>       blkcg_css_free
>         kfree(blkcg)--------blkcg has been freed!!!
> ====================================schedule_work
>               blkg_free_workfn
> 							__del_gendisk
> 							  rq_qos_exit
> 							    ioc_rqos_exit
> 							      blkcg_deactivate_policy
> 							        mutex_lock(&q->blkcg_mutex)
> 								spin_lock_irq(&q->queue_lock)
> 							        list_for_each_entry(blkg, xxx)
> 								  blkcg = blkg->blkcg
> 								  spin_lock(&blkcg->lock)-------UAF!!!
> 	        mutex_lock(&q->blkcg_mutex)
> 	        spin_lock_irq(&q->queue_lock)
> 	        /* Only then is the blkg removed from the list */
> 	        list_del_init(&blkg->q_node)
> 
> As a result, a blkg can still be reachable through q->blkg_list while
> its ->blkcg has already been freed.
> 
> [Fix]
> Fix this by deferring the blkcg css_put() until after the blkg has been
> unlinked from q->blkg_list in blkg_free_workfn(). This ensures that the
> blkcg outlives every blkg still reachable through q->blkg_list, so any
> iterator holding q->queue_lock is guaranteed to observe a valid
> blkg->blkcg.
> 
> While at it, move css_tryget_online() from blkg_create() into blkg_alloc()
> so that the css reference is owned by the alloc/free pair rather than
> straddling layers:
> blkg_alloc()  <-> blkg_free()
> blkg_create() <-> blkg_destroy()
> 
> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
> Suggested-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> Reviewed-by: Yu Kuai <yukuai@fygo.io>
> ---
> v3:
>  - move css_put() after mutex_unlock() in blkg_free_workfn().
> 
> v2:
>  - Move css_tryget_online() from blkg_create() into blkg_alloc() so the
>    css reference follows the blkg's own lifetime, making the put in
>    blkg_free_workfn() symmetric with the get in blkg_alloc().
> 
> v1: https://lore.kernel.org/all/20260518010932.633707-1-wozizhi@huaweicloud.com/
>  block/blk-cgroup.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index bc63bd220865..3ac41f766caf 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -136,6 +136,11 @@ static void blkg_free_workfn(struct work_struct *work)
>  	spin_unlock_irq(&q->queue_lock);
>  	mutex_unlock(&q->blkcg_mutex);
>  
> +	/*
> +	 * Release blkcg css ref only after blkg is removed from q->blkg_list,
> +	 * so concurrent iterators won't see a blkg with a freed blkcg.
> +	 */
> +	css_put(&blkg->blkcg->css);
>  	blk_put_queue(q);
>  	free_percpu(blkg->iostat_cpu);
>  	percpu_ref_exit(&blkg->refcnt);
> @@ -179,8 +184,6 @@ static void __blkg_release(struct rcu_head *rcu)
>  	for_each_possible_cpu(cpu)
>  		__blkcg_rstat_flush(blkcg, cpu);
>  
> -	/* release the blkcg and parent blkg refs this blkg has been holding */
> -	css_put(&blkg->blkcg->css);
>  	blkg_free(blkg);
>  }
>  
> @@ -313,6 +316,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>  		goto out_exit_refcnt;
>  	if (!blk_get_queue(disk->queue))
>  		goto out_free_iostat;
> +	/* blkg holds a reference to blkcg */
> +	if (!css_tryget_online(&blkcg->css))
> +		goto out_put_queue;
>  
>  	blkg->q = disk->queue;
>  	INIT_LIST_HEAD(&blkg->q_node);
> @@ -353,6 +359,8 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>  	while (--i >= 0)
>  		if (blkg->pd[i])
>  			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
> +	css_put(&blkcg->css);
> +out_put_queue:
>  	blk_put_queue(disk->queue);
>  out_free_iostat:
>  	free_percpu(blkg->iostat_cpu);
> @@ -381,18 +389,12 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
>  		goto err_free_blkg;
>  	}
>  
> -	/* blkg holds a reference to blkcg */
> -	if (!css_tryget_online(&blkcg->css)) {
> -		ret = -ENODEV;
> -		goto err_free_blkg;
> -	}
> -
>  	/* allocate */
>  	if (!new_blkg) {
>  		new_blkg = blkg_alloc(blkcg, disk, GFP_NOWAIT);
>  		if (unlikely(!new_blkg)) {
>  			ret = -ENOMEM;
> -			goto err_put_css;
> +			goto err_free_blkg;
>  		}
>  	}
>  	blkg = new_blkg;
> @@ -402,7 +404,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
>  		blkg->parent = blkg_lookup(blkcg_parent(blkcg), disk->queue);
>  		if (WARN_ON_ONCE(!blkg->parent)) {
>  			ret = -ENODEV;
> -			goto err_put_css;
> +			goto err_free_blkg;
>  		}
>  		blkg_get(blkg->parent);
>  	}
> @@ -442,8 +444,6 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
>  	blkg_put(blkg);
>  	return ERR_PTR(ret);
>  
> -err_put_css:
> -	css_put(&blkcg->css);
>  err_free_blkg:
>  	if (new_blkg)
>  		blkg_free(new_blkg);

LGTM.

Reviewed-by: Tang Yizhou <yizhou.tang@shopee.com>

-- 
Best Regards,
Yi

