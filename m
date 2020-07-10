Return-Path: <SRS0=lEwc=AV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A067DC433E4
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 14:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E552088E
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 14:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OWFvFVo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgGJOEo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGJOEo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jul 2020 10:04:44 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F6BC08C5CE
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2020 07:04:44 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id k6so5150983ili.6
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2020 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S+IEIUgGdDXtWlxBm6Rde4lOM1eNnt/a6bknMULuVK0=;
        b=OWFvFVo9sSocPV8f40g5h63XT8Ub5jDqPzOKeyJ885JUyjd+IyBksgOcSOyJcQqBVF
         jdkot1U2ftlX9uO1cVkXJfIZujUJnU9zK+7Rz8PzXHU1TyFno44gPELn1CaOwMQgVyr9
         m+VtbGR9v8zFA23dnPwaI+4JwXsxAZpKHmoRRd4JU7jMt7pRB+ttp3mqdaLaDkyuZl8C
         J2Ndw/TTSvS3VHKqS4QyRn991dFozp0Sy5cuHl7ByDnLGSXL9jBx0Gig3HO2aZqvbrYk
         XG1UaqdrCE6LrKPkXQ7ni3JbkYobDiFCZKvGbKOHcIOzFV7ql5Iee1DfgVoPy0glyP/o
         MSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S+IEIUgGdDXtWlxBm6Rde4lOM1eNnt/a6bknMULuVK0=;
        b=hfG9uVlS/1U3Q2qbal9PTKJ4070j7FEaOoVUsGrvl97ohVnrldX9m6YH4GG6uK28NA
         g47oYd3zIfOdbh5B0SUNnb0i3yw/d/AjscjFZuy+hmeD5MGzUC6sUhuMYy+4kkz7Fesn
         I1iU+2R8n7vyM1jSSek+DX9brS07pDeApDFZm+aYcUuIrwJoCw9v2y2eVsQPCesQEWUy
         p7w8gY7gJQzlRPGRnZLGX+8DpxVnzsj5BxflSLUIS9cLMeD25bVl6LYY8A8oxIREoV/B
         586w7ZhkPlqyU5Ycqo7oeOGIL+ZShYSqW276CP43yzy2Ugu2rbppwww3KNrsCAkVxjni
         bfdA==
X-Gm-Message-State: AOAM530RG42TCjDyg+2KFdzMRRt/7QlCLw0a4hNZPzLKQ4uCUaSzWGJC
        8bMxBW8Y5iSe0ErR4ckiIK5IOg==
X-Google-Smtp-Source: ABdhPJzIKmEpbVfTewLRHxPOhULW9PgWej+1MrzCXjaBzXsFLv/DBY1YMhEPjdQ2Tbt824rFwel4Cw==
X-Received: by 2002:a92:25c9:: with SMTP id l192mr50937334ill.135.1594389883468;
        Fri, 10 Jul 2020 07:04:43 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m5sm3413423ilg.18.2020.07.10.07.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:04:42 -0700 (PDT)
Subject: Re: [PATCH RFC 4/5] block: add a statistic table for io latency
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
 <20200708075819.4531-5-guoqing.jiang@cloud.ionos.com>
 <20200708132958.GC3340386@T590>
 <eb2cf4d0-4260-8f10-0ba9-3cbf4ff85449@cloud.ionos.com>
 <b37dd9cd-aebc-88ee-2b09-ac4eb36ca0f7@cloud.ionos.com>
 <cc04e449-3d41-3ef7-10c2-c257512d7650@cloud.ionos.com>
 <20200710005354.GA3395574@T590>
 <f1243a13-8773-f943-a6c3-021cde0eb661@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <63abcf56-576b-6ab4-8bbe-dfe34fbb7598@kernel.dk>
Date:   Fri, 10 Jul 2020 08:04:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f1243a13-8773-f943-a6c3-021cde0eb661@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/10/20 2:55 AM, Guoqing Jiang wrote:
> Hi Ming,
> 
> On 7/10/20 2:53 AM, Ming Lei wrote:
>> Hi Guoqing,
>>
>> On Thu, Jul 09, 2020 at 08:48:08PM +0200, Guoqing Jiang wrote:
>>> Hi Ming,
>>>
>>> On 7/8/20 4:06 PM, Guoqing Jiang wrote:
>>>> On 7/8/20 4:02 PM, Guoqing Jiang wrote:
>>>>>> Hi Guoqing,
>>>>>>
>>>>>> I believe it isn't hard to write a ebpf based script(bcc or
>>>>>> bpftrace) to
>>>>>> collect this kind of performance data, so looks not necessary to do it
>>>>>> in kernel.
>>>>> Hi Ming,
>>>>>
>>>>> Sorry, I don't know well about bcc or bpftrace, but I assume they
>>>>> need to
>>>>> read the latency value from somewhere inside kernel. Could you point
>>>>> how can I get the latency value? Thanks in advance!
>>>> Hmm, I suppose biolatency is suitable for track latency, will look into
>>>> it.
>>> I think biolatency can't trace data if it is not running,
>> Yeah, the ebpf prog is only injected when the trace is started.
>>
>>> also seems no
>>> place
>>> inside kernel have recorded such information for ebpf to read, correct me
>>> if my understanding is wrong.
>> Just record the info by starting the bcc script in case you need that, is there
>> anything wrong with this usage? Always doing such stuff in kernel isn't fair for
>> users which don't care or need this info.
> 
> That is why we add a Kconfig option and set it to N by default. And I 
> suppose
> with modern cpu, the cost with several more instructions would not be that
> expensive even the option is enabled, just my $0.02.

Never justify it with a Kconfig option, that doesn't help anything at
all. Distros then enable it, and all users are stuck with this overhead.
The ktime_get() is definitely extra overhead.

FWIW, I agree with Ming here in that this can easily be done from
userspace. And if that's the case, then I don't see why everybody should
carry this extra burden.

-- 
Jens Axboe

