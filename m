Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9436CC48BCD
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 08:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF0C611CC
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 08:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFJId4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 04:33:56 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:57068 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhFJIdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 04:33:51 -0400
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 9AB93AC8E83;
        Thu, 10 Jun 2021 10:31:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1623313908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jn+AugA0jjeMf75IXMzBMJDsoobmw9Ii5lTQIUixXj4=;
        b=Q65hq5fFQmFLGz6fM4S+YX8dskwWz+s7YJOd1oD5HrNpwJh/9osLB6RLffrQQXbtNO4bxr
        tYAk0GX6jZQREnlchpLJfETwaD6I4Az5KX7IYCNwk5yBzWh2QWdzsIenBwrNa1CLtDKlvv
        gFXgStH0IAv4fOolr4VlKgFVTiI4UcM=
Date:   Thu, 10 Jun 2021 10:31:47 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Piotr Gorski <lucjan.lucjanov@gmail.com>
Subject: Re: [RESEND PATCH 1/8] bfq: introduce bfq_entity_to_bfqg helper
 method
Message-ID: <20210610083147.xoefokucl5ey7v32@spock.localdomain>
References: <cover.1618916839.git.brookxu@tencent.com>
 <20210610072230.TAxxdh-wsL4sihK2TJxF-Gz85ZgsFR7IwOuifnxFi0k@z>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610072230.TAxxdh-wsL4sihK2TJxF-Gz85ZgsFR7IwOuifnxFi0k@z>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

On Thu, Jun 10, 2021 at 03:22:30PM +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> Introduce bfq_entity_to_bfqg() to make it easier to obtain the
> bfq_group corresponding to the entity.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
>  block/bfq-cgroup.c  |  6 ++----
>  block/bfq-iosched.h |  1 +
>  block/bfq-wf2q.c    | 16 ++++++++++++----
>  3 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index b791e20..a5f544a 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -309,8 +309,7 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
>  {
>  	struct bfq_entity *group_entity = bfqq->entity.parent;
>  
> -	return group_entity ? container_of(group_entity, struct bfq_group,
> -					   entity) :
> +	return group_entity ? bfq_entity_to_bfqg(group_entity) :
>  			      bfqq->bfqd->root_group;
>  }
>  
> @@ -610,8 +609,7 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
>  	 */
>  	entity = &bfqg->entity;
>  	for_each_entity(entity) {
> -		struct bfq_group *curr_bfqg = container_of(entity,
> -						struct bfq_group, entity);
> +		struct bfq_group *curr_bfqg = bfq_entity_to_bfqg(entity);
>  		if (curr_bfqg != bfqd->root_group) {
>  			parent = bfqg_parent(curr_bfqg);
>  			if (!parent)
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index b8e793c..a6f98e9 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -941,6 +941,7 @@ struct bfq_group {
>  #endif
>  
>  struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
> +struct bfq_group *bfq_entity_to_bfqg(struct bfq_entity *entity);
>  
>  /* --------------- main algorithm interface ----------------- */
>  
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 070e34a..5ff0028 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -149,7 +149,7 @@ struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq)
>  	if (!group_entity)
>  		group_entity = &bfqq->bfqd->root_group->entity;
>  
> -	return container_of(group_entity, struct bfq_group, entity);
> +	return bfq_entity_to_bfqg(group_entity);
>  }
>  
>  /*
> @@ -208,7 +208,7 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
>  	if (bfq_entity_to_bfqq(entity))
>  		return true;
>  
> -	bfqg = container_of(entity, struct bfq_group, entity);
> +	bfqg = bfq_entity_to_bfqg(entity);
>  
>  	/*
>  	 * The field active_entities does not always contain the
> @@ -266,6 +266,15 @@ struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity)
>  	return bfqq;
>  }
>  
> +struct bfq_group *bfq_entity_to_bfqg(struct bfq_entity *entity)
> +{
> +	struct bfq_group *bfqg = NULL;
> +
> +	if (entity->my_sched_data)
> +		bfqg = container_of(entity, struct bfq_group, entity);
> +
> +	return bfqg;
> +}
>  
>  /**
>   * bfq_delta - map service into the virtual time domain.
> @@ -1001,8 +1010,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
>  
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
>  	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
> -		struct bfq_group *bfqg =
> -			container_of(entity, struct bfq_group, entity);
> +		struct bfq_group *bfqg = bfq_entity_to_bfqg(entity);
>  		struct bfq_data *bfqd = bfqg->bfqd;
>  
>  		if (!entity->in_groups_with_pending_reqs) {
> -- 
> 1.8.3.1
> 

If it is a resend only, I can offer my Tested-by since I'm running this
series for quite some time already.

Thanks.

-- 
  Oleksandr Natalenko (post-factum)
