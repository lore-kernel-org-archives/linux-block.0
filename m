Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF4FC433F5
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 01:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0DAC6109D
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 01:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhJWBkZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 21:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhJWBkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 21:40:24 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F8AC061764
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 18:38:06 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id o204so7185733oih.13
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 18:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+RTHo9uuzJYBs3k/3SkM06KWDKDpUaV+YKk55nw5GKg=;
        b=6KT9XdGPERmFI4yLR3P56LEY40sxyPlsI3fkdgL3sVBYU4B37Xe+vr0v9WyXcnxBC4
         nwhuu3H05hJoW8mQvo1gBKr8mQ14Z7M9SK5VgNFqBE2ZKWBJPdsxyjpuBLfbyEgNb0NH
         13qVVFcahsCHmNxg7H1uFn95TnFH9Up0fiLe6ie/I/nQ6Am1nNGxGcttRP1nC9dOzWNq
         wjn0oi35Zcx3DPYRuIvGv9TEo0b8Kcg3UamiVW9ZivLgrv/hhU9WJKxc6UNZlcU1as9B
         pfaWOCnrrD2IL7BPMravgiSRhdTB1Y4xXpXQilFkY+bpjDEklriLxS736CPBk2nmMTZ5
         2ydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+RTHo9uuzJYBs3k/3SkM06KWDKDpUaV+YKk55nw5GKg=;
        b=UeFmBCrA+4XJK9sXalymea8g2fkO4RarVX6Ww6LnBOw58zG1f85+bycf4WZUMfHZJp
         Dt1eGGsXwY5pp3syirO9LIlDPCQfR9rxSAsM0cnT0x0HerNbNiZm2S2qI2vQIbaPkEiR
         uUvKufmbSyqRiO5M/fJLofHRUGMCDeuzAideGHh7smn5qQbPeVRzlyqwusCi3OnnEZyh
         A+Y+w221G7cGiRX03xWBPoKy2FRVoZrkTgu4w2pmLsS8mPCkvlW0W7F7uKi4lj96fMnQ
         x5ezpM6PvHJGZmLa0vzJTWmPKFLgwidvvNSW6IF2FkyyNz/+RJ1l+FQeeh7SZ0uFehJu
         1C2g==
X-Gm-Message-State: AOAM532GhkvjQ8Nyk0KFeEtJTXqxkzuvAuxr84JT2llPcCJJIBCvvoXT
        FZs9AS6Qg92f8kZqUVNUybVps9qfwsKVuyaI
X-Google-Smtp-Source: ABdhPJxsqfzZd/Es/Cmd4xrU/OtIG2XE2higWNDlumwudNmK/s++9zh7O2xSccV6C2M42uPJL62fMg==
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr1007927oic.64.1634953085787;
        Fri, 22 Oct 2021 18:38:05 -0700 (PDT)
Received: from ?IPv6:2600:380:7c50:21f2:ec35:e139:de38:5438? ([2600:380:7c50:21f2:ec35:e139:de38:5438])
        by smtp.gmail.com with ESMTPSA id t9sm2021744ott.70.2021.10.22.18.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 18:38:05 -0700 (PDT)
Subject: Re: [PATCH 4/4] block: cleanup the flush plug helpers
To:     Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
References: <20211020144119.142582-1-hch@lst.de>
 <20211020144119.142582-5-hch@lst.de> <YXMaZoQJiR5WFZTw@archlinux-ax161>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a3719d62-298f-edbc-18fb-8dd5d2855b40@kernel.dk>
Date:   Fri, 22 Oct 2021 19:38:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YXMaZoQJiR5WFZTw@archlinux-ax161>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/22/21 2:09 PM, Nathan Chancellor wrote:
> On Wed, Oct 20, 2021 at 04:41:19PM +0200, Christoph Hellwig wrote:
>> Consolidate the various helpers into a single blk_flush_plug helper that
>> takes a plk_plug and the from_scheduler bool and switch all callsites to
>> call it directly.  Checks that the plug is non-NULL must be performed by
>> the caller, something that most already do anyway.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> This patch as commit 008f75a20e70 ("block: cleanup the flush plug
> helpers") in -next causes the following errors with CONFIG_BLOCK=n
> (tinyconfig):
> 
> kernel/sched/core.c: In function ‘sched_submit_work’:
> kernel/sched/core.c:6346:35: error: ‘struct task_struct’ has no member named ‘plug’
>  6346 |                 blk_flush_plug(tsk->plug, true);
>       |                                   ^~
> kernel/sched/core.c: In function ‘io_schedule_prepare’:
> kernel/sched/core.c:8357:20: error: ‘struct task_struct’ has no member named ‘plug’
>  8357 |         if (current->plug)
>       |                    ^~
> kernel/sched/core.c:8358:39: error: ‘struct task_struct’ has no member named ‘plug’
>  8358 |                 blk_flush_plug(current->plug, true);
>       |                                       ^~
> 
> I tested the latest block tree and did not see it fixed nor did I see it
> reported or fixed elsewhere.

This should fix it, thanks for reporting.

commit 599593a82fc57f5e9453c8ef7420df3206934a0c
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Oct 22 19:35:45 2021 -0600

    sched: make task_struct->plug always defined
    
    If CONFIG_BLOCK isn't set, then it's an empty struct anyway. Just make
    it generally available, so we don't break the compile:
    
    kernel/sched/core.c: In function ‘sched_submit_work’:
    kernel/sched/core.c:6346:35: error: ‘struct task_struct’ has no member named ‘plug’
     6346 |                 blk_flush_plug(tsk->plug, true);
          |                                   ^~
    kernel/sched/core.c: In function ‘io_schedule_prepare’:
    kernel/sched/core.c:8357:20: error: ‘struct task_struct’ has no member named ‘plug’
     8357 |         if (current->plug)
          |                    ^~
    kernel/sched/core.c:8358:39: error: ‘struct task_struct’ has no member named ‘plug’
     8358 |                 blk_flush_plug(current->plug, true);
          |                                       ^~
    
    Reported-by: Nathan Chancellor <nathan@kernel.org>
    Fixes: 008f75a20e70 ("block: cleanup the flush plug helpers")
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c1a927ddec64..e0454e60fe8f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1160,10 +1160,8 @@ struct task_struct {
 	/* Stacked block device info: */
 	struct bio_list			*bio_list;
 
-#ifdef CONFIG_BLOCK
 	/* Stack plugging: */
 	struct blk_plug			*plug;
-#endif
 
 	/* VM state: */
 	struct reclaim_state		*reclaim_state;

-- 
Jens Axboe

