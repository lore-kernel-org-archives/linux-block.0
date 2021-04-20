Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8637CC43461
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 20:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BDC9613E5
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 20:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhDTUez (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:34:55 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:45724 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbhDTUez (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 16:34:55 -0400
Received: by mail-lf1-f54.google.com with SMTP id g8so63500169lfv.12;
        Tue, 20 Apr 2021 13:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ds+wc9pnh7F3tBBzIxDeZmH5MsAIktazgVxa1GWvZ9o=;
        b=j1w01EHvrnNQ2sS6OZAa2Xt3qTpglj9zaeN0mshMgbelm/cykIniXlB8KYUs9QVJ24
         bbTjKPCnT371LjP9SuwMQ4C8ca8D9npWVLUA5bw8eve/Y00HScHeGxNP/+CDMbvIeLZ0
         NvabECFthrPbkTGyJHv6E+E+g+oeJaKP0LnCwvJbCKu+cBSqtjoRSsC1aWV+Mj3UfeK+
         dx5izwiqjciA2aEtGgcOxLGjil7xMke1gCP894PDLH6Kx0FpOu3RoWTcGfwZHHtSmvQT
         fEA0vWcrzgPOQK2A04MD71RxYER4ZdXsr9v3K5RWVKPD4yhn3B3+lmwkvWgT81NmmzQh
         Ze0g==
X-Gm-Message-State: AOAM533vMllsBKjcrw9/KNOSE4xo+29EW4/QMPO8O2mBIy0u/95AG/dJ
        a5qRyeKvbcJk53MH/y6kv3IvXmkzFBA=
X-Google-Smtp-Source: ABdhPJxMREVqOXFw/E8wWTU78/qZhu9xphsz3z1WsT8m7nBl5TaC22dM5cBdHUXAupMPJ0SVoL25FA==
X-Received: by 2002:a05:6512:228f:: with SMTP id f15mr4724235lfu.42.1618950860712;
        Tue, 20 Apr 2021 13:34:20 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id a25sm2333570ljp.38.2021.04.20.13.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 13:34:20 -0700 (PDT)
Subject: Re: [PATCH 032/141] floppy: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <ede7ffddba64f621150f8f5c5f2b8f080b560903.1605896059.git.gustavoars@kernel.org>
 <2599e39d-faec-01fc-e835-16a5c96082d6@embeddedor.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <46d619c5-3b79-ad2a-196e-2b9180cbed82@linux.com>
Date:   Tue, 20 Apr 2021 23:34:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2599e39d-faec-01fc-e835-16a5c96082d6@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Sorry, this was missed somehow.

I would rewrite it to something more simple instead of adding fallthrough.

What about?

--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2123,12 +2123,14 @@ static void set_floppy(int drive)
 static void format_interrupt(void)
 {
        switch (interpret_errors()) {
+       case 0:
+               cont->done(1);
+               break;
        case 1:
                cont->error();
+               break;
        case 2:
                break;
-       case 0:
-               cont->done(1);
        }
        cont->redo();
 }

On 4/20/21 11:25 PM, Gustavo A. R. Silva wrote:
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
>>
