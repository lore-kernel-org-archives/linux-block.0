Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7640C48BDF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 14:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC210610A3
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 14:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhFROyT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbhFROyS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 10:54:18 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75482C061574
        for <linux-block@vger.kernel.org>; Fri, 18 Jun 2021 07:52:09 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id l12so10800259oig.2
        for <linux-block@vger.kernel.org>; Fri, 18 Jun 2021 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UZImo1VhvV6PYCVtMJ1ZtOxRSuCifEI3PziMcQ58pPQ=;
        b=k/56LsXk0/Tp2omxXKjEcdtTDXmZE2SqTmS2CiEoFE0WQN6AeIibasb3tYYMD/Ntj7
         TopQQ9L+StaE+VOpjWBl0gBgS3cyICNm9SS2SKpqXfbQI2ufTLIYV+sTRNthArLmSW3n
         zVP82CtFNnuqkSZBMuZROFJ/uY+GmOd3udGPhSWT/50VJ/H6ppKkKSgVFvMbWHl40GpO
         5vg9TajS0lY8EtfJIh0W7dUNmK97rPo1vQPnDrbBV+RASKqVnLn0iMXK9aHc/mjOyg/w
         DYyu0NFb6R10WgADj6jlibY5u0PmBN2C/p0oIiR5rWrmyzA1E/kBc4Ryii0wVRNr8FIR
         4KWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UZImo1VhvV6PYCVtMJ1ZtOxRSuCifEI3PziMcQ58pPQ=;
        b=Sncc4G+nHH76fUTOL6N0HYjHztg8IpRE9oj+jROxCtrPM8Y77/f0yR4+XV/2K+hBku
         oiTdVBpSquWLyJEZY9apSyaJ1cpjBrskWgznL6hZjkW0WHzp6ambLLl4YsfZW3LbUTye
         BfOXgpY1OuOsZHPQoZ0G4HhHvkHlFodVyShjuS0AjwvUkn+6876g/dzvMkKsMlVBDwC0
         So/ozI8Q5lwOANZaYsv5drZY/dXhpZ+Z8+fmeOZNsMwIo36M4k8+nJQ5es0Gx5FfpSP9
         Jd70MIO1i5wmcYY4r2hW+z8BHM8u/VkoSMSyRRid44oArRgoMuQcGEBT36MGqPnbvWu6
         yatw==
X-Gm-Message-State: AOAM532jYvgWQK3rjBw7j/o/vD1FfmukvtxNIVWefrb9LGmw24cgfKoL
        9DqNJ3BR82TWyheC9gr6/iHR8m/gU+FrSw==
X-Google-Smtp-Source: ABdhPJxQqYg1KZpmz38b77+pe+Qqb66GVGAFALg/Pn9ijZy9NBgUK+uvLZbqPkuYAXn7T7BxdpOIYg==
X-Received: by 2002:aca:758f:: with SMTP id q137mr7972827oic.108.1624027928714;
        Fri, 18 Jun 2021 07:52:08 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id p65sm1867498oop.0.2021.06.18.07.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 07:52:08 -0700 (PDT)
Subject: Re: [PATCH] block: Remove unnecessary elevator operation checks
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20210618015922.713999-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d4a52d0b-cac5-06fc-ed51-a173eeb5c3ee@kernel.dk>
Date:   Fri, 18 Jun 2021 08:52:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210618015922.713999-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/21 7:59 PM, Damien Le Moal wrote:
> The insert_requests and dispatch_request elevator operations are
> mandatory for the correct execution of an elevator, and all implemented
> elevators (bfq, kyber and mq-deadline) implement them. As a result,
> there is no need to check for these operations before calling them when
> a queue has an elevator set. This simplifies the code in
> __blk_mq_sched_dispatch_requests() and blk_mq_sched_insert_request().
> 
> To avoid out-of-tree elevators to crash the kernel in case of bad
> implementation, add a check in elv_register() to verify that these
> operations are implemented.
> 
> A small, probably not significant, IOPS improvement of 0.1% is observed
> with this patch applied (4.117 MIOPS to 4.123 MIOPS, average of 20 fio
> runs doing 4K random direct reads with psync and 32 jobs).

Applied, thanks.

-- 
Jens Axboe

