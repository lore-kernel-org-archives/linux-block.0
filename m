Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F82C433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 02:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiBQCs3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 21:48:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiBQCs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 21:48:28 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E671FFF7F
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:48:15 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so8188783pjl.2
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=orWYjDyN45vSz6ZP7TaoE7S9fDy/EIMGxQ4V5HcvUyk=;
        b=2RuiGpP1mmdsoV78PQC4UtTcr0fut8ZFELHcvxuAeEH3XfbvPJEfmszEwrgRMqjtOl
         e6wD+Y6WT9ELcafUQmLN+Gy7qIen6IxAlauw1LuYGr//bu4XIiCPpWidDRSWVfp+hDd5
         EHGrgKJiAWJGAAbwFx0V8+vQxeZHMDGJrX+Zz/+ySHt26vm2nQd1Jk+RJNLeYGDji1M3
         U/onulZhOYWvBGQ5xV3p3fl8W7QlU6cAJV0Fi2RwiY5j+RkJCxS43aUj1XbFYRhsiBMo
         62TD57UCkxKb09zzmJ5+fqE1m1ktPBFWQHOYvhwm+t2JCHG9RdIO2M+4bjeToPry1Ck8
         TRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=orWYjDyN45vSz6ZP7TaoE7S9fDy/EIMGxQ4V5HcvUyk=;
        b=2+drG++LKkVyFEbtVRbe6Fzuimd5jAd7/m6/9yezUGPrVXTAdRu8XxUFK/ZpJ0g//D
         Hfg5FjlxpFeggbTv7uESXFNR1rHp5nNQDx0lt6efn3uSQV5mYBpv59GERBxfJKSeio24
         A4nI+mOGs6dF+K7yYiuw7NrwfZSsK0GnesKDxNJPn21Z5y97zafpUoY6cYux91c8cRAe
         E9exi8f1cwRo/ySzlvJVpUw0zUkGtHfN2HQX7++cDMrpGlTtfyeNUwN+CYdCa3wMmEL1
         Ygq/CuOwlyPyVX8+SvwVI/vmkn8xvU/SoeH6MX6xSXnXW3LBkHv8puf/QZB0U1+7/bfd
         p61g==
X-Gm-Message-State: AOAM5309Fwp8pfFQz/Res3jDl+ZPGJKE2xqo+tcFQRnPSFlJWIwJrnzN
        pUP9jcpISyO+WEhLZn+boFFZbTzbeZ6JjA==
X-Google-Smtp-Source: ABdhPJy/n9IzisiaW1w6XdulKKef9hDQHYxHDkxdyvU6IU3DXQoDFOAdsqiNYeDXn+rRw3UMbTEMMQ==
X-Received: by 2002:a17:902:ee09:b0:14d:94fb:b060 with SMTP id z9-20020a170902ee0900b0014d94fbb060mr868835plb.96.1645066095273;
        Wed, 16 Feb 2022 18:48:15 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u9sm38718545pfi.19.2022.02.16.18.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 18:48:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     David Jeffery <djeffery@redhat.com>, linux-block@vger.kernel.org
In-Reply-To: <20220131203337.GA17666@redhat>
References: <20220131203337.GA17666@redhat>
Subject: Re: [PATCH] blk-mq: avoid extending delays of active hctx from blk_mq_delay_run_hw_queues
Message-Id: <164506609446.50213.6391948541288015260.b4-ty@kernel.dk>
Date:   Wed, 16 Feb 2022 19:48:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 31 Jan 2022 15:33:37 -0500, David Jeffery wrote:
> When blk_mq_delay_run_hw_queues sets an hctx to run in the future, it can
> reset the delay length for an already pending delayed work run_work. This
> creates a scenario where multiple hctx may have their queues set to run,
> but if one runs first and finds nothing to do, it can reset the delay of
> another hctx and stall the other hctx's ability to run requests.
> 
> To avoid this I/O stall when an hctx's run_work is already pending,
> leave it untouched to run at its current designated time rather than
> extending its delay. The work will still run which keeps closed the race
> calling blk_mq_delay_run_hw_queues is needed for while also avoiding the
> I/O stall.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: avoid extending delays of active hctx from blk_mq_delay_run_hw_queues
      commit: 8f5fea65b06de1cc51d4fc23fb4d378d1abd6ed7

Best regards,
-- 
Jens Axboe


