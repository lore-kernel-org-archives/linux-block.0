Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55C3C46467
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 13:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjAJNHz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjAJNHx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 08:07:53 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76FB5DE41
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:07:31 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id v3so8184424pgh.4
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0b3RSYe8mQauTsHJUs6ykMcTgur4za2xftvbQNqIJa0=;
        b=RLUlg0vAPGTz4hMSALnOAbA95CQ2QhiAPu67CW1t5ndi5fYQvoHNRfl2s9mmbfxynC
         n5Hl26i2wnPo3Po7VVrtnQueuJ9LNMFdRz54SOR0UzQpuEPMsDS42Z/bO4BEb4COnlqZ
         Yhl/RGwxFnAkY+cH1otEhavspwfCl0FOYahc2kH+YxTr3TQTFwyb+jOHwd6AbOmhbT/k
         UrCTqXrRr5OpYjY6+L/mYlkYPUtgEqwUoG1lp5ywtifFjrif5++oGbE8puNRSkItokP8
         ieNDdz1XkqTFKhhlST3mTca31Q50kVpZqKIC7YfgyJEYf+TFUH4gcW9m3mBKjOdd53dv
         s+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0b3RSYe8mQauTsHJUs6ykMcTgur4za2xftvbQNqIJa0=;
        b=YueqZ4oX8b4zcq0gHZF3RpON1qp1pbtudlgt13QAK9i7bBxK2vGAjwzRJZlT80JG4e
         Rnhz1DYprCm2GKArvWw+JCq/fU0ri+Yyx5LPrz+vw1pOsgJwCwf0cION6SXqcJeFTb/k
         xcDJhdJUal/i2zPKtm/iEsxVE+mpmcWMFg4GlITlgrebua5w8/CNXk28OaZCHgPQV1Rb
         OWjVmGOgdvN3iyViZjLhpG/mFGz+lJX0MzWnCyGndvkp4C7nWMs7awUWWBMsUoFxd/KA
         +oetjYVtUHrexhGZNqb077iDGHt20FxYRxckDyGyufARlrht1/+VVc+zBCZj4BJnys3x
         JmQA==
X-Gm-Message-State: AFqh2kq2+3D502weZRiqauqfzYe4bVBAQQhjT1o57cgnAnqqknrcIaBk
        K9+itQSMk0xbGPBrU/gjrcrrtw==
X-Google-Smtp-Source: AMrXdXuOnsxeqzWi+BrT/XazxVd/FkhSHxizdXq9xmqS2MG3LGJFCe4KApI5JgYxg1Fm6XPKXt5zLA==
X-Received: by 2002:aa7:85c8:0:b0:588:14ce:7e64 with SMTP id z8-20020aa785c8000000b0058814ce7e64mr7017731pfn.30.1673356051158;
        Tue, 10 Jan 2023 05:07:31 -0800 (PST)
Received: from [10.3.157.223] ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id v67-20020a622f46000000b00581ad007a9fsm8004776pfv.153.2023.01.10.05.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 05:07:30 -0800 (PST)
Message-ID: <f9b8e682-92aa-c39c-4d91-d77d104e0767@bytedance.com>
Date:   Tue, 10 Jan 2023 21:07:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [External] Re: [PATCH v3] blk-throtl: Introduce sync and async
 queues for blk-throtl
To:     Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
 <20230106153813.4ttyuikzaagkk2sc@quack3> <Y7hTHZQYsCX6EHIN@slm.duckdns.org>
 <c839ba6c-80ac-6d92-af64-5c0e1956ae93@bytedance.com>
 <Y7hlX4T1UOmQHiGf@slm.duckdns.org>
 <e499f088-8ed9-2e19-b2e5-efaa4f9738f0@bytedance.com>
 <Y7xYJfRLSMYk9tj9@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <Y7xYJfRLSMYk9tj9@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2023/1/10 上午2:08, Tejun Heo 写道:
> Hello,
> 
> On Sat, Jan 07, 2023 at 12:44:35PM +0800, hanjinke wrote:
>> For cost.model setting, We first use the tools iocost provided to test the
>> benchmark model parameters of different types of disks online, and then save
>> these benchmark parameters to a parametric Model Table. During the
>> deployment process, pull and set the corresponding model parameters
>> according to the type of disk.
>>
>> The setting of cost.qos should be considered slightly more，we need to make
>> some compromises between overall disk throughput and io latency.
>> The average disk utilization of the entire disk on a specific business and
>> the RLA（if it is io sensitive） of key businesses will be taken as
>> important input considerations. The cost.qos will be dynamically fine-tuned
>> according to the health status monitoring of key businesses.
> 
> Ah, I see. Do you use the latency targets and min/max ranges or just fixate
> the vrate by setting min == max?

Currently we use the former.

> 
>> For cost.weight setting, high-priority services  will gain greater
>> advantages through weight settings to deal with a large number of io
>> requests in a short period of time. It works fine as work-conservation
>> of iocost works well according to our observation.
> 
> Glad to hear.
> 
>> These practices can be done better and I look forward to your better
>> suggestions.
> 
> It's still in progress but resctl-bench's iocost-tune benchmark is what
> we're starting to use:
> 
>   https://github.com/facebookexperimental/resctl-demo/blob/main/resctl-bench/doc/iocost-tune.md
> 
> The benchmark takes like 6 hours and what it does is probing the whole vrate
> range looking for behavior inflection points given the scenario of
> protecting a latency sensitive workload against memory leak. On completion,
> it provides several solutions based on the behavior observed.
> 
> The benchmark is destructive (to the content on the target ssd) and can be
> tricky to set up. There's installable image to help setting up and running
> the benchmark:
> 
>   https://github.com/iocost-benchmark/resctl-demo-image-recipe/actions
> 
> The eventual goal is collecting these benchmark results in the following git
> repo:
> 
>   https://github.com/iocost-benchmark/iocost-benchmarks
> 
> which generates hwdb files describing all the found solution and make
> systemd apply the appropriate configuration on boot automatically.
> 
> It's still all a work in progress but hopefully we should be able to
> configure iocost reasonably on boot on most SSDs.
> 
> Thanks.
> 

These methodologies are worthy of our study and will definitely help our 
future deployment of iocost. Thanks a lot.

Thanks.

