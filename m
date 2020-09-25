Return-Path: <SRS0=r6We=DC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0DAC4363D
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 14:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BB3C20708
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 14:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="E55wmYy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgIYOfc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbgIYOfc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Sep 2020 10:35:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB77C0613D3
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2020 07:35:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u3so1859314pjr.3
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2020 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3sVDrl7nq71b7+Tl95Id30AEaStu5JjNu+SbInS86S8=;
        b=E55wmYy6/zrsq1xauJ75mYZUcCl/7T8kL0VfI5mCOUuYURZxcMOOCuqthu+IF2L+NV
         eVlWeUXhu5vEq18VjsiZrD8N8Pk0YBn3UJ20S0yUhwxU/3UiyJ/bTPgCZCRlHIKCtqf+
         4t22c3hKJyeQK7cv5zEt6qCepixo/cNSB3/qhci7vp34g73P5vhesH4X/NDeo6RfV2ub
         BIV8GJZkeuY5TiDZ/1rLHDCSOwqaT7mQ6eKLpRjVzo0yU2z/zidZBszbbUK642laboim
         qTAd7a0vjHf0JpTsjxT/CmJDVk2TnsS+rzCwxP9U/4bTuRRs+8MwUdkc8Raqtx1O3cZ2
         h+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3sVDrl7nq71b7+Tl95Id30AEaStu5JjNu+SbInS86S8=;
        b=FT6qBn4Xx0WXQNecDe6xlN0GTVxaYuoxqp5tTXj8WNBGVM496ib5F2pzVoMvRF76GI
         RM8Nc9f9o0BjiNCIbWZELISBk+TFfoGekN5EYe/HYbGN5TWncFdQwPLuIjQtAIxFBh0i
         jBgiry8FddPLGkXnKJ2PeS6XQDcJLZrsfYpadCLAR1LbSEIxN4QftSOPGwfQVFMjFuTI
         dBOr/q2BM2A7T9EBd9mrWb2JWyeuC2xYXuSfSHYIMYYNgA4rnOP+rO855Ra8bbduk/0g
         fxIek4Zzz3dSZy/6IV7bqTj7s4fVX5FjW4le11A8iOHgAI6PNVUvbzk1YpwfdLyjVoyB
         nk7w==
X-Gm-Message-State: AOAM532TqYs6W4NKJn7KGcI8WGyYpiJ2bRnNxsW4OGyFc0XUUh1d8+h6
        LOjLEtKO72lEtx1qTy/n3PZLmOR8q8R1Qg==
X-Google-Smtp-Source: ABdhPJxxZ/jipQ6UmFyIc2cAtDZeTloKi918d+xUfqX+TxGNVI9NqJKGAzht2a4+S8FbMh21YYiD/w==
X-Received: by 2002:a17:90a:e984:: with SMTP id v4mr599004pjy.202.1601044531755;
        Fri, 25 Sep 2020 07:35:31 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r16sm2257501pjo.19.2020.09.25.07.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 07:35:31 -0700 (PDT)
Subject: Re: [PATCHSET for-5.10/block] iocost: improve debt forgiveness logic
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200918004456.593983-1-tj@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a4baed8e-d3a5-3801-7f26-5c32f2931177@kernel.dk>
Date:   Fri, 25 Sep 2020 08:35:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918004456.593983-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/17/20 6:44 PM, Tejun Heo wrote:
> Hello,
> 
> Debt reduction logic was recently added by dda1315f1853 ("blk-iocost: halve
> debts if device stays idle"). While it was effective at avoiding
> pathological cases where some iocgs were kept delayed while the device was
> most idle, it wasn't very effective at addressing more complex conditions
> and could leave low priority cgroups unnecessarily harshly throttled under
> moderate load.

Applied, thanks.

-- 
Jens Axboe

