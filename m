Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400CBC71155
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 19:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CCA20825
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 19:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgK3TVV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 14:21:21 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:55524 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbgK3TVR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 14:21:17 -0500
Received: by mail-wm1-f51.google.com with SMTP id x22so434902wmc.5;
        Mon, 30 Nov 2020 11:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mukpp6Mq76LOTsdZgqPYBiMElAO+nckYaXg+oNK1qDc=;
        b=mhMMgZncKEvQlAFlJ1hVgwAXyI157SP7wpO3qat/UzJFhwjJGkpoVii/I6Z6bgTFaa
         qJs+wA7l3G2bcfHmTINDdXcVhVRFRermnyjuFsHm7VX5FfH4GPQjEK4idNhMTo8E0F6r
         mWHxs1A/QWywMNpZ+nbQCkrpwb9fHOlYaVO5doT2h9nHfJ6NOV//A8z1ZbpslUergcXq
         XHqjNMYHc+vOB0eJWN14FDfsqLTM6jfCaNmLrbDVeUiC5UGdwnxuR/JbrtCD7eXQQjfc
         TfYiw3x4wZthUVuPhjjwnTBr8cfutyfItsS899G8/sn5rny9uFK+bVUovNq68cFAdHXV
         ED1w==
X-Gm-Message-State: AOAM531o9lnasmOpcEAzzfENOzqLK45SxrbSQ0XrJ9tYR40sGlDMneQ7
        cxzZr9UMgSX5CDWrYwXH96E=
X-Google-Smtp-Source: ABdhPJzpAIM4wte2jLpvG6ah5G90aGtc/tPBXKn0F1OXOYAXgdaLbRYyOpvfvP1GZY/CMGC2i0wGXg==
X-Received: by 2002:a1c:208f:: with SMTP id g137mr330289wmg.67.1606764035732;
        Mon, 30 Nov 2020 11:20:35 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:9a41:a6e2:c4ef:e7b8? ([2601:647:4802:9070:9a41:a6e2:c4ef:e7b8])
        by smtp.gmail.com with ESMTPSA id z11sm346453wmc.39.2020.11.30.11.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 11:20:35 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To:     Rachit Agarwal <rach4x0r@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
        Qizhe Cai <qc228@cornell.edu>,
        Midhul Vuppalapati <mvv25@cornell.edu>,
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
 <81cdcb58-9a23-8192-6213-7f2408a3b8ee@grimberg.me>
 <CAKeUqKKHg1wD19pnwJEd8whubnuGVic_ZhDjebaq3kKmY9TtsQ@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0cce60db-5a41-2e1b-ba5d-7905966bec25@grimberg.me>
Date:   Mon, 30 Nov 2020 11:20:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKeUqKKHg1wD19pnwJEd8whubnuGVic_ZhDjebaq3kKmY9TtsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Dear all:
> 
> Thanks, again, for the very constructive decisions.
> 
> I am writing back with quite a few updates:
> 
> 1. We have now included a detailed comparison of i10 scheduler with 
> Kyber with NVMe-over-TCP 
> (https://github.com/i10-kernel/upstream-linux/blob/master/i10-evaluation.pdf). 
> In a nutshell, when operating with NVMe-over-TCP, i10 demonstrates the 
> core tradeoff: higher latency, but also higher throughput. This seems to 
> be the core tradeoff exposed by i10.
> 
> 2. We have now implemented an adaptive version of i10 I/O scheduler, 
> that uses the number of outstanding requests at the time of batch 
> dispatch (and whether the dispatch was triggered by timeout or not) to 
> adaptively set the batching size. The new results 
> (https://github.com/i10-kernel/upstream-linux/blob/master/i10-evaluation.pdf) 
> show that i10-adaptive further improves performance for low loads, while 
> keeping the performance for high loads. IMO, there is much to do on 
> designing improved adaptation algorithms.
> 
> 3. We have now updated the i10-evaluation document to include results 
> for local storage access. The core take-away here is that i10-adaptive 
> can achieve similar throughput and latency at low loads and at high 
> loads when compared to noop, but still requires more work for lower 
> loads. However, given that the tradeoff exposed by i10 scheduler is 
> particularly useful for remote storage devices (and as Jens suggested, 
> perhaps for virtualized local storage access), I do agree with Sagi -- I 
> think we should consider including it in the core, since this may be 
> useful for a broad range of new use cases.
> 
> We have also created a second version of the patch that includes these 
> updates: 
> https://github.com/i10-kernel/upstream-linux/blob/master/0002-iosched-Add-i10-I-O-Scheduler.patch
> 
> As always, thank you for the constructive discussion and I look forward 
> to working with you on this.

Thanks Rachit,

Would be good if you can send a formal patch for the adaptive queuing so
people can have a look.

One thing that was left on the table is weather this should be a full
blown scheduler or a core block infrastructure that would either be
set on-demand or by default.

I think that Jens and Ming expressed that this should be something that
we should place this in the block core, but I'd like to hear maybe
Ming can elaborate on his ideas how to do this.
