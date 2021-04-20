Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A126C43460
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 20:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F18D613C4
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 20:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhDTUbF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbhDTUbF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 16:31:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3571BC06174A
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 13:30:32 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h15so8766413pfv.2
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I0EdX6Z/acORAf6ns8xMAuM0MoN9fdagShR1XPcLHTU=;
        b=AJydimSR/zhzpyQHNvRYem5HMAnHQ0P1xKF7UzFMcctjylEHZ5Kz3E9XtBtfyMFvxa
         XY0s+kKLfu+hcuIZSCAQTLCLgns6WwP+IS7Pa2b7Dijf5xxUNzluMyLi0Shmj1nHkwHY
         avneTJhJOZHYJiM7dL041Za5DnzDUMT2uO/s78XtgcMTgl0R08c5qmTJ+39V1/DcSLb+
         T6dOhjYxTvl5HB9TBoFaGcUz9j5ePwUGSLnsI9pDykprLhfokEDJ62IXyUPr0d4jT4K6
         NSSW6ziqXlAxyYcJXwAmvoyvq+iwZ6ZczM8fvURqIfsgNHQhq6rXTRh15U9xu7sj4D8v
         AdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I0EdX6Z/acORAf6ns8xMAuM0MoN9fdagShR1XPcLHTU=;
        b=X8hz4F7pA+Q9kw6WjXpbY5/L9tjex+egTgqdLmbMeBIbhb4gg79neMShdzGxgd9dJp
         qbUlHlOW0jjq47qSx+FVY/4tCP0BOO4j+rrgb/zooebi/1pi73di7ZSamtV1E4bTSiXP
         8wE3TSAzMW1f9xo1jtV8yTxaaDNaqqHxKnWWHb1NUiHeN2XufjCvfL4MW6qroPj1Jgse
         q/CcgnnnnFk8frjyVa6/A+BaAZbMcklHgR7jfYkuDmI3Y+MeV5cNmly9GxNXjIgWnzBd
         P/NnRA4A8BpoCOHBMgYufUmlgzLgW+WLZWgfwKHXeilKlpQpxO2vhJ5e6Ob8rWQVThKH
         4GzQ==
X-Gm-Message-State: AOAM530ypH+BPK2sc+9nsu9cf+xQptKSEww7I4LyK7rRQMrCbuIG85/8
        pQ2USP7fb/MOcq392gEtM3+eEA==
X-Google-Smtp-Source: ABdhPJyCmkC6yXT7iH56sV9igVSdTQzBpbc2WSWDXUzbgSce6jWtBo/9Lb94mV+YrBmaqSevSn73Mg==
X-Received: by 2002:a63:c450:: with SMTP id m16mr18326523pgg.333.1618950631599;
        Tue, 20 Apr 2021 13:30:31 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b5sm198960pgb.0.2021.04.20.13.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 13:30:31 -0700 (PDT)
Subject: Re: [PATCH 032/141] floppy: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <ede7ffddba64f621150f8f5c5f2b8f080b560903.1605896059.git.gustavoars@kernel.org>
 <2599e39d-faec-01fc-e835-16a5c96082d6@embeddedor.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <47bcd36a-6524-348b-e802-0691d1b3c429@kernel.dk>
Date:   Tue, 20 Apr 2021 14:30:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2599e39d-faec-01fc-e835-16a5c96082d6@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/21 2:25 PM, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?
> 
> Thanks
> --
> Gustavo
> 
> On 11/20/20 12:28, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>> by explicitly adding a fallthrough pseudo-keyword in places where the
>> code is intended to fall through to the next case.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/block/floppy.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
>> index 7df79ae6b0a1..21a2a7becba0 100644
>> --- a/drivers/block/floppy.c
>> +++ b/drivers/block/floppy.c
>> @@ -2124,6 +2124,7 @@ static void format_interrupt(void)
>>  	switch (interpret_errors()) {
>>  	case 1:
>>  		cont->error();
>> +		fallthrough;
>>  	case 2:
>>  		break;
>>  	case 0:

I wonder about the consistency of the patches. The one I just applied
for libata adds a break, this one annotates fallthrough. But the cases
are really 100% the same. Why aren't the changes consistent? Both are
obviously fine, but for identical cases it seems odd that they differ.

IMHO, adding a break makes more sense. Annotate the fallthrough if the
two cases share work that needs to be done, as then that solution makes
sense.

-- 
Jens Axboe

