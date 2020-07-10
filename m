Return-Path: <SRS0=lEwc=AV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B332AC433DF
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 10:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0182076A
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 10:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="P0WMIyv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGJK3d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJK3d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jul 2020 06:29:33 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40593C08C5CE
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2020 03:29:31 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d18so4257350edv.6
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2020 03:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=guMByvYox8dZafcuC4tjfqWQaoFomOX1bLfR2T1h3+8=;
        b=P0WMIyv8jU/P9xokL7HGoyHJNqLOgslKdQls3Kw7SvAhDytFUWub1D5YIJ322JH855
         mfvUMaSObFGEth+TQpLd7RXbrm2tPwUYU9uiRmM/avi1PLBaCq/45LFWM6ivdaehaokD
         JHtut9nJKhWmO0KVfRMIefzv1wR/iMG2IE1EM83M8JP/MAo724avkdXbhA3kZJktooOx
         kNrGEyNlfzTlK285D6xl7QXMizIAqfILYo++CpnQIfRCtrdBN6yMrajKIvjXD16opIec
         hLYRit/ceO6KA9NvkLuwoZcc8pSVyzMsMo8TuqpDqod8ciZnX6ep5cFHpswLja19Ccku
         aCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=guMByvYox8dZafcuC4tjfqWQaoFomOX1bLfR2T1h3+8=;
        b=lN82nZUJY26q8mtoIrGejBb99x9HBWH/xAXa2O4wCtJbuzplDBOHMILrmdXCbxHydk
         tTyy2HPZi2Uy8rbHGj+pNSmJ1DxtkFH4PD0pfMdlwQXTW0aVo1/EeDNLFHr9JhX1rAqX
         IgFV1Aeet0INWvrhM5LApDyY59DUiJXoTkwAUHd79Lxh4SLHaE/gWRuCBz1Z5w37WzZN
         KEQSWKAqPXNqQRrDWr8dtUxMoQX+OMnauQuhNompGg64VfA9ATo/ERIk7fhMUhtaTh3a
         VUFckLwSInYaxC17Q8ttgu408hwwMYeNfPbDmnsNCHQPa61ft4e454Y2Uxu8Dw9mSX7j
         pcHA==
X-Gm-Message-State: AOAM531yHTM8/Q1FBBQFTCruaAJNqBr24yahLHIgpkszOBPI+lMZAgRJ
        YuJDfhITjHr9sK6805ldIZL7qkcGmPfKkw==
X-Google-Smtp-Source: ABdhPJzIQPigt+CenoqqQDt3XKegLHN6+ysBl5Y4e8wQt6vEjMlA97Tz6qGodLxsHpgbb9QbOqj+Bg==
X-Received: by 2002:a50:e791:: with SMTP id b17mr80714668edn.366.1594376969972;
        Fri, 10 Jul 2020 03:29:29 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48b5:3c00:587:bfc1:3ea4:c2f6? ([2001:16b8:48b5:3c00:587:bfc1:3ea4:c2f6])
        by smtp.gmail.com with ESMTPSA id u13sm3419827ejx.3.2020.07.10.03.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 03:29:29 -0700 (PDT)
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
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <c772fa01-2fe3-b72f-a7d9-193dde7b165c@cloud.ionos.com>
Date:   Fri, 10 Jul 2020 12:29:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710100051.GA3418163@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/10/20 12:00 PM, Ming Lei wrote:
> On Fri, Jul 10, 2020 at 10:55:24AM +0200, Guoqing Jiang wrote:
>> Hi Ming,
>>
>> On 7/10/20 2:53 AM, Ming Lei wrote:
>>> Hi Guoqing,
>>>
>>> On Thu, Jul 09, 2020 at 08:48:08PM +0200, Guoqing Jiang wrote:
>>>> Hi Ming,
>>>>
>>>> On 7/8/20 4:06 PM, Guoqing Jiang wrote:
>>>>> On 7/8/20 4:02 PM, Guoqing Jiang wrote:
>>>>>>> Hi Guoqing,
>>>>>>>
>>>>>>> I believe it isn't hard to write a ebpf based script(bcc or
>>>>>>> bpftrace) to
>>>>>>> collect this kind of performance data, so looks not necessary to do it
>>>>>>> in kernel.
>>>>>> Hi Ming,
>>>>>>
>>>>>> Sorry, I don't know well about bcc or bpftrace, but I assume they
>>>>>> need to
>>>>>> read the latency value from somewhere inside kernel. Could you point
>>>>>> how can I get the latency value? Thanks in advance!
>>>>> Hmm, I suppose biolatency is suitable for track latency, will look into
>>>>> it.
>>>> I think biolatency can't trace data if it is not running,
>>> Yeah, the ebpf prog is only injected when the trace is started.
>>>
>>>> also seems no
>>>> place
>>>> inside kernel have recorded such information for ebpf to read, correct me
>>>> if my understanding is wrong.
>>> Just record the info by starting the bcc script in case you need that, is there
>>> anything wrong with this usage? Always doing such stuff in kernel isn't fair for
>>> users which don't care or need this info.
>> That is why we add a Kconfig option and set it to N by default. And I
>> suppose
>> with modern cpu, the cost with several more instructions would not be that
>> expensive even the option is enabled, just my $0.02.
>>
>>>> And as cloud provider,we would like to know data when necessary instead
>>>> of collect data by keep script running because it is expensive than just
>>>> read
>>>> node IMHO.
>>> It shouldn't be expensive. It might be a bit slow to inject the ebpf prog because
>>> the code has to be verified, however once it is put inside kernel, it should have
>>> been efficient enough. The kernel side prog only updates & stores the latency
>>> summery data into bpf map, and the stored summery data can be read out anytime
>>> by userspace.
>>>
>>> Could you explain a bit why it is expensive? such as biolatency
>> I thought I am compare read a sys node + extra instructions in kernel with
>> launch a specific process for monitoring which need to occupy more
>> resources (memory) and context switch. And for biolatency, it calls the
>> bpf_ktime_get_ns to calculate latency for each IO which I assume the
>> ktime_get_ns will be triggered finally, and it is not cheap as you said.
> You can replace one read of timestamp with rq->start_time_ns too, just
> like what this patch does. You can write your bcc/bfptrace script,
> which is quite easy to start. Once you learn its power, maybe you will love
> it.

Yes, I definitely need to learn more about it :-). But even with the 
change,
I still believe read a node is cheaper than a script.

And seems biolatency can't trace bio based driver per below, and with
collect data in tree we can trace all block drivers.

# load BPF program
b = BPF(text=bpf_text)
if args.queued:
     b.attach_kprobe(event="blk_account_io_start", 
fn_name="trace_req_start")
else:
     b.attach_kprobe(event="blk_start_request", fn_name="trace_req_start")
     b.attach_kprobe(event="blk_mq_start_request", 
fn_name="trace_req_start")
b.attach_kprobe(event="blk_account_io_completion",
     fn_name="trace_req_completion")

Could it possible to extend it support trace both request and bio? Otherwise
we have to run another script to trace md raid.

Thanks,
Guoqing
