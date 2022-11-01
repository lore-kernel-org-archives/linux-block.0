Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3EAC433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 14:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiKAODI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiKAODH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 10:03:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25161A396
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 07:03:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b29so13506795pfp.13
        for <linux-block@vger.kernel.org>; Tue, 01 Nov 2022 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddhBEEwjGBN2pLxqG4SLKRVXPUCcl6MAcVu4ReyOAKs=;
        b=hdatqqVi5pMWfjwas1wuZcI11N5SMM9facNYNFNakyKEBqAvMcEi6OJXV5cw/Xm02i
         vGTyMFJHdDDBpYnqG8XbdmW9Vu7F5jX+IqPELqRHQRsSshZg7B7sVYp79VIRiG3PSxQx
         fUshNjqWqfXNwF+PP4YKoQ2ORUGCd9Cy9pyoaq4P/3D/GXYfANQy7PRoJ5xfXZz1QFwD
         ZzvLI5tW1adb96r89rQkbIHNRL48c79gZm2Hkw4iBbeJ20d1d2TNVX1yNeoI/CODUJ7K
         NJCF/BCEOyir581Q8XAxdetC6sUMm5XGpGXXnZs+MxYo3QLfeWq5JatVS9KoJUvVPrNu
         8xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddhBEEwjGBN2pLxqG4SLKRVXPUCcl6MAcVu4ReyOAKs=;
        b=z7arHf8WFFmjsaAx352/7p/S8OtKR5g6FTUJuSusSK7PSnA6fhSK2sEcatDUjI8/lX
         M2kkBlGBNrEiOiqUoevnr9cDG60ACDrQIx8DPdfe5ExJrJHBj2bzyLZAtZWkMmP9tUw+
         GGrjSTu95ajW+EQErHdmZuIfVewJh7zN2apa+PoabnHQawN7Hj0CG2TCwO8tV2stb8j3
         zOVHVhH/KIZToQQ8CP5w32HFirInKTMMzBEljqJ2E2aC+X56V94TQ7SvEFgWv20F05mo
         5AveiCygId4xDUVkhKZU9Va3lceFbkA0z/Cn7N5WXmwGzfKAJmciCEgPvOkVfTd3f8ip
         bUrg==
X-Gm-Message-State: ACrzQf2HCkSXRgZOOUzuSn8FF90J8Y7D5Cy5UuIGQG/s58YLHCw+K3At
        WjXYWvq4RAc43VfoaLGfDoI+QOrPTy9sSAdj
X-Google-Smtp-Source: AMsMyM4zeNhHRnTZ2osYZUcgyQYIHdq0p5WPNE6lqAiHEVM7Ak5AS9zR8NRr8OkVM5nkPqdMAZB55w==
X-Received: by 2002:a63:24d:0:b0:452:87c1:9781 with SMTP id 74-20020a63024d000000b0045287c19781mr17471769pgc.512.1667311384082;
        Tue, 01 Nov 2022 07:03:04 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w7-20020aa79a07000000b0056c04dee930sm6528262pfj.120.2022.11.01.07.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 07:03:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20221030100714.876891-1-hch@lst.de>
References: <20221030100714.876891-1-hch@lst.de>
Subject: Re: (subset) misc elevator code cleanups
Message-Id: <166731138316.255508.15343969907714337779.b4-ty@kernel.dk>
Date:   Tue, 01 Nov 2022 08:03:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 30 Oct 2022 11:07:07 +0100, Christoph Hellwig wrote:
> this series has a bunch of random elevator cleanups.
> 
> Diffstat:
>  blk-mq-sched.c |    7 --
>  blk-mq.c       |    2
>  blk.h          |    1
>  elevator.c     |  175 +++++++++++++++++++++++----------------------------------
>  4 files changed, 73 insertions(+), 112 deletions(-)
> 
> [...]

Applied, thanks!

[2/7] block: cleanup elevator_get
      commit: 81eaca442ea962c43bdb1e9cbb9eddb41b97491d
[3/7] block: exit elv_iosched_show early when I/O schedulers are not supported
      commit: aae2a643f508d768b65e59da447f3b11688db3cf
[4/7] block: cleanup the variable naming in elv_iosched_store
      commit: 16095af2fa2c3089ff1162e677d6596772f6f478
[5/7] block: simplify the check for the current elevator in elv_iosched_show
      commit: 2eef17a209ab4d77923222045d462d379d6ef692
[6/7] block: don't check for required features in elevator_match
      commit: bc3caee659d70addf58dde216d10a5589ab9ec73
[7/7] block: split elevator_switch
      commit: 817b4eed4a21cda7dad3002b23901156abdb7c36

Best regards,
-- 
Jens Axboe


