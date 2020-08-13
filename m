Return-Path: <SRS0=n79e=BX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4012C433DF
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 10:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC0A20768
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 10:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="s/s9gcdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgHMKSU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:18:20 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:36084 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMKSU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Aug 2020 06:18:20 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id BD8457FA229;
        Thu, 13 Aug 2020 12:18:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1597313892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oqJo//NoneW7PkB46Igg0Y4AUGFkiADCr7vVI5rxrdU=;
        b=s/s9gcdDebHxarumTc0n3bOWyHVafTpurL4mfVvIaiZwNZX4qcCSrOIAi+3L6b0OgF9Ci3
        M7LtKypclvN1rktNfdy/ITQcPpoKmOrnjtlQ0mysqulfcpbS6xzwkyh0lC6zxB49HP0dA9
        RI8YTUlYnqrllmtSoDRM6d6zH77NtTE=
MIME-Version: 1.0
Date:   Thu, 13 Aug 2020 12:18:12 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, paolo.valente@linaro.org
Subject: Re: [PATCH] bfq: fix blkio cgroup leakage v4
In-Reply-To: <20200811064340.31284-1-dmtrmonakhov@yandex-team.ru>
References: <20200811064340.31284-1-dmtrmonakhov@yandex-team.ru>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <8b435dd48d245afe2fda82ee711f9457@natalenko.name>
X-Sender: oleksandr@natalenko.name
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

On 11.08.2020 08:43, Dmitry Monakhov wrote:
> Changes from v1:
>     - update commit description with proper ref-accounting 
> justification
> 
> commit db37a34c563b ("block, bfq: get a ref to a group when adding it
> to a service tree")
> introduce leak forbfq_group and blkcg_gq objects because of get/put
> imbalance.
> In fact whole idea of original commit is wrong because bfq_group entity
> can not dissapear under us because it is referenced by child 
> bfq_queue's
> entities from here:
>  -> bfq_init_entity()
>     ->bfqg_and_blkg_get(bfqg);
>     ->entity->parent = bfqg->my_entity
> 
>  -> bfq_put_queue(bfqq)
>     FINAL_PUT
>     ->bfqg_and_blkg_put(bfqq_group(bfqq))
>     ->kmem_cache_free(bfq_pool, bfqq);
> 
> So parent entity can not disappear while child entity is in tree,
> and child entities already has proper protection.
> This patch revert commit db37a34c563b ("block, bfq: get a ref to a
> group when adding it to a service tree")
> 
> 
> bfq_group leak trace caused by bad commit:
> -> blkg_alloc
>    -> bfq_pq_alloc
>      -> bfqg_get (+1)
> ->bfq_activate_bfqq
>   ->bfq_activate_requeue_entity
>     -> __bfq_activate_entity
>        ->bfq_get_entity
>          ->bfqg_and_blkg_get (+1)  <==== : Note1
> ->bfq_del_bfqq_busy
>   ->bfq_deactivate_entity+0x53/0xc0 [bfq]
>     ->__bfq_deactivate_entity+0x1b8/0x210 [bfq]
>       -> bfq_forget_entity(is_in_service = true)
> 	 entity->on_st_or_in_serv = false   <=== :Note2
> 	 if (is_in_service)
> 	     return;  ==> do not touch reference
> -> blkcg_css_offline
>  -> blkcg_destroy_blkgs
>   -> blkg_destroy
>    -> bfq_pd_offline
>     -> __bfq_deactivate_entity
>          if (!entity->on_st_or_in_serv) /* true, because (Note2)
> 		return false;
>  -> bfq_pd_free
>     -> bfqg_put() (-1, byt bfqg->ref == 2) because of (Note2)
> So bfq_group and blkcg_gq  will leak forever, see test-case below.
> 
> 
> ##TESTCASE_BEGIN:
> #!/bin/bash
> 
> max_iters=${1:-100}
> #prep cgroup mounts
> mount -t tmpfs cgroup_root /sys/fs/cgroup
> mkdir /sys/fs/cgroup/blkio
> mount -t cgroup -o blkio none /sys/fs/cgroup/blkio
> 
> # Prepare blkdev
> grep blkio /proc/cgroups
> truncate -s 1M img
> losetup /dev/loop0 img
> echo bfq > /sys/block/loop0/queue/scheduler
> 
> grep blkio /proc/cgroups
> for ((i=0;i<max_iters;i++))
> do
>     mkdir -p /sys/fs/cgroup/blkio/a
>     echo 0 > /sys/fs/cgroup/blkio/a/cgroup.procs
>     dd if=/dev/loop0 bs=4k count=1 of=/dev/null iflag=direct 2> 
> /dev/null
>     echo 0 > /sys/fs/cgroup/blkio/cgroup.procs
>     rmdir /sys/fs/cgroup/blkio/a
>     grep blkio /proc/cgroups
> done
> ##TESTCASE_END:
> 
> Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> ---
>  block/bfq-cgroup.c  |  2 +-
>  block/bfq-iosched.h |  1 -
>  block/bfq-wf2q.c    | 12 ++----------
>  3 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 68882b9..b791e20 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -332,7 +332,7 @@ static void bfqg_put(struct bfq_group *bfqg)
>  		kfree(bfqg);
>  }
> 
> -void bfqg_and_blkg_get(struct bfq_group *bfqg)
> +static void bfqg_and_blkg_get(struct bfq_group *bfqg)
>  {
>  	/* see comments in bfq_bic_update_cgroup for why refcounting bfqg */
>  	bfqg_get(bfqg);
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index cd224aa..7038952 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -986,7 +986,6 @@ struct bfq_group *bfq_find_set_group(struct 
> bfq_data *bfqd,
>  struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
>  struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
>  struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, 
> int node);
> -void bfqg_and_blkg_get(struct bfq_group *bfqg);
>  void bfqg_and_blkg_put(struct bfq_group *bfqg);
> 
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index eb0e2a6..26776bd 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -533,9 +533,7 @@ static void bfq_get_entity(struct bfq_entity 
> *entity)
>  		bfqq->ref++;
>  		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
>  			     bfqq, bfqq->ref);
> -	} else
> -		bfqg_and_blkg_get(container_of(entity, struct bfq_group,
> -					       entity));
> +	}
>  }
> 
>  /**
> @@ -649,14 +647,8 @@ static void bfq_forget_entity(struct 
> bfq_service_tree *st,
> 
>  	entity->on_st_or_in_serv = false;
>  	st->wsum -= entity->weight;
> -	if (is_in_service)
> -		return;
> -
> -	if (bfqq)
> +	if (bfqq && !is_in_service)
>  		bfq_put_queue(bfqq);
> -	else
> -		bfqg_and_blkg_put(container_of(entity, struct bfq_group,
> -					       entity));
>  }
> 
>  /**

No crashes reported this time, at least so far.

Thanks.

-- 
   Oleksandr Natalenko (post-factum)
