Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32A1C433DB
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4D064DCC
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 17:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhA0RKR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 12:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhA0RKF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 12:10:05 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E075AC06174A
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 09:09:22 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id g15so1759886pjd.2
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 09:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YJFirqRxiABeTbLcOq0B8ivyDH34hEqL7q64G4hhzdg=;
        b=h9IX9k3+eev4VaJViLYLKESa7QZAI00kQQQYISQE1RxG0GynS5RHaXfkH0rek1dJ4a
         vEX8Uju8YcYl5fUqZqulrC5lONPMZDBu5bjvlQGBTZbzNhjgPjnzXt+ORkyT4LpUU9mT
         szeHTd7Ml53Vbh723gEHf5AW6zefm2cBW84PY83vEitWC/wjWg4AVGoDR06AkRQiENUQ
         BVrsB36k4HTs9a3AcJVBegsMz7bFIMwBd9tHNPQxHXSgMychugDktQAifnnf6U+oRLeK
         fSdTs1xGy4RQHmNZmKKHbRT9uN/fNIfdhobqRBStFHUsH6zq1iuzjcucb94WWe/IeYwJ
         fiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YJFirqRxiABeTbLcOq0B8ivyDH34hEqL7q64G4hhzdg=;
        b=SOGRfVZvMCB57iozqaa3MkYX00dD0TKm6P5lM+PiX+OFt8nfI4vMQHEh3VegMZRJ5V
         dBN9tNNq8+9kC8QOAqjbsTODI8o7k2o4SVTd2oI1t1d2mELXqRaGJO+3aGGdjGuFy37u
         nPk3dhlvgU6fpcCGxDYzZlT/8wRiNpZKK2AcKmRZvqZM+y1eZr/JTuXDv63G7I9XJbUd
         rRfCfXvuw4/zXgt1VKhyWTSJL2xOXHim+wWLJCCVemSLD3qDNa4uRDOI93cc9pZtzuE3
         3anMdmKIinemuwmv5+eRw3lGoR7oo1BKS0gqlv7K2PJDMW1Jz9j3WgP6Xk1xmkCqsVtT
         F4GA==
X-Gm-Message-State: AOAM533FjNIyxQL01sFvYw5I8U5xh9aH0IhQV38t+nqNN/6qqC7ltgrk
        fB0GdvxqeBUNmrjh7zfpBs6QHbkEZJxKJg==
X-Google-Smtp-Source: ABdhPJwQ1UoM9BVwq5PjAvq/C7WXKMZZ89ZliJF81kJm3qxWSKohWAlTNJumniZHSaRUJbV+ZgAybA==
X-Received: by 2002:a17:902:c40c:b029:dc:9bc9:b98d with SMTP id k12-20020a170902c40cb02900dc9bc9b98dmr12292977plk.19.1611767362370;
        Wed, 27 Jan 2021 09:09:22 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 101sm2628493pjo.38.2021.01.27.09.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 09:09:21 -0800 (PST)
Subject: Re: [PATCH] nvme-core: check bdev value for NULL
To:     Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        kbusch@kernel.org
References: <20210127053738.4922-1-chaitanya.kulkarni@wdc.com>
 <20210127071344.GA21223@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <683a593e-a5f2-0e09-2ad1-c2527946b253@kernel.dk>
Date:   Wed, 27 Jan 2021 10:09:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210127071344.GA21223@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/27/21 12:13 AM, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Jens, can you pick this up as it fixes an issue I introduced in
> for-5.12/block?

I can, I'll add the fixes tag too.

-- 
Jens Axboe

