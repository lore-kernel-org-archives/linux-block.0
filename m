Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDFAC2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 21:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CBE120790
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 21:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgJ2VIH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:08:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37341 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJ2VIH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 17:08:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so4292621wrm.4;
        Thu, 29 Oct 2020 14:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vRtRiwlU8ma+WachtYWH3lvFwCoEOB/5npCtcFH4arM=;
        b=Qqo9u+8y6RgAucV9/rj+vJLU7UgQBfB9zeYcYMEnwoFjjhLHfOJuq9qrvAz8wniUhc
         8A8LVsycX+qcJChN/1P6LTm2oFvx+eOxn1898M3EbQ1dEVMS5CfFpTeib/u9Qe444LRf
         pPSHOUXRpHLRfZJcOd5UGDLs1IUYyu4Scr4ueG2wzc2AE2HKI9ijLF29mYBTwHHkQL9T
         sGml3oc5x68Bjf/pXafaCaZt7Tq5vT3Uzg8e+mx8zIegoWsEjlNPHTFjr7gQpU8n1Wwd
         IszOa6O3NxE2Da9Ce2r7zit01A777nPsf/43m8oBXJJmqtU6PizkLLo2uw27OWoeXILi
         ymCw==
X-Gm-Message-State: AOAM533Yd5g08N8v9y/gkeG+U2eDC7N2omuf5qBbdOCYSQEXiAJwJ1wi
        dKdfMaLdOctNUe/7weqPznMuxcSJ2ds=
X-Google-Smtp-Source: ABdhPJwlEUnf5ZZxL8cZAYnaiF+ZohwTaYPGQE5w+F7efNltZt9KtENx2daUBCQnA2YFQkCJAxREQg==
X-Received: by 2002:adf:c3cd:: with SMTP id d13mr7926005wrg.15.1604005684961;
        Thu, 29 Oct 2020 14:08:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d32:e3ef:ad74:6ea9? ([2601:647:4802:9070:d32:e3ef:ad74:6ea9])
        by smtp.gmail.com with ESMTPSA id c129sm1806971wmd.7.2020.10.29.14.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 14:08:04 -0700 (PDT)
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>, Mike Galbraith <efault@gmx.de>
References: <20201028065616.GA24449@infradead.org>
 <20201028141251.3608598-1-bigeasy@linutronix.de>
 <20201028141251.3608598-3-bigeasy@linutronix.de>
 <20201029131212.dsulzvsb6pahahbs@linutronix.de>
 <20201029140536.GA6376@infradead.org>
 <20201029145623.3zry7o6nh6ks5tjj@linutronix.de>
 <20201029145743.GA19379@infradead.org>
 <d2c15411-5b21-535b-6e07-331ebe22f8c8@grimberg.me>
 <20201029210103.ocufuvj6i4idf5hj@linutronix.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <deb40e55-d228-06c8-8719-fc8657a0a19b@grimberg.me>
Date:   Thu, 29 Oct 2020 14:07:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029210103.ocufuvj6i4idf5hj@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>> Well, usb-storage obviously seems to do it, and the block layer
>>>>> does not prohibit it.
>>>>
>>>> Also loop, nvme-tcp and then I stopped looking.
>>>> Any objections about adding local_bh_disable() around it?
>>>
>>> To me it seems like the whole IPI plus potentially softirq dance is
>>> a little pointless when completing from process context.
>>
>> I agree.
>>
>>> Sagi, any opinion on that from the nvme-tcp POV?
>>
>> nvme-tcp should (almost) always complete from the context that matches
>> the rq->mq_ctx->cpu as the thread that processes incoming
>> completions (per hctx) should be affinitized to match it (unless cpus
>> come and go).
> 
> in which context?

Not sure what is the question.

> But this is probably nr_hw_queues > 1?

Yes.

>> So for nvme-tcp I don't expect blk_mq_complete_need_ipi to return true
>> in normal operation. That leaves the teardowns+aborts, which aren't very
>> interesting here.
> 
> The process context invocation is nvme_tcp_complete_timed_out().

Yes.

>> I would note that nvme-tcp does not go to sleep after completing every
>> I/O like how sebastian indicated usb does.
>>
>> Having said that, today the network stack is calling nvme_tcp_data_ready
>> in napi context (softirq) which in turn triggers the queue thread to
>> handle network rx (and complete the I/O). It's been measured recently
>> that running the rx context directly in softirq will save some
>> latency (possible because nvme-tcp rx context is non-blocking).
>>
>> So I'd think that patch #2 is unnecessary and just add overhead for
>> nvme-tcp.. do note that the napi softirq cpu mapping depends on the RSS
>> steering, which is unlikely to match rq->mq_ctx->cpu, hence if completed
>> from napi context, nvme-tcp will probably always go to the IPI path.
> 
> but running it in softirq on the remote CPU would still allow of other
> packets to come on the remote CPU (which would block BLOCK sofirq if
> NET_RX is already running).

Not sure I understand your comment, if napi triggers on core X and we
complete from that, it will trigger IPI to core Y, and there with patch 
#2 is will trigger softirq instead of calling ->complete directly no?
