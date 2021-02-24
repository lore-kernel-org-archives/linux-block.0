Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558B6C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 02:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE7364EBA
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 02:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhBXC37 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 21:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhBXC36 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 21:29:58 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE0EC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 18:29:18 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c11so305279pfp.10
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 18:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i6YKVuKQgEsrWoA4akWtYp6AQlXn0OwsPCHBh9sSxaQ=;
        b=bQwWrR69fFDICuhMoE+siORVp9Y+Tg5xFDNyLToOamhTsSsnsl5UmiTgd9Bjn8lUXl
         TrYjeZkJmuYBF1g6Q11IsC3HsSGU0pe0CWOSqOp2N40lWADQhTA184oE3ee9XmJqS/Wf
         tBTO/RvLsiodV7nG9vNNm32rtZWkmINrCPdfEPMBYV6LRA4dXK3YSmmM5k1+SycBs5zJ
         x4+JMwPdxJW+aBbo+7Hxm7rp0qGEzvM8Iy5JuIM8SxiQK6N91Kp1rI9DKDutuuUQSpo4
         Fng1ZhszJiYROb+ZAkZAqC4LkfBK07Y8uO/xQQ/eygAX3Zps/ffu0Bap8frUMjKpeSZp
         T8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i6YKVuKQgEsrWoA4akWtYp6AQlXn0OwsPCHBh9sSxaQ=;
        b=KnBL6tdRxV/1kBJAKD37hKi07mwSDeJywmaPGzT3NB0GK6oYEmfjUZkmanba6zzvoY
         vBw2QCcpIviyKJmMF0JsQzBXsnkfVOWq5uGU0gT5WZq4FwzLrAKpAgfd4sRf9mUyIH1u
         dJ2ytY/3EGRuhAho/LaA0wVfjKFPIw9Wnbh0SMeDDz9tGKh7mIIgQF++q/v252SzgVO2
         wH0SqyFHoESdrN2JR6P6xTn2cr+vbH91feZ8n0VdxY9nBsV7z4Zx/CLx9UTEPwWASHzc
         uaVj3rhpUL//g8e//zKSOkL3xXo8TELYW6EYz+XdmuBIPu6CuPk4ES++kF1PnryhVLG7
         m0Ng==
X-Gm-Message-State: AOAM531w6eaBXvul752IsCzZTpn4NnHi1kVv4Jr1UNWT1kxhTiZ4/5ye
        oavJkhw3l8jsyD5H9dDaBG9KubhSqO8nmA==
X-Google-Smtp-Source: ABdhPJyZLQrKMncPjyCLtImEfW4sYUzJnLMxmm+VCRIMDtI94rYd9vCClAVd4icuHtJyMLGhLFu2XQ==
X-Received: by 2002:a65:46c7:: with SMTP id n7mr6722865pgr.267.1614133758369;
        Tue, 23 Feb 2021 18:29:18 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e10sm397349pjr.56.2021.02.23.18.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 18:29:17 -0800 (PST)
Subject: Re: [PATCH] block: fix logging on capacity change
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210223085015.832088-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bee2ef3b-6a25-3770-5ca8-9919a9d4e53c@kernel.dk>
Date:   Tue, 23 Feb 2021 19:29:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210223085015.832088-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/23/21 1:50 AM, Ming Lei wrote:
> Local variable of 'capacity' stores the previous disk capacity, and
> 'size' variable records the latest disk capacity, so swap them for
> fixing logging on capacity change.

Applied, thanks.

-- 
Jens Axboe

