Return-Path: <SRS0=E+wN=EK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CEAC2D0A3
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 19:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9848206ED
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 19:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbgKDTPe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:15:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40364 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgKDTPe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Nov 2020 14:15:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id k18so3364280wmj.5;
        Wed, 04 Nov 2020 11:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7v8XNWb378ZY/CjlNvIn/30UioBbrTjZQwuMGRkG3IQ=;
        b=EWmns0/p6rhEnpxVmtUx4KY5rW8XtODDRB55Fd5q7SgcHF3xz7otJDvpCHoAqDOLKF
         swHbrN4ZQUlrbo98SFAZx9RQDB7VdgM0F+dpJQLD4fHUVXTpKDirSDRjN2ewKTqQac2P
         jHmyAuyBK3ylKJM4LgUxNlP173qIRfmp3UmyhGPlD3vU9PNs4Z+FK7eh19mlLaqtfJPf
         XNz/nngtLHa8OVa45Tw/4LljEGorm32t2kwt7OnI6jnsE0CxGtD3t3pXyd4LEO6f7ofC
         FLBMTkXYyqVpUHPL6oCLiVEyUODdBzjr0E0VFLtQ3HsR0Zk74bBapgN7O2KPayBLPpGS
         LOdA==
X-Gm-Message-State: AOAM530ZfGKKitBoUYHSQ5cmYJbuyZRl5cLhRi4UTHHG3+leqmQGBGdw
        uTMwU3rBKHuRHlLlCyNY0Hk=
X-Google-Smtp-Source: ABdhPJy+GUA1BUDCh53c1vQmUq/aXWgRuLFUU/fJOZ4/aRRtmTCr4ULfvetun6jIKGJqh/QpJQq0wg==
X-Received: by 2002:a1c:3103:: with SMTP id x3mr6148797wmx.107.1604517331370;
        Wed, 04 Nov 2020 11:15:31 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:f032:e586:d54c:b9cb? ([2601:647:4802:9070:f032:e586:d54c:b9cb])
        by smtp.gmail.com with ESMTPSA id n4sm3498536wmi.32.2020.11.04.11.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 11:15:30 -0800 (PST)
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
To:     Christoph Hellwig <hch@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>, Mike Galbraith <efault@gmx.de>
References: <20201029131212.dsulzvsb6pahahbs@linutronix.de>
 <20201029140536.GA6376@infradead.org>
 <20201029145623.3zry7o6nh6ks5tjj@linutronix.de>
 <20201029145743.GA19379@infradead.org>
 <d2c15411-5b21-535b-6e07-331ebe22f8c8@grimberg.me>
 <20201029210103.ocufuvj6i4idf5hj@linutronix.de>
 <deb40e55-d228-06c8-8719-fc8657a0a19b@grimberg.me>
 <20201031104108.wjjdiklqrgyqmj54@linutronix.de>
 <3bbfb5e1-c5d7-8f3b-4b96-6dc02be0550d@kernel.dk>
 <20201102095533.fxc2xpauzsoju7cm@linutronix.de>
 <20201102181238.GA17806@infradead.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <75970f9d-7e59-5fba-280a-d0d935fc4d2f@grimberg.me>
Date:   Wed, 4 Nov 2020 11:15:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102181238.GA17806@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> There really aren't any rules for this, and it's perfectly legit to
>>> complete from process context. Maybe you're a kthread driven driver and
>>> that's how you handle completions. The block completion path has always
>>> been hard IRQ safe, but possible to call from anywhere.
>>
>> I'm not trying to put restrictions and forbidding completions from a
>> kthread. I'm trying to avoid the pointless softirq dance for no added
>> value. We could:
> 
>> to not break that assumption you just mentioned and provide
>> |static inline void blk_mq_complete_request_local(struct request *rq)
>> |{
>> |                 rq->q->mq_ops->complete(rq);
>> |}
>>
>> so that completion issued from from process context (like those from
>> usb-storage) don't end up waking `ksoftird' (running at SCHED_OTHER)
>> completing the requests but rather performing it right away. The softirq
>> dance makes no sense here.
> 
> Agreed.  But I don't think your above blk_mq_complete_request_local
> is all that useful either as ->complete is defined by the caller,
> so we could just do a direct call.  Basically we should just
> return false from blk_mq_complete_request_remote after updating
> the state when called from process context.

Agreed.

> But given that IIRC
> we are not supposed to check what state we are called from
> we'll need a helper just for updating the state instead and
> ensure the driver uses the right helper.  Now of course we might
> have process context callers that still want to bounce to the
> submitting CPU, but in that case we should go directly to a
> workqueue or similar.

This would mean that it may be suboptimal for nvme-tcp to complete
requests in softirq context from the network context (determined by
NIC steering). Because in this case, this would trigger workqueue
schedule on a per-request basis rather than once per .data_ready
call like we do today. Is that correct?

It has been observed that completing commands in softirq context
(network determined cpu) because basically the completion does
IPI + local complete, not IPI + softirq or IPI + workqueue.

> Either way doing this properly will probabl involve an audit of all
> drivers, but I think that is worth it.

Agree.
