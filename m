Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C263C5519F
	for <linux-block@archiver.kernel.org>; Sat, 14 Nov 2020 17:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4D1221F9
	for <linux-block@archiver.kernel.org>; Sat, 14 Nov 2020 17:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="n6B3//yK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgKNRd5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Nov 2020 12:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgKNRd5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Nov 2020 12:33:57 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A79C0613D1
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2020 09:33:56 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f27so9397639pgl.1
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2020 09:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ulsmKHglBFQcaNkkac56gwErz0/feDKol0nz0iItjhs=;
        b=n6B3//yK6v0gBEt/Mpt9mIWD7kJrYNk0ahBsxCO49P+DdhCjP1na9tqymFiPs7W3Xm
         pESaoCkzMQ9hxes9QxmfJyj47s/YIuHmPC9h1C3Qs5nZZgM3HNqnhBzqh66uAGR+nvSI
         yVinQqM5tH8FCGvTftBPuCHG4JRGIWwo4E3cUQXOQMS8Hz9JgdRIFRInafKZhydG9OtL
         GwijYLlwCnzgls+BMbgvqMZHOl7jma8rhRPFy2S9/W3F+Q2RgN6yDdXWiPYjR/vEoTBa
         js4GhjLmwdZiH6W0gH7C3Gihg1zmW8AgtMihecwUCnMd8s06Lbrxkb7fB3U3ftPVXV+x
         dgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ulsmKHglBFQcaNkkac56gwErz0/feDKol0nz0iItjhs=;
        b=VzPrinKfQAMgAavNym9PvWAAhCniQL0WXoZUxB5HuADfln4O3r7/idE1z1EaeoHCJr
         i4ZxJJ++slAU5Mrs48ME0f1kSFsNIxQqJVIocjb6RQr1UI9Kx06cTdNaecioFhdxJjV9
         SlSkeOSV+a7Nf744RiArXWmEj2xOU0r5GyaxZEGX9QzIaScwAINqxN7mP/RGcrOieUhz
         UaCfbbzVq6SEnrDHElM9Cd9KcDXPTUKy8loQ9pSVMb5mbsVouPDPAO3mhYFVVzS4/4Ix
         oHSC6kl133scBQEJCBctpDG2KHjd9ZLQXmjXUwOT6OW6FNpViwFhcUL1unAfvDcnCTeV
         bHrg==
X-Gm-Message-State: AOAM5333Jrvb9677qN4NSZda4+CoYi/AP12A+duFI14akLJs1vQYSFN7
        CiLkq6GjDmB1DbKPkCFuP5tPtw==
X-Google-Smtp-Source: ABdhPJz9QZL5iR9ZnJ1O5op1psV633aSMIpEQrJdJm4GroVjVty7kcLZT/sCPmCSRW/K15mQmKMqng==
X-Received: by 2002:a62:8749:0:b029:18a:e2c8:a089 with SMTP id i70-20020a6287490000b029018ae2c8a089mr7003307pfe.13.1605375236357;
        Sat, 14 Nov 2020 09:33:56 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e8sm13205778pfn.175.2020.11.14.09.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2020 09:33:55 -0800 (PST)
Subject: Re: [PATCH] block: fix the kerneldoc comment for __register_blkdev
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20201114170821.4714-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e6ca1604-8de4-e340-0b43-194e25433329@kernel.dk>
Date:   Sat, 14 Nov 2020 10:33:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201114170821.4714-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/20 10:08 AM, Christoph Hellwig wrote:
> Switch the comment to talk about __register_blkdev instead of
> register_blkdev and document the new probe parameter.

Applied, thanks.

-- 
Jens Axboe

