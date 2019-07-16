Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A83C7618F
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 14:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC01720880
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 14:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oB+KUHUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbfGPOFX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:05:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40769 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfGPOFW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 10:05:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so9502788pgj.7
        for <linux-block@vger.kernel.org>; Tue, 16 Jul 2019 07:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aoVagbFNhgXjrt3W/Zg0iqvw808Ej48g/8edVM2FIxY=;
        b=oB+KUHUY8jt3xmhaIq2rMBhWkYYVxc9eFPInFzebpABp/zB+uYCQgZ3glw+vyYLnV/
         2mg0EhT075HTjuRnRbAKJuaqPU6ib+K895FCPnCxGwszWDGOVKc/wfSnREM+UVMRqXuv
         ZnK5puZMup9/KjRqYLNSRS01VzBq4dGdDSRsonnY3FhPNMMziuHRz/Ej0PvtLCYFO8fn
         f78ZjcEb4EYtPsZ22IkAKG8on/FD308r+91bk9uDXS/bIliBn7bIFfX7rXQdNq2RpHUI
         lyg4akf0G03slJn5OrL6b2iISkyDq+PBy/dQYwKhRTaUFQ7GjaLqGsS6wAOseBsIwewQ
         Fd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aoVagbFNhgXjrt3W/Zg0iqvw808Ej48g/8edVM2FIxY=;
        b=j8Lo2WITgg0NUyxEzLIjhZCIUDIqJfgwOtBL88BdQYPLDvYpUB7PznSSJvSAnNmm5C
         ItkdtfQz5j0ELQgRVo4nj0kEVQX30K/rCTiEXO0GV5aLhWKYvpgqTNmhR3swgoi5hONJ
         K6bBiPjeqr9DEb1mQsKTPu6yN8gvGkoBOt5hwzJjHSosXdHy6N2mCQ3XHzvlZ5S5cF7c
         gQakLHAh1jNToyFVC5wfytVDF/srLaWAUVBYf03K1ixqUfW0QSleSW/9NodfKxAsFo8J
         rngMUWyFjfSH64nzADOOi7T8h76V3LQ3M8YPga0vpVyk3loaK6QqXTvgoatETka9WmEn
         RyEA==
X-Gm-Message-State: APjAAAWg2DwgXMjYpXxf9fFHUl0NO6kxrk2Wmp0A5ZPTvaV/WKesezLV
        throYmUaOUgNyUYEe7xjP1M=
X-Google-Smtp-Source: APXvYqzjx0xWwCczyNCO7AxzI9Vek3/4hKvb7RI6GhrXm06aGJFLjKM6citOIZnYOh4ngmsyCA3uRQ==
X-Received: by 2002:a63:9318:: with SMTP id b24mr24121376pge.31.1563285922055;
        Tue, 16 Jul 2019 07:05:22 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id i198sm7788161pgd.44.2019.07.16.07.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:05:20 -0700 (PDT)
Subject: Re: [PATCH] scsi: sd_zbc: Fix compilation warning
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190715053833.5973-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f4812ac1-dfae-73d7-4722-4158c38d2382@kernel.dk>
Date:   Tue, 16 Jul 2019 08:05:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715053833.5973-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/14/19 11:38 PM, Damien Le Moal wrote:
> kbuild test robot gets the following compilation warning using gcc 7.4
> cross compilation for c6x (GCC_VERSION=7.4.0 make.cross ARCH=c6x).
> 
>     In file included from include/asm-generic/bug.h:18:0,
>                      from arch/c6x/include/asm/bug.h:12,
>                      from include/linux/bug.h:5,
>                      from include/linux/thread_info.h:12,
>                      from include/asm-generic/current.h:5,
>                      from ./arch/c6x/include/generated/asm/current.h:1,
>                      from include/linux/sched.h:12,
>                      from include/linux/blkdev.h:5,
>                      from drivers//scsi/sd_zbc.c:11:
>     drivers//scsi/sd_zbc.c: In function 'sd_zbc_read_zones':
>>> include/linux/kernel.h:62:48: warning: 'zone_blocks' may be used
>     uninitialized in this function [-Wmaybe-uninitialized]
>      #define __round_mask(x, y) ((__typeof__(x))((y)-1))
>                                                     ^
>     drivers//scsi/sd_zbc.c:464:6: note: 'zone_blocks' was declared here
>       u32 zone_blocks;
>           ^~~~~~~~~~~
> 
> Fix this by initializing the zone_blocks variable to 0.

Probably worth noting that this is a false positive, and even if it is,
include a Fixes: entry as well.

Otherwise obviously looks fine to me. Martin, do you want to pick this
one up?

-- 
Jens Axboe

