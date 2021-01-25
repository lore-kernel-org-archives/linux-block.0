Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BFAC433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 01:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9211222571
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 01:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbhAYBTx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jan 2021 20:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbhAYBTX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 20:19:23 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24BEC061573
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 17:18:42 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 11so7483393pfu.4
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 17:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L3uVyIQXg315cYdcWFUi5kSuy10il/YWLytcRu3EvKU=;
        b=xCHC0TeW5olhFVBW6SBSDbklWOHvyAC/fgRBJFg+QV/Q5ZqvnsCzJQdIeYog/GvYA+
         1FlflAU+h5Sv3UjYx7/qSst5YpD15GQvU71pZYe8ePM3LHf7kFNHWOT5y04CDdLR40el
         ftJQkDLB68lSuut4+JZEiF6z7FuIH/dM3Q15Ph7Hhfp9c+8AIVpmuuNERcDOSUosAhYh
         zfAeeaQ4lQrqaiFKx/jTGMBbadTTU4ZqAmvR58IdNsMNUC5N4BD2hBSmaHQkC1jILm+V
         Xwrp9hcTiZZYP3qSSCC6mLpDW0vrHJlkuHab4dCkhhTnUT3g2j3Rp9oFXActZiDaXc2A
         DoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L3uVyIQXg315cYdcWFUi5kSuy10il/YWLytcRu3EvKU=;
        b=GhQSF69U8ADUQ0fG8Wjubsa8FS+rsHgY/V3WvnFDGVGzBOafIXL+j0Gc6sB0Pvdk8V
         P+IqekI2Cb+6SLnj6vOvwkU+39JKxh5qMYX71KYKzWLDduyd002aJ9VvnKbQFOMcM5I3
         is6GAgvPd44ESSNCMM/7Z7IhiYABz24ikNyN+xqe/El8Bfpec0pcnkeKaYibQERWfPuP
         cC5qc1sRUpZHw+YxfP+1UF3o9pJzfPvKDmXhVxDMlo4taDX5TyK6eYj90Cc5ZBALqRnm
         xcKhbh9z7/WvF633aIGte3SpB+CkZ0xHmgTH0wK+wZBaNYACQsFPnT8eqouNaSKvXoCL
         zCEQ==
X-Gm-Message-State: AOAM533ILG0wJ46ky/84KKll22KyDliAkwUaIYQDc0zONZH/xKaZ8GsN
        xJV9EctMBXuFih7qppXmWrTtQlrqYgJqnA==
X-Google-Smtp-Source: ABdhPJxFWePCWmfNnsY9gw6UORyzTKjMRFWUXJ9grK/iqp7aHvcQXCH6VKSMOOKg59exGpxH5JsEmw==
X-Received: by 2002:a63:c702:: with SMTP id n2mr277682pgg.382.1611537522118;
        Sun, 24 Jan 2021 17:18:42 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id p13sm16036771pju.20.2021.01.24.17.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 17:18:41 -0800 (PST)
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/6] block, bfq: first bath of fixes
 and improvements
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210122181948.35660-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8e024512-992d-1f9f-2fba-5f51103b706a@kernel.dk>
Date:   Sun, 24 Jan 2021 18:18:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122181948.35660-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/22/21 11:19 AM, Paolo Valente wrote:
> Hi,
> 
> about nine months ago, Jan (Kara, SUSE) reported a throughput
> regression with BFQ. That was the beginning of a fruitful dev&testing
> collaboration, which led to 18 new commits. Part are fixes, part are
> actual performance improvements.

Applied, thanks.

-- 
Jens Axboe

