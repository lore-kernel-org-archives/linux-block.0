Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCCBC4338F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 15:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9620D60FBF
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 15:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbhHLPvm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 11:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238392AbhHLPvY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 11:51:24 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65073C0613D9
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 08:50:59 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id d10-20020a9d4f0a0000b02904f51c5004e3so8270558otl.9
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VfI56LlaYsE1GT9ydmBscLhveal3qQOlMq3m3hVypdI=;
        b=qrt6vFdW5LrV1feYwHg5iU+4lBDvRxPYOIZ9YUTkOoy/+sL9XnwQakNi6GYma/h0jS
         NHXxLI66MAbAyVkHPJ7h5+jFwjX5a6yvGR0WAgA/Ip/yyhWDJgk/QFS5fplY99FsacIC
         QZu0tuRdBtNxN992GGhN6gS6OEzdA2SnIb71Lvogz14FTolem+FnK2EjZZNL54vVo6kH
         7lFXekTk6gMOEhy6rBZxF/mIjBMPQNFeN7rWeYYoYwuXOUXYCXTCsl0tXdiH4YwsAVoI
         dm1QeWK5O3lOJXnjMQVnmzAcLnrR5E/KoviY2DwN2V1R03VdNpGVKM1G2n4f+9abeymr
         aZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VfI56LlaYsE1GT9ydmBscLhveal3qQOlMq3m3hVypdI=;
        b=gfzIOPXJadYceW5bELi7Biti1wlzEtlGUznfmNT+D/fRSjQiqEBVQsdx/S0al1Or4E
         TFVQoKotf0UDyqSAEr1z8LPXeDJ3ejWqQVVgpDSmOAPJgp4Oi+pHFKHwXg1TMEA+gNzY
         d3z5ojNjMerlcdekwADxlcwIOIgliq2t3wk1mGuXG74kiU1Re9u1g6ckraSE57zDEz91
         +08+uvdKITcgCvcOidROIMtv1qKXZ2VGMEO5AmwSF/Rug6bPykdw5DDvFZ/a9IIF15aL
         UF1zr1AN8ixdBXvvtKUkOAw7SQPblc54t2mhGwFbDX6nBBKeueZ+nClSA9UuYoh4LwbU
         3/xQ==
X-Gm-Message-State: AOAM532cnpPicUcI3AXu7W5L8J4AKBqYvEqYwN5PFEXCu/5wqts2JK9p
        sNhgCT1VjcW0BK6g/tcdWWHuFg==
X-Google-Smtp-Source: ABdhPJzz5iJwsG5TIlb+q0/rRUQdH0+Jwy+rdeNYEYvsMCyGyyoEEaBTFHX+enCuNWALJLLEnSJAig==
X-Received: by 2002:a9d:7f97:: with SMTP id t23mr3919250otp.229.1628783458781;
        Thu, 12 Aug 2021 08:50:58 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t9sm692069ott.39.2021.08.12.08.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 08:50:58 -0700 (PDT)
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
 <9683ccee-776f-70d6-39a5-2f9b7552b189@kernel.dk>
 <1700769.Imp7hYaAdB@natalenko.name>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1dc051a8-4d59-8137-2406-f74026b170bd@kernel.dk>
Date:   Thu, 12 Aug 2021 09:50:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1700769.Imp7hYaAdB@natalenko.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/21 8:14 AM, Oleksandr Natalenko wrote:
> Hi.
> 
> On středa 11. srpna 2021 21:48:19 CEST Jens Axboe wrote:
>> On 8/11/21 11:41 AM, Tejun Heo wrote:
>>> From e150c6478e453fe27b5cf83ed5d03b7582b6d35e Mon Sep 17 00:00:00 2001
>>> From: Tejun Heo <tj@kernel.org>
>>> Date: Wed, 11 Aug 2021 07:29:20 -1000
>>>
>>> This reverts commit 08a9ad8bf607 ("block/mq-deadline: Add cgroup support")
>>> and a follow-up commit c06bc5a3fb42 ("block/mq-deadline: Remove a
>>> WARN_ON_ONCE() call"). The added cgroup support has the following issues:
>>>
>>> * It breaks cgroup interface file format rule by adding custom elements to
>>> a> 
>>>   nested key-value file.
>>>
>>> * It registers mq-deadline as a cgroup-aware policy even though all it's
>>>
>>>   doing is collecting per-cgroup stats. Even if we need these stats, this
>>>   isn't the right way to add them.
>>>
>>> * It hasn't been reviewed from cgroup side.
>>
>> I missed that the cgroup side hadn't seen or signed off on this one. I
>> have applied this revert for 5.14.
> 
> Should my commit [1] be reverted too?
> 
> Thanks.
> 
> [1] https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.14&id=ec645dc96699ea6c37b6de86c84d7288ea9a4ddf

It could be, but may as well leave it for now as we're super close to
the limit anyway.

-- 
Jens Axboe

