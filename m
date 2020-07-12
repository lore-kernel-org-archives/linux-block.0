Return-Path: <SRS0=lQ3E=AX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C138BC433E0
	for <linux-block@archiver.kernel.org>; Sun, 12 Jul 2020 20:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C36D20702
	for <linux-block@archiver.kernel.org>; Sun, 12 Jul 2020 20:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="FlADgjCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgGLUjF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Jul 2020 16:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbgGLUjE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Jul 2020 16:39:04 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D36C061794
        for <linux-block@vger.kernel.org>; Sun, 12 Jul 2020 13:39:04 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lx13so12886288ejb.4
        for <linux-block@vger.kernel.org>; Sun, 12 Jul 2020 13:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mU2Jt3mxGc+ogzNTOjDnN0vLE9ImZcdRO7UyOnAHs2s=;
        b=FlADgjCA32gG0ukB4SvIXs397DVudZOKOKvxuPl/ahqouBTk22b5cL5O2ovrlGN0eA
         tpxKpy31K4FZXFg2iPyuOwp1fwldUFVkAaraKcWnsG744jcpqbEhc17KE7s9ytkT0j/r
         ryOJXQjJmA2iPrVqipVnSMKcj6toRw1BmWEzm8tPYwL3BxG1AFfpqxRjo1kEWV0jypxC
         krBTp4T9sfxyLdvuNgkETyylFiqnF5QT4FkgRLYXB8GZTqCjuprazE2sdRWh4Wy6fjFM
         re55n/uzs2BuoDvYusUJOP11ViLj/I+GZ+NoPBUq1wIEQCRgq0gERiLb0oZ8CIF69Ped
         5mLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mU2Jt3mxGc+ogzNTOjDnN0vLE9ImZcdRO7UyOnAHs2s=;
        b=O4b4dAX91uiMCh/9UQUnsiQv9jAXPY1o89pxWla5Xnz99Xj86C2SoTkim3mffZFUEh
         wy5zMRnIesVH2gmrhWdbOkJUwzh/9uqasqPGYP7CTuPs2PNpmkwK/69GhqUifVgznS0j
         clcpha6wNBRC9N+67nD6RGFSghV/kmqtNKA7YyRuqjd3imbvzsTLe/09NyFuctmRCLC+
         RIZfp/cKOnEXgxcPbJ9RcbRkV5Wo25XjBPbqn8nHtxAp2QERf68Z2MLwxAiIIsVCsc6l
         s3Eru+ZOWzVmNGdLPU5K54HLqGWcxEnVIzZ7FGaa0feOGFPUwFJCkVVrDkSsdceqWws0
         MPDQ==
X-Gm-Message-State: AOAM532gch3usuhMv6Ujf8+BFwu7xjNTlfOGywlxR51c9DP6D1GCvIgH
        YSuxCAT8qyG2oCVMTlRSb9ICNg==
X-Google-Smtp-Source: ABdhPJyG8y3jsa5ETb2UuOQNgyTbcN+GycCqveZHEBmB3ACka6j+aShcWZHWZvdRuoOvNY8+HDzWtQ==
X-Received: by 2002:a17:906:c209:: with SMTP id d9mr47423861ejz.449.1594586342830;
        Sun, 12 Jul 2020 13:39:02 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48df:aa00:587:bfc1:3ea4:c2f6? ([2001:16b8:48df:aa00:587:bfc1:3ea4:c2f6])
        by smtp.gmail.com with ESMTPSA id u13sm8196466ejx.3.2020.07.12.13.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 13:39:02 -0700 (PDT)
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
 <f1243a13-8773-f943-a6c3-021cde0eb661@cloud.ionos.com>
 <20200710100051.GA3418163@T590>
 <c772fa01-2fe3-b72f-a7d9-193dde7b165c@cloud.ionos.com>
 <20200711013212.GA3426141@T590>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <26338809-3e75-0721-c19a-c7c92635c333@cloud.ionos.com>
Date:   Sun, 12 Jul 2020 22:39:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200711013212.GA3426141@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/20 3:32 AM, Ming Lei wrote:
> On Fri, Jul 10, 2020 at 12:29:28PM +0200, Guoqing Jiang wrote:
>> On 7/10/20 12:00 PM, Ming Lei wrote:
>>> On Fri, Jul 10, 2020 at 10:55:24AM +0200, Guoqing Jiang wrote:
>>>> Hi Ming,
>>>>
>>>> On 7/10/20 2:53 AM, Ming Lei wrote:
>>>>> Hi Guoqing,
>>>>>
>>>>> On Thu, Jul 09, 2020 at 08:48:08PM +0200, Guoqing Jiang wrote:
>>>>>> Hi Ming,
>>>>>>
>>>>>> On 7/8/20 4:06 PM, Guoqing Jiang wrote:
>>>>>>> On 7/8/20 4:02 PM, Guoqing Jiang wrote:
>>>>>>>>> Hi Guoqing,
>>>>>>>>>
>>>>>>>>> I believe it isn't hard to write a ebpf based script(bcc or
>>>>>>>>> bpftrace) to
>>>>>>>>> collect this kind of performance data, so looks not necessary to do it
>>>>>>>>> in kernel.
>>>>>>>> Hi Ming,
>>>>>>>>
>>>>>>>> Sorry, I don't know well about bcc or bpftrace, but I assume they
>>>>>>>> need to
>>>>>>>> read the latency value from somewhere inside kernel. Could you point
>>>>>>>> how can I get the latency value? Thanks in advance!
>>>>>>> Hmm, I suppose biolatency is suitable for track latency, will look into
>>>>>>> it.
>>>>>> I think biolatency can't trace data if it is not running,
>>>>> Yeah, the ebpf prog is only injected when the trace is started.
>>>>>
>>>>>> also seems no
>>>>>> place
>>>>>> inside kernel have recorded such information for ebpf to read, correct me
>>>>>> if my understanding is wrong.
>>>>> Just record the info by starting the bcc script in case you need that, is there
>>>>> anything wrong with this usage? Always doing such stuff in kernel isn't fair for
>>>>> users which don't care or need this info.
>>>> That is why we add a Kconfig option and set it to N by default. And I
>>>> suppose
>>>> with modern cpu, the cost with several more instructions would not be that
>>>> expensive even the option is enabled, just my $0.02.
>>>>
>>>>>> And as cloud provider,we would like to know data when necessary instead
>>>>>> of collect data by keep script running because it is expensive than just
>>>>>> read
>>>>>> node IMHO.
>>>>> It shouldn't be expensive. It might be a bit slow to inject the ebpf prog because
>>>>> the code has to be verified, however once it is put inside kernel, it should have
>>>>> been efficient enough. The kernel side prog only updates & stores the latency
>>>>> summery data into bpf map, and the stored summery data can be read out anytime
>>>>> by userspace.
>>>>>
>>>>> Could you explain a bit why it is expensive? such as biolatency
>>>> I thought I am compare read a sys node + extra instructions in kernel with
>>>> launch a specific process for monitoring which need to occupy more
>>>> resources (memory) and context switch. And for biolatency, it calls the
>>>> bpf_ktime_get_ns to calculate latency for each IO which I assume the
>>>> ktime_get_ns will be triggered finally, and it is not cheap as you said.
>>> You can replace one read of timestamp with rq->start_time_ns too, just
>>> like what this patch does. You can write your bcc/bfptrace script,
>>> which is quite easy to start. Once you learn its power, maybe you will love
>>> it.
>> Yes, I definitely need to learn more about it :-). But even with the change,
>> I still believe read a node is cheaper than a script.
>>
>> And seems biolatency can't trace bio based driver per below, and with
>> collect data in tree we can trace all block drivers.
>>
>> # load BPF program
>> b = BPF(text=bpf_text)
>> if args.queued:
>>      b.attach_kprobe(event="blk_account_io_start", fn_name="trace_req_start")
>> else:
>>      b.attach_kprobe(event="blk_start_request", fn_name="trace_req_start")
>>      b.attach_kprobe(event="blk_mq_start_request", fn_name="trace_req_start")
>> b.attach_kprobe(event="blk_account_io_completion",
>>      fn_name="trace_req_completion")
>>
>> Could it possible to extend it support trace both request and bio? Otherwise
>> we have to run another script to trace md raid.
> It is pretty easy to extend support bio, just add kprobe on submit_bio
> and bio_endio().
>

The thing is that we don't like the cost of ebpf based solution. And FWIW,
two years ago, we had compared about ebpf solution and record those
data in kernel.

A. in-kernel monitor: 1~5% performance drop
B. ebpf monitor: 10~15% performance drop

Note, we even copied each bio in approach A, which means the performance
could be more better since we don't clone bio now.

And I think the major concern is about the additional Kconfig option, since
Jens doesn't like it, so I guess no need to make the change it in upstream
kernel.

Thanks,
Guoqing
