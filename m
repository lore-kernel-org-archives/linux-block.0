Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06D3C433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 10:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9528661354
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 10:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbhDLKU6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 06:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbhDLKUm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 06:20:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F17EC06174A
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 03:20:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bx20so13235747edb.12
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 03:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2sbKiGrB8YoAZxs5BogjkkYEwaFJJeJeaYHJx6e+ubc=;
        b=B2Dgm9YsV9+6JfvdUivIfWALhxdxIDq68rMLubbwC52L7N0XLgBtTDrP/633paOHQU
         SNtxl7QFKlzbXtPt6l8ED/TxnjKW6090tWrkNfKAB90dD4vv1aJ0DDV7FrEH1U/5qstR
         yagAhdsk3wEaH6A0FWpGDgzZeH6iuZ7UYmBaLWb9q5tccBJIXppRD+eElGOk0WIVq4Qx
         XnTfaIi3y4zIpmrf7x7ju2ccvQDk0NSyHrKME6xZBbLwSJYBknRns6QDLMD0XYTAEAnt
         OP9Zwy6W/yYfCw5bc9RFSTtJn37avLV08hQL4Z6+aU83XYPjWRhkh2iEEUhqKMXKQ00m
         ZWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2sbKiGrB8YoAZxs5BogjkkYEwaFJJeJeaYHJx6e+ubc=;
        b=ePdoecqSXUXWpmCSmhYE6vvHCysMd9lq/jk03RvEFkWYzUW3QEAZ2XzFSeByWNm9MK
         PcF0UUc4sjM7mmi/tDJOAGkCZvUJhaBVYrp3xrRPWQZPJLLHPiDgoc2bE13uQp9TUvbv
         c0SXarRmb72d1PlsF0w1dg5QSLsKzSnQYblYznox2fs0FJoYjjGoDeXQe2Nn+Vk1AAnm
         07p7fXuoynbNpZ3qHSNlf3xuF8C3LF5kzscREHM4hO+Cv/6Cs0GjKNSokU4oPhj+kZQo
         0jRBpmoU7SkUHh+A5idzhzs3YEj0k/+Zi5f8YxgvklxmRDHtEpXioDzDHGU6f/CM+7Go
         LT5g==
X-Gm-Message-State: AOAM530orQ+jgDkFEk5FQk1AXL2Xzirl8i5X6otm8iPufyVITmfRipHI
        4sio5l3pSBVpQ7G4/2uQl0y61Q==
X-Google-Smtp-Source: ABdhPJzZtmGwZe9mc56z2gc8pUTvoTddLIYxpATxbe7+AeiJZ5VixK2wouduyixplQw3AHxG4apKNA==
X-Received: by 2002:aa7:d917:: with SMTP id a23mr19584317edr.80.1618222820781;
        Mon, 12 Apr 2021 03:20:20 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id s17sm5338690ejx.10.2021.04.12.03.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 03:20:20 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: deprecated OCSSD support and schedule it for
 removal in Linux 5.15
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210412081257.2585860-1-hch@lst.de>
 <52ecf402-1361-e5a5-8c58-30d846d33541@lightnvm.io>
 <766257ca-4dd7-e20b-aa79-6ac3984567d4@lightnvm.io>
 <20210412094938.afyxzspcohw63zup@mpHalley.localdomain>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <3bf88f25-d06d-5b95-7eff-dfb8f78bc389@lightnvm.io>
Date:   Mon, 12 Apr 2021 12:20:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210412094938.afyxzspcohw63zup@mpHalley.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/04/2021 11.49, Javier González wrote:
> On 12.04.2021 11:26, Matias Bjørling wrote:
>> On 12/04/2021 11.21, Matias Bjørling wrote:
>>> On 12/04/2021 10.12, Christoph Hellwig wrote:
>>>> Lightnvm was an innovative idea to expose more low-level control 
>>>> over SSDs.
>>>> But it failed to get properly standardized and remains a 
>>>> non-standarized
>>>> extension to NVMe that requires vendor specific quirks for a few 
>>>> now mostly
>>>> obsolete SSD devices.  The standardized ZNS command set for NVMe 
>>>> has take
>>>> over a lot of the approaches and allows for fully standardized 
>>>> operation.
>>>>
>>>> Remove the Linux code to support open channel SSDs as the few 
>>>> production
>>>> deployments of the above mentioned SSDs are using userspace driver 
>>>> stacks
>>>> instead of the fairly limited Linux support.
>>>>
>>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>> ---
>>>>   drivers/lightnvm/Kconfig | 4 +++-
>>>>   drivers/lightnvm/core.c  | 2 ++
>>>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
>>>> index 4c2ce210c1237d..04caa0f2d445c7 100644
>>>> --- a/drivers/lightnvm/Kconfig
>>>> +++ b/drivers/lightnvm/Kconfig
>>>> @@ -4,7 +4,7 @@
>>>>   #
>>>>     menuconfig NVM
>>>> -    bool "Open-Channel SSD target support"
>>>> +    bool "Open-Channel SSD target support (DEPRECATED)"
>>>>       depends on BLOCK
>>>>       help
>>>>         Say Y here to get to enable Open-channel SSDs.
>>>> @@ -15,6 +15,8 @@ menuconfig NVM
>>>>         If you say N, all options in this submenu will be skipped 
>>>> and disabled
>>>>         only do this if you know what you are doing.
>>>>   +      This code is deprecated and will be removed in Linux 5.15.
>>>> +
>>>>   if NVM
>>>>     config NVM_PBLK
>>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>>> index 28ddcaa5358b14..4394f47c81296a 100644
>>>> --- a/drivers/lightnvm/core.c
>>>> +++ b/drivers/lightnvm/core.c
>>>> @@ -1174,6 +1174,8 @@ int nvm_register(struct nvm_dev *dev)
>>>>   {
>>>>       int ret, exp_pool_size;
>>>>   +    pr_warn_once("lightnvm support is deprecated and will be 
>>>> removed in Linux 5.15.\n");
>>>> +
>>>>       if (!dev->q || !dev->ops) {
>>>>           kref_put(&dev->ref, nvm_free);
>>>>           return -EINVAL;
>>>
>>> Thanks, Christoph.
>>>
>>> I'll send it to Jens with today's lightnvm PR.
>>
>> Javier, can I add your reviewed-by?
>>
>
> Yes, please.
>
> I'll crack a beer and cheer on it tonight. Good times :)
>
> Javier

Thank you.

