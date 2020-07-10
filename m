Return-Path: <SRS0=lEwc=AV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E60EC433DF
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 08:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56FB7207BC
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 08:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="ZuTu3kyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGJIz1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgGJIz1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jul 2020 04:55:27 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A60DC08C5CE
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2020 01:55:27 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p20so5189173ejd.13
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2020 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0bJMQiYpjt/HC4FJebPKex9OnNIQBMQPpAb4Ycewq8o=;
        b=ZuTu3kyOv2WuDhlPJH3pN72LGEPpEQdUZUIUQ6emr7K9VsDPTSqIG3dcAQYtas9Guq
         3mM49UF7C+aHYplQp3auIIxNnIvoG1mAOJ+CS1o3QfG2BTQE3JZfenoNCEGwKxUBRTk5
         zdat1RLa4LKsiIJx5RGbgMZ4XRvODbARXe/CA1FPwXl0izrH4ZaPDGTqGSNAoKErcNuU
         iHplnhZ+Vd48GBh8TAHNapBCEWhgOfqVzdunOPUKDnOht75j08Wu0cNz2/Y85N6XDchs
         IjHOTOMP3Nq9aEiWhn6JYtcY0kRevIBpgovr8c/KcyoK1yBdWw4rKmVBsus8LrDgRRfM
         QKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0bJMQiYpjt/HC4FJebPKex9OnNIQBMQPpAb4Ycewq8o=;
        b=r25fFiESULQ7A7Iso/S4UiKFURZ9wmND82TRCVqsjT1l57Y/DI9qG1aoTDftqM/+wi
         35ZJY2VMFand4dr/gOW2uQtDunYiVyKJkpHR0cAaTSFIGkMxpud7QBxUEzowH+u25IAG
         YrPxbD0dpUCkKmHUqPzt1xZV4sSkhrACt/Qa4U8aA0TZftgl27FG4/90+13tqx1mWXfK
         RJTHv820zBsrO3+7ZzbEqbsfEYrU9AsQI3XrnWk4dPafkKMAoFbFofY+eCI+wRlNu4dT
         ca067mmMi1kItmV8nRtBxEJj7ItsvyhvhmpQNXyBDTS4YFvMKjJq2ef2C7qa5BbJV6bI
         6FiQ==
X-Gm-Message-State: AOAM530kjZ4ULzd/ux7BAgN2Be9p+h49K5cxOvl2GT51ZaUM8gKHSMtN
        ofpUdBJG5kYvLj14EhVfop9LpQ==
X-Google-Smtp-Source: ABdhPJzOiymsB8hK0bpo3MI2agyGX/Cd9TH/cNYmbwWIlMbiVbADGHhuTBf98xXLmRqhMeqc/13Ysg==
X-Received: by 2002:a17:906:ce3c:: with SMTP id sd28mr56471533ejb.382.1594371325921;
        Fri, 10 Jul 2020 01:55:25 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48b5:3c00:587:bfc1:3ea4:c2f6? ([2001:16b8:48b5:3c00:587:bfc1:3ea4:c2f6])
        by smtp.gmail.com with ESMTPSA id be2sm3875032edb.92.2020.07.10.01.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 01:55:25 -0700 (PDT)
Subject: Re: [PATCH RFC 4/5] block: add a statistic table for io latency
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
 <20200708075819.4531-5-guoqing.jiang@cloud.ionos.com>
 <20200708132958.GC3340386@T590>
 <eb2cf4d0-4260-8f10-0ba9-3cbf4ff85449@cloud.ionos.com>
 <b37dd9cd-aebc-88ee-2b09-ac4eb36ca0f7@cloud.ionos.com>
 <cc04e449-3d41-3ef7-10c2-c257512d7650@cloud.ionos.com>
 <20200710005354.GA3395574@T590>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <f1243a13-8773-f943-a6c3-021cde0eb661@cloud.ionos.com>
Date:   Fri, 10 Jul 2020 10:55:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710005354.GA3395574@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On 7/10/20 2:53 AM, Ming Lei wrote:
> Hi Guoqing,
>
> On Thu, Jul 09, 2020 at 08:48:08PM +0200, Guoqing Jiang wrote:
>> Hi Ming,
>>
>> On 7/8/20 4:06 PM, Guoqing Jiang wrote:
>>> On 7/8/20 4:02 PM, Guoqing Jiang wrote:
>>>>> Hi Guoqing,
>>>>>
>>>>> I believe it isn't hard to write a ebpf based script(bcc or
>>>>> bpftrace) to
>>>>> collect this kind of performance data, so looks not necessary to do it
>>>>> in kernel.
>>>> Hi Ming,
>>>>
>>>> Sorry, I don't know well about bcc or bpftrace, but I assume they
>>>> need to
>>>> read the latency value from somewhere inside kernel. Could you point
>>>> how can I get the latency value? Thanks in advance!
>>> Hmm, I suppose biolatency is suitable for track latency, will look into
>>> it.
>> I think biolatency can't trace data if it is not running,
> Yeah, the ebpf prog is only injected when the trace is started.
>
>> also seems no
>> place
>> inside kernel have recorded such information for ebpf to read, correct me
>> if my understanding is wrong.
> Just record the info by starting the bcc script in case you need that, is there
> anything wrong with this usage? Always doing such stuff in kernel isn't fair for
> users which don't care or need this info.

That is why we add a Kconfig option and set it to N by default. And I 
suppose
with modern cpu, the cost with several more instructions would not be that
expensive even the option is enabled, just my $0.02.

>> And as cloud provider,we would like to know data when necessary instead
>> of collect data by keep script running because it is expensive than just
>> read
>> node IMHO.
> It shouldn't be expensive. It might be a bit slow to inject the ebpf prog because
> the code has to be verified, however once it is put inside kernel, it should have
> been efficient enough. The kernel side prog only updates & stores the latency
> summery data into bpf map, and the stored summery data can be read out anytime
> by userspace.
>
> Could you explain a bit why it is expensive? such as biolatency

I thought I am compare read a sys node + extra instructions in kernel with
launch a specific process for monitoring which need to occupy more
resources (memory) and context switch. And for biolatency, it calls the
bpf_ktime_get_ns to calculate latency for each IO which I assume the
ktime_get_ns will be triggered finally, and it is not cheap as you said.

Of course, we will keep the change in our own tree if it doesn't make sense
to others.

Thanks,
Guoqing
