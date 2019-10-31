Return-Path: <SRS0=XfYF=YY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57DECA9ECB
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 17:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE5E2087F
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 17:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kZwL4hpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfJaRjB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Oct 2019 13:39:01 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40564 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbfJaRjB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Oct 2019 13:39:01 -0400
Received: by mail-io1-f65.google.com with SMTP id p6so7666056iod.7
        for <linux-block@vger.kernel.org>; Thu, 31 Oct 2019 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7F7GIco+RAiSZMoAOBzaWPqe/Yne7EeIQyiFSkYuy08=;
        b=kZwL4hpQFDm4ME4xJiTcQIBTQqxEm5gDHWg/YHRNl2bxzsSfD3T+MHbO4F6W+iuqkv
         QFB8h1HUUSCcX1ZiM4TmvzUHDhF7XpjrAce9ZC5+/XNMmVVZ+gaMUC8CJyzi5eOfmbCL
         Y3XIPkt4OIEGuVaE32wwhSE3WSDWbdwuQIcyRLOeDQtTlp7p5FzjwxzMT/sJC1tGNT5d
         xCtv2tRMswgarBhova/acEgnl3pivcx/8EBxpmvGsH9AnprrF62PyyRbMkhTYzh5SMSZ
         dJCe0dzCvLp12a9j1g7leZEnJKyFJXHR9wLcuitgnC+qYcCTNinmOXEl1n5+HwYJcPUZ
         Nq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7F7GIco+RAiSZMoAOBzaWPqe/Yne7EeIQyiFSkYuy08=;
        b=R93JLRpZlYE5ZVpcQiLQJBDHVE+wH2DyzvQzn8QZPkzzABJYAfniIkubJ2lJZfISKa
         aQn6b3AzNW3btEDee7tOc/AEbbIM6BzI3Bd0UOVZQ6VnA2J2W++BS8i7zMDkxjKGLwe5
         bLeqQ2ZckjmFiAYKjGobPIMvwEVqqmAaD9KU7pb+juzHc7LFzRsaLE/hVa4ise90tLn4
         XqAUXpLY7Fl+3mzUGEH/TR0Z6flrbYPqOLe39AtjxnQDdKs1ByMH8XHab58X49MzE2bX
         EjZaOeTibY/GkXsmgeYLYRBs857xWd1I1NV8aGZacpa5Z3e8EPJiWWzypKOxLvSrrFg9
         2LrA==
X-Gm-Message-State: APjAAAX53r5rZIi2GHrnZdx3A6zmKVVciJpCm2qVbeLi3n6MZD9VkZaM
        AFRlRj6MvLZ6VNVHVbi5B3tY0A==
X-Google-Smtp-Source: APXvYqwnYzdGAm/xmPNC+zRrjWOT2IM9/nE8WqYcwOX7iRZc4ALvVWc8R9BiUDk1PMQO65jYHe/NRw==
X-Received: by 2002:a6b:fa08:: with SMTP id p8mr6279327ioh.84.1572543540403;
        Thu, 31 Oct 2019 10:39:00 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k7sm389299ioq.50.2019.10.31.10.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 10:38:59 -0700 (PDT)
Subject: Re: [PATCH] iocost: don't nest spin_lock_irq in ioc_weight_write()
To:     Dan Carpenter <dan.carpenter@oracle.com>, Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20191031105341.GA26612@mwanda>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5507a74c-35e6-177c-d9b1-91ebc3120ea2@kernel.dk>
Date:   Thu, 31 Oct 2019 11:38:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031105341.GA26612@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/31/19 4:53 AM, Dan Carpenter wrote:
> This code causes a static analysis warning:
> 
>      block/blk-iocost.c:2113 ioc_weight_write() error: double lock 'irq'
> 
> We disable IRQs in blkg_conf_prep() and re-enable them in
> blkg_conf_finish().  IRQ disable/enable should not be nested because
> that means the IRQs will be enabled at the first unlock instead of the
> second one.

Applied for 5.3, thanks.

-- 
Jens Axboe

