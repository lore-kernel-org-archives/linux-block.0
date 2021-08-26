Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80227C432BE
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 23:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A4E60EBA
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 23:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhHZXwB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 19:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhHZXwB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 19:52:01 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40307C061757
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 16:51:13 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y18so6167319ioc.1
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9lt+JYE+cgMyyJXz9REO9WWyxY4NGB0h/zyFB1xx8Sg=;
        b=Xp49W2e/mpqdfpR4X33JcNfhkF/bi0snMCZ6itiJ6Lw0+4/FBZOISKD03rbMMsH867
         Mm8FMLFA112ctZkAz/7MnCzmP9wCCCJcEeXzOUpyFzmVq3QuLZRLGCOT5pKSki1fCnoS
         ceNSxsxvE0ByLg6r09eERmgzgn522/OE5AzttLRQxEu2MAIvck9bX5rVMraNezMaEtID
         /99kH0WmxOWnDTB9DTYnbhbAaEuhhgtR7iettt/HXKHo2SUn+4YAg7dlrImm/Mdym7Vs
         CjeAVwdzQwd7Tsgdd5oY5H+cGqyvVLXv4OjZJeaqQebAgIznNonUELIGDlGSxN4gnfdf
         HihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9lt+JYE+cgMyyJXz9REO9WWyxY4NGB0h/zyFB1xx8Sg=;
        b=QTkup4DOaHmRYjE5+ZEzhXzxRX4eQ8BHusvl1zr74QKQxWgXEXAMRWpNVL7F7EgLMr
         35429be2mnvWGdZi+Qttc1Ri8tWcX1uyChRMxppkwbQoVOeGCN/eOg5ly5DGIwkDtl1j
         3+kqAPYpd0G77N2FzjoEoGECLjirX7Mo+WlB+hucrvPxKV3VgOIFCP54UTDn5DlDImBS
         p0WMd50xH6sb1q21w4akN5SRREQ4hZ1ybn7LAREfFXkr36ml9eYXNUWJy59/Fe4ewnoJ
         Lbxcf7uEovDiqYeWnA+rcQ33Kw9onb50W7dHifAnEAYoJkJ/nlxMQjmRuAM0si9Q3fhf
         aiQQ==
X-Gm-Message-State: AOAM532wEMOElBAN6gA3bysvD4RbulPnzsma9bq6eXYGE9aMvzPnmalQ
        XeZAFmLIzyn+JVLxd3IyovZL6g==
X-Google-Smtp-Source: ABdhPJzl47AokWsNflYgoHOWZOc4vty0vWcGrp2KRzJv6IVcSQC6h2ZGhYJOL2s03692A2oHLHX/Qg==
X-Received: by 2002:a6b:905:: with SMTP id t5mr4993149ioi.209.1630021872622;
        Thu, 26 Aug 2021 16:51:12 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i14sm926141iol.27.2021.08.26.16.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 16:51:12 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
To:     Bart Van Assche <bvanassche@acm.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
 <537620de-646d-e78e-ccb8-4105bac398b3@kernel.dk>
 <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
 <59c19a63-f321-94e8-cb31-87e88bd4e3d5@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0ef7865d-a9ce-c5d9-ff7f-c0ef58de3d21@kernel.dk>
Date:   Thu, 26 Aug 2021 17:51:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <59c19a63-f321-94e8-cb31-87e88bd4e3d5@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/21 5:49 PM, Bart Van Assche wrote:
> On 8/26/21 11:45 AM, Jens Axboe wrote:
>> Just ran a quick test here, and I go from 3.55M IOPS to 1.23M switching
>> to deadline, of which 37% of the overhead is from dd_dispatch().
>>
>> With the posted patch applied, it runs at 2.3M IOPS with mq-deadline,
>> which is a lot better. This is on my 3970X test box, so 32 cores, 64
>> threads.
> 
> Hi Jens,
> 
> With the script below, queue depth >= 2 and an improved version of
> Zhen's patch I see 970 K IOPS with the mq-deadline scheduler in an
> 8 core VM (i7-4790 CPU). In other words, more IOPS than what Zhen
> reported with fewer CPU cores. Is that good enough?

That depends, what kind of IOPS are you getting if you revert the
original change?

-- 
Jens Axboe

