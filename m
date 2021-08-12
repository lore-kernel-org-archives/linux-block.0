Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D4EC4338F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 18:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA0B6101E
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 18:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhHLS5P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 14:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhHLS5P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 14:57:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101DCC061756
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 11:56:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso16789943pjb.2
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 11:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HMMtcGN6kBWn4G2HuD1Q91lcBsss02J8sB36JWMDCeA=;
        b=FUV5Q+kR1m8rRoCPaZ84QndQ/NQWLPt+SRqxyCzv81YzcDEgX/x+Vb3Z17vB04Xdpe
         R3KghSck0MOak+WL4haV62i1wWdcXcwh9SuK74RKouqYqn3pHcYSGrHeieiS8GGW4P8W
         HgW/f+XoeTPpIyFkrFr+bw2AHVxMqTca8cx0hrPMVweVAmoG76vGJdgF8thWq468P4Q8
         2mOqev2hvsNrV5XecHrA2Rg1tOWvQsW/g2INgS4A22PYea3H9ov/aEvp3Wbuz1KLolqP
         So9/59tkNtxyNfXrPdq7czDyh5/dYR2XWoHfQMwIcSmaes/V32IJkQIVdFe3ugXzwoVm
         /7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HMMtcGN6kBWn4G2HuD1Q91lcBsss02J8sB36JWMDCeA=;
        b=L799lPP9mzRmOP4hazrJbzXzHr/XPtda4ouCV+1F29oguLZiwoAasSw9nIRP1S8lit
         Waw0OnNiXw4+oOGsauMYGJSmWCOU4YEKtPxTQf5RjxKmPARP/UGDkgAlFs8Mvq19k5hh
         whF1slFCQh3O1sHL3MJipH7KSeKBz39DiKyxjfw4gdGtncmv0c1L2cc68ibk7gVTwjKT
         CR21zukTkF3Rg2eBkIUtMLzryZCHZgikc/unBlcG6SPJsMViGh2+SYZU1WbehVB9FKt3
         3fEmKzCyUnJt78bjgof3Smt8A9Yy7uEm4FeuZU2q93RtH7ODuJoNAQkYEVAO2YtxbTu0
         bJ4g==
X-Gm-Message-State: AOAM533XEbPvTO0U+W6gb+hhwWKFKKgIPyjleTQOWD9ri5imbKriUsEi
        StUeyoKvxZMDQ22OAMARw9xiIMldtsJtT7mU
X-Google-Smtp-Source: ABdhPJzdW6eoygIymvyvd5pynI83pgutNGWIu04qKvZq8EcB9068+km/Oz0hUziY19/GuXkvJPYCNw==
X-Received: by 2002:a17:902:930b:b029:12c:a7f4:afb2 with SMTP id bc11-20020a170902930bb029012ca7f4afb2mr4687418plb.24.1628794609130;
        Thu, 12 Aug 2021 11:56:49 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id d31sm4738159pgd.33.2021.08.12.11.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 11:56:48 -0700 (PDT)
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
To:     Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
 <035f8334-3b69-667d-be91-92dcab9dc887@acm.org>
 <YRQhlPBqAlkJdowG@mtj.duckdns.org>
 <00e13a7b-6009-a9d7-41ba-aae82f5813de@acm.org>
 <YRVfmWnOyPYl/okx@mtj.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9441b463-50f8-e7c3-51ec-e4bc581da627@kernel.dk>
Date:   Thu, 12 Aug 2021 12:56:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YRVfmWnOyPYl/okx@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/21 11:51 AM, Tejun Heo wrote:
> On Wed, Aug 11, 2021 at 01:22:20PM -0700, Bart Van Assche wrote:
>> On 8/11/21 12:14 PM, Tejun Heo wrote:
>>> On Wed, Aug 11, 2021 at 11:49:10AM -0700, Bart Van Assche wrote:
>>>> You write that this isn't the right way to collect per cgroup stats. What is
>>>> the "right way"? Has this been documented somewhere?
>>>
>>> Well, there's nothing specific to mq-deadline or any other elevator or
>>> controller about the stats that your patch collected and showed. That
>>> seems like a pretty straight forward sign that it likely doens't
>>> belong there.
>>
>> Do you perhaps want these statistics to be reported via read-only cgroup
>> attributes of a new cgroup policy that is independent of any particular I/O
>> scheduler?
> 
> There's an almost fundamental conflict between ioprio and cgroup IO
> control. bfq layers it so that ioprio classes define the global
> priority above weights and then ioprio modifies the weights within
> each class. mq-deadline isn't cgroup aware and who knows what kind of
> priority inversions it's creating when its ioprio enforcement is
> interacting with other cgroup controllers.
> 
> The problem is that as currently used, they're specifying the same
> things - how IO should be distributed globally in the system, and
> there's no right way to make the two configuration configuration
> regimes agree on what should happen on the system.
> 
> I can see two paths forward:
> 
> 1. Accept that ioprio isn't something which makes senes with cgroup IO
>    control in a generic manner and approach it in per-configuration
>    manner, either by doing whatever the specific combination decided
>    to do with ioprio or ignoring it.
> 
> 2. The only generic way to integrate ioprio and cgroup IO control
>    would be nesting ioprio inside cgroup IO control, so that ioprio
>    can express per-process priority within each cgroup. While this
>    makes semantic sense and can be useful in certain scenarios, this
>    is also a departure from how people have been using ioprio and it'd
>    be involve quite a bit of effort and complexity, likely too much to
>    be justified by its inherent usefulness.
> 
> Jens, what do you think?

On the surface, #2 makes the most sense. But you'd then have to apply
some scaling before it reaches the hardware side or is factored in by
the underlying scheduler, or you could have a high priority from a
cgroup that has small share of the total resources, yet ends up being
regarded as more important than a lower priority request from a cgroup
that has a much higher share of the total resources.

Hence not really sure it makes a lot of sense... We could probably come
up with some heuristics that make some sense, but they'd still just be
heuristics.

-- 
Jens Axboe

