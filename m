Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863E4C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 19:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601836128B
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 19:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhJSTOF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 15:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhJSTOF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 15:14:05 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F65C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 12:11:52 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so3562132ott.2
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=CzG+Zf3dRxBFeY2vCinV3BI2+jApgHmGWmEPgYqpD6s=;
        b=Og+Y+bDzjDzpiy77y/IfgqxmJj2K9Pudl0/EJ4gxfKuynIhzrW0hCh+n8sBYBKlHow
         9rCqmBliSsUwt2NLRScaojiCVaPndOjuWj9F4eNSpiqJOLNWa9X48t1fDDjRDqf/JemW
         FvggDo5d0BAJHQLDr6wV7VU9eBx2/2MzXLtLyKu8PSTmPzbkuLBGw0dYF1pvfiM4FYhz
         N5DzC4RC1FQ6X80mYRxJgiPH6eoCP539GbxwVcbfgc/P+kEKLWV8fAYF6Xa3GuFAcyhP
         cSrDUP0Zok2A8QOdVNLH6Jqic4Cdsz/lAnd4uYw1/Jhgi/0paIlaVZovXoyHqDKCSV3c
         w59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CzG+Zf3dRxBFeY2vCinV3BI2+jApgHmGWmEPgYqpD6s=;
        b=OyvIJtyrRRnTzCe6cBxaVA9CQDTIkdGby+4iVsWM88azCMGj8Tsy3ZBM7PfSyk2zAq
         K7Y6ROUlwzPs1K8M1xOeOq7PY+KP6B2u/5kCOLr3emrXzuuyNTwDEHk0Pyt8T7tLCevf
         kqLL0FSE6bdNEAcxM5P6hCw/Yq07+EhYaQPIIdwmZSGMFJZUg2d4J5STOUHzTOS6WeaD
         jzCTZoxDDjhWN3d6u18n332Iiwk71izeatKsLcVadCYoNNXQpe6M4dJm7hAeJiz6gPXo
         nUUWigYiiPlVQem0aOFuZ1RJqpQ/6y1cCcsWPkT+/IPRvdzA2xkXJwoHoSOO8ETj1DJ1
         37Bg==
X-Gm-Message-State: AOAM532Zci8m510OVZ/dgAssxK2cCMh1tJWCnuJgsak1mLwLev9ZELSH
        q0lBqnt5BlC3HTmmIgznhGl88TgK5WtBmQ==
X-Google-Smtp-Source: ABdhPJyZJ09cjNcAgFuwBiDnNSAJNXC7aQIMCt1VgqWm7HzPrNrfZ2jsum0fTrkLBHmkcNJpZvnK5w==
X-Received: by 2002:a05:6830:2316:: with SMTP id u22mr6660586ote.239.1634670711228;
        Tue, 19 Oct 2021 12:11:51 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id bg16sm1658933oib.14.2021.10.19.12.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 12:11:50 -0700 (PDT)
Subject: Re: [PATCH] block: improve error checking in
 blkdev_bio_end_io_async()
To:     Pavel Begunkov <asml.silence@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <69df4731-3232-eb2a-664d-47d0db381843@kernel.dk>
 <b813826d-ce9a-c043-2d87-a7275d5df77d@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5383f8de-ddd9-2148-799a-7a72011975ac@kernel.dk>
Date:   Tue, 19 Oct 2021 13:11:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b813826d-ce9a-c043-2d87-a7275d5df77d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 1:06 PM, Pavel Begunkov wrote:
> On 10/19/21 19:59, Jens Axboe wrote:
>> Track the current error status of the dio with DIO_ERROR in the flags,
>> which can then avoid diving into dio->bio for the fast path of not
>> having any errors. This reduces the overhead of the function nicely,
>> which was previously dominated by this seemingly cheap check:
>>
>>       4.55%     -1.13%  [kernel.vmlinux]  [k] blkdev_bio_end_io_async
> 
> Jens, something gone wrong here. blkdev_bio_end_io_async() is a
> function from my not yet published branch, the perf here is for it,
> but the patch tackles blkdev_bio_end_io().

Yeah, see followup email...

-- 
Jens Axboe

