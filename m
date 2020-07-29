Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3141BC433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 04:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1563D20786
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 04:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgG2Eh0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 00:37:26 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51570 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgG2EhZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 00:37:25 -0400
Received: by mail-pj1-f66.google.com with SMTP id c6so1293126pje.1
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 21:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XU31FClko5F8gicbnWPOCsqy42fRTkYxwgHqqzVb+Ho=;
        b=Ud3ZaiN0sDn+BAMNYyLdWniu8KF3tepTCtBIhAorWKm6tV0Hg80sxL9Q9GgTCOdRAR
         3A3xxv/6FeEi8v7zlD0qyiXSsf3ORoGonzMX6rvC528foVHAmic56AO9T6+3kj4+CgIl
         mh1hEglLJTu18TFm7rERqDGXX/vX7d67TV5dRlfJHV+ineaCZ58nQ0VMMQNcCfr6T6gg
         479XrNajFCK4OKbQzOobX+XjRhZU5epd/rQlei80rJGxs0xTnBRFa1JJsgpl9uz34D92
         8hkXL6wVuz40p+NnhJTnEDaLyJqgdxzTet9mXa5wOcwPqamYb3UMDhRnRkfonu4nbuyS
         Cg0Q==
X-Gm-Message-State: AOAM5329AU/DzM2H0BAvgRuoSys9emoz8bo/b3Rqn62w7gXCnOuW1tTv
        9x4CPtVkeP1TKYDglqqMFPI=
X-Google-Smtp-Source: ABdhPJzrJrVRsxMmyLmDqk439jheErXZ3UST5+jlVprC28TP0ny6Lfwa/+oo3ejMLNGcZL6m1d0O2g==
X-Received: by 2002:a17:902:8697:: with SMTP id g23mr25366202plo.94.1595997445233;
        Tue, 28 Jul 2020 21:37:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:fcc5:69d8:6e20:4fd1? ([2601:647:4802:9070:fcc5:69d8:6e20:4fd1])
        by smtp.gmail.com with ESMTPSA id a193sm655256pfa.105.2020.07.28.21.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 21:37:24 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To:     paulmck@kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lin <mlin@kernel.org>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728135436.GP9247@paulmck-ThinkPad-P72>
 <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
 <20200729003124.GT9247@paulmck-ThinkPad-P72>
 <07c90cf1-bb6f-a343-b0bf-4c91b9acb431@grimberg.me>
 <20200729041004.GV9247@paulmck-ThinkPad-P72>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <57f76f9c-6fb9-b6f1-ba85-1594755e60f3@grimberg.me>
Date:   Tue, 28 Jul 2020 21:37:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729041004.GV9247@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> Dynamically allocating each one is possible but not very scalable.
>>>>
>>>> The question is if there is some way, we can do this with on-stack
>>>> or a single on-heap rcu_head or equivalent that can achieve the same
>>>> effect.
>>>
>>> If the hctx structures are guaranteed to stay put, you could count
>>> them and then do a single allocation of an array of rcu_head structures
>>> (or some larger structure containing an rcu_head structure, if needed).
>>> You could then sequence through this array, consuming one rcu_head per
>>> hctx as you processed it.  Once all the callbacks had been invoked,
>>> it would be safe to free the array.
>>>
>>> Sounds too simple, though.  So what am I missing?
>>
>> We don't want higher-order allocations...
> 
> OK, I will bite...  Do multiple lower-order allocations (page size is
> still lower-order, correct?) and link them together.
> 
> Sorry, couldn't resist...

Possible, but I didn't want us to resort to all this complexity and
thought we can find a better, simpler solution.
