Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBEAC47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 09:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C28613FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 09:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFJJIJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:08:09 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:43679 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhFJJIJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 05:08:09 -0400
Received: by mail-pg1-f172.google.com with SMTP id e22so22044360pgv.10;
        Thu, 10 Jun 2021 02:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WVYZh37iLNE3J4xzwZTUdF1tvtQC8S/ydWacg9ipzgY=;
        b=KdpAAEnO2Z2FCmbpRQ/ye4dryVfTV8KCyXdcKGPCEoWI0PEyPkZ2qof3wxuDvUHP91
         aWFO/y9owh7OoKAdy64N22ZRZquRGuyZdh6Cq1n6v36bCiN1Y2+nMxLeiVYmmAxYZvVN
         8GgrQ32n9oB2gj5RQxhFJGSbJG8iq9FEA2oEL+KlEe1Bd9Tp/PQVlPOch7t7CT9CB1+9
         iJ8sWwxS2gEOcy7RyBoyiY5eiqvaKMwYXlqPpl66u0nPMchObxwZAPkZGPlscitzEMRN
         SYN9DNI20X7Aj1V0u+v/gyzGb5CfAM38ChBCnH/oiMVdTYvYcL5jnvuJdbqyG+/T/Lbg
         Naig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WVYZh37iLNE3J4xzwZTUdF1tvtQC8S/ydWacg9ipzgY=;
        b=IAYpe8Zu/JE8jc3TxOWIuaCXVEwRHMO8GroO11VVbIXPsebomR81oIH61aTesbOZ0w
         Qig56TTJD1v6vdOhBdVNttIJVYlnXIwbH15hlk7YlhkOKu+NKJwxtXEpxH9bPOj+vbD8
         +vEQ3lAxGO/qQofaVIxgF5sGLOGT/LABL0DS2Jr92Cvvqqn1FNYn8qCl9ZZiUUAKEb1K
         P+ChSW0P7vJTntmqVW05o1UtQn/o+d1oJxis58pY0D0h3UURUr6TuW1X9Ov4reGuVz+g
         Ch/5wfLhMvdbRdkcuW61Tij5shaaVGgApXVtcdrmFYP6BrYluaCvLF763hWXyyfCQfNz
         G1EQ==
X-Gm-Message-State: AOAM531BCY0lmWI9MxVJrLCBX3HTw6JdY+CQEp0jk6qokiZnRMoH5Ykh
        rM1tcLNoj1OkzOPlZiHmc+E=
X-Google-Smtp-Source: ABdhPJyxi4anbag9ZpWO3Zhn+zjYgn2lHwH/b7JXexBto/qLq4Js+VWWoON8KGSaOpcDL64NzrDuzw==
X-Received: by 2002:aa7:8641:0:b029:2f4:7263:5524 with SMTP id a1-20020aa786410000b02902f472635524mr2083010pfo.70.1623315913522;
        Thu, 10 Jun 2021 02:05:13 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id u9sm2084786pgp.90.2021.06.10.02.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 02:05:13 -0700 (PDT)
Subject: Re: [RESEND PATCH 1/8] bfq: introduce bfq_entity_to_bfqg helper
 method
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Piotr Gorski <lucjan.lucjanov@gmail.com>
References: <cover.1618916839.git.brookxu@tencent.com>
 <20210610072230.TAxxdh-wsL4sihK2TJxF-Gz85ZgsFR7IwOuifnxFi0k@z>
 <20210610083147.xoefokucl5ey7v32@spock.localdomain>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <eac90e08-eb43-848a-7a5f-e0c84b7ea637@gmail.com>
Date:   Thu, 10 Jun 2021 17:05:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610083147.xoefokucl5ey7v32@spock.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



Oleksandr Natalenko wrote on 2021/6/10 16:31:
> Hello.
> 
> On Thu, Jun 10, 2021 at 03:22:30PM +0800, brookxu wrote:
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> Introduce bfq_entity_to_bfqg() to make it easier to obtain the
>> bfq_group corresponding to the entity.
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>> ---
>>  block/bfq-cgroup.c  |  6 ++----
>>  block/bfq-iosched.h |  1 +
>>  block/bfq-wf2q.c    | 16 ++++++++++++----
>>  3 files changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>> index b791e20..a5f544a 100644
>> --- a/block/bfq-cgroup.c
>> +++ b/block/bfq-cgroup.c
>> @@ -309,8 +309,7 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
>>  {
>>  	struct bfq_entity *group_entity = bfqq->entity.parent;
>>  
>> -	return group_entity ? container_of(group_entity, struct bfq_group,
>> -					   entity) :
>> +	return group_entity ? bfq_entity_to_bfqg(group_entity) :
>>  			      bfqq->bfqd->root_group;
>>  }
>>  
>> @@ -610,8 +609,7 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
>>  	 */
>>  	entity = &bfqg->entity;
>>  	for_each_entity(entity) {
>> -		struct bfq_group *curr_bfqg = container_of(entity,
>> -						struct bfq_group, entity);
>> +		struct bfq_group *curr_bfqg = bfq_entity_to_bfqg(entity);
>>  		if (curr_bfqg != bfqd->root_group) {
>>  			parent = bfqg_parent(curr_bfqg);
>>  			if (!parent)
>> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
>> index b8e793c..a6f98e9 100644
>> --- a/block/bfq-iosched.h
>> +++ b/block/bfq-iosched.h
>> @@ -941,6 +941,7 @@ struct bfq_group {
>>  #endif
>>  
>>  struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
>> +struct bfq_group *bfq_entity_to_bfqg(struct bfq_entity *entity);
>>  
>>  /* --------------- main algorithm interface ----------------- */
>>  
>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>> index 070e34a..5ff0028 100644
>> --- a/block/bfq-wf2q.c
>> +++ b/block/bfq-wf2q.c
>> @@ -149,7 +149,7 @@ struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq)
>>  	if (!group_entity)
>>  		group_entity = &bfqq->bfqd->root_group->entity;
>>  
>> -	return container_of(group_entity, struct bfq_group, entity);
>> +	return bfq_entity_to_bfqg(group_entity);
>>  }
>>  
>>  /*
>> @@ -208,7 +208,7 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
>>  	if (bfq_entity_to_bfqq(entity))
>>  		return true;
>>  
>> -	bfqg = container_of(entity, struct bfq_group, entity);
>> +	bfqg = bfq_entity_to_bfqg(entity);
>>  
>>  	/*
>>  	 * The field active_entities does not always contain the
>> @@ -266,6 +266,15 @@ struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity)
>>  	return bfqq;
>>  }
>>  
>> +struct bfq_group *bfq_entity_to_bfqg(struct bfq_entity *entity)
>> +{
>> +	struct bfq_group *bfqg = NULL;
>> +
>> +	if (entity->my_sched_data)
>> +		bfqg = container_of(entity, struct bfq_group, entity);
>> +
>> +	return bfqg;
>> +}
>>  
>>  /**
>>   * bfq_delta - map service into the virtual time domain.
>> @@ -1001,8 +1010,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
>>  
>>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
>>  	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
>> -		struct bfq_group *bfqg =
>> -			container_of(entity, struct bfq_group, entity);
>> +		struct bfq_group *bfqg = bfq_entity_to_bfqg(entity);
>>  		struct bfq_data *bfqd = bfqg->bfqd;
>>  
>>  		if (!entity->in_groups_with_pending_reqs) {
>> -- 
>> 1.8.3.1
>>
> 
> If it is a resend only, I can offer my Tested-by since I'm running this
> series for quite some time already.
> 

ok, thank you very much.

> Thanks.
> 
