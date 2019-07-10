Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5718C74A36
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8968208C4
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GvsKldwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfGJUGA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:06:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36431 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfGJUGA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 16:06:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so1749747pgm.3
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 13:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pLOr96dXlNzqjUscpra/v6MUR3Ix33OqtE6AS3rg8Io=;
        b=GvsKldwPrGY11/Fp7KuBL/3O9lVprXu4Jz8BbyjN1AiSQoKAkd71TGZuAnUamjRnq3
         seDpYKckejq0TmMeydN9Nj0VG0AL0yTZf+OTjcyKJagzzmflug8PqTIUYsu6/QfXB5ye
         gthntxSLGf5sodD51CFQI1KPHVwN/aXVDbmpTOChUK4GRWCtow9AdToeNLZxv2B7iEoG
         nO6UN36cLPaowjf4hVqqeD7JnYt4/zHLT5GkmcWyI+hJuaGqohGst1tnnMM3o6CaV3x3
         LSiTqts396hHFb9eln0qXWi3lYgR+iRFO5DpglRsQunTiPtga6vuGe5YrCeZd/tcZflH
         XNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pLOr96dXlNzqjUscpra/v6MUR3Ix33OqtE6AS3rg8Io=;
        b=c1h9NJkS1fpL7Gd9yop6iyEXFTDJuLZXxaA15ZjYTVW5EDaqroNPL0vIscDd0b6SDH
         6hI9QEMQrronbViSciuWUPU+eDMzTybDiYgjdUitO6gRuBloRPUv0ESAph5yb9Fu1jCr
         ABjgBBRD/5QPLstW0Au+ww0nDQwHunJXwunGYImTyliRfdTbAOFtkui74lRq/hUqPhk0
         ZmQY5xK6fA0vLb1vnvw9SC39t3OMwWsWpcHQZffiQYJt9WwRD2EiHK7ZmuGCEdKsF+nu
         PAgZmyqLoLFrDai5LRRkq4Pk+PhA/qr88rShRTUCkhZ82HVGgphG4eedekbQUAHpRZ7n
         akjQ==
X-Gm-Message-State: APjAAAWWu7PYL5dRImAdClVG/NpvXtDmg46wZioZwmYW8PQo6Yayhi+E
        Zx+fBZSVxiS2TKwDL9Tb1qorNvR3GlR+EQ==
X-Google-Smtp-Source: APXvYqyMPM5vi+QtGnBil0/SmoWYOlcmYU8UR11SXijLTjb9FKeXHUsMYsr4Kw4nwnD+i/p9a9pBqw==
X-Received: by 2002:a63:1f47:: with SMTP id q7mr53678pgm.264.1562789158842;
        Wed, 10 Jul 2019 13:05:58 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id m5sm3502565pfa.116.2019.07.10.13.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:05:57 -0700 (PDT)
Subject: Re: [PATCH] block: Remove unused definitions
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20190710155608.11227-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <92b1cf2f-8744-a2f5-6d41-1cd878220bb8@kernel.dk>
Date:   Wed, 10 Jul 2019 14:05:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710155608.11227-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/10/19 9:56 AM, Damien Le Moal wrote:
> The ELV_MQUEUE_XXX definitions in include/linux/elevator.h are unused
> since the removal of elevator_may_queue_fn in kernel 5.0. Remove these
> definitions and also remove the documentation of elevator_may_queue_fn
> in Documentiation/block/biodoc.txt.

Applied, thanks.

-- 
Jens Axboe

