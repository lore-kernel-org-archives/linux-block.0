Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCB9C4742C
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 21:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978252068E
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 21:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgKMV4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:56:13 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:39730 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgKMV4M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 16:56:12 -0500
Received: by mail-pg1-f174.google.com with SMTP id i7so8187709pgh.6;
        Fri, 13 Nov 2020 13:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SHSbzMcVfeIHaoE+yOJYMuqSia/Ry07Es4s6O7UdW3A=;
        b=H6HnASWCs2E6oPHUjmT7Kv3rN45BC+QdC8s+Q6mA9H199j6qxzpgL0x17ne62cFIgM
         SAAeGksCg6RMIEh7lnji2ijWkN4GCz5VUKFmlq/LlwUM9i+1W89r4Pze0+lixys5Pf8a
         HSiNPD9hZXdR+GLfEHIzGFwlEETv83tZgYsVxsRDjtAhMZtVK2prK5Fg1PN4SeZZuh80
         E/cBGjJZjMxC9sdLG0G/ar0ZBJuRxpptCPrES3NRd34Qb41ITXknJoMnsLFgThffMnej
         5WE89nvvcK5iyQBENxXI9IeCeuOgPnVxH19zLI8XYZoJ52bklXAQa5WhYD8pF+9053Ds
         sFMg==
X-Gm-Message-State: AOAM531WYrPHpy0DHDThUtgV8lgcLvBr1nZubNoBVA2nd02FkF4Q0lbW
        4YQPGmej3hGD69Aca78tWYw=
X-Google-Smtp-Source: ABdhPJwTOoAtJr0iibtmigs2tAP2l7L6yRVJViK+rRXstuLrzMg8yCn899CSRJZaTSbCG6DVghICrw==
X-Received: by 2002:a62:1ccf:0:b029:18b:c80f:cf0c with SMTP id c198-20020a621ccf0000b029018bc80fcf0cmr3717378pfc.24.1605304571302;
        Fri, 13 Nov 2020 13:56:11 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:be97:ffd:339d:919c? ([2601:647:4802:9070:be97:ffd:339d:919c])
        by smtp.gmail.com with ESMTPSA id r73sm10903169pfc.20.2020.11.13.13.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 13:56:10 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To:     Jens Axboe <axboe@kernel.dk>, Rachit Agarwal <rach4x0r@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
        Qizhe Cai <qc228@cornell.edu>,
        Midhul Vuppalapati <mvv25@cornell.edu>,
        Rachit Agarwal <ragarwal@cs.cornell.edu>,
        Sagi Grimberg <sagi@lightbitslabs.com>,
        Rachit Agarwal <ragarwal@cornell.edu>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
 <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
 <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me>
 <c4cb66f6-8a66-7973-dc03-0f4f61d0a1e4@kernel.dk>
 <cbe18a3d-8a6b-e775-81bb-3b3f11045183@grimberg.me>
 <26a1cd20-6b25-eaa6-7ab6-ba7f5afaf6dd@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <81cdcb58-9a23-8192-6213-7f2408a3b8ee@grimberg.me>
Date:   Fri, 13 Nov 2020 13:56:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <26a1cd20-6b25-eaa6-7ab6-ba7f5afaf6dd@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> But if you think this has a better home, I'm assuming that the guys
>>>> will be open to that.
>>>
>>> Also see the reply from Ming. It's a balancing act - don't want to add
>>> extra overhead to the core, but also don't want to carry an extra
>>> scheduler if the main change is really just variable dispatch batching.
>>> And since we already have a notion of that, seems worthwhile to explore
>>> that venue.
>>
>> I agree,
>>
>> The main difference is that this balancing is not driven from device
>> resource pressure, but rather from an assumption of device specific
>> optimization (and also with a specific optimization target), hence a
>> scheduler a user would need to opt-in seemed like a good compromise.
>>
>> But maybe Ming has some good ideas on a different way to add it..
> 
> So here's another case - virtualized nvme. The commit overhead is
> suitably large there that performance suffers quite a bit, similarly to
> your remote storage case. If we had suitable logic in the core, then we
> could easily propagate this knowledge when setting up the queue. Then it
> could happen automatically, without needing a configuration to switch to
> a specific scheduler.

Yes, these use-cases share characteristics. I'm not at all opposed to
placing this in the core. I do think that in order to put something like
this in the core, the bar needs to be higher such that an optimization
target cannot be biased towards a workload (i.e. needs to be adaptive).

I'm still not sure how we would build this on top of what we already
have as it is really centered around device being busy (which is not
the case for nvme), but I didn't put enough thought into it yet.

