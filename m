Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EDAC433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 03:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E86364E08
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 03:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhBCDik (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhBCDij (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 22:38:39 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4D5C061573
        for <linux-block@vger.kernel.org>; Tue,  2 Feb 2021 19:37:58 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o63so16319844pgo.6
        for <linux-block@vger.kernel.org>; Tue, 02 Feb 2021 19:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fSN6Pgt1aoM0TAmMiF4xYaXZD7X0CIk+4HtPonNt2CU=;
        b=YisAw8QobmFw2BTKnWgih2LBvHSoYR/XvbTH6JwK5vxD1+rA0neef3ehQT0bVTOcE2
         oniAGQzTDcffW9HNADkAIRxnwQ0BE6fKKGgRxJsiWzeRlKxjocAgKjaTxJn8cFd3YSaU
         d8JRHzijatq+DRkbFyH6u3hAJh2SMchWGOVaVVSWiLQGgiRvF14vzMEWpCAohmawBmer
         /sDn8qKMgcX/vM2TUvZuKJVZ/WaiffLJKipZ3KvNCo2wWE2lxcNhF9F3Tj9Gg1sGLCMl
         Y+r+mlsUkaKILPQSEEXSWIPHOQymnrdlZIWC87hd9Gh43BmgYsXiPOZ/1zTubATIA1+S
         2sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fSN6Pgt1aoM0TAmMiF4xYaXZD7X0CIk+4HtPonNt2CU=;
        b=CVeJviBzCOQfy2Pouo4/dKmCzjw+1MWuneO9KmG+eykp8Jy+eWL/f3dqDn6cmZpW95
         IJoBC9s0kPZkLBw452p3EcDj8l/gsZcK8gorlvyiVsVxUxYrNe/z7CVyw3xPmr6Xoo+K
         Ars1AMYAYpUTkL3u6ws3YQcymVjCVbPioZUmH371HCKPtts4vNVTTppQ8kJX8BDPgVse
         qIj60fuF5vJ+wZndbkF5s2/Jm2ZbfCEH/E85C1USr++9EkO0ungcs0BOJ0/rqAcMiHOx
         6PuR8ZvrRWX7BpYwtoQSsThYOTTSwYtGlqCJJ2DJ3I2B9rEcJesY6DDZFPQyO0pJrG0c
         Y90g==
X-Gm-Message-State: AOAM532l+ymgJ4kdnf+4JUSUtKxOyrhk5CEQiuEDJO0pnNaUO0zSJ54L
        c1zx887X9p6zCjUiW43uDU/V+2u9PGVdXg==
X-Google-Smtp-Source: ABdhPJyVKxenYt//tAykWN+Tih1p9orthovKcMlx92tQHN5yu535AkQpZG51jjBovDT6IjWciuv8mQ==
X-Received: by 2002:a63:560a:: with SMTP id k10mr1414013pgb.132.1612323478211;
        Tue, 02 Feb 2021 19:37:58 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a30sm393742pfh.66.2021.02.02.19.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 19:37:57 -0800 (PST)
Subject: Re: [PATCH] Fix Revert "bfq: Fix computation of shallow depth" in
 linux-block.git
To:     Lin Feng <linf@wangsu.com>
Cc:     linux-block@vger.kernel.org
References: <20210203033113.100260-1-linf@wangsu.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b992f657-11ec-ddc0-9461-30abd46522f3@kernel.dk>
Date:   Tue, 2 Feb 2021 20:37:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210203033113.100260-1-linf@wangsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/2/21 8:31 PM, Lin Feng wrote:
> Hi Jens,
> 
> Not yet got your mail, but per https://lkml.org/lkml/2021/2/2/1901, this patch
>  is the incremental. Codes based on:
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/patch/?id=8a483b42b1b3cef7e72564cdcdde62a373bd2f01
> 
> Notes: After checking previous hand-applied patch in block-5.11 broken 2 lines
> in original patch, the incremental covers all.

Thanks, folded in. Please check the resulting patch:

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.11&id=388c705b95f23f317fa43e6abf9ff07b583b721a

-- 
Jens Axboe

