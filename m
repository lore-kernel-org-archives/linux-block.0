Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E6CC83000
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 15:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75723206F0
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 15:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Qp+uRZqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgD2Pd7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgD2Pd7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 11:33:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143AAC03C1AD
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 08:33:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t9so915940pjw.0
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 08:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IGvDVT3X5Rji1nSv4+GY3THUNH0hpIMXYW3Et0wjyls=;
        b=Qp+uRZqGpSeyQEaRijkeyNN88UOpDJIJ79FQoNSlmprkQsqo/kuRywuIN6tjk0i1ny
         fpT0oioCaRVgYk9Lur19a8u+KlsnGrR+7Y1kPUZ2tfs8GMJan+kX2G8G/IeR0jHYgLQx
         UqkQiw1UAONdLZ2+2do4oZxGsvddL+3BFGx7B1GpkqOCPZSy1OKUBUZs3ahf6VH3PoFT
         f7VPFhVGsm3NIAvDHPzL1nciUJcrpqr281A79EvohB+Es+2hIewB9GbBFhSwtgFOK/Cu
         5df+XfLKP/5m1PPVDSayebNX8XRiz82+26knV7IxQy4fPuB0o8Z+15WCW6i0ODnzsEXD
         Or5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IGvDVT3X5Rji1nSv4+GY3THUNH0hpIMXYW3Et0wjyls=;
        b=Pes+9KdKhhXYVGqVOshSfdOOOgoC2uo8ieJpICiDHPk/tllq34LgLUmwW9tYb+MC8f
         qNqnzbbiPPin6sCsvUynfc59xMUTN0jotxtYekdnm6Vo0hwrGQk0weziSzyOSCieiA3V
         bMLlAhGnJjFjs1CiQZtYupwuIzfcvf3MsYw1D3lCewvyoJSSZHazsap5Tf8vFTpYaNS7
         Ac2ISeOGP+FocYPEiQOh0qNsIBetqbgM5+TKg63KBHSD6FhDUugKsWlBxpH+teUGYg92
         y/1m4Me2e49vqoDzTusDNgEpkVqjV+moql648jry5t4zq2LBegYZO6PcwgU7lgUQ0G8Z
         6oMQ==
X-Gm-Message-State: AGi0PuYjxtdL5FKvIymxWzoInjP7YlQAz92ooD+bPLPLEhWtdmrgX9qv
        TBn9b92P1syFDQOQn6zjTKtXTp5UDKKO/g==
X-Google-Smtp-Source: APiQypJE6km7eI/54drq8qK9NMDp3310Hn58sXkpd0Lxq3mVKI7BLx/9RbZ9qZyeX4Erygr6WgiEVw==
X-Received: by 2002:a17:90a:f00b:: with SMTP id bt11mr3968358pjb.121.1588174437007;
        Wed, 29 Apr 2020 08:33:57 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id 14sm1383663pfj.90.2020.04.29.08.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 08:33:56 -0700 (PDT)
Subject: Re: a few small bio related cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     hannes@cmpxchg.org, linux-block@vger.kernel.org
References: <20200428112756.1892137-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1deb1ed2-ac62-3469-db28-2735dc74d1f2@kernel.dk>
Date:   Wed, 29 Apr 2020 09:33:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428112756.1892137-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/28/20 5:27 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below a few patches to clean up the bio submission path.

Applied, thanks.

-- 
Jens Axboe

