Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ED8C433F5
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 22:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFCE56105A
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 22:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244705AbhJPWP4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 18:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244698AbhJPWP4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 18:15:56 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0E7C061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 15:13:47 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b188so7021926iof.8
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 15:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lbgEeB939NGOLnhWPR5Fa2/E1Q7+SrlpRH2rXX21ogY=;
        b=koH8LY86XRlx4OoY9elLEq8lucuJs7yws+FLWK4U5bAiHnufhadVIH3gOMXV5UcQew
         c/+7gLNd9Ung3P7qnkdxCq/dkoufB2imxQv59VbXs/wHUFt3yiVlK92J7AiqX4mTMlDy
         pcwxyC3BmguH3LO7SSElFwgcJEwfu7syklnggzWDB3SBws7tdo/P05WmRXP6t+tLj7Cc
         iq1b8avT+2uXVMFNJp44hk9p2yD6Rk/3/CWUYtCaNzCwhf7pIm1YkZ3gsO/1J1LlKtYX
         r5PcSHwjDp76RlDXPpb5YPErfQsDBRibjpJJJyQfqBctUsFd8XmK4TeM4mtGu7zdFDbv
         TApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lbgEeB939NGOLnhWPR5Fa2/E1Q7+SrlpRH2rXX21ogY=;
        b=cvoEd3FEq3imr5sGJ4dso5PSm8fvR0WuEEdgE+tk7oOKAXC0hdWNUeq+5x2SuuxoV4
         wOG6TrqkIqH/Q0YPvKDPR2eNRVTTPyo5Hhnx2PQnuOEEntU5qDeqLgBGxjQiy96PcqAA
         fotCgjgsVGRLp1CIGoiThq+ie0+WQ/MbTjB6VoBG/BQFY1sqnhVccgfhKttXyTVYKEUq
         00hO1Bmd+qx5JaH+vA8o55gJfsrmbKnCDxNkAc4S/q2MaQLyWS4s6ls689MPJuwZT6Mq
         Cyr0XBS24tY9jK/mkU2L5MPW49lSir8V+crElaQ+jzOgM+shg8AoAzfjwoUZWpmw8nGP
         h/9Q==
X-Gm-Message-State: AOAM533fpN+m/DNllwd+dIY8aHs0IVPIpGXC8JAW+vkf100CdmjpfzKl
        5KqevMAkmDlYFrM8TxmRh48mIA==
X-Google-Smtp-Source: ABdhPJzqpjc3W+0O5ZTVqY2TtvfOaMpHeP02UUwHCWa9TyVnGL+zKTcjIAanNMJD2AQOfKviKkNO9A==
X-Received: by 2002:a05:6602:2cd4:: with SMTP id j20mr9092562iow.121.1634422427327;
        Sat, 16 Oct 2021 15:13:47 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a5sm5137809ilf.27.2021.10.16.15.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 15:13:46 -0700 (PDT)
Subject: Re: [PATCH v3] block: only check previous entry for plug merge
 attempt
To:     Pankaj Raghav <pankydev8@gmail.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
References: <9222613d-d4d3-7cfb-2e96-1bfa3b5f2d7f@kernel.dk>
 <20211015141839.hlc4zjtvdpl75o2a@quentin>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f0c566bf-dd0c-0cf9-ff10-37d678898e15@kernel.dk>
Date:   Sat, 16 Oct 2021 16:13:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211015141839.hlc4zjtvdpl75o2a@quentin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/15/21 8:18 AM, Pankaj Raghav wrote:
> On Thu, Oct 14, 2021 at 12:34:21PM -0600, Jens Axboe wrote:
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index f390a8753268..575080ad0617 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
> 
> Even though the code is self-documenting, the current description on top
> of this function is now outdated with this change. 
> 
> - * Determine whether @bio being queued on @q can be merged with a request
> - * on %current's plugged list.  Returns %true if merge was successful,
> + * Determine whether @bio being queued on @q can be merged with the previous
> + * request on %current's plugged list.  Returns %true if merge was successful,
>   * otherwise %false.

Fixed up, thanks.

-- 
Jens Axboe

