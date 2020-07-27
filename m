Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17718C433E0
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 18:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044E420729
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 18:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgG0Sk2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:40:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37505 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgG0Sk1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 14:40:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so8574703pls.4
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 11:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rC7Tk0r3xbJ5Oshs2cMtEw58Q2CIxkR3NVrOAGPz33w=;
        b=YOsZ9w2guMFQEEhuaq+8NNoGncg7mUb8ZAqWrz6dm8gW7lBkAX4FFF1VHE43pl6hj4
         vLcxS++Bu6+RZVzntXb36FrSjSpg1zoV75/HPEY8rVsd9tC6jSYhiEgmhSiNbF791SEI
         JNDNvhD0uVBh4lakBeM3prFH6Jfiq1lQwqbHM90s4rxp3kNMlgs8hAFQ7/8hOjUsG6GY
         KbkD/KG58q2S6en8QEoTjAteBxuRq/BIZxY7X9VRZzYowyLpNZoZjyN/23242BudxAn7
         8yODhvslqalguq9+ANOK2Re8EPppeNOgSsSuzqOFtK1zss3nVZOHh1NeHfT3eJYK3u5F
         BtwQ==
X-Gm-Message-State: AOAM530536qVzebwCgohTNEFvgKrGXaA1TeO7mqJK9B30VgK5wrIOxnx
        i+A1hukMSbLxUQMVDI1rRTI=
X-Google-Smtp-Source: ABdhPJw2p7qTeYU2hJoAWFP3Sk8Bc8KLs/DYH7ECspsJSzpvEL0TKMzDwu8WLSFZNDMqB2G/rUFlxg==
X-Received: by 2002:a17:90a:d195:: with SMTP id fu21mr606720pjb.100.1595875226860;
        Mon, 27 Jul 2020 11:40:26 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b? ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id i128sm15685492pfe.74.2020.07.27.11.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 11:40:26 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To:     Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <f9ed3baa-2a83-c483-6ba0-70a84d40f569@huawei.com>
 <20200727035033.GD1129253@T590>
 <79ab699e-3f50-26c0-3c85-1962ae4dedac@huawei.com>
 <20200727063220.GA1144698@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f23c66b8-8c93-4b4d-56ab-dd17e9ddf4a2@grimberg.me>
Date:   Mon, 27 Jul 2020 11:40:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727063220.GA1144698@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>>> It is at the end and contains exactly what is needed to synchronize. Not
>>>>> The sync is simply single global synchronize_rcu(), and why bother to add
>>>>> extra >=40bytes for each hctx.
>>>>>
>>>>>> sure what you mean by reuse hctx->srcu?
>>>>> You already reuses hctx->srcu, but not see reason to add extra rcu_synchronize
>>>>> to each hctx for just simulating one single synchronize_rcu().
>>>>
>>>> To sync srcu together, the extra bytes must be needed, seperate blocking
>>>> and non blocking queue to two hctx may be a not good choice.
>>>>
>>>> There is two choice: the struct rcu_synchronize is added in hctx or in srcu.
>>>> Though add rcu_synchronize in srcu has a  weakness: the extra bytes is
>>>> not need if which do not need batch sync srcu, I still think it's better
>>>> for the SRCU to provide the batch synchronization interface.
>>>
>>> The 'struct rcu_synchronize' can be allocated from heap or even stack(
>>> if no too many NSs), which is just one shot sync and the API is supposed
>>> to be called in slow path. No need to allocate it as long lifetime variable.
>>> Especially 'struct srcu_struct' has already been too fat.
>>
>> Stack is not suitable, stack can not provide so many space for
> 
> Stack is fine if number of NS is small, for example, most of times,
> there is just one NS.

I prefer a single code-path, so stack is not good.

>> many name space. Heap maybe a choice, but need to add abnormal treat
>> when alloc memory failed, Thus io pause time can not be ensured.
>> So the extra space may must be needed for batch srcu sync.
> 
> In case of allocation failure, you can switch to synchronize_srcu() simply.

that is possible, but I still prefer to support both srcu and rcu hctx
in a single interface so I don't need to have different code paths in
nvme (or other drivers).
