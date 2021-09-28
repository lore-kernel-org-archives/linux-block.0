Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07654C433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 20:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E264E613A1
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 20:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242782AbhI1Uuo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242772AbhI1Uuf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 16:50:35 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7951AC06161C
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 13:48:55 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id j15so406635ila.6
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 13:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M+Xo/keb2YtXJy85eddgsX18zAHcND62ksdduLj8W7Q=;
        b=ukZ6Qpy65n7a8ZSrEk3/MAXQY67vhafEjOJxUklJfv22GLjI+rsLBBvT6XN79n1FP4
         zhiK/XaMbaRZuS2kjInI2vIvrdlcfylBGHdIBGIRlfjagRbkPQX4MKgfzsvuLmyYzqmx
         1BwEMNR4KF2+AEXyX+idMUECeRetIjamkXK2VGjuD9Pap5xChG+joCLapFKLDeL5+Zho
         sTpKvwDqAGWU8LoK757RkQIPeKop4LG8ERpow3OTr4Iq7QpdRzMol0JtyeC1EVGe/4qE
         iqtGU7MZOypY79uCJmaLtcEeLmrFY8BSQWAQrgARzp7UcrU3y8yR0YrYN+L1RH4f+xAx
         boaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M+Xo/keb2YtXJy85eddgsX18zAHcND62ksdduLj8W7Q=;
        b=BcgnrzzX1MboiomVRI1IejuFW2M1EogGlpHl30hfx2mKrbacUytbFjYasXeFILjJ+H
         xbQlxgWDix2ToTq2o3PGTk1eqJjNo1T0h+Z8iLKDtoxfn/d1xXL1WktKmHA/gSLeBZIG
         /qd3W2YtGxfLF85ZG2z5E1gn5TivPw6xIdwjB1l60wfqSdiSQO1dEX6RI1xQhjh/28Wr
         4uD8wq7Xa2yqnx6fUJOqlcv+dDcm7nIq9MaxtxJbMPYkq8x9dEYkP5FxeIIrz1/tSi37
         AhrpZ5tgE3A1sYfQgCYl92htLGVR5RP2UyI9rPZoKzXv7GzLPD7TUjTIhh4aDi78pHEa
         ngcw==
X-Gm-Message-State: AOAM533XNJSFUAbVF6ex6TM+vwo4SseE5v08/dZwT0AGVUoJMvJXakDf
        AOVQW5QaxFjXnwV2CBAnf8F95AV/25QT2qA8hnY=
X-Google-Smtp-Source: ABdhPJz5EXPT/jtSEq0AmxNWfg95o8OGdI+tLbAU05VsymohVmQz5xrtNg/w26JHbFG5IFQpFfe1Jg==
X-Received: by 2002:a05:6e02:d86:: with SMTP id i6mr5909549ilj.28.1632862134619;
        Tue, 28 Sep 2021 13:48:54 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w4sm104145iou.42.2021.09.28.13.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 13:48:54 -0700 (PDT)
Subject: Re: [PATCH] block: print the current process in handle_bad_sector
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210928052755.113016-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <68d11c73-54e8-ac7b-3c41-c7725be97153@kernel.dk>
Date:   Tue, 28 Sep 2021 14:48:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210928052755.113016-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/21 11:27 PM, Christoph Hellwig wrote:
> Make the bad sector information a little more useful by printing
> current->comm to identify the caller.

Applied, thanks.

-- 
Jens Axboe

