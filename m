Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79853C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 02:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C77221104
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 02:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uFJGaWA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C77221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeKUNVR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 08:21:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43454 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeKUNVR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 08:21:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so3215233plb.10
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 18:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AXX2un2Yyou4DpCqb9MsM52UsbdZMgAYnfeiAsly6Xw=;
        b=uFJGaWA2pfchJ2SHacDyms3NemU62NjYkD4t2rIHSNzAd7WcLdiTWbaFvbP44BnvcW
         UUD9HKYUPBfKAcdbzyG9dTPL6c3VvOeRsmgLJerhVNITH29+mCd3AyF5Ins8U+PqUpFb
         3mfMnwLDts0xJJCxTRmvloeEsXCv1mUuO9rGxOW+LyKet7mKA5hZsx0v0mGspX9of1V6
         9zuuNjbYt6leNKNT9fU2fbztxkM1sumD5k7xJXDLETib1u40ioxgmWBDlEPdnJZtrv30
         cfVFxGNnOY5IJ+Z6Qgv2/h85Mr4vU32AiIS6lcFFUd8oV2RlNVvb6LqQp5P1ckbaXvNU
         9dRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AXX2un2Yyou4DpCqb9MsM52UsbdZMgAYnfeiAsly6Xw=;
        b=RMyqYSM9Xxsx9cEPsUtjcpQ9YAbty+AUrHUYHRelEkZixKP9ptmwfm2W0mqMaJ4cq3
         UIgSpn+vIOW7KEHVrRb8XC4CYVBe+TAcQInxUMuFX1VRBET+yhNpl2yBsym6Ydml0+Gq
         gNxVfeCIbgfOJveSDW7yoJf5NAcG5+ZDNnEAmz0wg1jYV0d9Eg/uXuZgHmgkEUTvj0z1
         /SGbLdNILup5+swjMX6TEzydELaIJYNccD8+Zf+JP59WeOMuFaIAa7pb/pZhUNJo1QV+
         fFVk6LlfwpJgwoDJ3iK3zCv0hOb3RyLcFWRL1tpHjtZ9VLqMoJkqcLC8j/1wawrNKbH5
         SqyQ==
X-Gm-Message-State: AA+aEWbvYTGx9PHm8kz8LexQQulaDdmsLSJPw0Ls1ubtkvxsljAgab4z
        kNr15vJDtK6xbDZxw+zQNbZopQ==
X-Google-Smtp-Source: AFSGD/VO4KAQITfZFGyymkzqw2CAeOiOi6O/3ds1nPj2dwBa1EKxQJYKmKO5xK5wVmUpNzaz+y57KA==
X-Received: by 2002:a63:8e43:: with SMTP id k64mr4307488pge.346.1542768533532;
        Tue, 20 Nov 2018 18:48:53 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id l87sm30830823pfj.179.2018.11.20.18.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 18:48:52 -0800 (PST)
Subject: Re: [PATCH 2/7] block: Remove bio->bi_ioc
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
 <20181119035131.11255-3-damien.lemoal@wdc.com>
 <20181120172126.GA28169@ming.t460p>
 <c132f449-b45f-aab8-1b57-1a45e43d22f4@kernel.dk>
 <BN3PR0401MB164000EE62FE6BFF2ABE0069E7D90@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <68806243-0094-5cbb-39fe-cea697f40b1c@kernel.dk>
 <BN3PR0401MB1640389B8B28086F0185CE2EE7DA0@BN3PR0401MB1640.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9d7f5e60-f2cb-e257-95c0-61ec117304b2@kernel.dk>
Date:   Tue, 20 Nov 2018 19:48:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <BN3PR0401MB1640389B8B28086F0185CE2EE7DA0@BN3PR0401MB1640.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/20/18 7:45 PM, Damien Le Moal wrote:
> On 2018/11/21 11:11, Jens Axboe wrote:
>> On 11/20/18 4:58 PM, Damien Le Moal wrote:
>>> On 2018/11/21 2:31, Jens Axboe wrote:
>>>> I think the below should fix it, we haven't necessarily setup an
>>>> ioc if we're just doing as passthrough request.
>>>>
>>>>
>>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>>>> index 13b8dc332541..f096d8989773 100644
>>>> --- a/block/blk-mq-sched.c
>>>> +++ b/block/blk-mq-sched.c
>>>> @@ -34,9 +34,16 @@ EXPORT_SYMBOL_GPL(blk_mq_sched_free_hctx_data);
>>>>  void blk_mq_sched_assign_ioc(struct request *rq)
>>>>  {
>>>>  	struct request_queue *q = rq->q;
>>>> -	struct io_context *ioc = current->io_context;
>>>> +	struct io_context *ioc;
>>>>  	struct io_cq *icq;
>>>>  
>>>> +	/*
>>>> +	 * May not have an IO context if it's a passthrough request
>>>> +	 */
>>>> +	ioc = current->io_context;
>>>> +	if (!ioc)
>>>> +		return;
>>>> +
>>>>  	spin_lock_irq(&q->queue_lock);
>>>>  	icq = ioc_lookup_icq(ioc, q);
>>>>  	spin_unlock_irq(&q->queue_lock);
>>>
>>> This seems reasonable to me, but I wonder why this problem was not triggering
>>> before. The previous code getting the ioc with the rq_ioc(bio) call was
>>> essentially the same and there was no "if (!ioc) return;" in
>>> blk_mq_sched_assign_ioc() before the patch.
>>> Any idea why this is popping up now ?
>>>
>>> Ming,
>>>
>>> Is this a new test your are running ? If this same problem triggers on stable
>>> kernels, Jens patch needs to go to stable too.
>>
>> No, it's definitely introduced in your patches:
>>
>> -                       if (e->type->icq_cache && rq_ioc(bio))
>> -                               blk_mq_sched_assign_ioc(rq, bio);
>> +                       if (e->type->icq_cache)
>> +                               blk_mq_sched_assign_ioc(rq);
>>
>> Please run blktests on a series. Always. There's no excuse not to.
> 
> By the way, should I send an updated patch 2 to include your fix ?
> Or will you add an incremental fix ?

I had to add the incremental fix, I already merged your patches
earlier. It's all pushed out now.

-- 
Jens Axboe

