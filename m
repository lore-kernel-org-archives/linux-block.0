Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C84C433E0
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 10:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA5E464E6C
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 10:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhBIKQU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Feb 2021 05:16:20 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:37339 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhBIKKp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Feb 2021 05:10:45 -0500
Received: by mail-wm1-f44.google.com with SMTP id m1so2895414wml.2
        for <linux-block@vger.kernel.org>; Tue, 09 Feb 2021 02:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=seCJL4De3neOYVSF2iF0tKojHKwJFoTAHwmEK2t1MYg=;
        b=OMMB8tf9KK3G7foH/ErpNo5M6vVmrS+WOP4DQbSRHJRdVr7KjhQzMiQvEmaeWhVBTl
         5dwyaqz1yyOau+AfKRHvhKptJ+iXOgjLPs2/jN+5ZXJ/VLmnuOhWmYwezp0aIjgiVT91
         Wg2vGv3smc4+FHaOdrm90csCM+Wrgm76gy9Y67F3ERjhQpwUAxEdVYXBmIZ/31d3dwEP
         07wNwxJgRs9pMcI8t7PD+TZ0H8Yx7NNS07/4YFdwsRAYfxRLullt0PKPFaOWb2+r1rP5
         V5eq1TSFbiyxdDCD1C+2h1z2V3VSh9ncOHpRpI+8+hyYEyb3YnNTXmvPuCpOfJPPOlho
         oscA==
X-Gm-Message-State: AOAM5317Dkog/KYuAoDFYJkUJ4JXwncFnGJq6yc6X7V8zjpaMkFwWNx+
        4DhD2S4AWUBDCQiVZnYD/VJQgbpUwLo=
X-Google-Smtp-Source: ABdhPJwtm8lds5Xze0+ZHbvcE7HPSL8nzJOb3kUykUXJntGdvhWHTvVdt3w9XMXHDgdm0ZyvErtqJA==
X-Received: by 2002:a7b:c852:: with SMTP id c18mr2716398wml.118.1612865401970;
        Tue, 09 Feb 2021 02:10:01 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5? ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
        by smtp.gmail.com with ESMTPSA id x4sm493681wrn.64.2021.02.09.02.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 02:10:01 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Rachel Sibley <rasibley@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
 <6147d452-a12e-c76c-22f1-5d9e7cb6b01d@grimberg.me>
 <20210209042103.GB63798@T590>
 <1ea82025-44b8-ac3a-2039-35cb8d36dac2@grimberg.me>
 <20210209075001.GA94287@T590> <65F086AF-DDD7-46B7-9134-3E6B577E75A6@wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <92b6d55e-1a29-c5f2-f60c-0d1ac904dd4f@grimberg.me>
Date:   Tue, 9 Feb 2021 02:09:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <65F086AF-DDD7-46B7-9134-3E6B577E75A6@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> Yi, can you try the following patch?
>>>>
>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>> index 881d28eb15e9..a393d99b74e1 100644
>>>> --- a/drivers/nvme/host/tcp.c
>>>> +++ b/drivers/nvme/host/tcp.c
>>>> @@ -239,9 +239,14 @@ static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
>>>>           offset = 0;
>>>>       } else {
>>>>           struct bio *bio = req->curr_bio;
>>>> +        struct bio_vec bv;
>>>> +        struct bvec_iter iter;
>>>> +
>>>> +        nsegs = 0;
>>>> +        bio_for_each_bvec(bv, bio, iter)
>>>> +            nsegs++;
>>>>           vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
>>>> -        nsegs = bio_segments(bio);
>>>
>>> This was exactly the patch that caused the issue.
>>
>> What was the issue you are talking about? Any link or commit hash?
>>
>> nvme-tcp builds iov_iter(BVEC) from __bvec_iter_bvec(), the segment
>> number has to be the actual bvec number. But bio_segment() just returns
>> number of the single-page segment, which is wrong for iov_iter.
>>
>> Please see the same usage in lo_rw_aio().
>>
> That what I have suggested but I've also suggested the memory allocation part which Sagi explained why it is better to avoid.
> 
> In my opinion we should at least try bvec calculation in lo_aio_rw() and see the problem can be fixed or not, unless reverting the commit it right approach for some reason.

I'm trying to understand what this is, but I'm failing to reproduce
this. I may ask Yi to add some debug code for this.
