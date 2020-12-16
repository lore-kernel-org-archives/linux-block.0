Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7CDC4361B
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 14:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB9E233CE
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 14:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgLPOVD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgLPOVD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 09:21:03 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E8AC061794
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 06:20:23 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id q1so22705188ilt.6
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 06:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C021JhKQkhYlUBBz0AMr3K5Hjf2VRYixSeGrjaYAfG0=;
        b=d4JZk96EYHcTHRxM+2ID7P72FURflZDWG+mSgjfD/6ChDZPH09JaBgwqN2i0Z0Huv5
         fALRqjZ0B26sNmM8WEa2KU/WUyIUemBy7vBvWGIWcp1tqPpdleKsfVj7dODbb3dSmFnR
         RueSmt69smXNOWPs/bO7Ct7hUJBmdnSxoDylBeru2h4LuLU6UWqff7rfzQ6S1dbOFzZ1
         NvXZBon0ic9xQmW8aA4+ZoFt3ZY2mMWhiABmOm7fbxldEnQtC21w1ttY9MNeigp7yEb1
         T5s8x8VlCCmOwhJ2aKK+wR9WBp44J69+ziJ5QxW3T2pogdWHb02+LrLb8bek7GO5SYNy
         1Ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C021JhKQkhYlUBBz0AMr3K5Hjf2VRYixSeGrjaYAfG0=;
        b=qKlRnyfuD7drsULx/MbYrKFI5FbwbJPQ6pAZMZlIbk/m538cUaf5Im0BlqiMKbS6eI
         R1cmwjHKBKNuqY9RYj6Mmb3xryB/arx3e48nI+Qd2iqIecSM+H+kt3khbR6yyoW0upPS
         SPlzbyOjR6BQ+dJ66OSCFyIvUzvSC9Y44zEIJHqvJ7KcLx3dW3SvMKf/7NSimhWHlZvv
         WS4Ht1FRtOsnWtdBD6Ovd4TjzTYyBpvlv2AVszNQtmcMN1WSMCWy4yNO+lhnD6rqldOA
         bxqt9Eiz5Yp6H+bk5iDXf63zwk8wQ666wv3ZhueXPILzm3ICdBiFofWcuW8PgzavGPKs
         woMA==
X-Gm-Message-State: AOAM5333fLbCVqdsLloxirDqP1ElV8Vg0hympBv//XPm5tuHYEreBvmR
        fvM7jEvPR1l8P1Op9Hl34QLNxg==
X-Google-Smtp-Source: ABdhPJytQXwPVLMHj/Dqer+XiGlRi/fz0NwlL/naFJywR/EjeYP11H/9NQ4RT6tQUhjs5/RyVOa2VA==
X-Received: by 2002:a05:6e02:1148:: with SMTP id o8mr46759068ill.174.1608128422515;
        Wed, 16 Dec 2020 06:20:22 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o7sm12672950iov.1.2020.12.16.06.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 06:20:22 -0800 (PST)
Subject: Re: [PATCHv2 for-next 0/7] Misc update for rnbd
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
References: <20201210101826.29656-1-jinpu.wang@cloud.ionos.com>
 <CAMGffE=F0i_HqLNQBuek76-WNe9s+iKP24SRnHkkezQBejy+DA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7dc30e95-73e4-8bd2-5019-43a1cd096f70@kernel.dk>
Date:   Wed, 16 Dec 2020 07:20:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMGffE=F0i_HqLNQBuek76-WNe9s+iKP24SRnHkkezQBejy+DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/15/20 11:28 PM, Jinpu Wang wrote:
> On Thu, Dec 10, 2020 at 11:18 AM Jack Wang <jinpu.wang@cloud.ionos.com> wrote:
>>
>> Hi Jens,
>>
>> This is the misc update for rnbd. It inlcudes:
>> - 2 follow-up fixes for commit 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
>>   one warning, and one possible memleak.
>> - one fix for race with dev session sysfs removal.
>> - fix for write-back cache & FUA.
>> - reduce memory footprint by allocate sglist on demand and do not request pdu
>>   from rtrs-clt.
>> - Typo fix.
> 
> Ping?

Huh, I thought I had grabbed v2. In any case, it'll go in later in the merge
window, I do have it queued now.

-- 
Jens Axboe

