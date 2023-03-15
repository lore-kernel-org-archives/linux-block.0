Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410D1C6FD1D
	for <linux-block@archiver.kernel.org>; Wed, 15 Mar 2023 12:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjCOMvP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Mar 2023 08:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjCOMvO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2023 08:51:14 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4E08B060
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 05:51:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id a2so19893464plm.4
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678884671;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgIG/N2Ja+Ucf7HrpcTWuLU7nR6eEEEbNiBav/nvW1U=;
        b=A0W6rygtI1k04oXKs5BM8TGt2/QxjCjolngVTtDbPi+GBk+zCIR/4FrY/pQxCApgPC
         mAqPG1BRoQ32kp9MB33+d600jKPIxP/XQrtPN/EGWG/Fz/RSFUY0QCKYLtsxjvjQiHPl
         9X9Psfe1e5zT2FEOoau0BLD+Q/gSRO+frcJKmRa7mHnHE1hcZwlIlvdJzruRPZZNhyGL
         WRhS6tFiUFWmLhGq+Db+wCip8Y5UUPjZVXaSl222jxBi49AxcS5LPUxCLSGV+hbTCdR8
         GWGXSIp67q4pL0mHpn2ZEpPzODgAd7LwnW0OgdHdmCyxBrLlW1uW2z0m3EdWNIVE4LEj
         uz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678884671;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgIG/N2Ja+Ucf7HrpcTWuLU7nR6eEEEbNiBav/nvW1U=;
        b=78T04CkkFT5HbLEaPnabtvOex2biV1FdzUqCXLUATev9UsaHv1OxnOXHBGF4tyenUQ
         vP9ba89YLa4sJ26iX3C9pATLtIndAENYEI2sZ4j3GYz0L+OedEbcstlploC6oUe+GzNT
         pRabOiKq9/+p9ts1ec1jBJ/z+zbLn7+3UZD1K9oOgTYsNpNV/bqEwYjFXnAkP7BgwEWo
         djMlo34+DV5Nkcg0PnAezOOBFndLGi3V2r6mGaYSa+32JFpuOJ1C0GObsN/zWUFaGjta
         Ej1S71gCnhbVtvg5UtzKkz0D7xCMnkgl2n9E4+eFHpEBPHK96Hz0+l0sTDlLbPCSgo8x
         j1BQ==
X-Gm-Message-State: AO0yUKXtRT6fGnJA1iBB3unoGOMT0p0+cLHqdqhlbnbIh3Dl4/JXccFD
        DNUIc1R8yXYQ6CwJnQsUvzZSjMOIYFicMenxGq31Yw==
X-Google-Smtp-Source: AK7set82YtRqQCY/nSw3aK9PnDC9PLZo7vHSsgiFc2q7hWx8i1oLacdXeNwr0aK02RZpz9urpDL9jQ==
X-Received: by 2002:a17:903:6c3:b0:19a:a815:2864 with SMTP id kj3-20020a17090306c300b0019aa8152864mr15315706plb.4.1678884671211;
        Wed, 15 Mar 2023 05:51:11 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id kx15-20020a170902f94f00b0019f387f2dc3sm3618298plb.24.2023.03.15.05.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:51:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>
In-Reply-To: <20230314041106.19173-1-damien.lemoal@opensource.wdc.com>
References: <20230314041106.19173-1-damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/2] null_blk fix and cleanup
Message-Id: <167888467046.25248.14770675452051243638.b4-ty@kernel.dk>
Date:   Wed, 15 Mar 2023 06:51:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 14 Mar 2023 13:11:04 +0900, Damien Le Moal wrote:
> Patch 1 is the rewritten fix from Akinobu to correct handling of fake
> timeouts. The second patch is a small cleanup of the null_queue_rq()
> function without any functional change.
> 
> Damien Le Moal (2):
>   block: null_blk: Fix handling of fake timeout request
>   block: null_blk: cleanup null_queue_rq()
> 
> [...]

Applied, thanks!

[1/2] block: null_blk: Fix handling of fake timeout request
      (no commit info)
[2/2] block: null_blk: cleanup null_queue_rq()
      (no commit info)

Best regards,
-- 
Jens Axboe



