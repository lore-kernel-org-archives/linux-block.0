Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3FEC433DF
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 17:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89FC2068E
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 17:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHYRit (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:38:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34104 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgHYRir (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 13:38:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id m71so7918281pfd.1
        for <linux-block@vger.kernel.org>; Tue, 25 Aug 2020 10:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q+YopeIkFRKGljUOw9EJi+OWYEbgdLf5N6jXFJDCqtM=;
        b=SFgHLLBM0s0QpsKroTl4xDn4JgXZubbl9cdXwcmEQ0MjQAj7pw0Fo707Kf1zYqHvta
         7ikXr1iwRRDMu66yw2y7CgRLCSMOewuadU6ZzlfW+EemQdtk7Gg4e+CFC7E+BStY5SL5
         MMZ39w5LXFqjxuCdcOkwKkTQSjLj8IG1ocNNIYUvfRFGiUPZ6ck9S9u5znR3dnL1hIzB
         WT/hCYkxvy/TDx9aEV3zyp/U6MFp+Imo1lI+6HQtGQGviCR5SKxTjOmfan/cR4IAmnaZ
         abOi5SWiH662mf8FhHPVV9Ln3KHqTarVhUX0TiBQR5ab5wyMFKrBmdIMLF/HLSk2jeNH
         fEQA==
X-Gm-Message-State: AOAM5313/aTPFhH6/RFdOPbnS0bfsHxoWnK13LuJHJtbZEIoNdh4ztwp
        wa04qx3OF6eVzQUoMwVZKAQ=
X-Google-Smtp-Source: ABdhPJzkJAHG74gWjBtjtVpObp+kp9wrD8hna3apKpWDDk5qVaPcsN7cE4dIe74FlmAbew2/cffvwg==
X-Received: by 2002:a17:902:9b8d:: with SMTP id y13mr6677036plp.90.1598377126510;
        Tue, 25 Aug 2020 10:38:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c51:77cf:ef42:8603? ([2601:647:4802:9070:4c51:77cf:ef42:8603])
        by smtp.gmail.com with ESMTPSA id t25sm15616864pfe.76.2020.08.25.10.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 10:38:45 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200820030248.2809559-1-ming.lei@redhat.com>
 <856f6108-2227-67e8-e913-fdef296a2d26@grimberg.me>
 <20200822133954.GC3189453@T590>
 <619a8d4f-267f-5e21-09bd-16b45af69480@grimberg.me>
 <20200824104052.GA3210443@T590>
 <44160549-0273-b8e6-1599-d54ce84eb47f@grimberg.me>
 <20200825023212.GA3233087@T590>
 <a7b87988-4757-b718-511e-3fdf122325c9@grimberg.me>
 <399888c3-71e6-625e-3b0d-025ccbad4fd1@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6cef7a24-f19c-a39a-abd8-2f0ea50fb7a2@grimberg.me>
Date:   Tue, 25 Aug 2020 10:38:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <399888c3-71e6-625e-3b0d-025ccbad4fd1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> Good, but I'd also won't want to get this without making sure the async
>>>> quiesce works well on large number of namespaces (the reason why this
>>>> is proposed in the first place). Not sure who is planning to do that...
>>>
>>> That can be added when async quiesce is done.
>>
>> Chao, are you looking into that? I'd really hate to find out we have an
>> issue there post conversion...
> 
> Now we config CONFIG_TREE_SRCU, the size of TREE_SRCU is too big. I
> really appreciate the work of Ming.
> 
> I review the patch, I think the patch may work well now, but do extra
> works for exception scenario. Percpu_ref is not disigned for
> serialization which read low cost. If we replace SRCU with percpu_ref,
> the benefit is save memory for blocking queue, the price is limit future
> changes or do more extra works.
> 
> I do not think replace SRCU with percpu_ref is a good idea, because it's
> hard to predict how much we'll lose.

Not sure I understand your point, can you clarify what is the poor
design of percpu_ref and for which use-case?
