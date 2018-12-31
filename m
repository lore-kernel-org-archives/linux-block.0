Return-Path: <SRS0=5hX+=PI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54633C43387
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 17:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DB22133F
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 17:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="e0ekLYtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeLaRUI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Dec 2018 12:20:08 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:36736 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeLaRUI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Dec 2018 12:20:08 -0500
Received: by mail-pl1-f169.google.com with SMTP id g9so12832502plo.3
        for <linux-block@vger.kernel.org>; Mon, 31 Dec 2018 09:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pvsk2FxQRsHKJLA3eBX85r+qMuPjuQlru16o2peHBlQ=;
        b=e0ekLYttFnT1NQ1YxE0rKRE8rxZHvoMNkfv+HfNcs5ENtOABf2xbtQqooJ8c9s/6Ix
         2M/ztPXKWu2Wk+ANmiIKXoHPRt97T3cNOwW5OPaY7zjH1ca6nIjhP6LfDCkCGMQtQgWu
         pHuTRE2aj3iOMnbVUOMs0P1LKHVZ3wDwiQhIYY6wNb4OzgWLSnDv7vwx6m0LnxhjQa6l
         sYT4s2V94yIzYea+kHjccjQnneg3paDXKrVcU2e6mek1+eiraNVQhCM9tdZRBP875W0k
         QHDI6cyGLXLjGmNuEbyrb5AW+2Z7zUrEbE9fBrIVfVDUdzjLMpohT5mhUDe2cces8bia
         EUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pvsk2FxQRsHKJLA3eBX85r+qMuPjuQlru16o2peHBlQ=;
        b=Pw4E6bmnDSpqMspSfbp9J9hDf9/njPu5S8+PFGj66DqsRp+9GGkU+jvyuV582Yr8Pf
         cRydKq5Z/cA1xDwMMFXzSLqZ2zSHSI8Mg+tAa1Fz4yGjqXP+ME4gum6C5A+HHsLTKDQS
         5qOm47prSKFYb2+DHQkUgJtTcMk/6W5u4qjClv/N8gSMLko46lhFF64b0qHCmTb4ZRMf
         Z36mI4wXovWfsu5WH7iMVvIRI/ESCm+pDQLSZWuHcTiOwrO35LtbaEjgYqUhlKbEUHZD
         XGjMRuCrRHGaGGULEcNnLIben0qg/mMbIfFAP9A0kaYR6OvtiaEvglnLpUPjUDEzhxj5
         sTCA==
X-Gm-Message-State: AJcUukfpSqd6BdRPa2aLSvK3tbX+bP5LRPcZUDe1bgn112CD6MDRgLWn
        bZByp4CMLlX7QxitF1wjWlsaAw==
X-Google-Smtp-Source: ALg8bN43Zvakz6S+5js+fOB5JNo4pvpSRdaq89BbqyORRdaTGa+BMqhpiDbhWSvgYycyhN1BMFsSkA==
X-Received: by 2002:a17:902:bd46:: with SMTP id b6mr37452482plx.231.1546276806912;
        Mon, 31 Dec 2018 09:20:06 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id r4sm97843514pgn.54.2018.12.31.09.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 09:20:05 -0800 (PST)
Subject: Re: [PATCH] block/amiflop: Don't log error message on invalid ioctl
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <980e56c9dd86f2f94ea1f33d8b6cb27fe10ca436.1546235049.git.fthain@telegraphics.com.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <43d150c2-01fa-0853-549d-8559a9199e3a@kernel.dk>
Date:   Mon, 31 Dec 2018 10:20:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <980e56c9dd86f2f94ea1f33d8b6cb27fe10ca436.1546235049.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/30/18 10:44 PM, Finn Thain wrote:
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Applied, thanks.

-- 
Jens Axboe

