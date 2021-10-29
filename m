Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B89C433F5
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 12:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8BF61175
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 12:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhJ2MqJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 08:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhJ2MqJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 08:46:09 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D74C061570
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 05:43:40 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i12so4288538ila.12
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 05:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=KzNPsRfMKqoJP956zJMiQfTvmLR1jEeJQFEcOxRbL84=;
        b=wFzZUdp3ATwd3Rars+0pExsV2ODHdhY1M/Po9DvpSKvOa10PTnEzHmdg3TO7JpB/HZ
         EECr3ALaXqKazsL9cjRPCL5wZLmjareJxAAbRZVbPFBkhCkuGt5NZ6gNyZ7Lf4UsdYNP
         HTi5JlAmSPgEIV/mOc4lNGAf8kRQ5pNBjnqZ2MjD5Y6ddJwImt/EztwioOQ7r/7+0eEd
         sahJUWk2CDgH2pXHFn7qmQG/MEnDuYjzd1Uqs9UZ6nNdYyOM55F1ENNeycl6HfU3LUb8
         JL7sHmFye6uPdDVw6bvMjGy79USU/NJ7vqkfEeCpje1j/Hpdp/sQrox6JyyFhPZNMbwf
         3xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=KzNPsRfMKqoJP956zJMiQfTvmLR1jEeJQFEcOxRbL84=;
        b=shei31F7A2tUdp7l6Izv3OL5+UZQx7t6w+7xWadu3CUf9fchretTPkBH7dVNvhCtHs
         2w7mmrJoB9aVHclEUsWxDme1PkDW4Af6AmKxfnyrOiH11KTf68/ilJ6+hOJ+N+z5X6Ao
         njK94HcWR//IIUiw5uv8O7jKQhSHjrlviXcxPE5l1z01VkHPg0xDpnVoPdC8YehiHRBl
         WEc/wa8Fv2gBZ3W9O+5hlGEMJTFKC8LluHRGb629KDxxOna6UH/sm1oHCbG8ABmaTy+K
         cL3JXyUzt3ZtFH199t9X1RQz2bztUZhzU95ETdVNeLTFuAFStq91ILFQPfCk/tG/XBIB
         cfzQ==
X-Gm-Message-State: AOAM532u4Zc3hVwm6XHRwOZnr4eBlVmf6tMlgRnCJSO7BMnszjYnr9PJ
        OpF+dFnlor6oIhzAWY8nk6AkKA==
X-Google-Smtp-Source: ABdhPJxLRGMhbaPzvgUI3F11qdqZYCutKeT2sxM9DSk1aML83byWNJMqc5P2UkRIHU06aBEJVUG9bg==
X-Received: by 2002:a92:d752:: with SMTP id e18mr7589066ilq.31.1635511420289;
        Fri, 29 Oct 2021 05:43:40 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a20sm3126976ila.22.2021.10.29.05.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 05:43:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20211029060930.119923-1-colyli@suse.de>
References: <20211029060930.119923-1-colyli@suse.de>
Subject: Re: [PATCH 0/2] bcache paches for Linux v5.16 (2nd wave)
Message-Id: <163551141854.81306.9109988808769746352.b4-ty@kernel.dk>
Date:   Fri, 29 Oct 2021 06:43:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 29 Oct 2021 14:09:28 +0800, Coly Li wrote:
> This is the second wave of bcache patches for Linux v5.16.
> 
> The first patch is suggested by Arnd Bergmann and Christoph
> Hellwig that the bcache.h should not belong to include/uapi/
> directory, and I compose the change.
> 
> The second patch is code cleanup to remove coccicheck warning
> which suggests to use scnprintf to replace snprintf(), Qing
> Wang posts the change to remove the warning by using sysfs_emit().
> 
> [...]

Applied, thanks!

[1/2] bcache: move uapi header bcache.h to bcache code directory
      commit: cf2197ca4b8c199d188593ca6800ea1827c42171
[2/2] bcache: replace snprintf in show functions with sysfs_emit
      commit: 1b86db5f4e025840e0bf7cef2b10e84531954386

Best regards,
-- 
Jens Axboe


