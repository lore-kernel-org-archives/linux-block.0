Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A6FC54E8D
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 09:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 095482075E
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 09:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgEKJXY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 05:23:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36334 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgEKJXY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 05:23:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so2803524wrs.3;
        Mon, 11 May 2020 02:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YMRVaoGd7XDxLJTKtDh7pUXdfydxobundGlGWCD7a4s=;
        b=nTOc/m/J4picsnNW86nkUrTZ4oLjvFNmsnyHLZRuu5IFv7smiG+k54AKFI86cp7iDI
         j/6Fi3ZuXZzVEuC+Fzwr/1jEGuWLY70fb2jwurQzVH90htd9TSiRBTIYkVIRq9CtN+GB
         C9u9L9xuUxzBofMsXG2QVVwpXVOELjlkcYN+AtWZHxSSGH/4rAkc9Eo4sVaYfMAfBRuX
         PCXqJ5csLMtCAefIFR+DXCeyFHCbf4dbV9C+A0abLavXOu2Rc0Ldv6brcjvuHFHva0+K
         hd9QpyHmkhibLXbcjYKQovb7Ou+JKDtFF8pn4v4ToyM9gd1NqI/UnQ9ez7slmf3xLYrH
         qZEQ==
X-Gm-Message-State: AGi0Pub7sUR5FuqGzGaxzboguMY0MF5TJbop6s6BcncnF74sVesvy7KL
        C/+SXEeYVrg2DMXP42VwRJFlKuBG
X-Google-Smtp-Source: APiQypLBIua8zxmeT5qFYH3i8hqZ1S42D3OK4AlQWsCNzA868V57dR2WcHbSh+kV/mErfE7rcxTTEQ==
X-Received: by 2002:adf:e38b:: with SMTP id e11mr18080351wrm.343.1589189001351;
        Mon, 11 May 2020 02:23:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:59c:65b4:1d66:e6e? ([2601:647:4802:9070:59c:65b4:1d66:e6e])
        by smtp.gmail.com with ESMTPSA id b12sm5741106wrq.82.2020.05.11.02.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 02:23:20 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/7] block: Extand commit_rqs() to do batch
 processing
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1587888520.git.baolin.wang7@gmail.com>
 <c8bd9e5ba815a3f1bc9dac0a4bc2fbadadbc0a43.1587888520.git.baolin.wang7@gmail.com>
 <20200427154645.GA1201@infradead.org>
 <e4d47000-f89c-a135-ae58-011f0e9cc39e@grimberg.me>
 <20200508214639.GA1389136@T590>
 <fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me>
 <20200508232222.GA1391368@T590>
 <CADBw62ooysT7TJ5CjpPBC6zs7pvpUQysg8QqP9oW5jN7BSYS7g@mail.gmail.com>
 <20200509094306.GA1414369@T590>
 <6579459b-aa98-78f2-f805-a6cd46f37b6c@grimberg.me>
 <20200511012942.GA1418834@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8f2ddabc-01d0-dae9-f958-1b26a6bdf58c@grimberg.me>
Date:   Mon, 11 May 2020 02:23:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511012942.GA1418834@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> Basically, my idea is to dequeue request one by one, and for each
>>> dequeued request:
>>>
>>> - we try to get a budget and driver tag, if both succeed, add the
>>> request to one per-task list which can be stored in stack variable,
>>> then continue to dequeue more request
>>>
>>> - if either budget or driver tag can't be allocated for this request,
>>> marks the last request in the per-task list as .last, and send the
>>> batching requests stored in the list to LLD
>>>
>>> - when queueing batching requests to LLD, if one request isn't queued
>>> to driver successfully, calling .commit_rqs() like before, meantime
>>> adding the remained requests in the per-task list back to scheduler
>>> queue or hctx->dispatch.
>>
>> Sounds good to me.
>>
>>> One issue is that this way might degrade sequential IO performance if
>>> the LLD just tells queue busy to blk-mq via return value of .queue_rq(),
>>> so I guess we still may need one flag, such as BLK_MQ_F_BATCHING_SUBMISSION.
>>
>> Why is that degrading sequential I/O performance? because the specific
> 
> Some devices may only return BLK_STS_RESOURCE from .queue_rq(), then more
> requests are dequeued from scheduler queue if we always queue batching IOs
> to LLD, and chance of IO merge is reduced, so sequential IO performance will
> be effected.
> 
> Such as some scsi device which doesn't use sdev->queue_depth for
> throttling IOs.
> 
> For virtio-scsi or virtio-blk, we may stop queue for avoiding the
> potential affect.

Do we have a way to characterize such devices? I'd assume that most
devices will benefit from the batching so maybe the flag needs to be
inverted? BLK_MQ_F_DONT_BATCHING_SUBMISSION?
