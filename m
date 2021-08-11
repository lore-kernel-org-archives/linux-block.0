Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15945C432BE
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 18:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E77AC60E97
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 18:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhHKSti (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 14:49:38 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:34405 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhHKStg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 14:49:36 -0400
Received: by mail-pl1-f169.google.com with SMTP id d1so3897809pll.1
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 11:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RhifKV5b6IzIMlDaIF5JT7wrKwwP4msAEckwBTGEIcM=;
        b=I+QstCmb/8feisNd0FZ2+hDozkyAA/3JlTMfAPL+p1HaPhj7lfigMudlgWxaQVbum4
         IaDK323zcTjP7pGvEnMk3oFt9ofrjHaBXb0WFSZu5T/9OJP1chSHkBupb30ZHpInF1E8
         xcZxJz81nxmS4CAQQiH66J1NUzg50MEUxVlsOfGaSUpQoz3c6VXB06aNNNyS+VCF7fkS
         /iKpiqi5fDuX6sb42PPQETLqB+C8OUx1cOfWWdPKP8+GP39HhwCdNU8fLCNV/G/hkguh
         8kbqDbVJNONrIcCZ3RFYV4QbaIV1cIDE/Yvf8j4kMi+iqcq7QrQcRXs3PS2JnmWTcj/s
         tfxA==
X-Gm-Message-State: AOAM530fgGxQSlpZx7itIkDFPiBa7WxlRlcy+536el2MxwY6n9bLRzcu
        1nBNQSBJGG+g3duWs1iLIOH7znjj5ekMsJUq
X-Google-Smtp-Source: ABdhPJw2dXDdTxi9CgUxP6hFQ0+80SSxoZCVZrkz3oLJflSoVW6qvNOrKQkmiYNUy2ptveqspMwiOw==
X-Received: by 2002:a65:63d0:: with SMTP id n16mr134294pgv.432.1628707751998;
        Wed, 11 Aug 2021 11:49:11 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:85f2:bb0e:80b9:d6f6])
        by smtp.gmail.com with ESMTPSA id t1sm186246pgr.65.2021.08.11.11.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 11:49:11 -0700 (PDT)
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <035f8334-3b69-667d-be91-92dcab9dc887@acm.org>
Date:   Wed, 11 Aug 2021 11:49:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/21 10:41 AM, Tejun Heo wrote:
>  From e150c6478e453fe27b5cf83ed5d03b7582b6d35e Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Wed, 11 Aug 2021 07:29:20 -1000
> 
> This reverts commit 08a9ad8bf607 ("block/mq-deadline: Add cgroup support")
> and a follow-up commit c06bc5a3fb42 ("block/mq-deadline: Remove a
> WARN_ON_ONCE() call"). The added cgroup support has the following issues:
> 
> * It breaks cgroup interface file format rule by adding custom elements to a
>    nested key-value file.
> 
> * It registers mq-deadline as a cgroup-aware policy even though all it's
>    doing is collecting per-cgroup stats. Even if we need these stats, this
>    isn't the right way to add them.
> 
> * It hasn't been reviewed from cgroup side.

Agreed that I should have Cc-ed you on the cgroup patches. But where 
were you while my mq-deadline patch series was out for review? The first 
version of that patch series was published on May 27 and the patch 
series was merged on June 21 so there was almost one month time to post 
review feedback.

Additionally, the above description is not very helpful. If it is not 
allowed to add custom elements by adding more pd_stat_fn callbacks, why 
does that callback even exist? Why does the cgroup core not complain if 
a new policy is registered that defines a pd_stat_fn callback?

You write that this isn't the right way to collect per cgroup stats. 
What is the "right way"? Has this been documented somewhere?

Bart.
