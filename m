Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08070C35257
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 20:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E1520738
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 20:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="k+pqyndR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgJBU30 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 16:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgJBU3Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Oct 2020 16:29:25 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E798C0613E2
        for <linux-block@vger.kernel.org>; Fri,  2 Oct 2020 13:29:24 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k6so2944540ior.2
        for <linux-block@vger.kernel.org>; Fri, 02 Oct 2020 13:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+43azacrszXaJZE4tAWv17/zXnM0+9G1SeNbkNsAJqI=;
        b=k+pqyndRWPOHK5PXMx7ywsEbyOub5RRMmbLgmlywTJaYmiDD/Y0NAHAXgAwr+m7yhe
         FTxISuOXWCyjCdLZzJl/5W8C5TMUBp+QF0xUA8YlfX4Zpnq9Pj/EVHuLeXRKuvHPmxOu
         vumJsu4bv71Oa0k7Qnim6RHiAJhx1nN0OTcSadE8VwPCYQ5g+OEbgy8gmWCMD3cKg3AJ
         ClqximQZqkcQcBO3JgFAyPDlSQKKB0wDC/TIrgfpxyIshVfHWXi1d4/WrNHsILXm5Qwk
         Xfl29A3vn9DNIRXV6yxJvZwipSmx/26tK0k3ayqDJ/a5cXB+vQ2Y7E+z7YO0qt5Y/qTN
         UDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+43azacrszXaJZE4tAWv17/zXnM0+9G1SeNbkNsAJqI=;
        b=le/kP/g05xkbjcGFrXULeCbtu5Ms+F29FBz75tUVLAa0PR5Ok/2LngZO48qNsWduNG
         a+75iD6gHb2Dcu4IAvJ9c/EAjbuNxcN2TK0cSoZtCagyZHrcvOguInxH1GpAS3bavD85
         I9a4q/Nhk4S9ZbhJjvSzf2WK0/k2kpiWWHNQXbiAHS90LJ1uuh1fgRD86SsNUhBDQq2S
         mnUf4JXy7hgV+aOI0LNe+G6iIQxb6E8BWR6a9aUPcgktDbEgCGmoZNATW9KlivJQ7M8U
         jODNfDSI8/B5gHhkQkLSjUxipXECPaTEuB7ddXfq7G8NsDZsKkglaOy7zDemMvhNQtHq
         VMog==
X-Gm-Message-State: AOAM532E69BbItMd7h2Rz9ZnZdTfiLl3TuKTiYqzqRnX9AATzacyRgkX
        wWaD+TE5A5E6tJK15APTO4mvcCI3yuMBBw==
X-Google-Smtp-Source: ABdhPJwiPCxWx4+wvdiGtHkxh2ha4S06WYXc+9By+kX79clLRtqUEb8EXe4nJq+y3N19zqpu2FYWnA==
X-Received: by 2002:a6b:660b:: with SMTP id a11mr3203810ioc.144.1601670563392;
        Fri, 02 Oct 2020 13:29:23 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k198sm1360386ilk.80.2020.10.02.13.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 13:29:22 -0700 (PDT)
Subject: Re: [PATCH 00/15] bcache patches for Linux v5.10
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20201001065056.24411-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <74b67325-cbb7-8039-f865-dfeacb548ba9@kernel.dk>
Date:   Fri, 2 Oct 2020 14:29:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001065056.24411-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/1/20 12:50 AM, Coly Li wrote:
> Hi Jens,
> 
> This is the first wave bcache patches for Linux v5.10. In this period
> most of the changes from Qinglang Miao and me are code cleanup and
> simplification. And we have a good fix is from our new contributor
> Dongsheng Yang,
> - bcache: check c->root with IS_ERR_OR_NULL() in mca_reserve() 
> 
> Please take them for Linux v5.10. Thank you in advance.

Applied, thanks.

-- 
Jens Axboe

