Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76430C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 15:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30822206BA
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 15:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IbMC7GFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfC2P6Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:58:25 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39048 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfC2P6Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 11:58:25 -0400
Received: by mail-it1-f195.google.com with SMTP id 139so4642587ita.4
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 08:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=caXoiDSKn+Qb4g9BBNk10pBV5z7PZJqZpPtP1dFea80=;
        b=IbMC7GFKvrgUaiTqJFvP74ZyjG6NU/WKWiiWLX2Kidj5ZdQ8gGGveO5ndlA20lP2bD
         1aWAJBkg6eb+0bY/n6RLbKoX3M9WoHaqv+SV73l5Tr7Nbf/xLo2h6O0jMOcb7q1UC1ku
         ckOCP6vKQkWH5fmhHkjx70LL8RjbCf3qBwJPh4A5OltfvRt8ttNdnKvPJ/RMHQUp63ar
         8HV4uUJW0gMNuUlvpPogcGyzH+7zllW6Rfn+F56JDjvuGA4yegtQqGq/zYYwJVt+kJFf
         JZ3tYSnG6gUFKfjy1jqhRVVj3GneTVpveeher3SUmCfzn44+79S+xxxlHIUhIFwSD9oW
         rPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=caXoiDSKn+Qb4g9BBNk10pBV5z7PZJqZpPtP1dFea80=;
        b=FDFBlzVIrR2jixZMMk+MYDOFadT6RRv15jzqUsG3ScgbznelHzTeGxt7QzYLaR8etk
         ZJGSL7NejFd2IgCayuCpDgO2A4QUDy0UkUXSV0QWQmS0Dpyg5PBu/c5t0seSTp4zG7SU
         aJzz8jDqKMVFvwi2MxXldKFNG+8HZFyt+ZXJ7dmq2IIqSMN9OqWotQSHGcTOxXwh3Ig2
         4bvKU3JWoMXe9xYYQ8PsO+wcBKRH8rSJwvDJ9XManCG0x5CcZgaInXDQDx1r/6atXbgN
         msr+Euc3iiUWkS+dFeyBg1Zb0bnU3S8UmF4e5RV8Tvcus5hMHazKy6UoYAE/YLMYIvD3
         XYag==
X-Gm-Message-State: APjAAAVMDI25+OBCeFo00W5MixOgFxFlEV1ID9rZMyMPIbsTIFNGUSXx
        jz9p3G5Nig86bbtalrKfUpYf1g==
X-Google-Smtp-Source: APXvYqx0OlT9l2j8nq5h0N9ABWd9WGGmBJb7rxXzynWwch3PAmiVOR2VU1hPSN6jx18KdB9bRmWyzA==
X-Received: by 2002:a02:b78e:: with SMTP id f14mr4239534jam.43.1553875104720;
        Fri, 29 Mar 2019 08:58:24 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s10sm951215ioc.54.2019.03.29.08.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 08:58:23 -0700 (PDT)
Subject: Re: [PATCH] block/bfq: fix ifdef for CONFIG_BFQ_GROUP_IOSCHED=y
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
References: <155386807826.3190.16175453392005064129.stgit@buzz>
 <c40b8d4a-c504-fdf4-0b96-64aaeb167435@applied-asynchrony.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5234a971-2b6a-47b1-0071-8f3bd07d9fc3@kernel.dk>
Date:   Fri, 29 Mar 2019 09:58:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c40b8d4a-c504-fdf4-0b96-64aaeb167435@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 9:56 AM, Holger Hoffstätte wrote:
> On 3/29/19 3:01 PM, Konstantin Khlebnikov wrote:
>> Replace BFQ_GROUP_IOSCHED_ENABLED with CONFIG_BFQ_GROUP_IOSCHED.
>> Code under these ifdefs never worked, something might be broken.
>>
>> Fixes: 0471559c2fbd ("block, bfq: add/remove entity weights correctly")
>> Fixes: 73d58118498b ("block, bfq: consider also ioprio classes in symmetry detection")
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
>>   block/bfq-iosched.c |    2 +-
>>   block/bfq-wf2q.c    |    2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 4c592496a16a..fac188dd78fa 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -674,7 +674,7 @@ static bool bfq_symmetric_scenario(struct bfq_data *bfqd)
>>   	 * at least two nodes.
>>   	 */
>>   	return !(varied_queue_weights || multiple_classes_busy
>> -#ifdef BFQ_GROUP_IOSCHED_ENABLED
>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>   	       || bfqd->num_groups_with_pending_reqs > 0
>>   #endif
>>   		);
>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>> index 63311d1ff1ed..a11bef75483d 100644
>> --- a/block/bfq-wf2q.c
>> +++ b/block/bfq-wf2q.c
>> @@ -1012,7 +1012,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
>>   		entity->on_st = true;
>>   	}
>>   
>> -#ifdef BFQ_GROUP_IOSCHED_ENABLED
>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>   	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
>>   		struct bfq_group *bfqg =
>>   			container_of(entity, struct bfq_group, entity);
>>
>>
> 
> Good catch! I run without group scheduling and therefore didn't notice these
> stray defines earlier. For 5.1 it should merge cleanly; adding this on top of
> the pending 5.2 BFQ patches required a small context fixup in hunk #1 due to
> "block, bfq: do not idle for lowest-weight queues".

I'm hesitant to apply this, since the group scheduling stuff has obviously never
been tested.

Hence it should go through some actual testing first, which means it's a 5.2
candidate, not 5.1.

-- 
Jens Axboe

