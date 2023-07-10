Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C86EB64DC
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 19:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjGJTrp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 15:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjGJTro (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 15:47:44 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3036C13E
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 12:47:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5576ad1b7e7so797649a12.1
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 12:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689018462; x=1691610462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wx6jz07CguKA7YsY2NRJvMLsnINssTVQYdDo1GqP/S0=;
        b=0WbQHgoaMO2YKQRgiCfjEHrrT2yuQHX/f5+FVtNOd/TF+XhAcM1rFA3VH7tFY0mCOB
         Ok/u+UCt99IWrtDyeipbwp/Rl6F2lOxRKm45S5oZKg+y0QUCcsiUe9x5REQoJWdeHwax
         k+NqygxlmdkXYtrHGg15uk550SRgl0j3jCMPpq2Ow3c6gX017KTkbmBSfvKKSlGFmeY5
         mn/lwxJ7pCHqBt4Qfc8lULN6OMs8I0oaVjAzAOGgVTJz3nKSkb/mZ2EuAHF+zP7RbtVk
         Iy8FNQUYVzbGoPKfvmKvR3eDc0rM/5aL7Unx8ejt+MkTUv/32WHlwbg7qg9emODucEye
         dUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689018462; x=1691610462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx6jz07CguKA7YsY2NRJvMLsnINssTVQYdDo1GqP/S0=;
        b=R2BojdyF8e0zdqP04iOPGhnZ1NwQh0zAq7kekteBDS+n2b9ACp6y7BAYLgiE6Pw09m
         UA6Wc0jwIPeOrCZzQKYS4xEiJUODtRBE7vN2iDogpjSPEqX41MTqVZ7+PfmK1NAK6MrE
         Ud8kTJy7gHwKhQP2+3KJVtBcvPd8xs+NOgqYXVlzk6r8zH4At/SaSIdgwTSmL2LAtkiY
         BHdoHRp1au/wHXXi9Zb3kAf32BQamdtGlIbyjLlJk7npY49woAHhIv8JU6RRQbEzB64Y
         TYR9D986huO797LaqbrFihgwHgn8L+7OHZILyKv+AQ68/3ZmQ6mPffRmo+7gKRA3y2ig
         G7Eg==
X-Gm-Message-State: ABy/qLZHE4nNRpfQCnieBP6nfinkHXp9WdWJd7IT9CBCx71hwt11dUwj
        mBRHhbWl6O7Tw8GBCsbf4wNl4Q==
X-Google-Smtp-Source: APBJJlEjX5EE9AMOjnRkIhttTAuRuoQbE8zIt1M3jXvoaVqZ63sguWSrScz/k8tGFCDwa4d3c6QKJA==
X-Received: by 2002:a17:902:d4cd:b0:1b8:17e8:5472 with SMTP id o13-20020a170902d4cd00b001b817e85472mr17625205plg.1.1689018462501;
        Mon, 10 Jul 2023 12:47:42 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g7-20020a17090a714700b0025bdc3454c6sm6749421pjs.8.2023.07.10.12.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 12:47:41 -0700 (PDT)
Message-ID: <aa813164-9a6a-53bd-405b-ba4cc1f1b656@kernel.dk>
Date:   Mon, 10 Jul 2023 13:47:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Content-Language: en-US
To:     chengming.zhou@linux.dev, hch@lst.de, tj@kernel.org,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230710105516.2053478-1-chengming.zhou@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230710105516.2053478-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/10/23 4:55?AM, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The iocost rely on rq start_time_ns and alloc_time_ns to tell
> saturation state of the block device. Most of the time request is
> allocated after rq_qos_throttle() and its alloc_time_ns or
> start_time_ns won't be affected.
> 
> But for plug batched allocation introduced by the commit 47c122e35d7e
> ("block: pre-allocate requests if plug is started and is a batch"), we
> can rq_qos_throttle() after the allocation of the request. This is
> what the blk_mq_get_cached_request() does.
> 
> In this case, the cached request alloc_time_ns or start_time_ns is
> much ahead if blocked in any qos ->throttle().
> 
> Fix it by setting alloc_time_ns and start_time_ns to now when the
> allocated request is actually used.

One of the single most costly things we do in the io path is the crazy
amount of time stamping that's done or added without attention to what
else is doing it or where. And this is why we have a ton of them, and
why the batched time stamping made sense.

I'd much rather see this just get the saved timestamp updated when
necessary. If we block, that's certainly one such case.

-- 
Jens Axboe

