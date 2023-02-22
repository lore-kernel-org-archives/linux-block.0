Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779F5C61DA4
	for <linux-block@archiver.kernel.org>; Wed, 22 Feb 2023 03:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjBVDsg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Feb 2023 22:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjBVDsf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2023 22:48:35 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735A8C149
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 19:48:33 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id bh1so7356563plb.11
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 19:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1677037713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jr6aPM8WoqO9M0U1wWroCFGHljbEXUos5CEjfVWF7b4=;
        b=q3fHkTGKuXrK/WhnT8D/LYL/zrYnVUWi59OMUv+Vf6LD3FZz3K936yZM4xrfF6DZRn
         MDAszdYeSfvasFG9zlkYXWwNDbhTn9xNewXWzChHExxgaam/P3iinA6/spziIRh5GeZB
         4X8Nyv0YqQ9RVT8DTKRPsin6Oo6didyVEyjcYtPNQcRGm+81mp4y0cSzAnXTFi1cgNRd
         nBQtGkkw59kIHHtuNplHB8BdVS2GeuJdxVWg26FBH3ehQRSWa5iQwotFa0S0dB9sTY2A
         cL/iZwYuTTHLEhE4ZxqmocvramzgaD3VvbwrNXiUR1zHEh1xww2ulpY1sgeh9vojt0h2
         dMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677037713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr6aPM8WoqO9M0U1wWroCFGHljbEXUos5CEjfVWF7b4=;
        b=l6DpzDnwN8SIzKM/NMWRoVlVAMcqgfqW0Vd0eRj599AgRU3WPIakucI+r+R/X4Mau3
         kMQLtBO4HVNkIm//6Sth/0KoCSpCDgdsEG4zk+HCEils93urk6eGzquiYYs0dSCBFtCN
         Fnhey3/ajByFcuowaV3h4sQ6mD9y+82jH/2PdIn2zZWrpZfUqAkPOMQ32D1Jaxl5m5xQ
         YrEge9STtNyMHzEd/PhNU8SV1EUArHtXzIMbYL+GpuKPbzJ9viPd/ZiPiqNvFR6oRWRb
         8jSBvOeK4PhxS3s7is7P9rpesnUK+4bpwM5rySadIIQi/tIM+ypapcfysJMl0U6mjiXu
         bJbA==
X-Gm-Message-State: AO0yUKXKX/5l8nwLlD+VU9Qb0Ta3dh8vSnAk7yM4zADzEtmBH65GOroj
        BXctjHXYz1biJRUkFkL1EnlYiBahEO4vlHwG
X-Google-Smtp-Source: AK7set9CdaKlTB5s/hfjY3MZRZ6DrHZvSvNYjsWeeCfE1hVu6pNetjXpTYMLvoV9hMSbGNnW7oYW5w==
X-Received: by 2002:a17:90b:148a:b0:233:6d76:27b7 with SMTP id js10-20020a17090b148a00b002336d7627b7mr6137879pjb.3.1677037712773;
        Tue, 21 Feb 2023 19:48:32 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090a178f00b00213202d77d9sm3882724pja.43.2023.02.21.19.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 19:48:32 -0800 (PST)
Message-ID: <02bde1b9-daa0-132d-605c-62793382ece6@kernel.dk>
Date:   Tue, 21 Feb 2023 20:48:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [GIT PULL for-6.3] Block updates for 6.3
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
References: <5afa0795-775d-f710-7989-4c8e1cd7b56f@kernel.dk>
 <CAHk-=wiLu7VRyPUpthiV6qMJp1eN3n_wD+vAroDsnDZq05QsLA@mail.gmail.com>
 <9a048f21-1938-084d-b328-8a345bd20263@kernel.dk>
 <CAHk-=wimXoc_vsdfzVKAu6cHd_M1U3d5Dxtib1U4JdXMNUxLoQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wimXoc_vsdfzVKAu6cHd_M1U3d5Dxtib1U4JdXMNUxLoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/21/23 6:07?PM, Linus Torvalds wrote:
> On Tue, Feb 21, 2023 at 4:03 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> I'll double check it. The merge doesn't end up touching any of
>> bfq_sync_bfqq_move()
> 
> It absolutely does.
> 
> Or rather - your merge doesn't end up touching it, and I claim that's
> exactly the problem.
> 
> My merge *does* touch it, and I think my merge is the right thing to do..
> 
>> just conflicting with:
>>
>> bfq_check_ioprio_change(), where the release ordering should be upheld,
> 
> That's the trivial case.
> 
> But:
> 
>> __bfq_bic_change_cgroup(), where it's still done after assigning the
>> async_bfqq.
> 
> No.
> 
> That's where bfq_sync_bfqq_move() *comes* from. See commit
> 9778369a2d6c ("block, bfq: split sync bfq_queues on a per-actuator
> basis").
> 
> The whole bfq_sync_bfqq_move() function didn't exist at all in the
> tree that fixed the bfq_release_process_ref() ordering.
> 
> It was split out of the __bfq_bic_change_cgroup() code, so the change
> to __bfq_bic_change_cgroup() needed to now instead be done in that
> bfq_sync_bfqq_move() code.

Yep I'm being dense, you're totally right and your merge is the right
one.

-- 
Jens Axboe

