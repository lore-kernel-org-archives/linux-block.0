Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B244C433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 12:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B0A61246
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 12:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241374AbhDLM4Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 08:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbhDLM4Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 08:56:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E5BC061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 05:55:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k21so329239pll.10
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DEN7UWxU5iFQpUftfSPZicbN3DjnaYsTaEPzAYV3xeM=;
        b=CHcl6XTBgCY7rmOsqf15PHLM6f83nEN8N3JezvATOzNrLlwWwm7ivLSp1uHF6FXYFO
         zdz4dKLGgvQ1XrXzbgKKQPjnWQw7PGqdkQhyQ8dVMkIIdrHesQhYWcr+BezC1HEOqVxx
         CjEuAoTyTsbfL34x5IbCsoZ/EAiI1OZ2aXhbXf8+8L1xOKh2ej85pGsJjYYWdthtGGi1
         1W82iK/BhV/f5vaiupyYa62Xa4D+R2kJf2DPzQJFqjd4h6FTuqBBDqdS42nqqqMyq935
         1cL9D1g/2ZaLHFdk5OemotMlOmkc4yCBLmJuaxg5BBvmQNL3Kn7v1fHHURl7agNuhcjQ
         TAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DEN7UWxU5iFQpUftfSPZicbN3DjnaYsTaEPzAYV3xeM=;
        b=S6O7ZeLYG521REKCR3Q0Eh0A3zFAdaj3MdzmTpoX2cVAPE32+62ZfnK2vyAvod5aHK
         BFAYzetJz7CIIgFBr70OZ1ZcfgrT3sOy3X8vxRzZ1SaGFtmRggY2GfCNfbfSHzcuvP93
         6FfsZw5vqNSsYABC1l/10c5VDEqDpy2J1+zqSUVejd6kypUjxk5De1NM8USbYRK9P5mR
         7kAwW5B0gJrWny4pgx2axgXvjNZUBJA8Kk4gNzT1xUsqV076GleRfk16u2vHP8r68chX
         0bpA06cIfmD0oF+/hdsOl4mqk984R7Ho3EH8W84FF0Qa2QKexSss4/oE8G/KjlY7jqlZ
         j/cQ==
X-Gm-Message-State: AOAM5300KeNmkVh5nf6TIffs24ERGX0tuAUJ6DuU3vBkPO00RXD3EwvH
        IGpC9sgA3j8O72LX8vDuCcLlFlG87c0I6Q==
X-Google-Smtp-Source: ABdhPJwQal0GpA5BltPe+eAawSZQNR05clMs/QjGBddIMnOrFX3/msc2TYzsy5ppDeUKinXny5hu4g==
X-Received: by 2002:a17:90a:e510:: with SMTP id t16mr22678453pjy.224.1618232157942;
        Mon, 12 Apr 2021 05:55:57 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k13sm8114823pji.14.2021.04.12.05.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 05:55:57 -0700 (PDT)
Subject: Re: [PATCH for-5.13/drivers] block: remove the -ERESTARTSYS handling
 in blkdev_get_by_dev
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210412080318.2583748-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1e67afac-d41f-f9a6-81e1-294dfb81d0dd@kernel.dk>
Date:   Mon, 12 Apr 2021 06:55:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210412080318.2583748-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/21 2:03 AM, Christoph Hellwig wrote:
> Now that md has been cleaned up we can get rid of this hack.

Applied, thanks.

-- 
Jens Axboe

