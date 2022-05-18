Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704FCC433EF
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 22:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiERWb6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 18:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiERWb6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 18:31:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF163466F
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 15:31:56 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d22so3101546plr.9
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 15:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=thG3qSgnZW+qUMLaaxOPkQALuH6P7RbZ23MHltmMGlE=;
        b=AQkqPj3D0tdfs64sN8mLJd9diiGRGQDbqzoTBkPKxEszGHSW23pLd3DZLq1t7J1BaH
         N9Dc9tw3fZhqvdD7K5lreOPHKrd45AK941vaNu1U6kmB0u/LHeGMLIh4oh/lBCmsuM/R
         nT++BAX42jIVpVd2Cbc0IDNOSqTH4QxG9Nid9TMDGCoIPhTqZxONNkMk58Jq/wMtOPZn
         FR121zdv/+aGTq1DPhIOuVGzvj3hKtit/Buc/d9k5941ePSeMzytuGUKs98ffe6KJ8yI
         O4tYIxZQsAbIvPWbv/KXPvXLRccYsR4v+/q7YR/qrq7ooDJjsiO24fAzsrF642GuT1FQ
         Z4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=thG3qSgnZW+qUMLaaxOPkQALuH6P7RbZ23MHltmMGlE=;
        b=yX6yRdRGBBp445twWaCXxh0dJrZJaVmsjCFucQ6PBqf/WGxQno2WPqQD2Mktoy0HaS
         iENMSWYmbATDQarzEJMO8yyXklzTwy9lnqEQYaxrbHdFC5zF8P3b8/JQcMirx63GnlyU
         jhG3XTWWguOvcsSwWYMQItv2WK3KY2wJZz0x/l9hhsy5ZIqHLK1Pl8hZndBuhwxd2RfN
         6aYaPPtyLQlMyzplWDHAKCJVe0TX/7qhdfRcOktElvqE0GYfA4QUpGX/PrZp8xXdgQFO
         VKc5b95TGk5JOLMGFInnX4F0hC8vfLr6rpR2tw5mE6Df+hDagKlXRh+1lrP8ZBFKd42Z
         hSwg==
X-Gm-Message-State: AOAM533YO7x/ceLC8KRMiMGKfMT11E3VaB5A0SFSA4psSwZAbPv+E9JL
        4qpHDgFr6ZctwgmGfmuyEhCWrQ==
X-Google-Smtp-Source: ABdhPJxkM5dIjxffREWV17PoskbyG+tIqaT0rCNzAEMnjsyNnVjB3wANcJQX1M94VA+U2oCPAiV1OQ==
X-Received: by 2002:a17:902:b684:b0:156:80b4:db03 with SMTP id c4-20020a170902b68400b0015680b4db03mr1626285pls.16.1652913115359;
        Wed, 18 May 2022 15:31:55 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h1-20020a62de01000000b005181409a78esm2397294pfg.110.2022.05.18.15.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 15:31:54 -0700 (PDT)
Message-ID: <de6b0f81-67e1-b167-a618-193c2303f149@kernel.dk>
Date:   Wed, 18 May 2022 16:31:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] blk-cgroup: Remove unnecessary rcu_read_lock/unlock()
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Marek Szyprowski <m.szyprowski@samsung.com>, bh1scw@gmail.com,
        tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20220516173930.159535-1-bh1scw@gmail.com>
 <CGME20220518192850eucas1p1458c00d4917c5ed39f2c37c9eb30cd46@eucas1p1.samsung.com>
 <46253c48-81cb-0787-20ad-9133afdd9e21@samsung.com>
 <1dad86bb-ae31-5bf8-5810-9e81c68be8ff@kernel.dk>
In-Reply-To: <1dad86bb-ae31-5bf8-5810-9e81c68be8ff@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/22 4:29 PM, Jens Axboe wrote:
> On 5/18/22 1:28 PM, Marek Szyprowski wrote:
>> On 16.05.2022 19:39, bh1scw@gmail.com wrote:
>>> From: Fanjun Kong <bh1scw@gmail.com>
>>>
>>> spin_lock_irq/spin_unlock_irq contains preempt_disable/enable().
>>> Which can serve as RCU read-side critical region, so remove
>>> rcu_read_lock/unlock().
>>>
>>> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
>>
>> This patch landed in today's linux next-20220518 as commit 77c570a1ea85 
>> ("blk-cgroup: Remove unnecessary rcu_read_lock/unlock()").
>>
>> Unfortunately it triggers the following warning on ARM64 based Raspberry 
>> Pi 4B board:>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at block/blk-cgroup.c:301 blkg_create+0x398/0x4e0
> 
> Should this use rcu_read_lock_any_held() rather than
> rcu_read_lock_held()?

I think the better alternative is just to delete the WARN_ON(), we have
a:

lockdep_assert_held(&q->queue_lock);

right after it. Since the queue_lock is IRQ disabling, having two checks
serves no purpose. I'll kill the line.

-- 
Jens Axboe

