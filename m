Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D93C433F5
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 17:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA334611C8
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 17:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhKIROm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 12:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhKIROm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 12:14:42 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C128EC061764
        for <linux-block@vger.kernel.org>; Tue,  9 Nov 2021 09:11:55 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z26so6622003iod.10
        for <linux-block@vger.kernel.org>; Tue, 09 Nov 2021 09:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=L+T058xA0p0+2nUjmFze0Iv8YtMnLdkt5XkzUqs2YWA=;
        b=WdAhPHZ7hJDf0nmjljOr4vmk3QMLvKVv5RHPI5I3UMaduu+zROint2JcOlygO2xK3y
         aea19lKH+GNPIdt+ml4uUkMVzswAZVlw8DfkNGfOSjGuN6tZAiAlkVV+KtQUIE20XGBe
         iQiChWYyg1uI3UQUdTO+nzk8SEiEkRXO3bsMnoTx2jUef/1/vjMS2R5myFvuxxxaNmcJ
         dQE6LHCSh+YSPMtgcWyMhU+W8Dphj2b5raAg0qGhLevlUPcoXlXzGI1TgLPkuPnz68g0
         eQAGwk75CoCaNowkqmTuJXyJFWS87H8CDbXaTXJjUpWomErVhASQrT0igKPddYb+LR4x
         HOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=L+T058xA0p0+2nUjmFze0Iv8YtMnLdkt5XkzUqs2YWA=;
        b=7cN283yr0nRZsoktKGb1EhxULLRhxiT30TS7Q6zoRUlu9ci/ww0F44RANoYQ7qIlH3
         IDJc6KjRcKVgiiPiHysmAM4WdH67bBEX0uZbv9v+SXecumtcpHNptpbSndOBNub38I7x
         9OlMH0kRVeww4Y7NXtcbPFHaubAUzSkxCnE+/64yi0q5otTA8rrx6n17IJlIzc4wzU50
         wek1DuvE5LR52p0HH5+kyN4tea/pDbEiLUbdzbF/owwtE/FTnbg8ed1R6MeWgf2sTr4N
         La4t2mKq9FLq+Mc/ixnKmUmJdyzGj21CDYCqs6gtxy1+Zh/1GGboaQmbmG1RsetHHs6s
         Dtog==
X-Gm-Message-State: AOAM533cU10d36TigopNSh5hGF1BOGg4kyd+4WT4IRTGu5wmCzC+p2Eu
        xaswsyhBjdVxyg8RznCmkTadSchDNdxdlQB6
X-Google-Smtp-Source: ABdhPJz5cny3LoTD+rCronmq1jsGg3aAY04H6gxfPXLcIv7T/X6G0Q1BawgcIz9k74Li/1z1bGK/FQ==
X-Received: by 2002:a6b:6c1a:: with SMTP id a26mr6084098ioh.189.1636477914977;
        Tue, 09 Nov 2021 09:11:54 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l9sm12389508ilh.21.2021.11.09.09.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 09:11:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
In-Reply-To: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
References: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 0/2] block: Fix stale page cache of discard or zero out ioctl
Message-Id: <163647791409.31045.17386234356142603801.b4-ty@kernel.dk>
Date:   Tue, 09 Nov 2021 10:11:54 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 9 Nov 2021 19:47:21 +0900, Shin'ichiro Kawasaki wrote:
> When BLKDISCARD or BLKZEROOUT ioctl race with data read, stale page cache is
> left. This patch series have two fox patches for the stale page cache. Same
> fix approach was used as blkdev_fallocate() [1].
> 
> [1] https://marc.info/?l=linux-block&m=163236463716836
> 
> Shin'ichiro Kawasaki (2):
>   block: Hold invalidate_lock in BLKDISCARD ioctl
>   block: Hold invalidate_lock in BLKZEROOUT ioctl
> 
> [...]

Applied, thanks!

[1/2] block: Hold invalidate_lock in BLKDISCARD ioctl
      commit: f275c2aa4b47f3056acd182f2ff752cace21d8a5
[2/2] block: Hold invalidate_lock in BLKZEROOUT ioctl
      commit: 4b4d8b9375582b90f4fd9c708c739593e3a44946

Best regards,
-- 
Jens Axboe


