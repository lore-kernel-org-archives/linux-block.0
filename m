Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EB5C433E6
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 00:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138B023770
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 00:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbhAUA1h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:27:37 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:33170 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbhATVge (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 16:36:34 -0500
Received: by mail-wr1-f42.google.com with SMTP id 7so17224286wrz.0
        for <linux-block@vger.kernel.org>; Wed, 20 Jan 2021 13:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RMWtoZPt0wXfqvcUtOgF62hYIMnKD6ziI7A2LuBMA94=;
        b=lLRNuNlveR3eRGU5zUVsx2eWl17vvLTX/NXQ5oI5rV7baHmhQDCOmtlVIStvmtk07A
         xIZCM1jm77DaE2fHYOWYvgIB0k8Ch3b0kJ8h78WSrHdUqqnVhqweyXeKXsPHCjbuRUwj
         sdyL7YOsHUuOa7EYYuKbLeprxTp5tKxpPecGfnxST2qWzE+tTtckaOY1VIX+80jYtqna
         8XftUuojQuvBnJRlbQWZfsZ78DR95yZRrSLi0IRzpReZqfj/xRjLDYDtuft2VRiL9ArB
         Hn/36VP9tRl91z6q5ckMkSLB3hlhQNAeE2uhJFvo4IPqIOfvOSTDVIZy2waBW9mRoetb
         PbzQ==
X-Gm-Message-State: AOAM531KG4zK5YTfV/Ntx7keya13Xkif+xAZVRvr7HQ4XcUFlm5OVhsd
        uVDwpi46q/zuFXsP0AtoaloBZDu4FH4=
X-Google-Smtp-Source: ABdhPJweonrATr5mVR4u9BtfQRUEG6CBbF1U/Z4B5RjM6Cj53fxefwsiaskKNS+Mb7y1XyhJMfeFBQ==
X-Received: by 2002:a05:6000:254:: with SMTP id m20mr2810019wrz.300.1611178552579;
        Wed, 20 Jan 2021 13:35:52 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:a0fa:6c02:3a4c:3368? ([2601:647:4802:9070:a0fa:6c02:3a4c:3368])
        by smtp.gmail.com with ESMTPSA id b132sm5924493wmh.21.2021.01.20.13.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 13:35:51 -0800 (PST)
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de,
        linux-block@vger.kernel.org, axboe@kernel.dk
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-5-lengchao@huawei.com>
 <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
 <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com>
 <a3404c7d-ccc8-0d55-d4a8-fc15107c90e6@grimberg.me>
 <695b6839-5333-c342-2189-d7aaeba797a7@huawei.com>
 <4ff22d33-12fa-1f70-3606-54821f314c45@grimberg.me>
 <0b5c8e31-8dc2-994a-1710-1b1be07549c9@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2ed5391c-fe43-f512-adf0-214effd5d599@grimberg.me>
Date:   Wed, 20 Jan 2021 13:35:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0b5c8e31-8dc2-994a-1710-1b1be07549c9@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


is not something we should be handling in nvme. block drivers
>>>> should be able to fail queue_rq, and this all should live in the
>>>> block layer.
>>> Of course, it is also an idea to repair the block drivers directly.
>>> However, block layer is unaware of nvme native multipathing,
>>
>> Nor it should be
>>
>>> will cause the request return error which should be avoided.
>>
>> Not sure I understand..
>> requests should failover for path related errors,
>> what queue_rq errors are expected to be failed over from your
>> perspective?
> Although fail over for only path related errors is the best choice, it's
> almost impossible to achieve.
> The probability of non-path-related errors is very low. Although these
> errors do not require fail over retry, the cost of fail over retry
> is complete the request with error delay a bit long time(retry several
> times). It's not the best choice, but I think it's acceptable, because
> HBA driver does not have path-related error codes but only general error
> codes. It is difficult to identify whether the general error codes are
> path-related.

If we have a SW bug or breakage that can happen occasionally, this can
result in a constant failover rather than a simple failure. This is just
not a good approach IMO.

>>> The scenario: use two HBAs for nvme native multipath, and then one HBA
>>> fault,
>>
>> What is the specific error the driver sees?
> The path related error code is closely related to HBA driver
> implementation. In general it is EIO. I don't think it's a good idea to
> assume what general error code the driver returns in the event of a path
> error.

But assuming every error is a path error a good idea?

>>> the blk_status_t of queue_rq is BLK_STS_IOERR, blk-mq will call
>>> blk_mq_end_request to complete the request which bypass name native
>>> multipath. We expect the request fail over to normal HBA, but the 
>>> request
>>> is directly completed with BLK_STS_IOERR.
>>> The two scenarios can be fixed by directly completing the request in 
>>> queue_rq.
>> Well, certainly this one-shot always return 0 and complete the command
>> with HOST_PATH error is not a good approach IMO
> So what's the better option? Just complete the request with host path
> error for non-ENOMEM and EAGAIN returned by the HBA driver?

Well, the correct thing to do here would be to clone the bio and
failover if the end_io error status is BLK_STS_IOERR. That sucks
because it adds overhead, but this proposal doesn't sit well. it
looks wrong to me.

Alternatively, a more creative idea would be to encode the error
status somehow in the cookie returned from submit_bio, but that
also feels like a small(er) hack..
