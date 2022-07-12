Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBFFC43334
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 20:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiGLUAK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 16:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiGLUAK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 16:00:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B861D3B974
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 13:00:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso37048pjj.5
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 13:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B1sDLyZ5Xc8eB0+JNq24um+q5o46tQ9sjKC9v/SqDzk=;
        b=IxDSipI9m3WrKUabXBmTlLTxf+gLKIaKETVNyg0TZJfa/TkoR70FD69kLp3V34w/xn
         s1z1bMF0TIf7XSxOjGFhnOt83R4VK3lHCO3TX0VJTb5MVpLVFVHWqXBPDr+qT9drA6en
         BHtpkzZsuUXfzNaZmwlKeHwhPcOIUKvhIHgYmN5qKrsojN2D1JMN2yUSyzDlHj2HnQyg
         7TLnydoJWwsAqNd+aijbeW7eICLYaXqhZd+zRJGG+qob0Z3ow+NT7R85mPnKlL8wjbV8
         8S60K+aFV3Kcv4YkMNF9LAoYBR9bIlY8XFhnJLCpRhugOKOOchvezivfs9/bScIRA7XY
         Ca9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B1sDLyZ5Xc8eB0+JNq24um+q5o46tQ9sjKC9v/SqDzk=;
        b=Ttb/X/IBeCpEJ374yJhciqPwAhaaN8hZ9qCuz1OuuY1yPB4AR7XlNrPjAZ+fV0Qoua
         40CJlty+3x/I5dx37lEBq8F2tYQ0j5aOh66Ba9UplPTHMnFZ7c2aWk+VzGoZDZUko3Gb
         dlZ3SVWLOk1MVH3N9O9qk6ruwKuwRT0l8nnEc1upU5LQPqrL1E4Arp4GkIIgiPz8h2Dx
         9P/9R/VI9yn2x+DgKSUy6MO8ViZEFEAMAk6KKV1p6k2swLW2mPAjLHQqJuEnBefK8s1s
         U3hGXB1+mW+KqssThE4hx3aGN7NxbpVVo1orAxPeLkW1QQBUCnfYnFZpsvrtmdS3cdyc
         /pTg==
X-Gm-Message-State: AJIora/fEbshoTij/iGgrs6JK86el45QOQaZtYMMFAqrt1j8pVc7OwFE
        lqNBeCwjEBqOp0MePeipjysv+LXUADjg+Q==
X-Google-Smtp-Source: AGRyM1uq6wv7V+mVhyLGol5EDjl/naFAOpHVMYlLVDoUSpOh6O/Cff7sbtD1d6/Qw5Jd5GTigxLm9A==
X-Received: by 2002:a17:902:e948:b0:16b:9263:b6d6 with SMTP id b8-20020a170902e94800b0016b9263b6d6mr25641936pll.34.1657656008144;
        Tue, 12 Jul 2022 13:00:08 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b00168b113f222sm7292643plg.173.2022.07.12.13.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 13:00:07 -0700 (PDT)
Message-ID: <f88ba06b-4d4b-ffc4-362f-e00198ecc242@kernel.dk>
Date:   Tue, 12 Jul 2022 14:00:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] blk-mq: don't create hctx debugfs dir until
 q->debugfs_dir is created
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
References: <20220711090808.259682-1-ming.lei@redhat.com>
 <4c5f332f-ccd4-5d0e-14d4-bccf57bcd7cc@acm.org> <YszTg0GAQrOa96UX@T590>
 <3240717a-bec8-0681-1c78-c2b06a2346f3@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3240717a-bec8-0681-1c78-c2b06a2346f3@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/12/22 1:52 PM, Bart Van Assche wrote:
> On 7/11/22 18:50, Ming Lei wrote:
>> On Mon, Jul 11, 2022 at 10:20:39AM -0700, Bart Van Assche wrote:
>>> Does this patch need a Fixes: tag?
>>
>> Yeah,
>>
>> Fixes: 6cfc0081b046 ("blk-mq: no need to check return value of debugfs_create functions")
>>
>>>
>>> Additionally, as one can see here, I reported this bug before Yi:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=216191
>>
>> Sorry for missing your report, and I am fine to add your reported-by.
> 
> Hi Ming,
> 
> Since this patch is already in Jens' tree I will let Jens decide how
> to proceed.

It was top of that branch, I did amend it this morning with the Fixes
tag. I missed the reported-by, however... Sorry.

-- 
Jens Axboe

