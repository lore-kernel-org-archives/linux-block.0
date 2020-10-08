Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC51C4363A
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343B721D43
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EHBbaI62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgJHOAW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbgJHOAW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 10:00:22 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF4FC061755
        for <linux-block@vger.kernel.org>; Thu,  8 Oct 2020 07:00:22 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t12so5781868ilh.3
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2020 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PQYn98Q50q5N/GLYfX3Z+7jVvi2JaNHakYRoBkO7GXY=;
        b=EHBbaI6273UHbYRwW0lrb+qFFTEFHFvupZksJI9ZWuORueuFoTwZhEsf7VVtmqCpsZ
         Cht1c6ZwHY9nTo/m1TMEZ+h1yTCXN7lRxFHAiuiLVHZ1Mt/P7fibkhs6f/xiAfrpFsOl
         Bwp/PSx7VrCPK+CzQZ+JCzm66XSv3ueEWynzvV1I8plJv+Ap2mytPr9bRQNDrlhvDhP/
         h2kequvNzD2Wxm2xY509SjVvJIhaApynr93c5UffSxxQdYeU58D9f3G1E3lYCLoAXAtA
         6VgUDhKGXGPpAR2x8XGW/+KZ52yqzqZfYYILIIc9eO8tVY1rdWnaQb+gK0fAArhzBBFD
         QE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PQYn98Q50q5N/GLYfX3Z+7jVvi2JaNHakYRoBkO7GXY=;
        b=VwBlptZ7FjZEvZXA2s9UGH+nj917zQOC+lHccQelRX6cQBV9GkWtMzDLPr37I6Rufn
         T+QT5vWehZ9GCBJ+M7xCXTJkQNzdqMTh/PibgjyrVgiDyndc4iQEERc9hiQkLM7KsE3d
         zZ2eHzZYYrlnv6x2CLejvf5OyT1h2O3weYgfyTwLAUVo4EFYm+h6Y26yCI2GnxomLaPf
         NFNeM+ABIn60VKt9k8lnaFrYzNRXkzuXGZqvsj1xoZVWLkXkDGL/GLdZ5IFGo9Mwr3bd
         UhhRTAb2utAGjZaSo482qbK3+b31IqZT2h+YwDKJGQUgXKpIj9Cyupe5X8+AaTGv6cTh
         0U4Q==
X-Gm-Message-State: AOAM530G+GtpyaTh7sda/jApVr9Rx1hvYQ5GD0E+o74K6zP0V7WloD6E
        cxQ4gG6zLNuUwQ6Phe71K/E9xA==
X-Google-Smtp-Source: ABdhPJz8bTfhkuOj7kbL7x6L9bDTWe0Ocjzlxf+GJBUuot8ZUyumBYV3HK5f2YHawtln4Fe/QRgBJQ==
X-Received: by 2002:a92:9408:: with SMTP id c8mr6221774ili.61.1602165621179;
        Thu, 08 Oct 2020 07:00:21 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j3sm457630ilc.25.2020.10.08.07.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 07:00:20 -0700 (PDT)
Subject: Re: [PATCH] block: Remove redundant 'return' statement
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <633f73addfc154700b2f983bee6230f82de4c984.1601253090.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <902fc772-4f41-d6a2-0c6b-162da8165f46@kernel.dk>
Date:   Thu, 8 Oct 2020 08:00:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <633f73addfc154700b2f983bee6230f82de4c984.1601253090.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/20 6:42 PM, Baolin Wang wrote:
> Remove redundant 'return' statement for 'void' functions.

Applied, thanks.

-- 
Jens Axboe

