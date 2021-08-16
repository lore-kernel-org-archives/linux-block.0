Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CB0C4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E709360F11
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhHPQyv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHPQyv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 12:54:51 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE5DC061764
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:54:19 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id r16-20020a0568304190b02904f26cead745so21677469otu.10
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HpuepmFQr0ts7R+prQxEpV0BW2N1Xo7/i6KDZNHi/hI=;
        b=R2xxBa78PYOPoU/KY/yn88zpKivpgjgMdTt10Hzr4OLKXEqD+KRxSX2jYwXujSLMHb
         CdG6wuXXZdp9lH5/dNmNdHkGaJmuuiMVJD9yWIyrMLzMWHy1k/1/jFbgQaTSMsrHRxvJ
         /xcr0c5XRhVtCC9FJ6jx/TKasFkteyGtwI0WPa+B3+abtLb2pEWpDiMPgtQtTLwcD7Kd
         ah0Gk0FhEqfPGdXlY5gAc2IX0jT1A6Gi9nYbS7lZPI3/h8lS9ZtX/a50lCgXK4Tia5J3
         oc14CZN0BoDNPKOFX3pVBUk21DO4bPTtJ1zyRaqObmOUxuRSaW62OlNjsNY9+AaiSVbi
         zBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HpuepmFQr0ts7R+prQxEpV0BW2N1Xo7/i6KDZNHi/hI=;
        b=CgrslT87nS7OjzDHvXAN5DVMWQZwpCh3Kttg8iWNfTfMzXtk/QmJ/aSGBjb2MMt4Pz
         4+77LgxnpG7BpDCJMb6hQ/pY0obgq9a9BamWdQVZua2+QiQRKHZcY+1rRHsQdOmHmxZF
         6nudbuYHDR8bzXEYsVbBkfqwnV7GYfHSmKNREWNOd9sg65FHMM2/SAysTna33eScncfo
         kNVbERlg9HdR85J/EFlSXEVS2CQUScXVdqPvvnA6g4kLrAjj4RHt9yn4CEvBDWFJxY4N
         LReZhrp9mXG6Xnu5ymjoSkCE/XMJo1Z7a3H42pA/hzCaW8LrNBLXdPPTguHL9HClGzBS
         ubpg==
X-Gm-Message-State: AOAM532cdCm5h6+LNauOjr+VyrfZVZvdtIg42yQ0pPnEh6sc5ucdrwR1
        tT0m9uwN4/5cTUJAjNPXA3uVyDk7G2kgTbju
X-Google-Smtp-Source: ABdhPJxpuZOtaMXfTcgDjx0o/K3AOdnkk4P1MogCHk3+I3Fcstfkv3FZqTbYlJR1o2L2OItkveA05A==
X-Received: by 2002:a9d:887:: with SMTP id 7mr13468380otf.120.1629132858944;
        Mon, 16 Aug 2021 09:54:18 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b1sm2383609ots.29.2021.08.16.09.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 09:54:18 -0700 (PDT)
Subject: Re: [PATCH] block: unexport blk_register_queue
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210816123649.601591-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <071b5fd7-a3cb-ed21-80bc-be9ffb7e6e3b@kernel.dk>
Date:   Mon, 16 Aug 2021 10:54:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210816123649.601591-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/21 6:36 AM, Christoph Hellwig wrote:
> Not actually used in any modular code.

Applied, thanks.

-- 
Jens Axboe

