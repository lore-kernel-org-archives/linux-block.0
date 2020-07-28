Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3339C433E0
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 09:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD8020786
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 09:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgG1JhT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:37:19 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40360 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbgG1JhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 05:37:18 -0400
Received: by mail-pj1-f66.google.com with SMTP id t15so11173088pjq.5
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 02:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qc6XHMOfo5wnNZ/diCVPFqd6BfCfCaGvZVkP6ubbDA0=;
        b=Z5lTrWGTMCOjYh6/lifiBEyg2aam0qyiMoCFjh+5kdCane/1MIPt1Eb+QbdBBuOKi5
         6dDs5LqrdUI6t6fcCj3r+ORTVspXcBJJskuDJPQuTSRJlI28Wf0J4AbOcPx5XzENe298
         jZ+AMgM23kAZKDyiYTMiBI8qDlS40EZy7AIb2yAeYrbjAFy8XTMTBbrmwb4bn6DXt4z4
         RS4KSgU5paMEkgXuGLJC2Hb7/3lOuSyigjCizcsEXYX9LcEstouoeRq7nUD8zgsGfEEL
         53RYJKgGL9cd9VKFaXxHG/B8HTHt/J9If6tI/sNfIvPzjZJ1gjQRaSsvRq3oqnoHqZa8
         ptmg==
X-Gm-Message-State: AOAM531zmLHOIHTaKhCN7+jKYp/ftMLUK+GC+91fGjSuk19pBGAHbpML
        NLSkEk2x7Xt0z/zoMj5q9p8=
X-Google-Smtp-Source: ABdhPJyEv3KzVF7kG4ylniufEJRENgpIEiqrzqVmF5DzxWz4M0h5ZwA3KuSAj1F6qKD9rpjGnQLXoA==
X-Received: by 2002:a17:90b:355:: with SMTP id fh21mr3616808pjb.46.1595929037893;
        Tue, 28 Jul 2020 02:37:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe? ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
        by smtp.gmail.com with ESMTPSA id k29sm9885530pfp.142.2020.07.28.02.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 02:37:17 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <44f07df6-3107-3e7f-ee02-7bc43293ee6b@grimberg.me>
Date:   Tue, 28 Jul 2020 02:37:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728093326.GC1326626@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> I like the tagset based interface.  But the idea of doing a per-hctx
>>>> allocation and wait doesn't seem very scalable.
>>>>
>>>> Paul, do you have any good idea for an interface that waits on
>>>> multiple srcu heads?  As far as I can tell we could just have a single
>>>> global completion and counter, and each call_srcu would just just
>>>> decrement it and then the final one would do the wakeup.  It would just
>>>> be great to figure out a way to keep the struct rcu_synchronize and
>>>> counter on stack to avoid an allocation.
>>>>
>>>> But if we can't do with an on-stack object I'd much rather just embedd
>>>> the rcu_head in the hw_ctx.
>>>
>>> I think we can do that, please see the following patch which is against Sagi's V5:
>>
>> I don't think you can send a single rcu_head to multiple call_srcu calls.
> 
> OK, then one variant is to put the rcu_head into blk_mq_hw_ctx, and put
> rcu_synchronize into blk_mq_tag_set.

I can cook up a spin, but I still hate the fact that I have a queue that
ends up quiesced which I didn't want it to...
