Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DADC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 21:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176E1213F2
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 21:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfCRVc2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:32:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47047 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfCRVc1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 17:32:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id c18so15780253otl.13;
        Mon, 18 Mar 2019 14:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4BXC/lHg86GIdWhzmhI0EP9wZRbTvrvseoJ4Y49Ma28=;
        b=R5rBUTjWGBHcB4HrpJN9erJ5asvnKCJle+Jvbdvm0XooxjHYTIVBmNEDrJJEhvf8N/
         eD9NszR6MzNJvyuWE6Gf0sCpcLn1F7eEy8W6sQAxGP8xM2c82dqTjSLWQPzjguOz2qtF
         WuKkVAp5lzz2JcW8xDqgME9Zu2XLDsNIxhbz+8GvG8LAHQaPevkcaFcTyr2w9Lz8p//c
         7Kebj09Y/XTClUnrZz0p3nsQnC7wPa7prAiIesfsCSHRY2Q52N00lRIUSwi1uJOq7KOw
         ofGjg0dSLbbgKhLXiuR/r1arUoH+SrG05xoGHqI7BE6XuHQIumWd0ioUo4b/Qf19J4Aj
         KBcw==
X-Gm-Message-State: APjAAAXc2+6McW9yxJxS60WCWtv6GCkqoa7+BxTSLBodYe5nAhnogOXB
        PW2o7tf6938YMCXsUhEirczv3uhJ
X-Google-Smtp-Source: APXvYqytY+/2E6h2xxuASO8l5W1JZ5+B7523E8EO6/VP/wSO3kgLvweJCVjo+LMSEBDvUhKFQIX5ew==
X-Received: by 2002:a9d:624:: with SMTP id 33mr12224291otn.274.1552944746700;
        Mon, 18 Mar 2019 14:32:26 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id u201sm4320449oiu.2.2019.03.18.14.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 14:32:25 -0700 (PDT)
Subject: Re: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
To:     Yamin Friedman <yaminf@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tal Gilboa <talgi@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Idan Burstein <idanb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
 <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
 <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
 <50b3659d-fd88-85b0-755e-49565fbe98c2@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <78352f3a-7788-e4c3-8d53-7c0b7a63921b@grimberg.me>
Date:   Mon, 18 Mar 2019 14:32:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <50b3659d-fd88-85b0-755e-49565fbe98c2@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> I agree that blk is not the most successful name, we were trying to find
> something that would work for general storage applications. I think
> rdma_dim would work as it is completion based but then when we want to
> use it for nvme it will probably require code duplication.

Lets worry about reuse NVMe when it is actually applicable.

>> Also in the internal review Yamin added a table that summarize all the
>> testing that were done using NVMeoF (I guess it somehow didn't get to
>> this RFC).
>>
>> I guess we can do the same for iSER to get more confidence and then
>> set both to create modifiable cq (if HCA supports, of course).
>>
>> Agreed ?
>>
> I think that adding a flag in create_cq will be less clean as it will
> require more work for anyone writing applications that should not have
> to consider this feature.
> 
> Based on the results I saw during testing I would set it to work by
> default as I could not find a use case where it significantly reduces
> performance and in many cases it is a large improvement. It should be
> more of an opt out situation.

By detailed performance results I meant:
1. Full latency histogram for QD=1 both for single queue and multi-queue
(including max, 99.99% and 99.999% percentiles)
2. latency vs. IOPs graph/table for both single queue and multi-queue
3. At least some measurement/analysis of how well the algorithm is
    adapting to workload change dynamically and how quickly.
4. Test also with real NVMe devices.

Also, we need to separate the host side moderation and the target
side moderation to understand if/how they effect each other.

Its very easy to show that for high stress workloads you can get an
improvement as obviously there is a clear win for interrupt moderation,
however, if this was the only metric that is interesting, we wouldn't
need it to be adaptive.

As I said before, this adds entropy to the equation which in certain use
cases can make more harm than good, and we need to quantify where is the
impact and understand how important they are compared to the extremely
niche use-case of a single host pushing 2M-8M IOPs.

> Performance improvement (ConnectX-5 100GbE, x86) running FIO benchmark over
>       NVMf between two equal end-hosts with 56 cores across a Mellanox switch
>       using null_blk device:
> 
>       IO READS before:
>       blk size | BW      | IOPS | 99th percentile latency
>       512B     | 3.2GiB  | 6.6M | 1549  usec
>       4k       | 7.2GiB  | 1.8M | 7177  usec
>       64k      | 10.7GiB | 176k | 82314 usec

I've seen this before, why are we not getting 100Gb/s for 4k with CX5?
I recall we used to get it with CX4.

>       IO READS after:
>       blk size | BW      | IOPS | 99th percentile latency
>       512B     | 4.2GiB  | 8.6M | 1729   usec
>       4k       | 10.5GiB | 2.7M | 5669   usec
>       64k      | 10.7GiB | 176k | 102000 usec
> 
>       IO WRITES before:
>       blk size | BW      | IOPS | 99th percentile latency
>       512B     | 3GiB    | 6.2M | 2573  usec
>       4k       | 7.2GiB  | 1.8M | 5342  usec
>       64k      | 10.7GiB | 176k | 62129 usec
> 
>       IO WRITES after:
>       blk size | BW      | IOPS  | 99th percentile latency
>       512B     | 4.2GiB  | 8.6M  | 938   usec
>       4k       | 10.2GiB | 2.68M | 2769  usec
>       64k      | 10.6GiB | 173k  | 87557 usec

The fact that the 64k 99% latency is substantially higher (20+
milliseconds) without any BW benefit, while its not a very interesting
measurement, gives me an indication that a more detailed analysis needs
to be made here to understand where are the trade-offs.

> It doesn't really make a difference to me how the option is implemented
> but I think it makes more sense to have it dealt with by us such as in a
> module parameter and not something like a flag that has a larger radius
> of effect.

I was suggesting a sysctl global parameter for global behavior and of
someone wants to override it it can add a CQ flag (which follows the
common net params exactly).
