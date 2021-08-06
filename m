Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E3BC4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 06:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58B0611C6
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 06:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243376AbhHFGiT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 02:38:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52300 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhHFGiO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 02:38:14 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6B7F71FE9C;
        Fri,  6 Aug 2021 06:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628231878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=11F7vf2VJ6T0TivdTVIFesJ86SixA4ATGqbIwq4iPoQ=;
        b=eRW7dggE8AwdKRv1CuCXWzifyRM9OFr/UkLBW6lsOZ7T/xWkU9CSD6erVDLKOIFScOWyMd
        QuVWjUUA7jG1NuI7XjIghexwEEVGfPrsylZqzC9HGp4KqXY0ddD+iwcrbdu1ttzaxSEdkZ
        nXbPdab/f155C9hq28E5a4uEboQHbZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628231878;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=11F7vf2VJ6T0TivdTVIFesJ86SixA4ATGqbIwq4iPoQ=;
        b=YSX5NX/l5Tmh+4NUXGP6EZXvs4w+Nsq274PA+1KvG5F50BcXieP02pbk2tcE/uyNW6VKA3
        ina7I8ILN5AD1JBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1F13D136D9;
        Fri,  6 Aug 2021 06:37:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id YWiEBsbYDGGQBgAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 06 Aug 2021 06:37:58 +0000
Subject: Re: [PATCH v2 3/4] block: rename IOPRIO_BE_NR
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20210806051140.301127-1-damien.lemoal@wdc.com>
 <20210806051140.301127-4-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d0bc418e-ddf7-6038-427a-2e9ad2f4ab87@suse.de>
Date:   Fri, 6 Aug 2021 08:37:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806051140.301127-4-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/21 7:11 AM, Damien Le Moal wrote:
> The BFQ scheduler and ioprio_check_cap() both assume that the RT
> priority class (IOPRIO_CLASS_RT) can have up to 8 different priority
> levels. This is controlled using the macro IOPRIO_BE_NR, which is badly
> named as the number of levels applies to the RT class.
> 
> Rename IOPRIO_BE_NR to the class independent IOPRIO_NR_LEVELS to make
> things clear.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   block/bfq-iosched.c         | 8 ++++----
>   block/bfq-iosched.h         | 4 ++--
>   block/bfq-wf2q.c            | 6 +++---
>   block/ioprio.c              | 3 +--
>   fs/f2fs/sysfs.c             | 2 +-
>   include/uapi/linux/ioprio.h | 4 ++--
>   6 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 1f38d75524ae..d5824cab34d7 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2505,7 +2505,7 @@ void bfq_end_wr_async_queues(struct bfq_data *bfqd,
>   	int i, j;
>   
>   	for (i = 0; i < 2; i++)
> -		for (j = 0; j < IOPRIO_BE_NR; j++)
> +		for (j = 0; j < IOPRIO_NR_LEVELS; j++)
>   			if (bfqg->async_bfqq[i][j])
>   				bfq_bfqq_end_wr(bfqg->async_bfqq[i][j]);
>   	if (bfqg->async_idle_bfqq)
> @@ -5290,10 +5290,10 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
>   		break;
>   	}
>   
> -	if (bfqq->new_ioprio >= IOPRIO_BE_NR) {
> +	if (bfqq->new_ioprio >= IOPRIO_NR_LEVELS) {
>   		pr_crit("bfq_set_next_ioprio_data: new_ioprio %d\n",
>   			bfqq->new_ioprio);
> -		bfqq->new_ioprio = IOPRIO_BE_NR - 1;
> +		bfqq->new_ioprio = IOPRIO_NR_LEVELS - 1;
>   	}
>   
>   	bfqq->entity.new_weight = bfq_ioprio_to_weight(bfqq->new_ioprio);
> @@ -6822,7 +6822,7 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
>   	int i, j;
>   
>   	for (i = 0; i < 2; i++)
> -		for (j = 0; j < IOPRIO_BE_NR; j++)
> +		for (j = 0; j < IOPRIO_NR_LEVELS; j++)
>   			__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j]);
>   
>   	__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq);
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 99c2a3cb081e..385e28a843d1 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -931,7 +931,7 @@ struct bfq_group {
>   
>   	void *bfqd;
>   
> -	struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
> +	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
>   	struct bfq_queue *async_idle_bfqq;
>   
>   	struct bfq_entity *my_entity;
> @@ -948,7 +948,7 @@ struct bfq_group {
>   	struct bfq_entity entity;
>   	struct bfq_sched_data sched_data;
>   
> -	struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
> +	struct bfq_queue *async_bfqq[2][IOPRIO_NR_LEVELS];
>   	struct bfq_queue *async_idle_bfqq;
>   
>   	struct rb_root rq_pos_tree;
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 7a462df71f68..b74cc0da118e 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -505,7 +505,7 @@ static void bfq_active_insert(struct bfq_service_tree *st,
>    */
>   unsigned short bfq_ioprio_to_weight(int ioprio)
>   {
> -	return (IOPRIO_BE_NR - ioprio) * BFQ_WEIGHT_CONVERSION_COEFF;
> +	return (IOPRIO_NR_LEVELS - ioprio) * BFQ_WEIGHT_CONVERSION_COEFF;
>   }
>   
>   /**
> @@ -514,12 +514,12 @@ unsigned short bfq_ioprio_to_weight(int ioprio)
>    *
>    * To preserve as much as possible the old only-ioprio user interface,
>    * 0 is used as an escape ioprio value for weights (numerically) equal or
> - * larger than IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF.
> + * larger than IOPRIO_NR_LEVELS * BFQ_WEIGHT_CONVERSION_COEFF.
>    */
>   static unsigned short bfq_weight_to_ioprio(int weight)
>   {
>   	return max_t(int, 0,
> -		     IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight);
> +		     IOPRIO_NR_LEVELS * BFQ_WEIGHT_CONVERSION_COEFF - weight);
>   }
>   
>   static void bfq_get_entity(struct bfq_entity *entity)
> diff --git a/block/ioprio.c b/block/ioprio.c
> index bee628f9f1b2..ca6b136c5586 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -74,9 +74,8 @@ int ioprio_check_cap(int ioprio)
>   			fallthrough;
>   			/* rt has prio field too */
>   		case IOPRIO_CLASS_BE:
> -			if (data >= IOPRIO_BE_NR || data < 0)
> +			if (data >= IOPRIO_NR_LEVELS || data < 0)
>   				return -EINVAL;
> -
>   			break;
>   		case IOPRIO_CLASS_IDLE:
>   			break;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 6642246206bd..daad532a4e2b 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -378,7 +378,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		ret = kstrtol(name, 10, &data);
>   		if (ret)
>   			return ret;
> -		if (data >= IOPRIO_BE_NR || data < 0)
> +		if (data >= IOPRIO_NR_LEVELS || data < 0)
>   			return -EINVAL;
>   
>   		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, data);
> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> index abc40965aa96..b9d48744dacb 100644
> --- a/include/uapi/linux/ioprio.h
> +++ b/include/uapi/linux/ioprio.h
> @@ -31,9 +31,9 @@ enum {
>   };
>   
>   /*
> - * 8 best effort priority levels are supported
> + * The RT an BE priority classes support up to 8 priority levels.

This sentence no verb :-)
(maybe 'The RT class is an BE priority ...'?)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
