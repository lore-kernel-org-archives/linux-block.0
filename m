Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C647C10F14
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 15:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1057320854
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 15:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RQsjMM+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfJOPwS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:52:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42241 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbfJOPwP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 11:52:15 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so46965768iod.9
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=klz9XF0n5Dx23te5u1HbHnrUpRLcGEesCFK6Z+SLWew=;
        b=RQsjMM+K2avoCN2xnMldLxkHX7TbdffiFc5gI1gcqH/ZDCgLqQOzoCqBXsrSLn0ccs
         kzpIPB6AKSN2uKUfLsDq6nqdtkmRf9sTTYDkN4Kv8noVSsSqKTlUysCm3pzpugnWV+aV
         Ky2t7co7bQCPAnDE+zzzPIxTdO2v2aq4gSU4jC3XbF49DXa+Rt9d4L8w9ob2qYicTgOI
         J4j59x2+VIQUq1pmXulJOS0pcZgSNXG7MXqipG48Yuvs9okrOepGruMX1A5nLnpU9OOO
         Z35ZlxRdOs2IHy0stMoExM2RMUnLjXoaXc4tRmbqxoSWK+SrBUyDQPLxCes+Kzhou6ac
         zIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=klz9XF0n5Dx23te5u1HbHnrUpRLcGEesCFK6Z+SLWew=;
        b=odB81QVq+Q3KnJNizDqgc29YfGPNd7Yvbe8JGSA0lG4u6abfPI5kDa/JL6puQChHAX
         Lgu2ln2tCn4EKwuttoFXVmHE7Z5qpmKM+Yn49LKvG95XUfbYT5moSi7qHya+MbI3kT04
         AIWpAgGvCTWdmbdeakSE0e840PZoBmDlnVukxfDQ4QnauQU3/FJq0ek9YGhy3yRyOtNT
         69MBWqiA3xWfgQ8I3m6s4jc3Am4s0t5jPky2YtJsDKOJvAsI0heJ58vNy1E2JI3fsc5j
         DQJZhx1rr4wG4bDXCLYbg5x51oQ31fBJj0RrKQ+0Jl4Tld9qYHaN7N60XeTdQuAIvg04
         46rA==
X-Gm-Message-State: APjAAAUxtV8ivQXZG9BB6kJXLx6FqPehjTQVBUIccRecJrgpQzxeQbuy
        DWjGc2nVMAi5DnLCowjjdU0uIpLXgFpVZw==
X-Google-Smtp-Source: APXvYqzr4ZyFt9+diFgQyl7KaG1y/10oIRx/Zzw9ZodclIRdwn1K+mHttkhdigmTK4CUNdhHRLP+xQ==
X-Received: by 2002:a92:5f4c:: with SMTP id t73mr6801457ilb.220.1571154733938;
        Tue, 15 Oct 2019 08:52:13 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q17sm2582994ile.5.2019.10.15.08.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 08:52:13 -0700 (PDT)
Subject: Re: [PATCH block/for-linus] blkcg: fix botched pd_prealloc error
 handling in blkcg_activate_policy()
To:     Tejun Heo <tj@kernel.org>, Julia Lawall <julia.lawall@lip6.fr>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-block@vger.kernel.org
References: <alpine.DEB.2.21.1910151232480.2818@hadrien>
 <20191015154827.GK18794@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <07cbc404-65db-b236-9ae2-558197b8cdb6@kernel.dk>
Date:   Tue, 15 Oct 2019 09:52:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015154827.GK18794@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/15/19 9:48 AM, Tejun Heo wrote:
> While fixing ->pd_alloc_fn() bug, ab94b0382d81 ("blkcg: Fix
> ->pd_alloc_fn() being called with the wrong blkcg on policy
> activation") broke the pd_prealloc error handling.
> 
> * pd's were freed using kfree().  They should be freed with
>    ->pd_free_fn().
> 
> * pd_prealloc could be kfree()'d and then ->pd_free_fn()'d again.
> 
> * When GFP_KERNEL allocation fails, pinned_blkg wasn't put.
> 
> There are also a couple existing issues.
> 
> * Each pd is initialized as they get allocated.  If alloc fails, the
>    policy will get freed with pd's initialized on it.
> 
> * After the above partial failure, the partial pds are not freed.
> 
> This patch fixes all of the above issues.

I dropped the other one, do you mind sending a folded patch?

-- 
Jens Axboe

