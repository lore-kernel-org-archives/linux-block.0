Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF40AC38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 22:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D7E20731
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 22:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgEHWTu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 18:19:50 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34454 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgEHWTt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 18:19:49 -0400
Received: by mail-pj1-f67.google.com with SMTP id h12so5717752pjz.1;
        Fri, 08 May 2020 15:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=agEiPPMNgwyK2BliOmzqFg2hxzKUzHpkr6vduFi84gQ=;
        b=g009fLPX477tOlQmG7l4KRZh5Xah8g5B+/OID4YVwp9l4sl0JKY1w1QXORb6h9LIXc
         we1Ls8BadeLgc8FTwgyWXFazXmXlDnmsWwQ62wyyxViWE6CnvIdalaOqaCzAx1Hd+05k
         BGDHH+Qc+/8H+uFajj4pC3oizbPieoRxlft7KE2NBOL4w4ha1NY3Z2e/V6vyCrLAGfJh
         1mX+/3sQuJngiGq3fHtUVF2U5dz+BvQid04+m+lzU0AC4wds/+1E4870KkqWDQupYKB1
         0ES98w68POyEZBfZM6x+vXkycWNlAVozPfkpXfN/V8QFpF4XQn1m7lk73Nun+fqJhO9O
         GrgA==
X-Gm-Message-State: AGi0PuZ/o10RsWxwcPlYdjy58DZyPzq8IPkqZ5rtiU8WS+zpkw0Qjwhx
        pt6GZg9OxdrhccVf1z0uTtU2jio7
X-Google-Smtp-Source: APiQypJ8zZSznj1d26ER6zLx3yrkDj/sxZsgeiqPDzyEjy1E4wJ/TuYQ1jMjgC02OMGhy8Tw7rPAsA==
X-Received: by 2002:a17:90a:730a:: with SMTP id m10mr8915600pjk.9.1588976388140;
        Fri, 08 May 2020 15:19:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:bc73:49fb:3114:443? ([2601:647:4802:9070:bc73:49fb:3114:443])
        by smtp.gmail.com with ESMTPSA id a16sm2135918pgg.23.2020.05.08.15.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 15:19:47 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/7] block: Extand commit_rqs() to do batch
 processing
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Baolin Wang <baolin.wang7@gmail.com>, axboe@kernel.dk,
        ulf.hansson@linaro.org, adrian.hunter@intel.com, arnd@arndb.de,
        linus.walleij@linaro.org, paolo.valente@linaro.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1587888520.git.baolin.wang7@gmail.com>
 <c8bd9e5ba815a3f1bc9dac0a4bc2fbadadbc0a43.1587888520.git.baolin.wang7@gmail.com>
 <20200427154645.GA1201@infradead.org>
 <e4d47000-f89c-a135-ae58-011f0e9cc39e@grimberg.me>
 <20200508214639.GA1389136@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me>
Date:   Fri, 8 May 2020 15:19:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508214639.GA1389136@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey Ming,

>> Would it make sense to elevate this flag to a request_queue flag
>> (QUEUE_FLAG_ALWAYS_COMMIT)?
> 
> request queue flag usually is writable, however this case just needs
> one read-only flag, so I think it may be better to make it as
> tagset/hctx flag.

I actually intended it to be writable.

>> I'm thinking of a possibility that an I/O scheduler may be used
>> to activate this functionality rather than having the driver set
>> it necessarily...
> 
> Could you explain a bit why I/O scheduler should activate this
> functionality?

Sure, I've recently seen some academic work showing the benefits
of batching in tcp/ip based block drivers. The problem with the
approaches taken is that I/O scheduling is exercised deep down in the
driver, which is not the direction I'd like to go if we are want
to adopt some of the batching concepts.

I spent some (limited) time thinking about this, and it seems to
me that there is an opportunity to implement this as a dedicated
I/O scheduler, and tie it to driver specific LLD stack optimizations
(net-stack for example) relying on the commit_rq/bd->last hints.

When scanning the scheduler code, I noticed exactly the phenomenon that
this patchset is attempting to solve and Christoph referred me to it.
Now I'm thinking if we can extend this batching optimization for both
use-cases.

> batching submission may be good for some drivers, and currently
> we only do it in limited way. One reason is that there is extra
> cost for full batching submission, such as this patch requires
> one extra .commit_rqs() for each dispatch, and lock is often needed
> in this callback.

That is not necessarily the case at all.

> IMO it can be a win for some slow driver or device, but may cause
> a little performance drop for fast driver/device especially in workload
> of not-batching submission.

You're mostly correct. This is exactly why an I/O scheduler may be
applicable here IMO. Mostly because I/O schedulers tend to optimize for
something specific and always present tradeoffs. Users need to
understand what they are optimizing for.

Hence I'd say this functionality can definitely be available to an I/O
scheduler should one exist.
