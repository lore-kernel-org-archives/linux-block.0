Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9D2C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Mar 2021 23:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F9464F18
	for <linux-block@archiver.kernel.org>; Tue,  2 Mar 2021 23:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhCBXqq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Mar 2021 18:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350258AbhCBS04 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Mar 2021 13:26:56 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8B8C0617AB
        for <linux-block@vger.kernel.org>; Tue,  2 Mar 2021 10:25:53 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id d5so18925350iln.6
        for <linux-block@vger.kernel.org>; Tue, 02 Mar 2021 10:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/tR2XTG0HxjyVGlaiC+WrfL7p8OXI5fljdp3i9qrHB0=;
        b=aqjY/V6RGVgwKRL3/lnscUN2LZ6ifrGWr6AfB4V8YKtxF6R2oeWYBA19kyaPGfjI9i
         1+OZ+ZoBIQgOmkat3LFIZ4oXs9nUp3wluYxoRBavOpqQg7AlgdOkqYIJ6ha4GCWhniZj
         eudr58unxm0p5t6SC2J12nC6zk14Dj2uUIW7P+JeI/hiwPLRMyFW41Pk+HDwY6szSXOR
         pjb7i5NyzCaMtMcGxYV9snoFVZBU8xrnFi+bvEOXzgOJd4/AsdNLWTc2uaw1Zc1cg9fT
         ZC+Xptql+b5CzelkIDp7i0xdCCi8cLL5qhvnVz0IuPq5naC/xtkBdtv0HdPrzlCy8ABM
         uq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/tR2XTG0HxjyVGlaiC+WrfL7p8OXI5fljdp3i9qrHB0=;
        b=UzurAbML2HThlP8WiVqyOpCmSXG/a0nGfUp4cuDUX/jLz1qBPPynhh8VbHkPadS1rr
         p3mLiOZ309JA4hYO5mikRLg5m2JJZC+FaXseEWLbvUvflfOM11hWeMM35bQGBTULQHVp
         Ugy2csfgTTjHkv28/efyRq2+6FDljGNBKwU5IkUT1PQxOnuemFba2MyfR6gH/LH+u9a9
         qA1Y4u6nJRjEiVAw9YaCiV7fXz9d07F39lD4Gc3qtuAVARg1v7lc0FWqZEm1oGkskyMy
         Vq+jcVWifnLT5GcV8FVkyaucNYnCqOuQU3xYVGzH/YvlzfrddSQT8s7kPIQPLdwpdffj
         CY9A==
X-Gm-Message-State: AOAM531wdw8/4SZbxQWVIjD2CgUj+d4iFto0DNbZs2bLpQG7mwOiAmqF
        yHPEtIhmF6fxcrgyZKwN14OTRCMHAPWpig==
X-Google-Smtp-Source: ABdhPJxy5HeFvi7BpQUeJ7U/Std4KxNuGk5C3a6ucMAQfIiEHxLI3BHv4WrSSKvXo1Q9FozOFscU1A==
X-Received: by 2002:a05:6e02:e87:: with SMTP id t7mr18767828ilj.211.1614709552488;
        Tue, 02 Mar 2021 10:25:52 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g6sm8840282ilj.28.2021.03.02.10.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 10:25:52 -0800 (PST)
Subject: Re: [PATCH] block/bfq: update comments and default value in docs for
 fifo_expire
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
References: <1614045328-87234-1-git-send-email-joseph.qi@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a98d251d-f68f-a0e0-acda-54ad0b2779d8@kernel.dk>
Date:   Tue, 2 Mar 2021 11:25:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614045328-87234-1-git-send-email-joseph.qi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/21 6:55 PM, Joseph Qi wrote:
> Correct the comments since bfq_fifo_expire[0] is for async request,
> while bfq_fifo_expire[1] is for sync request.
> Also update docs, according the source code, the default
> fifo_expire_async is 250ms, and fifo_expire_sync is 125ms.

Applied, thanks.

-- 
Jens Axboe

