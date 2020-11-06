Return-Path: <SRS0=ZSeo=EM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A9AC2D0A3
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 16:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FEEB2151B
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 16:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mnD9nhzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgKFQhi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Nov 2020 11:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQhi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Nov 2020 11:37:38 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD89AC0613CF
        for <linux-block@vger.kernel.org>; Fri,  6 Nov 2020 08:37:36 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r186so1352278pgr.0
        for <linux-block@vger.kernel.org>; Fri, 06 Nov 2020 08:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YzV8rqDFCFdrm11VJcdiu+4uNT2gi4D9ChWF/T6uRTA=;
        b=mnD9nhztsjPCTZsT2hc8h5WS+ivQm99TeVQ7trDteSYfxcGaX5yQtfTmm9R4qkRrXy
         RaUWfCtIe6w22TJmggCCpeLlpxHepMH7VhDhuxZvzld/2vndsjBM/aPyQktBHqQdBqvv
         YEC/As71wBrwClzj5SDBgfZ35YXZWPRq+yMiwznqNU2P0VKiTYYM89hg7t7HpP6P0AYK
         aCZkCRXHbbkG82Mmpus0YQGd72nByBZIoXAivD8QjT4PQ4udXPLm8hmdtJwgde7ojL2F
         dCsqAWH/abUsjLt+pITQn3uhvUkxAMBhAz7fFjKLCJJ4PngHi/+3TZiHu5ycQ9bRVHgI
         5c5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YzV8rqDFCFdrm11VJcdiu+4uNT2gi4D9ChWF/T6uRTA=;
        b=Vro/QbnTJ4d3VCIWkTEV8HmfkxAoICgpFl9F/gnZqsOMiW1Br0c9VL7ZCZ4NQjEZdr
         Pe93V9hlilYtoVHQ3Sa/EMqNPi+F3cCSZOOZ0iKXFasVC9L1AV1213IScTrlZkb4ByiU
         fpGtxrq7yWYCp09kXzcgC8XNcGicNRwBp67QnnQv+gBTaKVDuOl3+93Wjcjbb4nw0Ws+
         1dliwR2TbXM5qUpCktjpq31uL8CtlMPaA/vS+ayHkWMFlFLhj8lHf8jRgE9YuJNVFdtr
         zyTSrx3rR8bIEsQ3ntvncBCvwbSBGFn/GzTqEODoYOp3pD2mgyX0VrfYukcViLFhM7qm
         mN4A==
X-Gm-Message-State: AOAM531tus61TdAVHJT9IzGqjDnAIIz1cjsNS2lfdjcDIp5LogXakGkl
        ARh0IYEqY+pXG55dcDdZ0JETN8LQFutkgQ==
X-Google-Smtp-Source: ABdhPJxBQJk114unzKAyyhUitwi1soB0CaKljWjdJoUbZ57SGpDamYuke+6L0WnXugDEvLVGHcl75A==
X-Received: by 2002:a63:1418:: with SMTP id u24mr2448751pgl.43.1604680656147;
        Fri, 06 Nov 2020 08:37:36 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r8sm3320893pjz.51.2020.11.06.08.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 08:37:35 -0800 (PST)
Subject: Re: [PATCH] null_blk: Fix scheduling in atomic with zoned mode
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20201106110141.5887-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <916d292c-a33b-d58e-f9ce-eea5cfdaf928@kernel.dk>
Date:   Fri, 6 Nov 2020 09:37:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106110141.5887-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/6/20 4:01 AM, Damien Le Moal wrote:
> Commit aa1c09cb65e2 ("null_blk: Fix locking in zoned mode") changed
> zone locking to using the potentially sleeping wait_on_bit_io()
> function. This is acceptable when memory backing is enabled as the
> device queue is in that case marked as blocking, but this triggers a
> scheduling while in atomic context with memory backing disabled.
> 
> Fix this by relying solely on the device zone spinlock for zone
> information protection without temporarily releasing this lock around
> null_process_cmd() execution in null_zone_write(). This is OK to do
> since when memory backing is disabled, command processing does not
> block and the memory backing lock nullb->lock is unused. This solution
> avoids the overhead of having to mark a zoned null_blk device queue as
> blocking when memory backing is unused.
> 
> This patch also adds comments to the zone locking code to explain the
> unusual locking scheme.

Applied for 5.10, though I do agree that the locking for non-memory
backed should go. The whole point of null_blk is to be able to
benchmark the underlying layers, and if we end up having null_blk
be the limiting factor, then it's pointless.

-- 
Jens Axboe

