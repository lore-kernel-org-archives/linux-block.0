Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64DAC433E0
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 23:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828A9207BD
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 23:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgL2Xsm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Dec 2020 18:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgL2Xsm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 18:48:42 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E02BC06179C
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 15:48:02 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id n10so10143871pgl.10
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 15:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xpodWtOja8+8IgQp2uqm+eXTXrWRDnzD9wzyhFOEunM=;
        b=ZPN8t/RShB+vZaktcFvJMDn8rfY8t57pa7UwrbvLkaDEri+Ny4a8r10Km9QCWJtlv3
         KeS9ZmaCCRYV4koYUsXTYUIMwbDWIlMoJNv+W81i1zK/P+GAJ46KoCivWeUUjC9a6YWH
         oEmaFS56HwkTNG9/l5614oEECZ/pf2PMdpZLkiATp18keq506vwGfZCtnya+P+ZZ996d
         zcQXPNfajxDJri7E8p+hoG+zHMKpiYC6BBJYkL/4EwL3SqBc/QantedHIeBnmZttDepY
         S5SGD2OdeHCIA9tLnx8qt0+2iDlE+GajlrD5OPOU2YoKO8E/zMY7knhhgjygK5+HRgGf
         SPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xpodWtOja8+8IgQp2uqm+eXTXrWRDnzD9wzyhFOEunM=;
        b=jpD/lgxAxW03sS9VM2925j/TPm/zA0U35VexwyN23CGiht2p0+E4FDVhVE9+xqC3Ib
         Xvq+pnqPIdhSj/Z55Qs0CSl0gL6iic4VjAnwoqZ73wGtvFfjNoJqH92z89VSJXYZvf74
         9oZgKa78cUBzOAZXkoCv6tVv+l5XIJXCsNWJKKl2pb27LVhvlkrvJFYDuZubsAlf4JXC
         LU6K806LZ3cDCDjruEcaH6BJfwblhqHsDAI9OPoBbmhT7rrNbLFcoO7eICQdS7aLhdIQ
         2uOUgdTjaIn0vm8cLdAIk6ANbcynCcCOCA4jRkYSqg9u+SitTKNChIXTqqXhDqhPU/R7
         SpBw==
X-Gm-Message-State: AOAM533BH73U6YqHcQ0ABeSpEi62F0deOY86nyQVofP0XwFHOgCHlgvE
        GL3Y2XfoHJab0QbbZfFP5ePl0Q==
X-Google-Smtp-Source: ABdhPJx1F45NRQCfWmkqeCvBNvQ/AtsH1YOZfRIEoF4NJfpqvzUUjlNj2gy71Do6H5g4LKoltCceLg==
X-Received: by 2002:a63:4821:: with SMTP id v33mr50398388pga.7.1609285681645;
        Tue, 29 Dec 2020 15:48:01 -0800 (PST)
Received: from ?IPv6:2603:8001:2900:d1ce:8f91:de2a:ac8a:800e? (2603-8001-2900-d1ce-8f91-de2a-ac8a-800e.res6.spectrum.com. [2603:8001:2900:d1ce:8f91:de2a:ac8a:800e])
        by smtp.gmail.com with ESMTPSA id g3sm4244239pjt.34.2020.12.29.15.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 15:48:01 -0800 (PST)
Subject: Re: [PATCH] block: add debugfs stanza for QUEUE_FLAG_NOWAIT.
To:     Andres Freund <andres@anarazel.de>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Christoph Hellwig <hch@lst.de>
References: <20201228192717.1015629-1-andres@anarazel.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2fdcc766-0999-02bb-5ed9-e943dbb81277@kernel.dk>
Date:   Tue, 29 Dec 2020 16:48:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201228192717.1015629-1-andres@anarazel.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/28/20 12:27 PM, Andres Freund wrote:
> This was missed in 021a24460dc2. Leads to the numeric value of
> QUEUE_FLAG_NOWAIT (i.e. 29) showing up in
> /sys/kernel/debug/block/*/state.

Applied, thanks.

-- 
Jens Axboe

