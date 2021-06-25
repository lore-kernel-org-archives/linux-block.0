Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C51DC2B9F4
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 15:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DEA561952
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 15:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFYPxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jun 2021 11:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFYPxL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jun 2021 11:53:11 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4755DC061574
        for <linux-block@vger.kernel.org>; Fri, 25 Jun 2021 08:50:50 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so9738570ota.4
        for <linux-block@vger.kernel.org>; Fri, 25 Jun 2021 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QzUZ3F0IpRWiLAQ6tT4/X794s3i+ASSo1JFj5MB7HAI=;
        b=dCEkONOw1RUPHxGRe9JzUEc7Zih4ML+EBhhoZYxoOvhvbWeGHPdZeYjSFGwiIUQkFn
         MKXz3uHiTHK6uQ6d7M9CkUBaMMTLK1nDXm/mqNQyr+dJZLyesJQMwTQos0PaTUW6BbK9
         vEhplH29bt1N0ir/r44LPmYDOh2cx4ovm2mgWrbJfKWnophC4wzhc9jUOw/RWu8c2+lj
         JVa9h+Cd5Ho4tG7YBknMZYzkmA4x1Mvh/OjhImJ1IxZQgdPLCncAS/ULamISxyZh5bLu
         TyAyQKaRPZOIfO0IX+YNRO8+Yt5u4zQVqBoysluhtLFzKYnVHWSpk8X8t3zVP4axT0Hm
         LPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QzUZ3F0IpRWiLAQ6tT4/X794s3i+ASSo1JFj5MB7HAI=;
        b=ddXbMaY/mmfurwrq36kjzdV2mB731cKgmpv+HUQXYTMMzsCfGqBEKgAqY/xHHNpBoH
         vEDzXLvWzXDMx09DhzXcbpZaNYj2NOWG8YSk+gesvav8YpsO41W0XNw9kE06wbqsAIwC
         Y6/sPbzoOPchTGEHP6uLwMLWnhk4pbVuzWerdpkoDRztlvb7sSvI2wmROSel4mVL6jKm
         /5UHHBABfi5noprmBniw3qE2grZ+mkUkmk+snomubyBuGzxEEWsX0fcl99wizVo+Tgct
         Pp/ZCsgV+tMQMSk0y/9ycVrfkLaSKeSND3K9GFPBrZQpQAJDI/Dwo7D6dtHMFpsCF6HE
         zYPg==
X-Gm-Message-State: AOAM532EWmUJ34ORD1yS3CjB9DUksvxpRd+1HKoq3QEwzd21LbcVWjp+
        eeZmXs+q7/pxRxRZy2nG6pGv/w==
X-Google-Smtp-Source: ABdhPJw5KA0cURPDZsirFYOyRO5iBPgxLWhjH4kzr2FBCl3eS52W4r6UkazlrViZGY4dSQKKwvRFKg==
X-Received: by 2002:a9d:6d0a:: with SMTP id o10mr10190591otp.0.1624636249554;
        Fri, 25 Jun 2021 08:50:49 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id 33sm1423372otr.78.2021.06.25.08.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 08:50:48 -0700 (PDT)
Subject: Re: [PATCH RESEND] blk-mq: update hctx->dispatch_busy in case of real
 scheduler
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <20210625020248.1630497-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <97a0ae9c-359e-b54f-c662-8d885477ed75@kernel.dk>
Date:   Fri, 25 Jun 2021 09:50:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210625020248.1630497-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/21 8:02 PM, Ming Lei wrote:
> Commit 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
> starts to support io batching submission by using hctx->dispatch_busy.
> 
> However, blk_mq_update_dispatch_busy() isn't changed to update hctx->dispatch_busy
> in that commit, so fix the issue by updating hctx->dispatch_busy in case
> of real scheduler.

Applied, thanks.

-- 
Jens Axboe

