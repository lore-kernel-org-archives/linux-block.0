Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC90C4320E
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 13:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0561260F4C
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 13:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhHRN3k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 09:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbhHRN3i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 09:29:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BC0C06179A
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 06:29:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so2399612pjb.0
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 06:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YZfF52HpL/UKlefpqFZVekLhQrr9CceEDqqOQlI/5cs=;
        b=VANPbhOvUtEl7/HmLunl0gKjYeFV8bzE5NJu9BuCgf17P3e4Cg2Hc8PFMJN34YAOKT
         V+q5UJzXGLd8M+jOMoq/stNCyu2FVR/0XZ7t4qb/RRCklaW1HPbRWe5nfdugKg9KQxgp
         ryK/Xr4Nh72g2cA/xAMroLzGqcXxIsh/KTTu7723+GwXvSDlFqDUCQXLMFflZYUFT06p
         UGsa0eak99ACPYKKx5gKPgca2t7puUcLZ7vOZTMRewUxp81lC55DYOfXsU6X0gC6h4ip
         BNqwj12qcJaD1P+WmR4MGgolBPE1Y0SjeoSrZRaXTHsbTeEc/TQfRpJaPLNjetFmgLSs
         uT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YZfF52HpL/UKlefpqFZVekLhQrr9CceEDqqOQlI/5cs=;
        b=IlQfHoW7Q7hsTrILV6X8+5aVfUoOAH5swfFJn/d6eSgOGPhyLrHDHkTTQ8Y+UJhcID
         CcVXwdHBhEOKWinX2wPeJirK/jWmufp+8OujVHYzwFFTR4EC246gacbYDy6J55MBsTuj
         sYxvusR4sui4L/H9h6do2HH2K/eMoItY3/7j4IaKO0Fs7J7ExMKl6CkvjQQ7S34lJUht
         xKCUIihpeqjp6KVrJMp1/7ex8VH8qZnwU19VU9RYnHFRkHjrsXs0idRnXdTQllzP+crM
         NFtsXf3wTDu6fJz0p45Q8kRL+UObxDkNnDcNJTq/7wpwVPO4351cYWQw+Hl0nfaNU4xx
         EWKg==
X-Gm-Message-State: AOAM532lWi9Gzhgpizd+H3zYuOco3n1Fg4qZwZAR6yCYutOgOOFYksqf
        iu6mbeHfZ0poXMXLSpVP3SqLKQ==
X-Google-Smtp-Source: ABdhPJzcG4MuuyYGSYc5aRovMBAKdtgr0/c+TmaEGwcn6bvlGOd9c/rLwCWsd7uFwB1rb5YeBKY0Ow==
X-Received: by 2002:a17:90a:5801:: with SMTP id h1mr9105659pji.63.1629293343263;
        Wed, 18 Aug 2021 06:29:03 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s46sm6663515pfw.89.2021.08.18.06.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 06:29:02 -0700 (PDT)
Subject: Re: [GIT PULL] first round of nvme updates for Linux 5.15
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YRy5uawonM5ERm3D@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e2e66212-d555-18df-c9db-957b43d584aa@kernel.dk>
Date:   Wed, 18 Aug 2021 07:29:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YRy5uawonM5ERm3D@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/21 1:41 AM, Christoph Hellwig wrote:
> The following changes since commit 9ea9b9c48387edc101d56349492ad9c0492ff78d:
> 
>   remove the lightnvm subsystem (2021-08-14 15:54:09 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.15-2021-08-18

Pulled, thanks.

-- 
Jens Axboe

