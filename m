Return-Path: <SRS0=CCtz=CH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453A9C433E2
	for <linux-block@archiver.kernel.org>; Sat, 29 Aug 2020 16:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21FDE20791
	for <linux-block@archiver.kernel.org>; Sat, 29 Aug 2020 16:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VGJdmi/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgH2Qth (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Aug 2020 12:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbgH2Qtf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Aug 2020 12:49:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579A1C061236
        for <linux-block@vger.kernel.org>; Sat, 29 Aug 2020 09:49:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 2so964404pjx.5
        for <linux-block@vger.kernel.org>; Sat, 29 Aug 2020 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3SqozLt6bwIUnI1vOeA+acf+9jhMF6OzZTJZihoVax8=;
        b=VGJdmi/YSBvXZBd6KuYEtXEz7S0kJGkdo9bfENLBeFOYqFYptmRrr1DVAJGhsp+7pa
         h09i++XrLTHDbiJZhC/I0N01GC7wHX5CfPAvfr7t5Z6qqZ+TDPxfNslXP30SOtQ6QegU
         VDgLBLEHrbG7/+e/LeUdXEKzO27B2Iib2BR2dxFpTuJNspJ5WGNtLBNVxdzuESoNyxhT
         hYHXloMAo4nVv2D7voUmxPYc+XduXKT3BTexV46BQjkTIo0580Kq2oSX6VORu4/wS9nB
         dB+03YGKBrU9UBkilyteeCWcRbqd9BuMNcfS+zD72nMUQ/ApPHAa34gU6c4109YnU4hn
         /0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3SqozLt6bwIUnI1vOeA+acf+9jhMF6OzZTJZihoVax8=;
        b=rfJOCVwA9d+HkfnZbrlovRjjGX9cR1qzUQn88Ga1HmiMnIjkl/6JiBrUgs61g4x6VY
         YxdGl/QQfW/X4M153Bjer/etlTBEaTuS/JRBsQenw7TXKbyIkSIVGxaDU6K7kGiYE2Si
         D5GzM1gu0A+3YnUgNwiNETZm3ugHGYz6l2VBdRwXWXuYqMWvGMiDho/fkIjXf5lte1aF
         bFfFn7PRZCoeGsA1magZbGtFsoiPGHMMxbdB/eYyXDgSI8Nb5HIj/zqPVhN0noKOl90u
         Pt4k+DPFfKI3SjKmJxqRhZvrYo36jqtJ3Q39SgAn1kErrB6IKVIuuvXm+0k4kv7jW3vY
         BSUw==
X-Gm-Message-State: AOAM531gdF+O5EiQSg7t3UjWmVb5+qVFAHj/ynIrUtXQKU1xa2Gk0Yx9
        Cs9cgo7znOQYqLI+1pghviA8xolrCg4+Rbu8
X-Google-Smtp-Source: ABdhPJwlLXaM4VjC3mK3EPenzEHKqQ8/tOHaswOgNPtZfccN/WeZUdr4NLhmcF+59Dh45O/btHIUEw==
X-Received: by 2002:a17:90a:9b18:: with SMTP id f24mr2319823pjp.195.1598719773958;
        Sat, 29 Aug 2020 09:49:33 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v16sm3119181pff.124.2020.08.29.09.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 09:49:33 -0700 (PDT)
Subject: Re: simlify the blk_rq_map* implementation and reclaim two bio flags
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20200827153748.378424-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a98cac5b-45c9-2377-c9f1-3b254a51c4cf@kernel.dk>
Date:   Sat, 29 Aug 2020 10:49:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827153748.378424-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/20 9:37 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up some of the passthrough remapping code, and as
> part of that reclaims two bio flags.

Applied, thanks.

-- 
Jens Axboe

