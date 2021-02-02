Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADB0C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 16:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC7464E2B
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 16:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbhBBQAP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbhBBP7J (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 10:59:09 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E01C061573
        for <linux-block@vger.kernel.org>; Tue,  2 Feb 2021 07:58:26 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id z18so19247944ile.9
        for <linux-block@vger.kernel.org>; Tue, 02 Feb 2021 07:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mEKAAyorRRb2cGK1/IHzibcLIt435RpFXav4KGFJvoo=;
        b=0LzT/zjBL2NZTFaScgfbCVMUk9ITa7/pYDstU2YRVkf2E6DCuLjuwgLzWeT6CCIBPF
         yOLfJMRAS/Vh+TGPl/nOLUmAvy3hZdmt9GNnveAZuZnQTb16eMy2WifUkBqez+OXFw5F
         cPVJa4aJu2mAuHkM9ou4SXqZR7U7Pe74D2RREOlBdZjthhZFoXpVZYnF8T1bnjiAp49z
         6olF0vNa9UF7pu5XUwWZGeSJFxvO0d2elK9our3/BBcopqj1nKla5zEjHWTuwpEYqmUN
         EUaUsKXaSLmuryeAoK2w9Tr1fNn6jMHwM1dJLtKypZs17wG0lzMtJm/KXazuTmvny5wF
         XLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mEKAAyorRRb2cGK1/IHzibcLIt435RpFXav4KGFJvoo=;
        b=BBFcwjXP9lmhvp+Yc50qArajuv1FsCtxf1Ne7GpS2qezH+uHZ8NusNVmPLB085R8md
         2fCxwZ/rRPZn/QIqOF6By51lQiC9f2G41431pWOiLIWbN4u71KgD+XjXmiMJH3G2QHAZ
         9jZsG9LCDJnAz14CNU9t+t/tt+FQDmK8BtBFhdM5jPU2Sg+lWh8QYlZX/5qS17tEKuXE
         fVjzMZ9b+2EyGgkCSiY7M1UCKdWnrKi3ZciBvPUcv8VCn7m95ANGX8kO9DZzJMFiNC1p
         +x7zMOyKbD0sw3lJbLbMMdnMHZL/siR8mnFJrzMKbbvjq6TJOWJjy+nH1Gm/W4ZVw2IE
         m1Uw==
X-Gm-Message-State: AOAM531onElgftkeqNBFBiUHdn9rZmzC1qpUROp5vJqu+VuPf4KptjiJ
        Qikvf0g2NMckhjyH83rus5sa9w==
X-Google-Smtp-Source: ABdhPJz6VV33/by2keG912VXypTJ5pm4ZaPCwzXYEfq+oiwpacMrV7Xgr2FvmSXi18ODo4WkAE03zw==
X-Received: by 2002:a05:6e02:1bad:: with SMTP id n13mr17657394ili.260.1612281505979;
        Tue, 02 Feb 2021 07:58:25 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k9sm9979555iob.13.2021.02.02.07.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 07:58:25 -0800 (PST)
Subject: Re: [PATCH] block: fix memory leak of bvec
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20210202155410.875745-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f9b654d0-0425-c634-f820-b36b38fe6e8a@kernel.dk>
Date:   Tue, 2 Feb 2021 08:58:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202155410.875745-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/2/21 8:54 AM, Ming Lei wrote:
> bio_init() clears bio instance, so the bvec index has to be set after
> bio_init(), otherwise bio->bi_io_vec may be leaked.

Applied, thanks.

-- 
Jens Axboe

