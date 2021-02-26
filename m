Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46264C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Feb 2021 22:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03ED664EE2
	for <linux-block@archiver.kernel.org>; Fri, 26 Feb 2021 22:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBZWvX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Feb 2021 17:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhBZWvS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Feb 2021 17:51:18 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E083EC061788
        for <linux-block@vger.kernel.org>; Fri, 26 Feb 2021 14:50:37 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id e45so10587247ote.9
        for <linux-block@vger.kernel.org>; Fri, 26 Feb 2021 14:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FVaorLf6cYpgwAX1Zd+PAdGIFbAbkDLp5X5cbNNtpWI=;
        b=d+4DXdNi3Hsf1qtaCslXgCnjYIRyaDj8f8bfyqMMcqVJbpzwWO09DmL46UwpdtZrjJ
         vcMov54SHAgxr2pMUT7pNRPLf9LT6hVWeCjlE3DJGEkOUgVLsLQ0SP+hdAOhy7M+xAfW
         THkJAqyMf7xPoBkpiM4msxG/kbe+4b/eToH4MbYYFMqe1L2jOL2VLLU4GdyLytwdt/hu
         4riO33xmrmts6mZL91cgEy4lKDN28cLKiK50M7H5I6X902Bf0JYk4O2nmylmQHjOTIfo
         UQaBHH15nGuSDwPf1rrfHfSd9hEHLRjj1AIe0Lr1b8/LRU4I238+07wZLNOsoV6TKEsm
         veSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FVaorLf6cYpgwAX1Zd+PAdGIFbAbkDLp5X5cbNNtpWI=;
        b=CBe5jXTrK2T6Ik/amTxI3U22HTkY1Ha2ZHfvYhaus++sdi2933bnngS8AjW/gtiq+I
         QD2KiCGhD6SSa+mMgVgLQTYI2afd5y85FNcYUKavy9ZhEGRWBkZeX46akbF2b1FWOwqm
         XMpg8VE0/v6/TPKjIek4G2Dr+M6Y6AcP6jQL6PB+LylBMCEotXt9L/rHj/7wbv6bDJW+
         RzbaejhccniF6bdGv4dA+GUcsJ66vr+T0VmrQ0M7JVA74wW31U2nQjO40LgVtY5ptccX
         DYWdmSVjSs/0oV6DQw0D9SBkvXwML80ko9xttde8PDhgYMqHNJGpblx20Gp5Cg+Pt2pM
         TJ9Q==
X-Gm-Message-State: AOAM5336sa0Ep5ggltLsFRyhoZjnVUoHgHV2hOPqdij1Sdw0831XDvDD
        ciSVnVHUro9vr3fDS7NWaIjXOw==
X-Google-Smtp-Source: ABdhPJxkfATb74vHEI7DysbxiEX6T4pY/s82kdocO+CCdgFkE47lbzUNeVp/UlhM7T2U92yE9ArjiA==
X-Received: by 2002:a9d:2945:: with SMTP id d63mr4076467otb.70.1614379837232;
        Fri, 26 Feb 2021 14:50:37 -0800 (PST)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id r205sm1949094oib.15.2021.02.26.14.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 14:50:36 -0800 (PST)
Subject: Re: [PATCH v2] block: Add bio_max_segs
To:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210129043857.2236940-1-willy@infradead.org>
 <20210226203819.GH2723601@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <307e1cef-0932-b7f2-4d65-42983e3e0d1b@kernel.dk>
Date:   Fri, 26 Feb 2021 15:50:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210226203819.GH2723601@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/26/21 1:38 PM, Matthew Wilcox wrote:
> 
> This seems to have missed the merge window ;-(

It ain't over yet, and I haven't shipped my final bits for 5.12 for
block yet... I'll queue it up.

-- 
Jens Axboe

