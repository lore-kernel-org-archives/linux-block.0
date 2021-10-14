Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753B7C4167D
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6065A61151
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhJNPQm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbhJNPQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 11:16:40 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3242C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:14:35 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id i189so4204980ioa.1
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ww3KH2wTTqnipZwzgG67/y0sw8ABjtYvekZ99wY0LNM=;
        b=zVwh8cB8gNXcbDlWm5h41lDyl/i7/wXM36v8SLOyB//tdX7QOm1P8X9OXzOBP3I/Pi
         EWlTmomNvnkrWsjp739qHPO/TUs0hrJ5CJkTEIMfOGZAljcQUJZPD69dYFUYPKRVvrf+
         hBvyGQizfdbFiB9jSzRRSZLxinZUHcSMO19U42JwQS3nSfsXAaj/fIt/bxHD2fPS8HAw
         aym8ep6+/O7cwca0/pQAOZjCdh0fR5qkN6U/SAkvHf+iTrWZpQj5z/zfrOAoi9CcZmVd
         DWbWtxeaksSOdEHggeS+yXAnzwx1qTlndo/mK3YSgiULJpv/9DTu8VwYCnuXHqI+9CfK
         OCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ww3KH2wTTqnipZwzgG67/y0sw8ABjtYvekZ99wY0LNM=;
        b=RWchziQHDFM5dwJXbTpQacU9dU5WomCnd5d6PJjzLiOpmEfdu5d3f4QuPusKZ+nod2
         rI79t94JmGEaLz7Fjf4KKw2vy3l9t3Wpo6INvWVx0k5VeIxkfdvvCq7zEKLrzyPzTPbj
         paRJ53PNbWfJM+NFOFliJp5laewuvKOYg7Ta1FX+FJvMKtt2DF7acl8gSayU1sWMUEX/
         U6pK1o6M5Qml8O+eDxRJJt11pHeTRQIZ55gIxCQ0W/WoB7BIa0dFQ7tsCkGPtsqoHNvQ
         EIF8Zx0+urZ9kmRPLL4CucoHobpQ6ioMBjB7XPUj+kjCS3r+EyfYqYYRVF+RCLFQZW0H
         aDTg==
X-Gm-Message-State: AOAM531DnhsVN7G1jKxuhQF0Mtu9ADVX50QXavImiALAT1x04krKBfMd
        l8bD80wVQgRn1Ch6k2f/IxLJBrgsfwdJww==
X-Google-Smtp-Source: ABdhPJzOCaVOFP4dvIW1PHIEhGGqIyU5H24wa/NkAMptcrUThne6DhwqXuamRk8j1xRTtRm0jr3p5A==
X-Received: by 2002:a05:6602:3412:: with SMTP id n18mr3102921ioz.65.1634224474937;
        Thu, 14 Oct 2021 08:14:34 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u12sm1327199ioc.33.2021.10.14.08.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:14:34 -0700 (PDT)
Subject: Re: [PATCH 4/4] block: move update request helpers into blk-mq.c
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013164937.985367-1-axboe@kernel.dk>
 <20211013164937.985367-5-axboe@kernel.dk> <YWcYFywO7J0R4oMb@infradead.org>
 <f55d823f-79ca-67f0-1868-c013d7711fe5@kernel.dk>
 <YWcdXjZPpYvuaJ5O@infradead.org>
 <2418e448-6df4-ce6e-da2d-99fb7ac41fcb@kernel.dk>
 <YWe5h25TVmF3V05w@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd531677-0d1c-c6d7-fb7f-3b8dd40a4e64@kernel.dk>
Date:   Thu, 14 Oct 2021 09:14:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWe5h25TVmF3V05w@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 11:00 PM, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 11:57:51AM -0600, Jens Axboe wrote:
>> It's not like they are conditionally enabled, if you get one you get
>> the other. But I can shuffle it around if it means a lot to you...
> 
> As I've been trying to reshuffle the files and data structures to
> keep the bio and requests bits clearly separated I'd appreciate if we
> can keep the status codes in core.c and just do the long overdue move
> the request completion helers.

Fair enough, I'll leave the error stuff in blk-core, doesn't really matter
anyway as it should be out-of-line.

> And as said before:  I think we should fix the trace point to not
> unconditionally call the status to errno conversion first as not doing
> it at all for the fast path will be even faster than inlining it :)

I'll do that as separate patch on top.

-- 
Jens Axboe

