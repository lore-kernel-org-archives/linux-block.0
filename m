Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5A9C433E0
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 09:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3BCE207E8
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 09:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgG1JnJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:43:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40101 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgG1JnI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 05:43:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id u10so106649plr.7
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 02:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UUVmTpxXz4wQsES92rzvuhj8anv3EYHGJFmNkZcSM/I=;
        b=bIcaQKx4KNy3uS7L+xcBzlkIbLuYzIASF0OmoXTmM/tq1HPofPei66EVphuxjFA21j
         zzxWMdmmKbK70sfMauoqh5F/nPkesHSt8DzbE7VtMan8CPaOlBGHATqQIw0UIHzCw97G
         obkc40fLi09vgxjUt6QS3+IE/2eHSB0bk+ODUCushSW5bdKFTt2cKNufvRNb7UabpfkZ
         v1HoFPhsJCStkRkxnPYMsRBYj5I2ZwRvyFxrNjS/jygOLHu5P/njHz+p3pyx1satcRmw
         InLAsFdZRj+vPPyUCyZDazKXAZJMHumnD9e4WPdJZlY7K+V4+2NeVOEyEzI9ZpbBlaQk
         M98Q==
X-Gm-Message-State: AOAM531vs6E/opARzlcuxZ8b0gkFol/CMVAI51hIY4DoB3zEaZ/puFA4
        Z841UoEqQILlouTyZvBXZFI=
X-Google-Smtp-Source: ABdhPJx0SNP3y2ppgHVkQbLyOdkXsmyvE9dQdhMdVCWwleLidD7zxMzyb4xKz6wGjiw9QXka6LdejA==
X-Received: by 2002:a17:902:8498:: with SMTP id c24mr22772382plo.332.1595929388125;
        Tue, 28 Jul 2020 02:43:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe? ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
        by smtp.gmail.com with ESMTPSA id k125sm1078093pga.48.2020.07.28.02.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 02:43:07 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chao Leng <lengchao@huawei.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lin <mlin@kernel.org>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728093326.GC1326626@T590>
 <44f07df6-3107-3e7f-ee02-7bc43293ee6b@grimberg.me>
Message-ID: <6a678d5d-22b2-5238-92c5-d68e2aafeb9e@grimberg.me>
Date:   Tue, 28 Jul 2020 02:43:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <44f07df6-3107-3e7f-ee02-7bc43293ee6b@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>> I like the tagset based interface.  But the idea of doing a per-hctx
>>>>> allocation and wait doesn't seem very scalable.
>>>>>
>>>>> Paul, do you have any good idea for an interface that waits on
>>>>> multiple srcu heads?  As far as I can tell we could just have a single
>>>>> global completion and counter, and each call_srcu would just just
>>>>> decrement it and then the final one would do the wakeup.  It would 
>>>>> just
>>>>> be great to figure out a way to keep the struct rcu_synchronize and
>>>>> counter on stack to avoid an allocation.
>>>>>
>>>>> But if we can't do with an on-stack object I'd much rather just embedd
>>>>> the rcu_head in the hw_ctx.
>>>>
>>>> I think we can do that, please see the following patch which is 
>>>> against Sagi's V5:
>>>
>>> I don't think you can send a single rcu_head to multiple call_srcu 
>>> calls.
>>
>> OK, then one variant is to put the rcu_head into blk_mq_hw_ctx, and put
>> rcu_synchronize into blk_mq_tag_set.
> 
> I can cook up a spin,

Nope.. spoke too soon, the rcu_head needs to be in a context that has
access to the counter (which is what you called blk_mq_srcu_sync).
you want to add also a pointer to hctx? that is almost as big as
rcu_synchronize...
