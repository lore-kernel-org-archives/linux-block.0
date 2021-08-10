Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE0C4320A
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 13:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A025E60C51
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 13:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbhHJNx3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 09:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbhHJNx3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 09:53:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8E9C0613D3
        for <linux-block@vger.kernel.org>; Tue, 10 Aug 2021 06:53:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b7so1264959plh.7
        for <linux-block@vger.kernel.org>; Tue, 10 Aug 2021 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3BaQG7uNacgdVp+drfazKFG6Tgy96a7rOj8pZqTgzhc=;
        b=1Mo+/RZNvWDNjdmXd/QIeKdpWn2FxSb6ryjjbIgaCAWijH40jFBZFekGmZR5+o21M+
         qWvwrD/880UDQMbVaRs0RPvBwoH30kOJNLxqepJ+lUgMPrvew2CwoLtZyl1fLnz+S3po
         0dAw9d3Ec+voR0Z/iRPbXgzcqVSbz8cL4g5g++XJT8vfI0WLB8unYSNilVbKJ7vrATWC
         K/UX22DEJGLT3qGdkp9U5UGMNFnMSMBzIeUFNm2pX5rI+c8WU/r6vuerGI8FlGfAkbGz
         yZc0tUKv4sGpNusWP1tjflcoxmcPxydV4avKEHYBoP0uhZsapSXkP0n6gGPDSUy4Tx3R
         povQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3BaQG7uNacgdVp+drfazKFG6Tgy96a7rOj8pZqTgzhc=;
        b=nYz2VpSZL9szJyzcjB4Qw8U7c9NPLxMGNqLrRACGDohGXYxqbUDyT3vcx2BvelefRq
         CkoQ5oJD+vn4xMggMCzCfDTZqs90GD3P77bg8b0mPAOX3pTUJvBKk1VoC+RDA/Q/KITL
         Q2X3xxRNrlK775mkD8whVoWifWvB5NKQ1ENIINcbPF3dVTnQvETB9Is16Ttd2I7MT/V2
         eFLa1TtEeECF0/tqx1aGejmhI/vVs50Jg4y80zvtVTYWbfm8yroYA0Y1e3MstwPRx6IT
         ZhXADx1g+oYSCyL1nErAp4u7bsU4BLuV801hugPE6xGOHbG/nRw5TP+MOIJG7l49GUWK
         b5Wg==
X-Gm-Message-State: AOAM530IchpTqIbvg61muqr9dwGttpIsstYGhJzPv7p3Yof5JJi7QdGb
        6nbHkFIDCEkMiHBgC41R235UpRz3aKTqXjLu
X-Google-Smtp-Source: ABdhPJz+dgHKaPdfvp762hdQb6DzhTCzglW6Zw6wa8i3RPOE2gY86BPWyxP7sR1SB7oWb+b/FxRkAg==
X-Received: by 2002:a17:902:7786:b029:12c:dac0:15ba with SMTP id o6-20020a1709027786b029012cdac015bamr25309235pll.27.1628603586628;
        Tue, 10 Aug 2021 06:53:06 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id y20sm10985632pfb.54.2021.08.10.06.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 06:53:06 -0700 (PDT)
Subject: Re: [PATCH 1/4] bio: add allocation cache abstraction
To:     Ming Lei <ming.lei@redhat.com>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
References: <20210809212401.19807-1-axboe@kernel.dk>
 <20210809212401.19807-2-axboe@kernel.dk> <YRJ74uUkGfXjR52l@T590>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <79511eac-d5f2-2be3-f12c-7e296d9f1a76@kernel.dk>
Date:   Tue, 10 Aug 2021 07:53:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YRJ74uUkGfXjR52l@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/10/21 7:15 AM, Ming Lei wrote:
> Hi Jens,
> 
> On Mon, Aug 09, 2021 at 03:23:58PM -0600, Jens Axboe wrote:
>> Add a set of helpers that can encapsulate bio allocations, reusing them
>> as needed. Caller must provide the necessary locking, if any is needed.
>> The primary intended use case is polled IO from io_uring, which will not
>> need any external locking.
>>
>> Very simple - keeps a count of bio's in the cache, and maintains a max
>> of 512 with a slack of 64. If we get above max + slack, we drop slack
>> number of bio's.
>>
>> The cache is intended to be per-task, and the user will need to supply
>> the storage for it. As io_uring will be the only user right now, provide
>> a hook that returns the cache there. Stub it out as NULL initially.
> 
> Is it possible for user space to submit & poll IO from different io_uring
> tasks?
> 
> Then one bio may be allocated from bio cache of the submission task, and
> freed to cache of the poll task?

Yes that is possible, and yes that would not benefit from this cache
at all. The previous version would work just fine with that, as the
cache is just under the ring lock and hence you can share it between
tasks.

I wonder if the niftier solution here is to retain the cache in the
ring still, yet have the pointer be per-task. So basically the setup
that this version does, except we store the cache itself in the ring.
I'll give that a whirl, should be a minor change, and it'll work per
ring instead then like before.

-- 
Jens Axboe

