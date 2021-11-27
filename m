Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3775C433F5
	for <linux-block@archiver.kernel.org>; Sat, 27 Nov 2021 16:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347000AbhK0QJr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Nov 2021 11:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355398AbhK0QHq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Nov 2021 11:07:46 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22B4C061746
        for <linux-block@vger.kernel.org>; Sat, 27 Nov 2021 08:04:31 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id b187so4156634iof.11
        for <linux-block@vger.kernel.org>; Sat, 27 Nov 2021 08:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6gEzggS/SNiTxE1Mw/WTJYP8e0XPDcQofR9+8vWZpss=;
        b=1C4/3gvEGBoS4Xi5mGoT8/nJs01juaR0OIP14nrgMZWfpi1Eit5mNc1WxtDntDGLFr
         FPuqYATKQLfoJf0YT1fyrX3amFBJglONBRDbSx3UkAzASY//2YEi8WpiT+cfkvqLeVPA
         8YmNpbY4ey05VeNNASxev6T2HijyStOcuSYWU+pE7geKgdpWUT4eRa9xOYQ6GLmc+JvL
         k35yJogCUbh+U3pC+QOIOLbdTqcTP+yYvOEEmlc8UaTPn2XIarNoCZxUYvEtNJU4S2Ec
         PQWI9B5WD0oS2wOR1Er1vg30Vb5LR9IPCJh1wsyBBElpdkIZ9+hVrZUtuEqykzfRnJCs
         YuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6gEzggS/SNiTxE1Mw/WTJYP8e0XPDcQofR9+8vWZpss=;
        b=K5jI4V5fxNZxeJglrr9eadxeQY2QBWau8+K3I2MzL6QSbokIwVpW0yosKdmjKrRXLf
         5qtQZ8TkxsOIPHqhs2X2Tqegg1KOLC548HcDNs/UprN5JVRqxM2vMWONH/2qUnABkEnN
         yPfYRGgOlRmhEcVFIz9CmFrNQ/2RVtPL35KXrJurBFn7Qemm9+Xebuzz7VNf6Z9fdERe
         3YhlVMjPSSAaHE5Yt1Pymyo8e60rhYcPHQSgJ/OSI6/QEipjpJbcpfI4uH2ftLUdjLGt
         VkKPWa3w9i4UL5yW43AC7yhFOtBxxByQ0XYUk/0+G115xvV9juikTRMckw6V9J3oiByT
         zy3Q==
X-Gm-Message-State: AOAM532JZtdtWTLTvZ7TAgF0brKU+Ibz8yIAYDFAryPLOy94X5G5ifUk
        Ap0u+YAd9DpOkaSQXTuGN17/XBzQExsBod9j
X-Google-Smtp-Source: ABdhPJx018rKThEkMD7ZVFJL+of+NMUj3fuNwO7BbK9JdZ9afMruZJ4J8V6er1EvrlTE1RDd/fWhtQ==
X-Received: by 2002:a05:6638:1648:: with SMTP id a8mr57259098jat.92.1638029070802;
        Sat, 27 Nov 2021 08:04:30 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j21sm5020077ila.6.2021.11.27.08.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 08:04:30 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block followup fixes for 5.16-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <def53d9f-f655-3435-6804-be4482816eed@kernel.dk>
Date:   Sat, 27 Nov 2021 09:04:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Turns out that the flushing out of pending fixes before the Thanksgiving
break didn't quite work out in terms of timing, so here's a followup
pull request.

- rq_qos_done() should be called regardless of whether or not we're the
  final put of the request, it's not related to the freeing of the
  state. This fixes an IO stall with wbt that a few users have reported,
  a regression in this release.

- Only define zram_wb_devops if it's used, fixing a compilation warning
  for some compilers.

Please pull!


The following changes since commit e30028ace8459ea096b093fc204f0d5e8fc3b6ae:

  block: fix parameter not described warning (2021-11-25 09:32:19 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.16-2021-11-27

for you to fetch changes up to d422f40163087408b56290156ba233fc5ada53e4:

  zram: only make zram_wb_devops for CONFIG_ZRAM_WRITEBACK (2021-11-26 09:57:32 -0700)

----------------------------------------------------------------
block-5.16-2021-11-27

----------------------------------------------------------------
Jens Axboe (2):
      block: call rq_qos_done() before ref check in batch completions
      zram: only make zram_wb_devops for CONFIG_ZRAM_WRITEBACK

 block/blk-mq.c                | 3 ++-
 drivers/block/zram/zram_drv.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
Jens Axboe

