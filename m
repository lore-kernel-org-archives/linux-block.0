Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6815DC433F5
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 13:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C83D61221
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 13:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhKSNbi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Nov 2021 08:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbhKSNbh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Nov 2021 08:31:37 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D538C061574
        for <linux-block@vger.kernel.org>; Fri, 19 Nov 2021 05:28:36 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id j21so4656919ila.5
        for <linux-block@vger.kernel.org>; Fri, 19 Nov 2021 05:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=XfIBwGswpTXAAmIcv+zJjuj9NfvN0Okn8rKYDi2VxqA=;
        b=ARPVu5GFDyujuH9c87bJ8zn1EUV5y3KIXLPSvd5sHysYdfoLRGfmZWNLFmrPWbJiCr
         2K9EYaQtWxJyMilQAu8FG98ENR5yxVUls6J+OLL60OxjbdvLdNDVnYoDPSr1MUqTzVoC
         xXre9gHSFHhgErzSwJI0PFLcLXoNNSCuiAgSx7eu8LvutuUWwQQxxe8+hanIvh705QV5
         ZvgE5GANriRuvrrDJOMjyR8KnDwLClcJVN9B2+mTtT7+49ngjRjJ+xVi3B7kj7MjgyI0
         qcr6I8GQYRKAdYB/XQsgzIzZfWcYdzHsURL9wW9+GQW9USWDZcE6OrIqyqDFLNIteia3
         rPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=XfIBwGswpTXAAmIcv+zJjuj9NfvN0Okn8rKYDi2VxqA=;
        b=haL0F5uecNaDuhYWjGy1QxrcLPD+ur5Qzio8zq/7wPtKwoNvSc64jB2NfIuFXXxtV2
         rJBuFWW0/ZxNPZIXi7fNHN299D5hRVZ7kKDz9czYE/jpyQV6qn6KMXY9GHjpapeti2VH
         WqvmiGK1x0rDISWtHp2p4wJF0MRQYJRC45g+f+KQwbxgi8C3lnanTVI8AJqFNIL2Ynow
         YnZJWkGNzy9PH9zxjbVbphK1fLWEQjznEg4644D1uTzeKd011jj2tN+3jOAB/KKGuvXj
         Su687UNw1BArV5dSjKlwFfbG1hbxOAvr/NtHhO4lh+3bJ2EvDxelrkPDHxDM1Cp7Q2sF
         TqXg==
X-Gm-Message-State: AOAM533bN/Ugr1LN6xaVvqZcTKqNvRcNKy9mtaFDkJcCLKSRvAApB/jc
        xoElpSDOPPRI+StfpSxEhQRovh+e8NNcOklA
X-Google-Smtp-Source: ABdhPJxhCpdFjDnTiVTMuBhqstDA/l7r8udjQ7kGpvECq/gXiDvgXdza7VP53jq1+6+vvQKyCL38lw==
X-Received: by 2002:a05:6e02:174e:: with SMTP id y14mr4850987ill.89.1637328515354;
        Fri, 19 Nov 2021 05:28:35 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id q13sm2156678ilo.25.2021.11.19.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 05:28:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
In-Reply-To: <20211118153041.2163228-1-ming.lei@redhat.com>
References: <20211118153041.2163228-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: don't insert FUA request with data into scheduler queue
Message-Id: <163732851304.44181.8545954410705439362.b4-ty@kernel.dk>
Date:   Fri, 19 Nov 2021 06:28:33 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 18 Nov 2021 23:30:41 +0800, Ming Lei wrote:
> We never insert flush request into scheduler queue before.
> 
> Recently commit d92ca9d8348f ("blk-mq: don't handle non-flush requests in
> blk_insert_flush") tries to handle FUA data request as normal request.
> This way has caused warning[1] in mq-deadline dd_exit_sched() or io hang in
> case of kyber since RQF_ELVPRIV isn't set for flush request, then
> ->finish_request won't be called.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: don't insert FUA request with data into scheduler queue
      commit: 2b504bd4841bccbf3eb83c1fec229b65956ad8ad

Best regards,
-- 
Jens Axboe


