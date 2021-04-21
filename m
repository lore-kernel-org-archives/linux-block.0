Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE143C433B4
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 16:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E0D6144C
	for <linux-block@archiver.kernel.org>; Wed, 21 Apr 2021 16:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbhDUQuq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbhDUQuq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 12:50:46 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7E8C06174A
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 09:50:11 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z14so9224047ioc.12
        for <linux-block@vger.kernel.org>; Wed, 21 Apr 2021 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yGqCexpFuGR9LLielbhXKnfOcJAEBpHm0Ib4c2gARxQ=;
        b=NApz4+N+yH2J7oktqEtQ9T4IYJIFiZoCK7BmUqJstzQ2pevszQ3/CXoHIrmk/HDl0e
         MkNclseGLnA9VgU7hFi5qRbLYR1M6JNTEEwQSKSXBtGQb6xZoZ1dEAozbxlDxcdo6ezO
         O8lY1Si0BZJn4PQG+vW/ybiyfZONwRyeVLznOEtidfikd1qoDpLAjXJStsvQbwnXXn2t
         aCpISALVpuGKn7vYNGSn6n5ElywPbWiJMwO0gga2wV5zxSFN0AnyJKWYPNw97Q5seJku
         6eXZsPVXN+RjqLl6I66G6xQBaNh3BeDd8fKeF7U5/QJcJyVFDIJj4Ws9vsVxaiit1cZH
         8f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yGqCexpFuGR9LLielbhXKnfOcJAEBpHm0Ib4c2gARxQ=;
        b=SZncRxnsXdcTVhKB42y/qvV1vjUE1F1rCR9sHCY4GxIlpNtAOZzCnVxwmlcd2gbO4p
         VTjGSQwysq0xvMfz2RSr2g0/zXMKTdl5TmwXmbUeje0+czJFAlBoPhkR9V5o/hLHjF2C
         9nTjqQwpYCLf3xKx1x18aj13ZDozb+LiJt2pxDj9PjvM0yK/ApNPgxk7mlDSAqvM4I/8
         W4kZ7zZ3hk/vZjgxR2Nvxre4JTvDzq36YelvlNinac7xjQ9YUiwqI+pIiZrkfRc9zwou
         dilXKfX1X6EBF6AWEX+MZt00Ug7i2CWdXOT68rWYHKDxyJ6JpGG1Pr/dhBZQc6I7rWqE
         8F6g==
X-Gm-Message-State: AOAM530sY6tRXsl7l5hOHq9BBd1XU9cURQ428h5j5cyGH4tjjYPiZGC5
        bAT0pKVTbJkHAT7F/rL/yu+RHGvU3MgeDg==
X-Google-Smtp-Source: ABdhPJxuXHw+abIlD9Thcjyb2kOA7ibvWI0DmHXa3evhKtanM3Ssmw8nwkWHz+r/nzc9F1A7qvFrmQ==
X-Received: by 2002:a5e:d907:: with SMTP id n7mr25239566iop.177.1619023811274;
        Wed, 21 Apr 2021 09:50:11 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v10sm1243913ilg.26.2021.04.21.09.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 09:50:10 -0700 (PDT)
Subject: Re: [PATCH] block: return -EBUSY when there are open partitions in
 blkdev_reread_part
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Karel Zak <kzak@redhat.com>
References: <20210421160502.447418-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <965792bf-441c-95b5-88cb-b176196cc373@kernel.dk>
Date:   Wed, 21 Apr 2021 10:50:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210421160502.447418-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/21 10:05 AM, Christoph Hellwig wrote:
> The switch to go through blkdev_get_by_dev means we now ignore the
> return value from bdev_disk_changed in __blkdev_get.  Add a manual
> check to restore the old semantics.

Applied, thanks.

-- 
Jens Axboe

