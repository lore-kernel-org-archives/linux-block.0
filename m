Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D22C47082
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 13:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981D8613E7
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 13:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhFCNod (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 09:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhFCNod (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 09:44:33 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA78C06174A
        for <linux-block@vger.kernel.org>; Thu,  3 Jun 2021 06:42:48 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z24so6351406ioi.3
        for <linux-block@vger.kernel.org>; Thu, 03 Jun 2021 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1RDUISF2jsikTWwm3f0Zbh1NDK4OuRR1Slpow+Un5vU=;
        b=V0esR9S3/wJ1cAgfIL6tcbRBlsmNwi2vKK3YrDvqflsD91/iwrmHxvH8CbELUFZQox
         aeCJjjhsY7P42mzQXAuo/d7357fSe4fxy5uoKn2geR4F3F37jp1RI/4054a+/UYpdOs9
         Jvb8ftpaiTgyRR0D0rKsesxUZMYKgtTKuHf7yrS1V8eKLYQm3LlnZ6cA7TE+nKC9LzPm
         icAZQVKej/EOz4OdXH6qNys+XuFtphqPGkFZyEb4mhJl2oe9x1jg1tfBQO+CLk7kjbe6
         VX7gcU1io4Lnn6pWFJxB7KitqjQfg95OJxQ97uBhgvH+BZNf+SbYusOrb8CPzEimchZO
         EUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1RDUISF2jsikTWwm3f0Zbh1NDK4OuRR1Slpow+Un5vU=;
        b=hvqM5mSM4m6SThY7PaymRK0F4i/b16uvgf6bEKRUWKAqIdbqGakKgwUupU4OzXxxMp
         EyHZbPHHBitbUzhnrObzQzBXKEGCsl6XHZ9hRhDjxGhNZzCEREVkNN10kyBqmnEquVv7
         0gyWGHyZCpVsHSeJd2DrLN6XcswYOsCyAI83u/AFVngX3qB2rmnrxl9YkQ75B6X4apHT
         vX+y3upTQzgBoTg5+aLX1lOdydqOLXPGN2kYNa7ggcLNWXOJp2jDJKw9m8igqtkEn01U
         DWQOYwz5CoehiwOQ5dwAizSnwEcGUkXeWegqgiWe/+KuFh1mZu9ySanw9NqEvMcwpwJf
         OvBA==
X-Gm-Message-State: AOAM530c2BCGNT4hwv/cRg9SlSI3FeogpuHA758fODj0B4FP/tEdW1ZR
        zbmQXvPqPAEigb25K0u3398DP4MLUK8qZoZ8
X-Google-Smtp-Source: ABdhPJyvhFMKNbIdh+lPzLE0icitYuwpRQlqqSNC6QqRYx52mr6hKPoq2evVj57bwfkUobA6EM817g==
X-Received: by 2002:a05:6638:197:: with SMTP id a23mr10487867jaq.77.1622727767427;
        Thu, 03 Jun 2021 06:42:47 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g3sm1571814ioq.42.2021.06.03.06.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 06:42:47 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.13
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YLh/K7UbJFnA2HPa@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4e58ee70-d923-cb66-44de-5e9f82408189@kernel.dk>
Date:   Thu, 3 Jun 2021 07:42:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YLh/K7UbJFnA2HPa@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/3/21 1:05 AM, Christoph Hellwig wrote:
> The following changes since commit a4b58f1721eb4d7d27e0fdcaba60d204248dcd25:
> 
>   Merge tag 'nvme-5.13-2021-05-27' of git://git.infradead.org/nvme into block-5.13 (2021-05-27 07:38:12 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.13-2021-06-03

Pulled, thanks.

-- 
Jens Axboe

