Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F140C2BB9A
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 18:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11AD5233E2
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 18:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgLQSXl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 13:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730167AbgLQSXk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 13:23:40 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832BAC0617B0
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 10:23:00 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id i18so28454958ioa.1
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 10:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XRVEJnFoqZ8eEZQgsvJ36yIgj4Ljw0VrDBn8q+Mxmns=;
        b=CPQX8X9Z+MvU1a68dh6pK+4Ac0QTW/yo7IDInjOHYy51HsaWrWGbzVcEuteLCcx9/P
         rAaRyey4xOgCCwHXtOfAtcxOFfXhqvlpuGyOo9OKpZPqpwLfNPf7VruTIBTl/tVumv0o
         xxRlA3ZZjJ4evBBtqDEeDtNIwFLSaoMXjlGRaJT+drloEEY3F86Cha/gif+d4W7wGUra
         GqAqhp9+MS4V9MSxtRAkirzb/bxIj0M0+szAQwXQjHzj86480PKuVmUP6x3kjjpvjMSK
         Xs9921g3Ql1syOZXiZvI5naCSGVD0j5zr0tXADBPERLVDih2KNeEYZQnWpOcCwDOJuPQ
         pL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XRVEJnFoqZ8eEZQgsvJ36yIgj4Ljw0VrDBn8q+Mxmns=;
        b=UKehMVD5k25s+Dbdt1VQChhJ7xHgzVit0kt7uAItj9AmEh0hCUZDAOUhgq3VrYBv6T
         C/W0CKh04YOqjTOaM1nA0mXRLlm40IdYhntMSM6kt+GM0cQwref0zRZqgEqSRGomNAo0
         MzSC9kVvBMmJn4ErXhKx3lm2btrnZobQhr9zYtnM2qV8k0I4mYnhM7uK5nCDk811FKVL
         42+knjW5tGF6Q+XIQZxNpJOb6b4ne9FXvtdOpFw1tkHQm529eN+pA9mLmuUdyFjDFsOD
         kGOXLp8YJVhud5YvF/o+R8Hm/7MorneFKUWFqhV4MuefPitUMf7Pa/yo6NGTbKLH14Xa
         X8og==
X-Gm-Message-State: AOAM531bs6ndRpkplzAPkPn6QCFxyEIgYLrVIzfW+GCw5A6sxJ1R/ARR
        ev9SkIYW6kVybhRbwWuNbBBufTKpeFGpBw==
X-Google-Smtp-Source: ABdhPJw5SjpryI/txwkJRdYNqTyX5IDkBJ687Jr9AMUnjKW/W6Pi7bffGF8UNDAaXDG1OU+So3TJOg==
X-Received: by 2002:a5e:c811:: with SMTP id y17mr309316iol.207.1608229379820;
        Thu, 17 Dec 2020 10:22:59 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y13sm14267301iop.14.2020.12.17.10.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 10:22:59 -0800 (PST)
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208131319.GB22219@infradead.org>
 <20201217164308.ueki3scv3oxt4uta@linutronix.de>
 <e3ca3c82-cddc-ea06-39ae-48605abc77eb@kernel.dk>
 <20201217181639.byvly7dvpbdxmeu5@beryllium.lan>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1c11b5eb-4e3f-120e-2228-89f63c26bf29@kernel.dk>
Date:   Thu, 17 Dec 2020 11:22:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201217181639.byvly7dvpbdxmeu5@beryllium.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/20 11:16 AM, Daniel Wagner wrote:
> On Thu, Dec 17, 2020 at 09:55:08AM -0700, Jens Axboe wrote:
>> Yeah, I think we're good at this point. I'll queue this up for 5.11.
> 
> If I am not complete mistaken you queued v2 of patch 3. Sebastian sent out
> a v3 (slightly hidden):
> 
>   https://lore.kernel.org/linux-block/20201214202030.izhm4byeznfjoobe@linutronix.de/
> 
> which includes the changes Christoph asked for.

Not only slightly hidden, b4 gets me v2 as well. Which isn't surprising,
since it's just a patch in a reply. I'll fix it up, but would've been
great if a v3 series had been posted, or at least a v3 of patch 3 in
that thread sent properly.

-- 
Jens Axboe

