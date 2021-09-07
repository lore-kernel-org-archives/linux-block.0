Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB91FC433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 16:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2BBA61100
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 16:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345186AbhIGQul (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 12:50:41 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:38787 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344728AbhIGQuk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 12:50:40 -0400
Received: by mail-pl1-f182.google.com with SMTP id u1so6192995plq.5;
        Tue, 07 Sep 2021 09:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ckxfBj+sYI6pH4j0PxlAxe4sHMsPjnlvuDhP/EE4qY=;
        b=c0fvzMxm3F+sA5SvCRjsemr7j0rC222bzIvyeKcfwpuZsV4c1yGJ3IKu2eHVFh43x+
         Ifmr+cOo4HKVQtsO+GA9L9dQUe12kcClU4tiGMSH6eLVlPGa0anN0vWCDU2HITZ92frz
         1kDFAsnxx7szbdX+owvwbTJX7WDInraEF5ENTyGGDXUBcqhVgRmIWD2QhHTDMa0VkU8x
         AS5AlCZ3NQqHEfXMRknKfpXYlvTUkNe334sZIcgXmKQtIWmxXZAizfieo2N5G4Jx5ZD2
         bVUqzjDWNSgVV+ErCOvkh1BIF8bKDuphhTCRNwpKfXsDa/zTZcLjEN+i+MsYbcn4opEz
         URgg==
X-Gm-Message-State: AOAM532Ajz+oo6IVoSbHE73giO+fQFerJOQVuFkPOhuLe4L0vukgaQT6
        +8siMfpfNqEjeqg+OagRzUmwCA+RXHQ=
X-Google-Smtp-Source: ABdhPJxphsb8FOvB+uoa7Gm2EDTY66FANVE1F8aLchUDLMCQWf+CsKiNxP5ZilZWGxsW6LbVDZN7mg==
X-Received: by 2002:a17:90b:e8e:: with SMTP id fv14mr5572970pjb.150.1631033373499;
        Tue, 07 Sep 2021 09:49:33 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id n3sm11087304pfo.101.2021.09.07.09.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 09:49:32 -0700 (PDT)
Subject: Re: [PATCH 2/2] Revert "mq-deadline: Fix request accounting"
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210907142145.112096-1-Niklas.Cassel@wdc.com>
 <20210907142145.112096-3-Niklas.Cassel@wdc.com>
 <d544384b-617f-b7a4-f895-72adc900f41b@acm.org> <YTeOW+GoW/Ps2NXq@x1-carbon>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <36d25cd9-f4ec-0e7f-cbf0-19a71e7d781a@acm.org>
Date:   Tue, 7 Sep 2021 09:49:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTeOW+GoW/Ps2NXq@x1-carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/21 9:07 AM, Niklas Cassel wrote:
> On Tue, Sep 07, 2021 at 07:54:09AM -0700, Bart Van Assche wrote:
>> Please take a look at
>> https://lore.kernel.org/linux-block/18594aff-4a94-8a48-334c-f21ae32120c6@acm.org/
>> If dd_prepare_request() is removed I will have to reintroduce it.
> 
> dd_prepare_request() itself is not removed, just the
> rq->elv.priv[0] = NULL; inside dd_prepare_request().
> 
> If you need to modify dd_prepare_request() in a future
> commit, that should be fine, no?
> 
> Without patch 1/2, e->type->ops.requeue_request() can get called
> both for requests that bypassed the I/O scheduler, and for requests
> that were inserted in the I/O scheduler.
> 
> See:
> block/blk-mq-sched.h:blk_mq_sched_requeue_request()
> If the RQF_ELVPRIV flag is not set, e->type->ops.requeue_request()
> will not be called.
> 
> Perhaps you are having issues with requests that were inserted
> in the scheduler, but later requeued?
> 
> If so, shouldn't these fixes help you, since you do not need to
> worry about passthrough requests resulting in spurious calls to
> the I/O scheduler callbacks?

In my comment I was indeed referring to requeued requests. If a request
is requeued the scheduler insert callback function is called multiple
times. From my point of view this patch series doesn't help much since
requeued requests are not addressed.

Thanks,

Bart.
