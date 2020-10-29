Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAC7C2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 20:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1962087D
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 20:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgJ2UDf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 16:03:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43752 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2UDe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 16:03:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so4091782wrp.10;
        Thu, 29 Oct 2020 13:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L2/NcJj+iHYkGDNkmgcYCv1Kv0O8+QeL39KIf4j5s4g=;
        b=hKGxXo1BI5C8fKuk0N6xNS+pDYiIw9dbPdhtQMfjMGCUkYdSKE2sQPpn8R8IyuvUsa
         hqchIgDyp5Bixq0kNdG55IdCgCWJTE62ogSJKoOp7PPyMxKUB+55t5ak7yPLm+WGvIlA
         uOi4yJxb92l6v04dYp3QduMz3yRRyn4p5qm0ZmuBqk32SRHc6SCY1IzDSOGZEbsEVjUi
         ejj3Y6GW9lRtU6Pr8FG0rboSUvQlzFZ91cIUT716iTDOXbvDcNjMv1QsL9nDoyQYlnCO
         RThdknu9ukJ6vQQKGEuwJIVAvXYaVIB08ryqAB2rbHtckYBGkmdb0/ZUN89Vsn9F7A5O
         KRmA==
X-Gm-Message-State: AOAM530zXL8w3fJcy+uBDmVV+QhgFUxJRh/0nkVTDSBGj+pHg1syp4lk
        FJH/buf19XY8XVdBh5MRIn0kdwCxizo=
X-Google-Smtp-Source: ABdhPJyl2gtV0/dunbmSNCoHhsW2+X6ivjkDdN7o58QU9x31MfatD3jnuHMyJzQ3n/yQ9xXV/ajtvA==
X-Received: by 2002:a5d:660a:: with SMTP id n10mr4364043wru.59.1604001812246;
        Thu, 29 Oct 2020 13:03:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d32:e3ef:ad74:6ea9? ([2601:647:4802:9070:d32:e3ef:ad74:6ea9])
        by smtp.gmail.com with ESMTPSA id r18sm7687328wrj.50.2020.10.29.13.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 13:03:31 -0700 (PDT)
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
To:     Christoph Hellwig <hch@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d2c15411-5b21-535b-6e07-331ebe22f8c8@grimberg.me>
Date:   Thu, 29 Oct 2020 13:03:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029145743.GA19379@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> Well, usb-storage obviously seems to do it, and the block layer
>>> does not prohibit it.
>>
>> Also loop, nvme-tcp and then I stopped looking.
>> Any objections about adding local_bh_disable() around it?
> 
> To me it seems like the whole IPI plus potentially softirq dance is
> a little pointless when completing from process context.

I agree.

> Sagi, any opinion on that from the nvme-tcp POV?

nvme-tcp should (almost) always complete from the context that matches
the rq->mq_ctx->cpu as the thread that processes incoming
completions (per hctx) should be affinitized to match it (unless cpus
come and go).

So for nvme-tcp I don't expect blk_mq_complete_need_ipi to return true
in normal operation. That leaves the teardowns+aborts, which aren't very
interesting here.

I would note that nvme-tcp does not go to sleep after completing every
I/O like how sebastian indicated usb does.

Having said that, today the network stack is calling nvme_tcp_data_ready
in napi context (softirq) which in turn triggers the queue thread to
handle network rx (and complete the I/O). It's been measured recently
that running the rx context directly in softirq will save some
latency (possible because nvme-tcp rx context is non-blocking).

So I'd think that patch #2 is unnecessary and just add overhead for
nvme-tcp.. do note that the napi softirq cpu mapping depends on the RSS
steering, which is unlikely to match rq->mq_ctx->cpu, hence if completed
from napi context, nvme-tcp will probably always go to the IPI path.

