Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD93C43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 18:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245563AbiFOSiM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 14:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiFOSiK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 14:38:10 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8843F27B31
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 11:38:09 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 1Xu2oIs6ogNxB1Xu2o39DQ; Wed, 15 Jun 2022 20:38:07 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 15 Jun 2022 20:38:07 +0200
X-ME-IP: 90.11.190.129
Message-ID: <a1f3152a-6102-f5d9-0f27-a6e6f43705a7@wanadoo.fr>
Date:   Wed, 15 Jun 2022 20:38:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] block: Directly use ida_alloc()/free()
Content-Language: fr
To:     Bo Liu <liubo03@inspur.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220615081816.4342-1-liubo03@inspur.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220615081816.4342-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Le 15/06/2022 à 10:18, Bo Liu a écrit :
> Use ida_alloc()/ida_free() instead of
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Hi,
for what it's worth:

Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

> ---
>   block/blk-core.c  | 4 ++--
>   block/blk-sysfs.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 06ff5bbfe8f6..eb86c756a7fd 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -448,7 +448,7 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
>   
>   	q->last_merge = NULL;
>   
> -	q->id = ida_simple_get(&blk_queue_ida, 0, 0, GFP_KERNEL);
> +	q->id = ida_alloc(&blk_queue_ida, GFP_KERNEL);
>   	if (q->id < 0)
>   		goto fail_srcu;
>   
> @@ -498,7 +498,7 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
>   fail_split:
>   	bioset_exit(&q->bio_split);
>   fail_id:
> -	ida_simple_remove(&blk_queue_ida, q->id);
> +	ida_free(&blk_queue_ida, q->id);
>   fail_srcu:
>   	if (alloc_srcu)
>   		cleanup_srcu_struct(q->srcu);
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 14607565d781..2ed9e7d52b47 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -799,7 +799,7 @@ static void blk_release_queue(struct kobject *kobj)
>   	if (blk_queue_has_srcu(q))
>   		cleanup_srcu_struct(q->srcu);
>   
> -	ida_simple_remove(&blk_queue_ida, q->id);
> +	ida_free(&blk_queue_ida, q->id);
>   	call_rcu(&q->rcu_head, blk_free_queue_rcu);
>   }
>   

