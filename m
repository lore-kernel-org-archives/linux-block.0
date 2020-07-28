Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A12C433E0
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 23:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38B420829
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 23:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgG1Xq1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:46:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33553 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgG1Xq0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 19:46:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id t1so1758792plq.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 16:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vVYisOyWkKYyWKcrtYGb2W0FzH+WmFt68pzFrRJmeys=;
        b=hvxa2NKEZCNZie+kvj9iwsSSspYlRt3I2VZqWO4K44YLUJK1Eqq/xLXA6dyZnkXg+L
         Pz+DQo78wUdGwZHn+BJYEaX/7CHoVXvxx7jaW5PyVdFPrqBVKMpR16kNmygS4pMqBe4+
         pe21wm98ndgnOohclBwycsql1Ci2B0qwkmCUurjcPWsbw+3wdO775C/rFYlJG+iSnuow
         gyjfJ3I8rz7HZGgJwd/PIreW27t46QYpbXzO6JP+MKDZGW4u3c6J/31EHkQKDAW9aZp7
         DYG4mSZxzzUC8xwUqKG1BffoGc/kQA2+gdrNv/sU5QacN58/cRK0A6NhyN3Cm4CpR0VJ
         Ju7g==
X-Gm-Message-State: AOAM531FTzyj3l1wacBjozg3rUdtZwhwNkMxh13SUwVTrEiUrdkO+3XT
        c0rG52Sha/3fFCe0kXroJg0=
X-Google-Smtp-Source: ABdhPJyQ6oNwws9JqVd40NewMcu/lFOsIla9Y+TTF3gVGnye95+Znm2xVx8m7SfILRWekZO5yjeiAw==
X-Received: by 2002:a17:902:b714:: with SMTP id d20mr23801312pls.318.1595979985975;
        Tue, 28 Jul 2020 16:46:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:fcc5:69d8:6e20:4fd1? ([2601:647:4802:9070:fcc5:69d8:6e20:4fd1])
        by smtp.gmail.com with ESMTPSA id 12sm150351pfn.173.2020.07.28.16.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 16:46:25 -0700 (PDT)
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
Date:   Tue, 28 Jul 2020 16:46:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728135436.GP9247@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey Paul,

> Indeed you cannot.  And if you build with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> it will yell at you when you try.
> 
> You -can- pass on-stack rcu_head structures to call_srcu(), though,
> if that helps.  You of course must have some way of waiting for the
> callback to be invoked before exiting that function.  This should be
> easy for me to package into an API, maybe using one of the existing
> reference-counting APIs.
> 
> So, do you have a separate stack frame for each of the desired call_srcu()
> invocations?  If not, do you know at build time how many rcu_head
> structures you need?  If the answer to both of these is "no", then
> it is likely that there needs to be an rcu_head in each of the relevant
> data structures, as was noted earlier in this thread.
> 
> Yeah, I should go read the code.  But I would need to know where it is
> and it is still early in the morning over here!  ;-)
> 
> I probably should also have read the remainder of the thread before
> replying, as well.  But what is the fun in that?

The use-case is to quiesce submissions to queues. This flow is where we
want to teardown stuff, and we can potentially have 1000's of queues
that we need to quiesce each one.

each queue (hctx) has either rcu or srcu depending if it may sleep
during submission.

The goal is that the overall quiesce should be fast, so we want
to wait for all of these queues elapsed period ~once, in parallel,
instead of synchronizing each serially as done today.

The guys here are resisting to add a rcu_synchronize to each and
every hctx because it will take 32 bytes more or less from 1000's
of hctxs.

Dynamically allocating each one is possible but not very scalable.

The question is if there is some way, we can do this with on-stack
or a single on-heap rcu_head or equivalent that can achieve the same
effect.
