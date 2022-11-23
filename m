Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EB1C433FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 00:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiKWAOf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 19:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbiKWAOc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 19:14:32 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C70BD53BD
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 16:14:31 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y10so14001340plp.3
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 16:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSXez7TMqEXPVH18DMil2V+wMo2ZAq8fU8n9Svrm0YU=;
        b=ttIttDPZTykCFPR3yUs+dkffd67+C/A5MJ4fjN6FD+7T43G1YL8Nk6mcVeB9JjVkXw
         gi32sFfDUwtdO5dpXDeb6QBf2ncMZm9XF8fJGMkN+1ZgADqJ8mjuxQeYoQ13AG+PRwID
         h0N+LcbcG84cYpzmSdiSPiimEhxTrl/3izqU9Oki/3QOcg9DwKHTId350Q05Xu/5q03W
         +RzHliDUY0k/H2L7qOGzhs5f+mLdOuKqxRlwV1RAfI1afEZ1ol4mDSxmGEnUF4zV6lYS
         C9LS/8OzmHlDuxle0r1MBda7KUlW6NkHgcdYImd+cbzJWGzZbf5s5Z6jIbhuljCi95bI
         Xc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSXez7TMqEXPVH18DMil2V+wMo2ZAq8fU8n9Svrm0YU=;
        b=b1yUjf4ekO1puimxg4QbpifVTPMEgh6CPJI5UasCmwjGMx4Uz9wQcS2npqTT7tBQsv
         xtk60qC6mVpzgSAe3E3lzVy3qBeAqHbnpLgKbERc49HeB2ZOD2kzXJXUP1AkO3yx+Y44
         28s1j7lzF69kJ38+7y3Dc5+yYwSv3U+5vj+sSHeCQklSz6VN3gyia51Optl3Y3wP1Ach
         7iG2CdGhZCqAH3NMLl3D7fKod6Kwg9/SpkAmurr7Atn9xGt9xoLMTzxlHz0TgSndPHr7
         Dypj1shRAjdwhrgw6fZAW2aqSnNplCczaaNbUJKUdCV7p0yCaXps9pQYY9+qBXCGf1Jq
         Et0Q==
X-Gm-Message-State: ANoB5pk6xuvgyCL/6UFbsTgPDs4/YF9TBcSGt3pLouGfPEFkjykpAL/o
        CqkX6TvkyQ/N+Kv3NWjl5I+UsA==
X-Google-Smtp-Source: AA0mqf6GVtLxBNKUS6oMjDNlawwIOIT8MPUoiUGJO7VE6o0/Tx/aXX+y/u3LzT2gGYwHKQocQeQDMA==
X-Received: by 2002:a17:902:7b96:b0:188:b0db:cd5d with SMTP id w22-20020a1709027b9600b00188b0dbcd5dmr7458453pll.104.1669162470773;
        Tue, 22 Nov 2022 16:14:30 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b00186985198a4sm12753838plg.169.2022.11.22.16.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 16:14:30 -0800 (PST)
Message-ID: <1f52ccb1-c357-a2a0-ef9d-48d7e2eb51f8@kernel.dk>
Date:   Tue, 22 Nov 2022 17:14:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 4/5] blk-iocost: fix sleeping in atomic context
 warnning
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221104023938.2346986-1-yukuai1@huaweicloud.com>
 <20221104023938.2346986-5-yukuai1@huaweicloud.com>
 <Y3K8MSFWw8eTnxtm@slm.duckdns.org>
 <3da991c6-21e4-8ed8-ba75-ccb92059f0ae@huaweicloud.com>
 <Y306xJV6aNXd94kb@slm.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y306xJV6aNXd94kb@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/22/22 2:10 PM, Tejun Heo wrote:
> On Thu, Nov 17, 2022 at 07:28:50PM +0800, Yu Kuai wrote:
>> Hi, Tejun!
>>
>> 在 2022/11/15 6:07, Tejun Heo 写道:
>>
>>>
>>> Any chance I can persuade you into updating match_NUMBER() helpers to not
>>> use match_strdup()? They can easily disable irq/preemption and use percpu
>>> buffers and we won't need most of this patchset.
>>
>> Does the following patch match your proposal?
>>
>> diff --git a/lib/parser.c b/lib/parser.c
>> index bcb23484100e..ded652471919 100644
>> --- a/lib/parser.c
>> +++ b/lib/parser.c
>> @@ -11,6 +11,24 @@
>>  #include <linux/slab.h>
>>  #include <linux/string.h>
>>
>> +#define U64_MAX_SIZE 20
>> +
>> +static DEFINE_PER_CPU(char, buffer[U64_MAX_SIZE]);
>> +
>> +static char *get_buffer(void)
>> +{
>> +       preempt_disable();
>> +       local_irq_disable();
>> +
>> +       return this_cpu_ptr(buffer);
>> +}
>> +
>> +static void put_buffer(void)
>> +{
>> +       local_irq_enable();
>> +       preempt_enable();
>> +}
>> +
>>
>> Then match_strdup() and kfree() in match_NUMBER() can be replaced with
>> get_buffer() and put_buffer().
> 
> Sorry about the late reply. Yeah, something like this.

Doesn't local_irq_disable() imply preemption disable as well?

-- 
Jens Axboe


