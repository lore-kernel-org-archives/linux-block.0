Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE8BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 02:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B051760232
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 02:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbhJ0Ci3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 22:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhJ0Ci2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 22:38:28 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B249C061570
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 19:36:04 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id i14so1769436ioa.13
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 19:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rBbyfwAA1XAbf3WeQ5smM9kbfwrjNTyxKkIdng8HT9Y=;
        b=vJzRhOZ9fLujLSobp74paNSqSjQKV1HMPhAiJLDFYWwWaDFrTAQxuD6S3NUkaUK6Fm
         MIfK1hAAbvgf0o8MA2h+E4NNyGZxeogQY4S22GluvPsFoj/QRGyGbCo+w+7JM5rhscp5
         c0ugqQXz4DtaWEJdHz3X7Ctv3RmjFDlJ7Sf4GzXWvqe2ToFMr643m9/O0gzSS5r7501V
         s7iIfefFwNQpZp2VqqtFXk2kKj8rLS5TEcQTFQsFIsZ3hUwnoJRe0Ralb5BQb18jeAnR
         reDMP33A0owJDHG1kqgpWIJrh2JwS7VNjHkZuPcvA6xxoyVr9FtMk+Be0xqYialVxC6q
         FCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rBbyfwAA1XAbf3WeQ5smM9kbfwrjNTyxKkIdng8HT9Y=;
        b=b6G5CRx6YaLmM94Lir6E6nEYm2JVEr2Rm5ItCqRNcRJ9GlENWlD1IktDZ64lbOdhLp
         b/+gAz6lb3nEllXgRJsq1onl0MOW3TXcXYl8k2m2XdVuvK7G5V+kZNlnzh6ulLRnkJgx
         kLBVsVM+uQAq8/HSSpcJNHtv6UShsV6yeA60U9bu7ArzkCmSdSuUCzTODmtcBStMd4B7
         ItEDxgkeNUSrBATeRWeX2+KM6BH7tHioq0EspB5uQ+mgq/9Qon7f9KeZAlO0mY+Gg9y8
         FRaT9vMg9PNDEig/zPzb8USODqAEsheCP/ltISm1iBGcDZ8cxovD1suwX3Fkzsjk6lFD
         7xuA==
X-Gm-Message-State: AOAM532dFQEuTOn5dJizQKw2V9QXxf0OxB1IElwaSj5LPM7PvoEFLK/h
        yH7obu0ahjfMdfiBfdHI8Crew6gPDlBxwg==
X-Google-Smtp-Source: ABdhPJwdIu7jiSIbCj0s8s2gh1tNpz+wEU3tdkATO3cGG8TGLClU7M9VwulX5QxsBe7byDDFE1T3FA==
X-Received: by 2002:a05:6602:2b06:: with SMTP id p6mr18221430iov.17.1635302163774;
        Tue, 26 Oct 2021 19:36:03 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y20sm9201208ilq.74.2021.10.26.19.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 19:36:03 -0700 (PDT)
Subject: Re: [PATCH 2/2] block: attempt direct issue of plug list
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-block@vger.kernel.org, hch@lst.de
References: <20211019120834.595160-1-axboe@kernel.dk>
 <20211019120834.595160-3-axboe@kernel.dk>
 <20211027011347.GA3111117@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8e0583e5-8c34-336b-9f46-0586f4db9c5f@kernel.dk>
Date:   Tue, 26 Oct 2021 20:36:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211027011347.GA3111117@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/26/21 7:13 PM, Guenter Roeck wrote:
> Hi,
> 
> On Tue, Oct 19, 2021 at 06:08:34AM -0600, Jens Axboe wrote:
>> If we have just one queue type in the plug list, then we can extend our
>> direct issue to cover a full plug list as well.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> This patch results in a number of warning tracebacks in linux-next.
> Reverting it fixes the problem. Example tracebacks and bisect result
> attached.

See other replies in this thread, it's fixed in the curren tree.

-- 
Jens Axboe

