Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05572C432BE
	for <linux-block@archiver.kernel.org>; Tue, 17 Aug 2021 14:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD2B160F14
	for <linux-block@archiver.kernel.org>; Tue, 17 Aug 2021 14:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhHQOfh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Aug 2021 10:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240151AbhHQOfW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 10:35:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91D5C06179A
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 07:33:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a5so25074054plh.5
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 07:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tzdG91mvLikItkKHL16jMN1Imbxkt6wutxPZo5aGWC0=;
        b=ULDbYXgdwjERpFMDjtFc9mhN1l0x5bTrtCFWHNEBPXxHUgPbNbbNRPZrkv2E/LJcYZ
         Vir5oHUOpDl58CdByxQ/08eG6aafzUeRbJwtbd2cM9/3ZaVwqFg6U6aoqbwb80oYcgad
         xgs1KNMRoEuzAWUCji8C9ZV/U01DEEP7H0TfLy4X2gYp/+cfw5gQVaa+lZLHorZzMwVQ
         7R/7i6ZyfTK3AXkt6kAnuWMr9zSr4py8zxvSHVNw6sjXVIj6s6j+LWmNSroSfg9JZcVd
         bTrrvj1fdpoKtpM+P/nA+u0IYYHz57s6siYwScqSOspm4kpzkJERkoJdLNaTJPRiwiCD
         enWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tzdG91mvLikItkKHL16jMN1Imbxkt6wutxPZo5aGWC0=;
        b=GBXVA3l9KhzzgrEEjnVK2hdm1ybPWXkvP+eeJx4NT7r9li9KHbhMj97Bk/1Y79PJS6
         ZNZxaBplq3xTi6Dx9KGmLrLEBr5XaYVa0FWxdahCEPjD0hkKWXN9pv4BAFJbU4NeJP0G
         kthkCcBA53O1Vp6M1zMEeuCA0p6074ho5hJZstT+DUsNEmlOn72GobZLmI/xTSHrMIIE
         mVRtujTphIo0c0CBaGZO3DwQ1LDgPe8+gSoMuVPjE81/fY8CpefNNht/EAwNlYLCyxXR
         UxUd7QflbieerNal9QrH/Fq+u2e/zShJYQ1epHwyaOJsxNRHa4iONRxOFasRGgUP9R2Z
         5LQA==
X-Gm-Message-State: AOAM532yCkwBOuw0KTeGyzXA0Gop/DWCK7VZ5edEihwxiU2l1FiKysC3
        QxpWnSJTsdNfhHyRz1B7j2clYg==
X-Google-Smtp-Source: ABdhPJyzw5LxZcz/PDNPEIfypb+Gc8aylTUVDDq2GSGGiSHPW9NHLKMZKpfeg8v0fsEcu29HG27Z+Q==
X-Received: by 2002:a05:6a00:1348:b0:3e2:c99:a7b0 with SMTP id k8-20020a056a00134800b003e20c99a7b0mr4075381pfu.62.1629210831161;
        Tue, 17 Aug 2021 07:33:51 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n5sm3450665pfj.49.2021.08.17.07.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 07:33:50 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: fix kernel panic during iterating over flush
 request
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>,
        "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>
References: <20210811142624.618598-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e59e905-0ffe-ec1b-05cc-ae9d367999cd@kernel.dk>
Date:   Tue, 17 Aug 2021 08:33:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210811142624.618598-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/21 8:26 AM, Ming Lei wrote:
> For fixing use-after-free during iterating over requests, we grabbed
> request's refcount before calling ->fn in commit 2e315dc07df0 ("blk-mq:
> grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter").
> Turns out this way may cause kernel panic when iterating over one flush
> request:
> 
> 1) old flush request's tag is just released, and this tag is reused by
> one new request, but ->rqs[] isn't updated yet
> 
> 2) the flush request can be re-used for submitting one new flush command,
> so blk_rq_init() is called at the same time
> 
> 3) meantime blk_mq_queue_tag_busy_iter() is called, and old flush request
> is retrieved from ->rqs[tag]; when blk_mq_put_rq_ref() is called,
> flush_rq->end_io may not be updated yet, so NULL pointer dereference
> is triggered in blk_mq_put_rq_ref().
> 
> Fix the issue by calling refcount_set(&flush_rq->ref, 1) after
> flush_rq->end_io is set. So far the only other caller of blk_rq_init() is
> scsi_ioctl_reset() in which the request doesn't enter block IO stack and
> the request reference count isn't used, so the change is safe.

Applied, thanks.

-- 
Jens Axboe

