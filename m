Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95220C433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 15:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731C22075E
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 15:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DUNL3Tro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbgFRPY5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgFRPYz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 11:24:55 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB537C0613ED
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 08:24:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l24so3054404pgb.5
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=57vHaiJ1z2Z+B6kffIaWqG5PKqCuhVgYJgvWdR2P1mU=;
        b=DUNL3Tro95sEbRGk1k9182cC3jStTGoNgKewAglJ6YRNlHJv87uK1t1hRNtaQEhV5L
         UTfj1GpvRmmyA1B50ZcYrWpgiFOcwWnKq2nXWTEZwrFFTNXGymBVxNRFka/68NlJ2dTG
         qfIjIYmNPyT62lJwvHbbdQhPYaZQAJagTnkZTuAhHtO5KfsR0g9wzBLXQfxfHsV6GHN6
         624iEklbDzR+9xIIXd5GYyQv5IbY5SFbJuPhTfj2/PA36ccdpVyi2vUq3QFFfc+Ubw2V
         AH6WRctLz7qByC57MT+eoT/ewS7naR0XN7qYj300Tz5IjdKy2nzjJXr72q397zinrHI/
         C+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=57vHaiJ1z2Z+B6kffIaWqG5PKqCuhVgYJgvWdR2P1mU=;
        b=XgNl6AS3PbOxVYq8NVX3/VWXqlUu+D1b2veKgdRAQU+Fwc6zeqT7DuukC6/Nb3mMGI
         p2NbK5TymKIJB7I4A5ZQz2oIHwx0Il+I44L9myqtxCgQCOUv3hFWJyTMsjx8mCgRe4Tz
         a0ZaPS2KZCgya7nfqxgdN0NUsBMy08opJPhTZ9zE0mHUl2k6IX040QvRDZ0MlohwoGw9
         zZdghu/tk7lgc4EYe3+YT724yIh7znB2mVg3kb3+cYiaLT4baSAxVePvr/0ZkfzKHJNI
         YH7Yf1EulgnuJnDALXBpPp+VK+Zs94Ww+tS3IzqJPm39btIlUa4EtBVfPo+Hk3BsX5dN
         i/sA==
X-Gm-Message-State: AOAM532XQC80qxrmSmYt1nHA/r6iSA0XzgjjNlgpqU4yd+wjvLSWfVk2
        Mqoc5qHm7EXUWyoZ4qrPMrmC1Q==
X-Google-Smtp-Source: ABdhPJwMIf0SfezQ0GrtwoEg2e+XOj/fVZ1pbA7uq3769PZ3tvRMFjSVUgXFvAyB6WvFBwS+/oiD+g==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr4105037pfd.248.1592493894149;
        Thu, 18 Jun 2020 08:24:54 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 85sm3255834pfz.145.2020.06.18.08.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:24:53 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] loop: replace kill_bdev with invalidate_bdev
To:     Zheng Bin <zhengbin13@huawei.com>, hch@infradead.org,
        bvanassche@acm.org, jaegeuk@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     houtao1@huawei.com, yi.zhang@huawei.com
References: <20200618042138.2094266-1-zhengbin13@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22da0c3f-6656-1c1c-9b6f-6069392de719@kernel.dk>
Date:   Thu, 18 Jun 2020 09:24:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618042138.2094266-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/20 10:21 PM, Zheng Bin wrote:
> v1->v2: modify comment, and make function 'kill_bdev' static
> v2->v3: adapt code for commit 0c3796c24459
> ("loop: Factor out configuring loop from status")
> 
> Zheng Bin (2):
>   loop: replace kill_bdev with invalidate_bdev
>   block: make function 'kill_bdev' static
> 
>  drivers/block/loop.c | 8 ++++----
>  fs/block_dev.c       | 5 ++---
>  include/linux/fs.h   | 2 --
>  3 files changed, 6 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
Jens Axboe

