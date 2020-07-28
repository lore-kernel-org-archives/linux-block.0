Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E906BC433E4
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 09:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0903207E8
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 09:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgG1JYl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:24:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34282 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgG1JYk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 05:24:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id t6so11543719pgq.1
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 02:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xL/B9gY8iip3iVNIPktCRqfoRqM3/8PUZ5p5fFHBhHg=;
        b=dM8wyzk04AkjfmIYff3M8NpAnlOiXDiCR5KBz3GLnEz6iT64tfd9ucZBaywGFcaN31
         2s76Sgt4WSycMvb9QVca+HwSUJdExSudUk9iy+OKZq9BFee3MZWMCB9h3lsOdPbhZx5L
         F4cKEq662X4kC3uuxtuermbN0nR5XZRtDve/d6hisSOx8jqnf9PlEWfoZZpyBjjYQ+U7
         vNKptgYHoOH9OpE4+kXS0SDqJ6+cBa3epv+/Ghln9yXzYvmiD45EApaXS0L0TjznnGLa
         bomYlRNLpwo/jpdw84T1lVTpoUdUexJVXx1VpbUcc8rqjW13WLVL3hGCc7OqejRYeluR
         143g==
X-Gm-Message-State: AOAM531ouD/X0VIi/ls7zh+GINpkpsdasHryawkdijZCbVlXwyCU9zsc
        ogqbIqucMu+9wuGV2Ahm+pE=
X-Google-Smtp-Source: ABdhPJxVa5rYu2TnTkAe+FZGgFK6TELYiTpOSPNAxllgBKznCmx9Kt4Xk0+RuZuwDbxN8Ag9YuxMEA==
X-Received: by 2002:a05:6a00:10:: with SMTP id h16mr23685918pfk.214.1595928280149;
        Tue, 28 Jul 2020 02:24:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe? ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
        by smtp.gmail.com with ESMTPSA id g19sm17952974pfb.152.2020.07.28.02.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 02:24:39 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chao Leng <lengchao@huawei.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lin <mlin@kernel.org>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
Date:   Tue, 28 Jul 2020 02:24:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728091633.GB1326626@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> I like the tagset based interface.  But the idea of doing a per-hctx
>> allocation and wait doesn't seem very scalable.
>>
>> Paul, do you have any good idea for an interface that waits on
>> multiple srcu heads?  As far as I can tell we could just have a single
>> global completion and counter, and each call_srcu would just just
>> decrement it and then the final one would do the wakeup.  It would just
>> be great to figure out a way to keep the struct rcu_synchronize and
>> counter on stack to avoid an allocation.
>>
>> But if we can't do with an on-stack object I'd much rather just embedd
>> the rcu_head in the hw_ctx.
> 
> I think we can do that, please see the following patch which is against Sagi's V5:

I don't think you can send a single rcu_head to multiple call_srcu calls.
