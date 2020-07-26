Return-Path: <SRS0=9ghM=BF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A074C433E0
	for <linux-block@archiver.kernel.org>; Sun, 26 Jul 2020 11:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B342070A
	for <linux-block@archiver.kernel.org>; Sun, 26 Jul 2020 11:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="u+fD/NYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgGZLhA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jul 2020 07:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZLhA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jul 2020 07:37:00 -0400
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Jul 2020 04:37:00 PDT
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73478C0619D2
        for <linux-block@vger.kernel.org>; Sun, 26 Jul 2020 04:37:00 -0700 (PDT)
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 9B4847D9EF6;
        Sun, 26 Jul 2020 13:31:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1595763097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qb2TCMYxY7BR4BMmQM5x3ulbNhE6P2tR4EJMVyVxQBA=;
        b=u+fD/NYy+SDz2yG8qW86qEqb2wXH18wrztBRd5H+UuYTN5leLNkxRC8MW392wWohJXewJD
        FviVzx8MQIeWFeW5o9143NcbCvrbFbMIshj8C6WKM7UtDk6QD9cqFKOhJWRxHU4xyZlymI
        wjCRW7Hxcq7kHDiNHi+gSFGC2Pu+COQ=
MIME-Version: 1.0
Date:   Sun, 26 Jul 2020 13:31:37 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, paolo.valente@linaro.org
Subject: Re: [PATCH] block: bfq fix blkio cgroup leakage v2
In-Reply-To: <20200720170411.21250-1-dmtrmonakhov@yandex-team.ru>
References: <b4561a09-f00f-568b-9d55-0a2893de4be5@kernel.dk>
 <20200720170411.21250-1-dmtrmonakhov@yandex-team.ru>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <6422992afade0015d817a65c124e0c75@natalenko.name>
X-Sender: oleksandr@natalenko.name
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

On 20.07.2020 19:04, Dmitry Monakhov wrote:
> commit db37a34c563b ("block, bfq: get a ref to a group when adding it
> to a service tree")
> introduce leak forbfq_group and blkcg_gq objects because of get/put
> imbalance. See trace balow:
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
> We should drop group reference once it finaly removed from service
> inside __bfq_bfqd_reset_in_service, as we do with queue entities.
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
>  block/bfq-wf2q.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 8113138..93b236c 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -635,14 +635,10 @@ static void bfq_idle_insert(struct 
> bfq_service_tree *st,
>   * @entity: the entity being removed.
>   * @is_in_service: true if entity is currently the in-service entity.
>   *
> - * Forget everything about @entity. In addition, if entity represents
> - * a queue, and the latter is not in service, then release the service
> - * reference to the queue (the one taken through bfq_get_entity). In
> - * fact, in this case, there is really no more service reference to
> - * the queue, as the latter is also outside any service tree. If,
> - * instead, the queue is in service, then __bfq_bfqd_reset_in_service
> - * will take care of putting the reference when the queue finally
> - * stops being served.
> + * Forget everything about @entity. If entity is not in service, then 
> release
> + * the service reference to the entity (the one taken through  
> bfq_get_entity).
> + * If the entity is in service, then __bfq_bfqd_reset_in_service will 
> take care
> + * of putting the reference when the entity finally stops being 
> served.
>   */
>  static void bfq_forget_entity(struct bfq_service_tree *st,
>  			      struct bfq_entity *entity,
> @@ -1626,9 +1622,16 @@ bool __bfq_bfqd_reset_in_service(struct bfq_data 
> *bfqd)
>  	 * execute the final step: reset in_service_entity along the
>  	 * path from entity to the root.
>  	 */
> -	for_each_entity(entity)
> +	for_each_entity(entity) {
>  		entity->sched_data->in_service_entity = NULL;
> -
> +		/*
> +		 * Release bfq_groups reference if it was not released in
> +		 * bfq_forget_entity, which was taken in bfq_get_entity.
> +		 */
> +		if (!bfq_entity_to_bfqq(entity) && !entity->on_st_or_in_serv)
> +			bfqg_and_blkg_put(container_of(entity, struct bfq_group,
> +						       entity));
> +	}
>  	/*
>  	 * in_serv_entity is no longer in service, so, if it is in no
>  	 * service tree either, then release the service reference to

As reported by one of my customers, this patch causes the following 
crash: [1]

[1] 
http://pix.academ.info/images/img/2020/07/26/52d097c02b6061657443bba92de75e8a.jpg

-- 
   Oleksandr Natalenko (post-factum)
