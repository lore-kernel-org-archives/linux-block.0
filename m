Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6682C433E0
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 13:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8401D6522B
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 13:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhCINhA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 08:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhCINg6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 08:36:58 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFF9C06174A;
        Tue,  9 Mar 2021 05:36:58 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so5208858pjg.5;
        Tue, 09 Mar 2021 05:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pN5yQKRfRTbXA/8iCmu4wSQChv6isl6+ebWvSdzyiJk=;
        b=B8KCBTrMK6yUjH7O0yBGsWSXJ4qIhuE96sFLL1IKDTRj/0qbne7tfglIO/M2PKwPXu
         +oU+CbtA+xBtGOVOackja6NJYC0fFr8XTQqTU0x7/Zed9FRC66L+kgH1qWIsq0D/gxmC
         DtW1IHJ9QG3YECxJ6tyPG8Hda+tL6I2jJy0RtUSwPKW+/Pl7QlyK95TC3yTamNw0DuFx
         ZoV7Nr58W7DRFLYQp7WkdRKgNvEWsaBQPLVNaENBX/9nvrIQcXuJSMCu+NDvhzmWy7FC
         wNsdyNWNPBOIQjHjA+g7cgnUI1UYB62H6/sv8mx7pPIdGDXxCFhgl3bikbcCN3L/A1hd
         gI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pN5yQKRfRTbXA/8iCmu4wSQChv6isl6+ebWvSdzyiJk=;
        b=skX8+lqNgPwhmTB+3h9XpX4Eigg7j2dJ2ddk4d+lAAhG8aN36pob7oj9zqieb2UxzM
         BX/S6V8G7PJ0vFT7YzJVsRWqUfVcVhjd0gy/jnAvMgwFWjQW+VIiXL9JVi2JTuRN17LM
         29EjDziS8PRLJp1ij2LMsPVOtxjRrgyJ1gxbSYIcHev/ZfOdLeKR8FGKMMQVpg9HlN8X
         86F2SrkYx76f4VKMUW5Gg1SYQS1oU3EiZ3cSPE+XAI0Q0IS69ZLXRQY+JaXS4/RLjB1/
         sevk05EQRC1pL2i588me2EfMmiB63n6Mg91sjwIiZO1NxDIbPj0a7laXQ9ObPb+a5mHV
         l1Zw==
X-Gm-Message-State: AOAM530dwrSB7I7d0gOT9vLs294BHA3AhOGPlgW3vv7fJ7FAFVv6KHzn
        Y8FgvEZXiK95M8ihQ868asMSTkMCtutiIGM5
X-Google-Smtp-Source: ABdhPJzij+H9Gt4O/r0DW79ziF+FSoYp5/MhL4jOu1RJoFap17YQrn1zJFZ04ozi1ZHVU/KxEUawHg==
X-Received: by 2002:a17:903:31c6:b029:e5:d0a4:97cc with SMTP id v6-20020a17090331c6b02900e5d0a497ccmr25494251ple.52.1615297018004;
        Tue, 09 Mar 2021 05:36:58 -0800 (PST)
Received: from [10.160.0.34] ([45.135.186.124])
        by smtp.gmail.com with ESMTPSA id 197sm13324536pfc.1.2021.03.09.05.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 05:36:57 -0800 (PST)
Subject: Re: [PATCH] block: keyslot-manager: fix error return code of
 blk_ksm_evict_key()
To:     Satya Tangirala <satyat@google.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210309091812.26029-1-baijiaju1990@gmail.com>
 <YEdf6utvWih7mToY@google.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <4285b8ed-585c-2290-044b-8b6a3c6c0640@gmail.com>
Date:   Tue, 9 Mar 2021 21:36:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YEdf6utvWih7mToY@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/3/9 19:45, Satya Tangirala wrote:
> On Tue, Mar 09, 2021 at 01:18:12AM -0800, Jia-Ju Bai wrote:
>> When blk_ksm_find_keyslot() returns NULL to slot, no error return code
>> of blk_ksm_evict_key() is assigned.
>> To fix this bug, err is assigned with -ENOENT in this case.
>>
>> Fixes: 1b2628397058 ("block: Keyslot Manager for Inline Encryption")
>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   block/keyslot-manager.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
>> index 2c4a55bea6ca..4dd5da0645bc 100644
>> --- a/block/keyslot-manager.c
>> +++ b/block/keyslot-manager.c
>> @@ -375,8 +375,10 @@ int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
>>   
>>   	blk_ksm_hw_enter(ksm);
>>   	slot = blk_ksm_find_keyslot(ksm, key);
>> -	if (!slot)
>> +	if (!slot) {
>> +		err = -ENOENT;
>>   		goto out_unlock;
>> +	}
>>   
>>   	if (WARN_ON_ONCE(atomic_read(&slot->slot_refs) != 0)) {
>>   		err = -EBUSY;
>> -- 
>> 2.17.1
>>
> This function was deliberately designed to return 0 on success *and also*
> if there's no keyslot found with the specified key - i.e. it returns 0 if
> the key is no longer programmed into the keyslot manager, which is what the
> callers care about, so I don't think there's a bug here.

Thanks for the reply and explanation!
It seems like a false positive here, and I am sorry for this false report.


Best wishes,
Jia-Ju Bai
