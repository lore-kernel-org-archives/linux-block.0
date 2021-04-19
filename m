Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46307C433B4
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 17:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13108611F2
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 17:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbhDSR6T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbhDSR6T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 13:58:19 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B02EC061761
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 10:57:49 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id y10so7977410ilv.0
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uwWLsde78U+OWRMpAjedbXCKjqXJtKh6CIJWySBCdmM=;
        b=vFplaac525AEqujuV4Fu5iyM0e2d5ZsVWmqaRNvyhEVJxMYx1sH+1JaT7cplK0vRCp
         xI4pDa3MRP3FWHJHU0oDmYRBS+EiNsyOprdfY0o8BEdtukatn1W4+nhdhVHVJs6xGEEy
         RFin9gLiSDXxV6kcbWgMo9KNlCt9RM/uiMVicPqZIIOQj70QEWCwxdjVVfeqnsdlr17q
         AsDkPsX6+ZlGgq+eBijwgiAo6hJh7ggq++Gl6Q5Yx8qGRTx+WSgKelNYRA5qEigDprel
         41tRfIdepAxqzuNZiV2IHA+ZjRDfvQd7ZCDtimx2wJNybv9aV2Brv/9K2XdMHDWoKg1h
         raMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uwWLsde78U+OWRMpAjedbXCKjqXJtKh6CIJWySBCdmM=;
        b=CMEfJtZKOVIFs7WLQ+4AwjomTLhg8JclwvmRXYnLv0RmsP7nZ4Xtltoat6fIn4itSG
         3jaCeiEG6EfX8MR935lneLLqMYIP79sZKkPDOhbBUYgR/gTTlfqKilnKKJT6/0ImF7KQ
         vueyy+1W4BTO633IY6smmsKD/XjT79T1nKhKMshMgxu9A5ZiXBfZuPfVWpGNQmcOXMSh
         vtAkxHreWdNEItWtfckH3u5MnBIFe0OKH+iPCCjm/D6CfgXy0OU8/QOQUOUhjoEJbMJl
         xhGDl7jNZ6+T3W6jIBJyFVyR6EG8xSpT0opIYub0SkQ6jE+GluAUQN/pva/oW/M4IijE
         gd9w==
X-Gm-Message-State: AOAM531vscRMzy43Sadzr7rCL/KjwPkOZR4WhBMqgeL2YbqRtt1Q1mmJ
        U/LVVQXuM8MEUv/1FgO7TVPq+Q==
X-Google-Smtp-Source: ABdhPJwcCbNrr2lSjhGw5e/V2+XmesOV4Ln+dd87H9ZiRemGnyxDKIkKLXzsxOmrUSe9/ijcTe0BpA==
X-Received: by 2002:a92:320f:: with SMTP id z15mr16366027ile.231.1618855068517;
        Mon, 19 Apr 2021 10:57:48 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r16sm7145044ioc.29.2021.04.19.10.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 10:57:47 -0700 (PDT)
Subject: Re: [PATCH V6 0/3] block: add two statistic tables
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Md Haris Iqbal <haris.iqbal@ionos.com>,
        linux-block <linux-block@vger.kernel.org>,
        Danil Kipnis <danil.kipnis@ionos.com>
References: <20210409160305.711318-1-haris.iqbal@ionos.com>
 <ef59e838-4d7f-cab4-e1ac-26944cb7db75@kernel.dk>
 <CAMGffE=ZdCUc_HABY3_F_aK6pqCt8maB4yi9Qu4gKoox6ub6QQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <16182211-0e85-540d-1061-6411ec3351a5@kernel.dk>
Date:   Mon, 19 Apr 2021 11:57:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMGffE=ZdCUc_HABY3_F_aK6pqCt8maB4yi9Qu4gKoox6ub6QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/21 11:35 PM, Jinpu Wang wrote:
> On Fri, Apr 9, 2021 at 11:03 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 4/9/21 10:03 AM, Md Haris Iqbal wrote:
>>> Hi Jens,
>>>
>>> This version fixes the long lines in the code as per Christoph's comment.
>>
>> I'd really like to see some solid justification for the addition,
>> though. I clicked the v1 link and it's got details on what you get out
>> of it, but not really the 'why' of reasoning for the feature. I mean,
>> you could feasibly have a blktrace based userspace solution. Just
>> wondering if that has been tried, I know that's what we do at Facebook
>> for example.
>>
> Hi Jens,
> 
> Thanks for the reply.
> For the use case of the additional stats, as a cloud provider, we
> often need to handle report from the customers regarding
> performance problem in a period of time in the past, so it's not
> feasible for us to run blktrace, customer workload could change from
> time to time, with the additional stats, we gather through all metrics
> using Prometheus, we can navigate to the period of time interested,
> to check if the performance matches the SLA, it also helps us to find
> the user IO pattern,  we can more easily reproduce.

My suggestion isn't to run just blktrace all the time, rather collect
the tracing info from there and store them away. Then you can go back
in time and see what is going on. Hence my questioning on adding this
new stat tracking, when it's already readily available to be consumed
by a small daemon that can continually track it in userspace.

-- 
Jens Axboe

