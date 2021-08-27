Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EC1C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 00:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578E560F4F
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 00:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243843AbhH0AEQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 20:04:16 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:33666 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhH0AEL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 20:04:11 -0400
Received: by mail-pf1-f173.google.com with SMTP id u6so3515214pfi.0
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 17:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qrFdikOrnYHtmJZBCdqGMdRie8fgZv1RBkgnLFVxubk=;
        b=mBsxkGLvNJffi6PEgtuHnxQ3r60UQP77c6N2/01Dnr/iKqaD0jK4qM0d7ZSD0p8aQH
         hKUVu/LIP5ObMEs9lT51CO6NRi0nU0okjI79SmBkAZIngwdD4XcSlZ0hPEadF9tTkhY/
         dAE8LgcUE6tyYH2KnxK09eC0KgsoAGdq+nU75EEC+UzvmmKRgJLbstrsr3K47K3qWkIN
         at3KEz2ZKxN6GlkW2K9jQUTGsNxi2D/1GazWie93htJe96NPI0kDGjmaR896vmoj9Iea
         +/JyJIvaxDf9AeqUc74CMplifzFQ7FSwI38JsO8PSAZtcbqei83+ZgkUTYizmg4sYSZV
         yNXg==
X-Gm-Message-State: AOAM5335Khdkkpuo7xCS4tAg5QwppsKZmhY3I1TBNaIKYKotsgrlqwxz
        4omyICB4J9ZXZ7N2k0UcXfnPecMiKLg=
X-Google-Smtp-Source: ABdhPJzD4OzI7QcRA0xhsh8O4P27upf23XXatHig96RlArr961CHtNBKrkxjUh/8XL748SMoqNlcxw==
X-Received: by 2002:a63:c147:: with SMTP id p7mr5442610pgi.247.1630022603025;
        Thu, 26 Aug 2021 17:03:23 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:22e3:6079:e5ce:5e45? ([2601:647:4000:d7:22e3:6079:e5ce:5e45])
        by smtp.gmail.com with ESMTPSA id b20sm4010492pfl.9.2021.08.26.17.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 17:03:22 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Speed up the dispatch of low-priority
 requests
To:     Jens Axboe <axboe@kernel.dk>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20210826144039.2143-1-thunder.leizhen@huawei.com>
 <fc1f2664-fc4f-7b3e-5542-d9e4800a5bde@acm.org>
 <537620de-646d-e78e-ccb8-4105bac398b3@kernel.dk>
 <82612be1-d61e-1ad5-8fb5-d592a5bc4789@kernel.dk>
 <59c19a63-f321-94e8-cb31-87e88bd4e3d5@acm.org>
 <0ef7865d-a9ce-c5d9-ff7f-c0ef58de3d21@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2332cba0-efe6-3b35-0587-ee6355a3567d@acm.org>
Date:   Thu, 26 Aug 2021 17:03:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0ef7865d-a9ce-c5d9-ff7f-c0ef58de3d21@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/21 4:51 PM, Jens Axboe wrote:
> On 8/26/21 5:49 PM, Bart Van Assche wrote:
>> On 8/26/21 11:45 AM, Jens Axboe wrote:
>>> Just ran a quick test here, and I go from 3.55M IOPS to 1.23M switching
>>> to deadline, of which 37% of the overhead is from dd_dispatch().
>>>
>>> With the posted patch applied, it runs at 2.3M IOPS with mq-deadline,
>>> which is a lot better. This is on my 3970X test box, so 32 cores, 64
>>> threads.
>>
>> Hi Jens,
>>
>> With the script below, queue depth >= 2 and an improved version of
>> Zhen's patch I see 970 K IOPS with the mq-deadline scheduler in an
>> 8 core VM (i7-4790 CPU). In other words, more IOPS than what Zhen
>> reported with fewer CPU cores. Is that good enough?
> 
> That depends, what kind of IOPS are you getting if you revert the
> original change?

Hi Jens,

Here is an overview of the tests I ran so far, all on the same test
setup:
* No I/O scheduler:               about 5630 K IOPS.
* Kernel v5.11 + mq-deadline:     about 1100 K IOPS.
* block-for-next + mq-deadline:   about  760 K IOPS.
* block-for-next with improved mq-deadline performance: about 970 K IOPS.

Bart.


