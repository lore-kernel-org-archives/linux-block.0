Return-Path: <SRS0=horf=6J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C307CC55185
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 15:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9959F20644
	for <linux-block@archiver.kernel.org>; Sat, 25 Apr 2020 15:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wA6w0yXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgDYPph (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Apr 2020 11:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726108AbgDYPpg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Apr 2020 11:45:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE7EC09B04B
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 08:45:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id hi11so5176237pjb.3
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2020 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WbXqUvy6Zx4jWra7/mKAUkU8JyHGv+EMw9mv1e/ZXrw=;
        b=wA6w0yXnoRQod/x9kLNhbiBia/FHpGoN4xQViR4JBH8y01Ngws6t68NvQVilPaLZx2
         xJ8vIdznCP+MwPFk8khyg9Dnz+lLcCtj3agOmaFX1EpIyhoxTy4HLil0x6mua7/yvGMt
         uS2/H+3/kBL6nnbMDD0r515N0pxGXyEcLW1+xvH+xm0sJyoEHnshgNhAjnpoCmXDZiSe
         qLlNf1VLRJmTlrMx33woZMj9ZerpbqLYpTsOeEJcGnm7SyM3wd4ynvkjiZsQK9fNgDKW
         o3bV3ow/MslKyJPLXYeG4o2M5aiMMJ2iR9uPTQlp17n66iJH3swYfMTzxnJ8aSiFbP3a
         smJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WbXqUvy6Zx4jWra7/mKAUkU8JyHGv+EMw9mv1e/ZXrw=;
        b=i4tu2fIBjBvYZ9QvLYUU02qudHBorjdaNYbwk1R7n40vkKnqf+bZgbK130wwqnGZsE
         P/rVfxWyKvB7HEvmIdTrEga6B3DOM0ZpkC1FSwMqmhOYSfaeldmkzaPseGzlzKbUGGAz
         oGtay+/KaQUTOgu38hqu+qn6yf4UPaq7c8+26CjlEdsMxDzCVVFaJ2SLyxeN+8Go8B3a
         HbNk983wLGY6+sLFBPrQ0d72qW40o64Dq95ibzRborptaKOKhZzQxWS36cNMzMDmBFMv
         ZXUMe3MCFRR7fHOcwRt4lTXnXksO9NWKXOdeO6mkNoT0Fes2FHrHMVUxgR83nM6yFmE9
         ID1Q==
X-Gm-Message-State: AGi0Pub6xoz+RWYcJTUgIqW+loQHYM8vg5DbNfUD9LMnZXLdqljwC7p3
        oa2WEJL7XfOywCo7TOhhiFxbp5rA2OOy4g==
X-Google-Smtp-Source: APiQypIlBZtsrMImuPudY2tg2Rzjk77JhIq2anQwrD+xO4v3/vehSA9N2sPj2aHncEr8sTNiiKhqHQ==
X-Received: by 2002:a17:902:59cc:: with SMTP id d12mr7704421plj.237.1587829535828;
        Sat, 25 Apr 2020 08:45:35 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id f21sm8454701pfn.71.2020.04.25.08.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 08:45:35 -0700 (PDT)
Subject: Re: avoid the ->make_request_fn indirect for blk-mq drivers
To:     Christoph Hellwig <hch@lst.de>
Cc:     dm-devel@redhat.com, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20200425075336.721021-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <98cd7aac-e4ee-8de0-e7aa-0d3e1a2b20e0@kernel.dk>
Date:   Sat, 25 Apr 2020 09:45:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200425075336.721021-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/25/20 1:53 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this small series avoids an indirect call for every submitted bio that
> eventually ends up being handled by blk-mq drivers.  Let me know what
> you think.

I like it, I've been pondering something like this for a bit, but
I like the simplicity of this one and changing it so that only
non-regular make_request_fn is set.

I'll apply this.

-- 
Jens Axboe

