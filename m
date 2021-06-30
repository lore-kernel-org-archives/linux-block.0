Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DD3C11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 18:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C55961437
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 18:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbhF3TCE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 15:02:04 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:43819 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhF3TCE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 15:02:04 -0400
Received: by mail-pg1-f180.google.com with SMTP id o18so2642411pgu.10
        for <linux-block@vger.kernel.org>; Wed, 30 Jun 2021 11:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Wi/OHievHiEkbKZk39MUJJHz8CqqbZiqlSseobXU1M=;
        b=IBXGk4PbQ7iQgqb3M93irT2e1jkxNyM7naGh3qhjxxxWlVsVNRKFWb3bivIDSMWKaD
         8u1SjCjUMevb5dcXV6I+S/R1XkRdy0lqaEzJc3L3x7SyMz4r419TYG2YM79IawnDQefp
         UUNJsZezEx65nA5xcTQTZv03zliiWE7fc7ZXCvzJSsHQlPWrdmqvAqK0tI1JuEaW4kO5
         2UUZKuGBFK1cwZmhUcCVwH6xe+KYkzT23UTI90mxrcj1QB1vEAO5YwHOjazpjevA+CES
         SjY8yqPtNeDYllkN45BwcXvEmCZTqJo8suYl60nFjXp345C2bl5c/27irMkAbXdxjRDa
         3aSQ==
X-Gm-Message-State: AOAM533R0Hkf56C2vRXNjqo7as9JdzJ1GRwcTatlLGS6OGrQ859xhCJj
        C0+3Vy+xUzIGzb0LOT2vd7A=
X-Google-Smtp-Source: ABdhPJy5tD0xCLQMXKqgVzsGUSIoGa7yBsH1MnAew8zlYGkpf2YhN3yoWG+sZC4S96FcwF5kZZ03gw==
X-Received: by 2002:a63:b0b:: with SMTP id 11mr35524933pgl.341.1625079575156;
        Wed, 30 Jun 2021 11:59:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8e5:b428:30c3:f97b? ([2601:647:4802:9070:8e5:b428:30c3:f97b])
        by smtp.gmail.com with ESMTPSA id c24sm22501230pfd.167.2021.06.30.11.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 11:59:34 -0700 (PDT)
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
To:     Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de> <YNwug8n7qGL5uXfo@T590>
 <c1de513a-5477-9d1d-0ddc-24e9166cc717@suse.de> <YNw/DcxIIMeg/2VK@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e106f9c4-35c3-b2da-cdd8-3c4dff8234d6@grimberg.me>
Date:   Wed, 30 Jun 2021 11:59:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNw/DcxIIMeg/2VK@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> Shouldn't we rather modify the tagset to only refer to the current online
>>>> CPUs _only_, thereby never submit a connect request for hctx with only
>>>> offline CPUs?
>>>
>>> Then you may setup very less io queues, and performance may suffer even
>>> though lots of CPUs become online later.
>>> ;
>> Only if we stay with the reduced number of I/O queues. Which is not what I'm
>> proposing; I'd rather prefer to connect and disconnect queues from the cpu
>> hotplug handler. For starters we could even trigger a reset once the first
>> cpu within a hctx is onlined.
> 
> Yeah, that need one big/complicated patchset, but not see any advantages
> over this simple approach.

I tend to agree with Ming here.
