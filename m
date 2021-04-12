Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F6CC433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594586128A
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbhDLJba (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbhDLJ0g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 05:26:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D349C061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 02:26:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bx20so13049346edb.12
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 02:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Zq6SzHAm3RCM5GyicGRVZyYMAiAaSoDTa2/IPNgAZCg=;
        b=VJEJli/YmKEoboEU7bmA8IIevz4AciNwN+egJpzaLtpzWsNrc308boHUAwIBZpimhd
         PgB1niK4vagyyiT/oNdzxez8AqAuMEY0NlkZM/dN055NoIBR8f1HNSPG7/ngraOmM7KX
         4syMnjdAWJ1ueinRj1Vyt+ZsmbzuPW3I0+Tf2yHfbn0BHUUp3aSDztMIv8+Zn3TmtciV
         oe35ll/7IB7M6V5lSq+OV2oKwySi/QoyViKCrdsZ9uPvD6dRNWYmEcS0JuA+XG88aMas
         7x5ZuwlvbqwbiGnE6JvprSRZwnfHWG0lwm2f8K7fiXNnqhCFeeTRpjXbY77gn/3fM1yZ
         9cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Zq6SzHAm3RCM5GyicGRVZyYMAiAaSoDTa2/IPNgAZCg=;
        b=AD3B2g1fd4m6Qh/J0s8/JOFlqMsRIOXRNYtCKk7Pce4CMRucWpCY3ixq8Rp9HDwK3O
         XiJqZlZgAjgF/tY2ywGpRfKTOs6AJZjUzxZkiOl9NxsOZMBhKzZTgWnOTpjThsK3gRl2
         dmAnEvCFJWRq/Cbf2D2qBE7wx3kiuNryo9k2Wki0bauIaVuYAAwhWLovvsqZu7Q3XoW+
         l4PH7CFLvlDI8TIq8Qc3zKw+ezsIrc3leyEK/OkpsKvVmByotCfKEziIU3vY2FAp29Sd
         64m1j5PSv3NvK2NTd1/CMECa+KoqnUCuzSJRTdmHxBDieZRHAlcObK0yezSJ/5ACfbZo
         PEng==
X-Gm-Message-State: AOAM531c1zZVRv+Yb58T1Kuk1XgAd6unrquAnff4kpWYpHBHwwxys1mX
        vDeakRl+Pr9WneebtIf/jVW45A==
X-Google-Smtp-Source: ABdhPJzeI6cNp7Qa3gKMGM8vTCwxQig0Bi7cmjH52gDYxJ4v1s0F1fux5V53xrPGrst6uuPbstpNzw==
X-Received: by 2002:a05:6402:506:: with SMTP id m6mr27494810edv.157.1618219575833;
        Mon, 12 Apr 2021 02:26:15 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id n13sm1689950ejx.27.2021.04.12.02.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 02:26:15 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: deprecated OCSSD support and schedule it for
 removal in Linux 5.15
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210412081257.2585860-1-hch@lst.de>
 <52ecf402-1361-e5a5-8c58-30d846d33541@lightnvm.io>
Message-ID: <766257ca-4dd7-e20b-aa79-6ac3984567d4@lightnvm.io>
Date:   Mon, 12 Apr 2021 11:26:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <52ecf402-1361-e5a5-8c58-30d846d33541@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/04/2021 11.21, Matias Bjørling wrote:
> On 12/04/2021 10.12, Christoph Hellwig wrote:
>> Lightnvm was an innovative idea to expose more low-level control over 
>> SSDs.
>> But it failed to get properly standardized and remains a non-standarized
>> extension to NVMe that requires vendor specific quirks for a few now 
>> mostly
>> obsolete SSD devices.  The standardized ZNS command set for NVMe has 
>> take
>> over a lot of the approaches and allows for fully standardized 
>> operation.
>>
>> Remove the Linux code to support open channel SSDs as the few production
>> deployments of the above mentioned SSDs are using userspace driver 
>> stacks
>> instead of the fairly limited Linux support.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   drivers/lightnvm/Kconfig | 4 +++-
>>   drivers/lightnvm/core.c  | 2 ++
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
>> index 4c2ce210c1237d..04caa0f2d445c7 100644
>> --- a/drivers/lightnvm/Kconfig
>> +++ b/drivers/lightnvm/Kconfig
>> @@ -4,7 +4,7 @@
>>   #
>>     menuconfig NVM
>> -    bool "Open-Channel SSD target support"
>> +    bool "Open-Channel SSD target support (DEPRECATED)"
>>       depends on BLOCK
>>       help
>>         Say Y here to get to enable Open-channel SSDs.
>> @@ -15,6 +15,8 @@ menuconfig NVM
>>         If you say N, all options in this submenu will be skipped and 
>> disabled
>>         only do this if you know what you are doing.
>>   +      This code is deprecated and will be removed in Linux 5.15.
>> +
>>   if NVM
>>     config NVM_PBLK
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index 28ddcaa5358b14..4394f47c81296a 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -1174,6 +1174,8 @@ int nvm_register(struct nvm_dev *dev)
>>   {
>>       int ret, exp_pool_size;
>>   +    pr_warn_once("lightnvm support is deprecated and will be 
>> removed in Linux 5.15.\n");
>> +
>>       if (!dev->q || !dev->ops) {
>>           kref_put(&dev->ref, nvm_free);
>>           return -EINVAL;
>
> Thanks, Christoph.
>
> I'll send it to Jens with today's lightnvm PR.

Javier, can I add your reviewed-by?

Thank you.

