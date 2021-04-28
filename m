Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3C8C433B4
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 16:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AFE6143A
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 16:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbhD1Q7c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 12:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhD1Q7b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 12:59:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD3CC061573
        for <linux-block@vger.kernel.org>; Wed, 28 Apr 2021 09:58:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lp8so3080738pjb.1
        for <linux-block@vger.kernel.org>; Wed, 28 Apr 2021 09:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NgRj6vNx+sUo6L/aruM99++vdWBFyxTwbl90az3eLps=;
        b=TrjWFz5as3M1tCsFB+cSoRVSWMYkUgNB5WnuPq/zARAxKVrPz11s4JNUnNSB6NFTc2
         uyvlv4tbWZ4JPhKAJ/pv1tt+FTvWRRga8KokVLiFhNbrdXuO5r2Tc2KNvjCAXTzXeKVx
         c5FOVEcrbGmSthTX5NFAqvWVrcdvk4cogCyjAh+vcA1deJ8yO2Aj/kRAx0PXBNbSltbc
         Jiql1wn4TSKaMieGlLe/JDYI7YvJ8UIO7xMfGwK32NKn3bIQ6mRJR7nxf4w+Xp77ONzZ
         q/ze/sWVD8HQvy3qs4+qfIYS/RjhadBUn2t6sT4ArY/OrWDldf4GM+GoCCLYgL5AZ7G6
         F1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NgRj6vNx+sUo6L/aruM99++vdWBFyxTwbl90az3eLps=;
        b=kuUgJHcPd+61vSyqcU7rjK8bPwEY/Vnt31x9XR5iIGbtCOmb40hxpDhdDzOt/obpo8
         lnj5r98G/Y6RhjT+KK7r6K2mxDKzCaKFH3zPOWojzgpu7XCO7E9SvqghMpvI/ThklXLe
         gRFNfUuVpUMTFsOhOyjy8erJjcbXIBszDXo2t1Kz9Wl0LxVgE7o1oZFGgRL5crP2Fy5e
         q3LtdleAu6b1O1tzN4Dcv4PPeIeOJEl4YpbobohJ92WilftG8x7fnOibqOrXsdqsBYA4
         xUGKg++oFPat7/W1RsLsozfcg8JVmtPG/Zw9Dy4oQf+NEqyi2Y1Q9E9IXTM39JlWX5QT
         kzEA==
X-Gm-Message-State: AOAM531G+xF+FEq2Qwfq3MW9S/H41jMLcFDnjUpksrxiJ8UEqgF1m6Ba
        JNpsuk5O9MaKgO7Lx9G5UvIrLA==
X-Google-Smtp-Source: ABdhPJw0m/ycdiCc661fwy+wOR6HFuRAyhki0asYKedlTVFIDAIFZBwHA7OBDYturAk7+xc3Js/3tQ==
X-Received: by 2002:a17:90a:9312:: with SMTP id p18mr4879444pjo.171.1619629125945;
        Wed, 28 Apr 2021 09:58:45 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x2sm246938pfu.77.2021.04.28.09.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 09:58:45 -0700 (PDT)
Subject: Re: bio_add_folio argument order
To:     Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
References: <20210428165044.GB1847222@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7be8f00a-1444-d614-267f-1477289e4f62@kernel.dk>
Date:   Wed, 28 Apr 2021 10:58:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210428165044.GB1847222@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/28/21 10:50 AM, Matthew Wilcox wrote:
> bio_add_page() has its arguments in the wrong order:
> 
> extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
> 
> Oh, right, and the prototype commits the cardinal sin of just giving you
> a pair of unsigned ints and doesn't bother to tell you what they mean.
> I'll send a patch for that ... anyway:
> 
> int bio_add_page(struct bio *bio, struct page *page,
>                  unsigned int len, unsigned int offset)
> 
> This fails to follow #4: https://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html
> 
> Here's what I want to do for the folio equivalent:
> 
> size_t bio_add_folio(struct bio *bio, struct folio *folio, size_t off,
>                 size_t len)
> 
> This will make the transition more painful, but it does remove an irritant
> for the future.  Any objections?

What's the point in shuffling len and offset around?

-- 
Jens Axboe

