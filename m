Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C84C433F5
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 15:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349784AbiA1P6s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 10:58:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349778AbiA1P6p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 10:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643385525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=4mmE2BDklC4kbyMzrXLJtoHLPinScMnYfFrJMWf1e+U=;
        b=YiU8i5vPggHHv9jTk1U0uyFvbrgmBgukg5RRC/ktn5gvxb83b9s1eSpc2eVNQIK1wdFCCw
        +KZdwm9EDN52ORO2BweDCrHJFK6Iiev40S3H7lL3ZP73KbnBeewkQP2DXF//Ses0lWuME2
        J6bkVygE2R29cQo5+UWz1MZgbN+LpKg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282--irWfNuOMqqm9A1qPL2bmQ-1; Fri, 28 Jan 2022 10:58:43 -0500
X-MC-Unique: -irWfNuOMqqm9A1qPL2bmQ-1
Received: by mail-qt1-f197.google.com with SMTP id e14-20020ac84b4e000000b002cfbbdf8206so4819105qts.10
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 07:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4mmE2BDklC4kbyMzrXLJtoHLPinScMnYfFrJMWf1e+U=;
        b=o8J7f3uOODRGkB0AETfvs3Qi5Ml4n68h0KPRgY9KZzAPYcVjeYlHPRB8FLCQiXiphq
         nGQRAr5KKpJ+0Nc+gANOr5bNSqBbeSJMCCUxFdOuBrMf//l4h+GKD1OoPz6vepS2obOb
         0R7ydW6Tm0jz4m1CJ1Dc/LCEPVBNVW14uwsm6AHlNbv5OO3nvX8/lTKDdEFv/IhZFsIC
         yaQhSbOGGq+qG+SEaidTO34sjodGQ9N9XtQ+HOgaW7LtA0GwjTdy8AfD74ViiXUV571O
         jQhitwn3Mr7nVyzP6XyPcvJ+WddLj26m+1Teyg01ziieu42UTiKrxLuIxoW/uwI2BCYS
         5pZw==
X-Gm-Message-State: AOAM533WQx637RtjpULFmmuNI7icbjO+sKsHVpV+FfpfXrIMYnfNvg0Q
        e73Ogq7/R5xVW3nJD2s2bwNZDKi8x6YiHvZWxkXiSEHkZy8qc5Lp400fAQCpXHe5PJEGYxAKM5X
        I/HNw9ZmTuBTRoUTfDlV0Yg==
X-Received: by 2002:a05:620a:1790:: with SMTP id ay16mr6070288qkb.330.1643385523337;
        Fri, 28 Jan 2022 07:58:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1Sp8T3UlIDPcX8b/jwkTUzeQeOx03Ve8v0cn9k0JmN8doT4Ho3uDIdTRk9+2Xvyywgk7lgA==
X-Received: by 2002:a05:620a:1790:: with SMTP id ay16mr6070276qkb.330.1643385523160;
        Fri, 28 Jan 2022 07:58:43 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id o10sm3457427qtx.33.2022.01.28.07.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 07:58:42 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v4 0/3] block/dm: fix bio-based DM IO accounting
Date:   Fri, 28 Jan 2022 10:58:38 -0500
Message-Id: <20220128155841.39644-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[this v4 is final iteration, should be "ready"...]

Hi Jens,

Just over 3 years ago, with commit a1e1cb72d9649 ("dm: fix redundant
IO accounting for bios that need splitting") I focused too narrowly on
fixing the reported potential for redundant accounting for IO totals.
Which, at least mentally for me, papered over how inaccurate all other
bio-based DM's IO accounting is for bios that get split.

This set fixes things up properly by allowing DM to start IO
accounting _after_ IO is submitted and a split may have occurred. The
proper start_time is still established (prior to submission), it is
passed in to a new bio_start_io_acct_time().  This eliminates the need
for any DM hack to rewind block core's accounting that was started
before any potential bio split.

All said: If you'd provide your Acked-by(s) I'm happy to send this set
to Linus for v5.17-rc (and shepherd the changes into stable@ kernels).

Or you're welcome to pickup this set to send along (I'd obviously
still do any stable@ backports). NOTE: the 3rd patch references the
linux-dm.git commit id for the 1st patch.. so that'll require tweaking
no matter who sends the changes to Linus.

Please advise, thanks.
Mike

v4: added Christoph's Reviewed-bys. Removed READ_ONCE from patch 3
v3: fix patch 3 to call bio_start_io_acct_time
v2: made block changes suggested by Christoph

Mike Snitzer (3):
  block: add bio_start_io_acct_time() to control start_time
  dm: revert partial fix for redundant bio-based IO accounting
  dm: properly fix redundant bio-based IO accounting

 block/blk-core.c       | 25 +++++++++++++++++++------
 drivers/md/dm.c        | 20 +++-----------------
 include/linux/blkdev.h |  1 +
 3 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.15.0

