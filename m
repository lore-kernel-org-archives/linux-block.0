Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC89AC433F4
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 13:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD33E207EA
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 13:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kRts8hHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGQNOJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgGQNOH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 09:14:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C01C061755
        for <linux-block@vger.kernel.org>; Fri, 17 Jul 2020 06:14:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id md7so6350526pjb.1
        for <linux-block@vger.kernel.org>; Fri, 17 Jul 2020 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o4Fs9aQMGweLBCfNGjUAcKyxKv0OfgD8REoZk6Mumcw=;
        b=kRts8hHbCw6dHUoVrSV0RfQrDstH1xu1kNduISwY69QOLKZDR4cQZuWKGP2nhBHzcQ
         ukNbQn2pES0LpE1L9Wal0oS0m33W+Q5Ppr/1EoF/vEdMmQgh4aojAUqs9a5OkOACnPAU
         BurC2DJ+0/g7WQiMUEN7Wz3so12czyyDxf1L5JDXwL0DHA9f/R7UJFZfxuKcHzZgm3yl
         tyTWdXsmQnB9ob3EbMJY1k/nCVa3NPq9OeFeuo5iGzwfpci1KOOBYWosYyCix10EEqLJ
         /XKRlPa7gYMQgO96gxwr1MZecMwN0skTDScHsSTKrrNsLBLmrzUqi15Mh+HiBGjAGIMW
         v6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o4Fs9aQMGweLBCfNGjUAcKyxKv0OfgD8REoZk6Mumcw=;
        b=g7xIWLdkQVJkhAS+lrqZHq4cI7kYnNSJKhNlvK4Mwx5TZMOxscVnxME3Zj3JT32tu7
         XG0XEa/vSpBVPkCawYoBxrgnRZ9GYIV3FBlVWFRzGeU79Np2xhUQCx0b0mKitkDbvXEn
         kc66bZ0QG0Dte3i8rLalNAJLk+c/TyMMKhbrOs1cRNAmwl2jbxvRvsHgRZrQozN8snl8
         Ccl0phnCoBjDn8q0u+stkaoaUFcZ7M3uTLDfPsbQRii8tnX6cp8JgtFwypnmHyjrC4hO
         9588plbj0vWTRgQRL4CCnpU3QYQWvyZvxg+W3Aa1KPoZFzKXNS6jOHPasWLVQ2ATlUnt
         2A5Q==
X-Gm-Message-State: AOAM533NXvdS0c5JaB0XbyzHH/jI1m80YJf+2DdMhEJTpK2LAd7ONeyp
        KFZIwKCS3dVIgxS5se3REgBm/o2BWc9Jaw==
X-Google-Smtp-Source: ABdhPJw0m01gOOfOAjM4+QcoTlyH+SsvdUUm7GjowQOPOOSgHkBf3TzzvSuZWC33XldtV+O36IBmmw==
X-Received: by 2002:a17:902:7483:: with SMTP id h3mr7372336pll.114.1594991646820;
        Fri, 17 Jul 2020 06:14:06 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i132sm7944326pfe.9.2020.07.17.06.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 06:14:06 -0700 (PDT)
Subject: Re: [PATCH -next] block: make blk_timeout_init() static
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Cc:     linux-block@vger.kernel.org
References: <20200717100002.51739-1-weiyongjun1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <adbf90e4-89f1-0bf2-ea2b-c81d08087601@kernel.dk>
Date:   Fri, 17 Jul 2020 07:14:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717100002.51739-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/17/20 4:00 AM, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> block/blk-timeout.c:93:12: warning:
>  symbol 'blk_timeout_init' was not declared. Should it be static?
> 
> Function blk_timeout_init() is not used outside ofblk-timeout.c, so
> marks it static.

Applied, thanks.

-- 
Jens Axboe

