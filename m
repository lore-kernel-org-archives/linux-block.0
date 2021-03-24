Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C368C433E1
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 15:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3637761A09
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 15:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbhCXPnY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 11:43:24 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:38706 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbhCXPnV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 11:43:21 -0400
Received: by mail-pg1-f181.google.com with SMTP id l1so14872449pgb.5
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 08:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QggucVUwSzig6GMS5zGAfRIs6DTm/Z/TqSfdC+FdYj4=;
        b=IA0bOQXsgJ8/pMf9fmX6D0JUoHam62gG840Ws1MvK96XrBOzRYF/PluLVJJZq6sXPD
         Z3ez7WU/e18JP8ilMOEcG2skZhYiCBTMquQGaAUnAicuJ/zGxQaNR0JJfaBtLejvYkF+
         OBfNzC25shtH1j0Erhs+0vR2L2bKhvrwHt4vlVqq3unQ5IPyx1editdz8QVPo+y5IlJ2
         b29Ccvi3MjeWJecykPOAl+2NZIp1rm2GPGjGfilvjUHXycy/8NxPe+Vma+o6PmGnaxaR
         OQeaIlQfz3TuAOf2lSrNl2lGtY1MxkltyYn5p6S0USYUA5I1y8+Dq2vo7QrbGo15DHjd
         qZaQ==
X-Gm-Message-State: AOAM532yN0I2khYnm/522xKlwEaptBxcZuu8aMAJLCx57HpMnU2EsTCn
        nfJniwRJvKRrSAZVkzZt8XLTm1mXn08=
X-Google-Smtp-Source: ABdhPJzY590vZ7RjrvvjVHPdylv4paVDI2xrLYyTvKklWkN770EUwLBBPU8PIiuD9xG2KyBtvIWaOQ==
X-Received: by 2002:a63:4441:: with SMTP id t1mr3645875pgk.124.1616600601382;
        Wed, 24 Mar 2021 08:43:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3b29:de57:36aa:67b9? ([2601:647:4802:9070:3b29:de57:36aa:67b9])
        by smtp.gmail.com with ESMTPSA id y24sm2923614pfn.213.2021.03.24.08.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 08:43:20 -0700 (PDT)
Subject: Re: [RFC PATCH V2 09/13] block: use per-task poll context to
 implement bio based io poll
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210318164827.1481133-1-ming.lei@redhat.com>
 <20210318164827.1481133-10-ming.lei@redhat.com>
 <522a2c87-e9f3-e62a-e09b-084821c698a0@grimberg.me> <YFnYhBIiFhiyX8Wb@T590>
 <713f2a27-4a2c-8723-3dfd-de6d68956eb2@grimberg.me> <YFqDXeEsDNBfoWqW@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <86cdc9a2-9640-9625-0741-e43f0ad40250@grimberg.me>
Date:   Wed, 24 Mar 2021 08:43:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFqDXeEsDNBfoWqW@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Well, when it will failover, it will probably be directed to the poll
>> queues. Maybe I'm missing something...
> 
> In this patchset, because it isn't submitted directly from FS, there
> isn't one polling context associated with this bio, so its HIPRI flag
> will be cleared, then fallback to irq mode.

I think that's fine for failover I/O...
