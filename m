Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C512C28CC0
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 20:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2DD24137
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 20:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1xhA7lV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfE2UQi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 16:16:38 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:32852 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2UQi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 16:16:38 -0400
Received: by mail-ua1-f66.google.com with SMTP id 49so1591519uas.0
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+aRuvNSkCgdb6HzBJ/us4CqIpKYSiZLXJN5gZFlmZwo=;
        b=N1xhA7lVCa3B9QR9918GjulK7Rng4D8KsYm9isZViw4mMJHc8uy7CS2LJBxZJLlLSP
         ML5NLeSJEjsqW0IlCZByJJ6xa636bCcpWtEEU0JUR4+CZYZKRl369DQIUbvH/KqlI59x
         WMXAZUiQJc8kyEdVlLfv7NrbZ44LnGcZO7yaxoRgsnWx11Tpo9QQglKj2aHi7fk310a8
         Vq95C6GVXJWN7LCpTuswY+r1vs63Ivs8TTdLlqVQxb/3H9Hd29rXKn6QwECB4BGYA9xk
         BzGBP+nqw+aS1e5DOqYO4kl42nrGQq4KziyN+lMUcbqPGz7Uuxlw1mSp9Ye7EF3xpeKf
         hmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+aRuvNSkCgdb6HzBJ/us4CqIpKYSiZLXJN5gZFlmZwo=;
        b=EqDwHIGNXVJSE92gIADPa4pkFfjtV0IbO4tYFXnn/V/ZLLer/CXaDaJBzJg3v0cZco
         abvVSQfqOUVljBAmiRXQa3QQ/Rc4t7U1JvNlhgbV/COs0u2xgcNTA6LufB6e4iODlmWn
         9KnuCK2Nz3mz/VnA1xmi3ldSinUScfnDV5rpxkKYeaGg246H3tPv4JvKfef0xS57/HMI
         2/DxReb9vA/uKcKFb9Cs32HAGg4Tt7BtNBvaFOzrhzkjJEjAuJDm01u20uRNQbEz5qqL
         JONxd5S9HXFIx/7bgzdEAZZQHhJHiK44BgQcxX2iwWTUS1qfpAvzUJg7TlJ7JlzN+22s
         3sHg==
X-Gm-Message-State: APjAAAUteqrfn1/9ufDnvr5fmlqenxN7/2R7EFuk59YW0TDDyw8hVtNt
        1J84BmZWBpS+JY71r7j6G2A=
X-Google-Smtp-Source: APXvYqyNi40922woo/Qm6sqMU3M/oUHqfnREYNe0uSYKZzeoYrCwA9SQuck0CHFMi3Q91uQrrhwuhg==
X-Received: by 2002:ab0:3109:: with SMTP id e9mr2752463ual.66.1559160997052;
        Wed, 29 May 2019 13:16:37 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a3:10e0::26d7? ([2620:10d:c091:500::3:60e4])
        by smtp.gmail.com with ESMTPSA id m10sm190133vke.46.2019.05.29.13.16.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:16:36 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH 0/1] blk-mq error handling memory leak
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Kernel Team <kernel-team@fb.com>
References: <20190419203544.11725-1-Jes.Sorensen@gmail.com>
Message-ID: <922c7482-817e-48cb-42ec-3e0dcaa8fc9e@gmail.com>
Date:   Wed, 29 May 2019 16:16:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419203544.11725-1-Jes.Sorensen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/19 4:35 PM, Jes Sorensen wrote:
> From: Jes Sorensen <jsorensen@fb.com>
> 
> Hi,
> 
> Digging through this, I don't see the callback data getting freed in
> case of errors in blk_mq_init_allocated_queue() unless I am missing
> some obscure path that cleans it up later?

Ping!

Any reason not to apply this?

Thanks,
Jes

> Cheers,
> Jes
> 
> Jes Sorensen (1):
>   blk-mq: Fix memory leak in error handling
> 
>  block/blk-mq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

