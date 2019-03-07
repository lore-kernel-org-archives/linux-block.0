Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0474C10F03
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 15:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B23C20652
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 15:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P5/EiTyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCGP7t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:59:49 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40903 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfCGP7s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 10:59:48 -0500
Received: by mail-it1-f195.google.com with SMTP id l139so16501026ita.5
        for <linux-block@vger.kernel.org>; Thu, 07 Mar 2019 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YR2PiZD6BHr8hgVqVgUGtVxLkfx0p0sFvLP49y5X5EI=;
        b=P5/EiTyU4KfgnW2+IBT7ZH5KGDuij6zl65bbE5KcMtmJWTWMR2Ui7E7uFQ2ss9mDTw
         ryFFeSc5FcaIb59hlJgyi1cXKO/QH8ZQLbfUOH2FX9xPrZr3q0fmgPfxPenrJUL5UXg4
         uqZdAML7UD/m2bahGJDnkKQfA73U94svTUhYwHSgiy9VQwxLRbs3rq7Zfk9GYelDsR3I
         QtZq3G9g9qD1UNBpzhgn76A6P5bdZMPkPc4kyGRhA5aaGgzUk/vr+1gzuvsKUn/WHbla
         mpHeKlBTEQSmOyQ5TM0Nuq2//uCb/i3MuqkYztI3K6cXTH2P3ZXa6A5YaacLVYNikIu0
         2ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YR2PiZD6BHr8hgVqVgUGtVxLkfx0p0sFvLP49y5X5EI=;
        b=SGv4kjjQF822z4wXw/juXybSjQXjk8/mZ2O8rOnoBdkftodyAny/OEoVseeFr2FJGc
         rnVhwll6fdObfBHa/tSA8/6ue+BcuY01hPg3j9X1NqTiG4DZQPgB3uWleMjISzMLKoas
         SNZUvTUf4aSFzZxcPnAhZgnVL6pPsJextwcF92Og5abkDa9ZB5suOX1I9NFeznVUJ41F
         8F2LpFpUunfq3Fo54uORRKZgPj4oX52EnnRp8hvrAxnX2qqUY4S4pK+ad4zKyTbTHj9F
         nBiCRDWgXP3fnsGoa/v3B5oDUuFkUq+EGKODpukYUCCH5mc2EAfdMx8aumHlCvJsUkbN
         qXcg==
X-Gm-Message-State: APjAAAU1px3IftqS/7S6Hvfx9hs/JBOWPl3frBER8zOjUodtbTGL38sj
        PawWfvSSJTVi5xa68sPH08VFmUfUagrIeA==
X-Google-Smtp-Source: APXvYqxmvbSmWH8FSqy1YOBptTvP1Jy52VMXPnwHGvYyYDU/NCxcwDU+qN3Zu9EUcEonMK20GUp5zw==
X-Received: by 2002:a24:1c4d:: with SMTP id c74mr5540098itc.36.1551974387250;
        Thu, 07 Mar 2019 07:59:47 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x25sm259164ion.78.2019.03.07.07.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 07:59:46 -0800 (PST)
Subject: Re: [PATCH] pblk: fix max_io calculation
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190307121853.14503-1-javier@javigon.com>
 <8b13dcf3-4486-0e14-b718-417c7fc42a7b@lightnvm.io>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a2f98eea-2407-49ad-4ff6-c1e92762d2f8@kernel.dk>
Date:   Thu, 7 Mar 2019 08:59:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <8b13dcf3-4486-0e14-b718-417c7fc42a7b@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/19 8:57 AM, Matias Bjørling wrote:
> On 3/7/19 1:18 PM, Javier González wrote:
>> When calculating the maximun I/O size allowed into the buffer, consider
>> the write size (ws_opt) used by the write thread in order to cover the
>> case in which, due to flushes, the mem and subm pointers are disaligned
>> by (ws_opt - 1). This case currently translates into a stall when
>> an I/O of the largest possible size is submitted.
>>
>> Fixes: f9f9d1ae2c66 ("lightnvm: pblk: prevent stall due to wb threshold")
>>
>> Signed-off-by: Javier González <javier@javigon.com>
>> ---
>>
>> Matias: Can you apply this as a fix to 5.1. This is a case I missed when fixing
>> the wb threshold, which is also scheduled for 5.1
>>
>> Thanks,
>> Javier
>>
>>   drivers/lightnvm/pblk-rl.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
>> index b014957dde0b..a5f8bc2defbc 100644
>> --- a/drivers/lightnvm/pblk-rl.c
>> +++ b/drivers/lightnvm/pblk-rl.c
>> @@ -233,10 +233,15 @@ void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold)
>>   	/* To start with, all buffer is available to user I/O writers */
>>   	rl->rb_budget = budget;
>>   	rl->rb_user_max = budget;
>> -	rl->rb_max_io = threshold ? (budget - threshold) : (budget - 1);
>>   	rl->rb_gc_max = 0;
>>   	rl->rb_state = PBLK_RL_HIGH;
>>   
>> +	/* Maximize I/O size and ansure that back threshold is respected */
>> +	if (threshold)
>> +		rl->rb_max_io = budget - pblk->min_write_pgs_data - threshold;
>> +	else
>> +		rl->rb_max_io = budget - pblk->min_write_pgs_data - 1;
>> +
>>   	atomic_set(&rl->rb_user_cnt, 0);
>>   	atomic_set(&rl->rb_gc_cnt, 0);
>>   	atomic_set(&rl->rb_space, -1);
>>
> 
> Hi Jens,
> 
> If possible, could you please pick this one up for 5.1? It fixes a 
> previous patch that was introduced in 5.1 that should fix a stall, but 
> didn't quite catch it.

Applied

-- 
Jens Axboe

