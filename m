Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653E0C433ED
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 16:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345D961405
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 16:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhDVQZU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 12:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhDVQZT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 12:25:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C66C06174A
        for <linux-block@vger.kernel.org>; Thu, 22 Apr 2021 09:24:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so1252739pjv.1
        for <linux-block@vger.kernel.org>; Thu, 22 Apr 2021 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qNli8Bvyrp/OrayAw2x3P5rkmIQ2D/dpkSqa0fGuG/s=;
        b=cjuFxwuL8wRM5mOipSk8cXJlWJgk3hTRlDI44cj/Y6IkMlXCNFqN19VDCdlxhZ3sMR
         7GLz97ST15FolpO/0NeoO7FbUqMxju0mM34ZECcSC0wU088Hpz24USb22r90Zm3ATT23
         BAk4yModv5pAhsft8UzB+PTP9YQ5fYKOgzp/VWZxguqybOJ+h5QxscexyPAir+GdHqgd
         kRSzzSRly8sBo37lowbK1iLT0QLWsQ1BbCN7N9rISdRcbhUv2o9fd1ZZ2UdPlcpNUZ9T
         7Ig4f/speBxnLBwtB1ehvACuOQ6pkBWJgAklVwu4q4gtArb+vr/I46iAK7wyL3Gth+R3
         w4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qNli8Bvyrp/OrayAw2x3P5rkmIQ2D/dpkSqa0fGuG/s=;
        b=N//me3gGwactk7XItBet6nDMDMQxEMFCwsGKnYKKwxM3MS9i04SzPShS0PxPrI0c7G
         CuHyGhddFgtoHZynDEJSy3KsRABHnPPt7DQQmY2fG4ZkdGtPvWI58vIoTZSA8RVWeLwj
         cFuQgIDJsYXdfLpUgY73fsB2v23jvytY/+SsLa3F9mewYT3gMrHEPRMucvA6zHn5a1/o
         bOPRVIAz9cW+u7zc4bhvHUBAAZeeBh9bQRAegV6HQDtAFVTa9H39xmkFHdG6GRPW6nmF
         F22fkrZQBNVAk+4V3vywg1Ab1hx5lSJbZyoIlichPXxPmY5gWA1L17bDJubVmyLtPNbW
         y1MA==
X-Gm-Message-State: AOAM532K6/3qhDwxYiE0PdTKv4xRO4ag0IYrFH0wfDQu4mlgoFPlx/el
        KaW+SD7gX/MifOxIMh+v1zGzzsl/Yynn5g==
X-Google-Smtp-Source: ABdhPJw408HfqX8ux0SMjNoU1+smcc6Tv2pTBLITekCTe+8bErtsbPS6uronB3e72pTPGY3SitLCrw==
X-Received: by 2002:a17:90a:5d92:: with SMTP id t18mr4952889pji.226.1619108683214;
        Thu, 22 Apr 2021 09:24:43 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id u6sm2474501pfi.44.2021.04.22.09.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 09:24:42 -0700 (PDT)
Subject: Re: [GIT PULL] third round of nvme updates for Linux 5.13
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YIGE8ORkKryOdxtE@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2bc18dda-c09b-7a97-5766-0b7a9c14033d@kernel.dk>
Date:   Thu, 22 Apr 2021 10:24:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YIGE8ORkKryOdxtE@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/21 8:15 AM, Christoph Hellwig wrote:
> The following changes since commit b777f4c47781df6b23e3f4df6fdb92d9aceac7bb:
> 
>   ataflop: fix off by one in ataflop_probe() (2021-04-21 09:15:27 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.13-2021-04-22

Pulled, thanks

-- 
Jens Axboe

