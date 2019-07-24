Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F8BC7618B
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 11:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC73229ED
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 11:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="P/Uz1vqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfGXLsn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:48:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41612 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfGXLsn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 07:48:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so43428313wrm.8
        for <linux-block@vger.kernel.org>; Wed, 24 Jul 2019 04:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ja8qOZBd/+yPpakrfgGOO9Lsjgvj3+ENbjktOu7PQg=;
        b=P/Uz1vqQq8oTd7cuw88+8LKg4UMpx/GPMqE8FjyIKrALHxccYwxrrS5IA0bnYBWN2z
         AiPq/PW8v6DI6Rj+Fta0BYE0v7+XUbhdpjc3/s3kijRktL+u6AdV6STGtga6cTCBSiqt
         k2V2MxsWYugo60P9luWE+sT/58/mo9CpZx1it+vKxBV5qljjcO6F+gIKzTGPCHqa+R/U
         ga2kJT5ZpI6bXSb6sUsAROUihfuMumxnDD+RA3pNVCZqpMso+DHB/NIIrH3AM4EvcIKX
         8nqTtsWPpihGh7iIzDYcoCGE1273gk6xYTy865HsxclPsMHiYhBEZUqE6/SwHX+oDrZ6
         UjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ja8qOZBd/+yPpakrfgGOO9Lsjgvj3+ENbjktOu7PQg=;
        b=VgxAzlM4yZ4kxi3iXLcn5AKKRxjzKT8mVjHrWycdCfeRoQBun8vTBMaq9UnGfxlpdc
         9xWqQxv+2tDTcI8dJaTgANA63EmlWqFs6/pUkbYs4vVg8Akocm+Q23cCYNI9YKVJ2cSi
         pxgWKDnN20cPRI8WmZ/qmoMNIGtFTpz4U1nDkcW93hPtQHHzeFfPLaX9CVy2DDWzQuuV
         tIZVN1NLymGHAD1pbWuHnAZT6pWVSSOCCCpE/kMprjMwG7bpmAE8DLkYWJzDqATHLdTt
         Zb+KHa34lEpNqEAVMP4BCfsRG8quq9ybwuOL3OXrtHLdkMx1B6KrBn2p95vxXvDFJasE
         l4WA==
X-Gm-Message-State: APjAAAXpE5t2J2YOEICfXf7QtInoTW+2WdmGx0VJm1aRUYP0wKjNNdLW
        h2fln6gagNhRFICwdW4qHLJXMA==
X-Google-Smtp-Source: APXvYqxtbimswj1+iqEbPXS+959hF1x39IRwg6ckgQ3h6RiygXt2444TSZdS5jTfDlL37IKCtELZKw==
X-Received: by 2002:adf:e883:: with SMTP id d3mr91261045wrm.330.1563968921330;
        Wed, 24 Jul 2019 04:48:41 -0700 (PDT)
Received: from localhost (static.20.139.203.116.clients.your-server.de. [116.203.139.20])
        by smtp.gmail.com with ESMTPSA id g11sm46247726wru.24.2019.07.24.04.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 04:48:40 -0700 (PDT)
Date:   Wed, 24 Jul 2019 13:48:39 +0200
From:   Roland Kammerer <roland.kammerer@linbit.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH 1/2] block: drbd: Fix a possible null-pointer dereference
 in receive_protocol()
Message-ID: <20190724114839.fl3ldycrn3zwfgaw@rck.sh>
References: <20190724034916.28703-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724034916.28703-1-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 24, 2019 at 11:49:16AM +0800, Jia-Ju Bai wrote:
> In receive_protocol(), when crypto_alloc_shash() on line 3754 fails,
> peer_integrity_tfm is NULL, and error handling code is executed.
> In this code, crypto_free_shash() is called with NULL, which can cause a
> null-pointer dereference, because:
> crypto_free_shash(NULL)
>     crypto_ahash_tfm(NULL)
>         "return &NULL->base"
> 
> To fix this bug, peer_integrity_tfm is checked before calling
> crypto_free_shash().
> 
> This bug is found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Roland Kammerer <roland.kammerer@linbit.com>
