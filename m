Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE007C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 19:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2CF619A3
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 19:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhCWTAx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 15:00:53 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:38432 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbhCWTAh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 15:00:37 -0400
Received: by mail-pj1-f41.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso12568841pji.3
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 12:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O/3qn3sPLpLHnlktoBlJGBkI4ltpf5u7GjymR/6WLUg=;
        b=M5BF0x9YM6pww0UeWP3ReA/b8UoMh3xY6PRWvdZZGixC5NHujVyrRjZtAwBt3k1Wz/
         1z5znAeYC6N++52w+AqX3H8XOwiVV5PZtxSYGHt0p750WXYPn7R0A8y+Hw8xCRULcYVg
         rF2KyBnqDhUaJ2Eg1WyYW3zL23aE9KEeFcf3J1fA0EDkfCidtMVImjn8AP2PopWHFbst
         t9pCk4OMporzBMBrjWQlwt+6X+VBtIiGakRAfuAQa4bI2BbHVYLjNLsdOHCXTvFuxHiV
         JvZJXffUfW66fagYAtZHr5RszkvAUPJNP3hiZq0pIc1mhsbqpfcqCWNr5lJTmyNDvBJK
         IcjQ==
X-Gm-Message-State: AOAM530BZ8XKzTH0svCdGHQ2FAJ6Fc/wVH4F3wZx5ugTjIsedSRaUcbi
        sjokQvkxKBqFQIIx3dF17xA=
X-Google-Smtp-Source: ABdhPJxKGX6jlJBKXMP33WR+TIBDDDNJn54IG4rhNKR4rhZzSeIwabCSLlc4zSh+Nrn20AapJ3qC3w==
X-Received: by 2002:a17:90a:4604:: with SMTP id w4mr5797704pjg.56.1616526037254;
        Tue, 23 Mar 2021 12:00:37 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3b29:de57:36aa:67b9? ([2601:647:4802:9070:3b29:de57:36aa:67b9])
        by smtp.gmail.com with ESMTPSA id 22sm3599104pjl.31.2021.03.23.12.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 12:00:36 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
 <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com>
 <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me>
 <20210323161544.GA13402@lst.de>
 <162dc8f7-b46d-37ff-01e8-51d813e0a904@grimberg.me>
 <20210323182244.GA16649@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c4ceed19-cdc5-aeca-0c4b-ebed088e8b82@grimberg.me>
Date:   Tue, 23 Mar 2021 12:00:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210323182244.GA16649@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> The deadlock in this patchset reproduces upstream. It is not possible to
>> update the kernel in the env in the original report.
>>
>> So IFF we assume that this does not reproduce in upstream (pending
>> proof), is there something that we can do with stable fixes? This will
>> probably go back to everything that is before 5.8...
> 
> The direct_make_request removal should be pretty easily backportable.

Umm, the direct_make_request removal is based on the submit_bio_noacct
rework you've done. Are you suggesting that we replace it with
generic_make_request for these kernels?

> In old kernels without the streamlined normal path it might cause minor
> performance degradations, but the actual change should be trivial.

That is better than getting stuck in I/O failover...
