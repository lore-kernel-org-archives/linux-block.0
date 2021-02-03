Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D4CC433DB
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 15:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04EF464E4B
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 15:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhBCPOC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbhBCPL2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Feb 2021 10:11:28 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F24C0613ED
        for <linux-block@vger.kernel.org>; Wed,  3 Feb 2021 07:10:47 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id z18so22417638ile.9
        for <linux-block@vger.kernel.org>; Wed, 03 Feb 2021 07:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=h+u3c1x+iHyqjckyxE0QvNhs3RUcX7XNRtl4dzwmlDs=;
        b=d1SZtbrABZKvOGJV2MIbYnoHtWphx+/ewCIL7fuHmlRKPj1tocPKQAT8HFXVoDA29d
         Qam1aGRgq1HbMuT8x28t7d6stjRPmVLHofe0mNDoNTgmA3D6haIR8NQJF1PFopiTjYNu
         NZKcnTXkk7/OZ5WTl6z2MmaiLBPgea50IJ1qYl1U3Lottnoh0B70tZRV0xCehKNi8NzW
         YsIngRnW68/A72jecsjLN/nGbjmFhogUzBQ4ZMRkbKYCdo/gkhcUJtvHZdhEpdKx72BG
         RPZMVO9qyHVB94xLS3Yl4lgfaY3Ixmu5BZGaiNDJrG8T7F+pPqwOQVAIGzg865zPXZfD
         tHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h+u3c1x+iHyqjckyxE0QvNhs3RUcX7XNRtl4dzwmlDs=;
        b=bRC5SEsskST/emylOkbGWtMwZRxZoE12tzBhJbB8oTKWfmnHaRxI52VDrgRapH6Htn
         0eKj310hCkUY2FuOnPDgKVBHzea2nJHW3fitlBPwzrA+OQ6+rJbSevARcrbLNtNX+Ccg
         Z8l1p14iT1TIKTDJl/fmWBHjxu3J0HE0FdLTvOBg+rElIzoRrIUBQLzkJhiFl3MzWxGi
         B84DBvp12JDlWA1oWcAQepTvIDuRMMrNKrgUxPHAaugNJx8z4mVj10L/uxXY04ZmXqm5
         uy1vREBkwfmbjAWvNHsePprS/JhxekOuvzaim7PPxZFUWm6HFbF8M2uIQhTy46jxOzXV
         GTfw==
X-Gm-Message-State: AOAM530BnolWbAQ16ZWwzsy2pmXvmhD0FtOXNJ/Kg2DWCiG/MUQbs5e9
        cenZV9cEZQyfML2s8P0p2oNddA==
X-Google-Smtp-Source: ABdhPJySVnNlxI70FEyqpIgJsDpyAplBdhqB7XAFWtTXlJGWK3Hsv6gG17RKX1zIL/ca3sIqfxUQ8Q==
X-Received: by 2002:a92:c26f:: with SMTP id h15mr2895008ild.65.1612365045901;
        Wed, 03 Feb 2021 07:10:45 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fd01:c087:775e:21aa])
        by smtp.gmail.com with ESMTPSA id e15sm1201962iog.24.2021.02.03.07.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:10:45 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V4 0/3] block: add two statistic tables
Date:   Wed,  3 Feb 2021 16:10:16 +0100
Message-Id: <20210203151019.27036-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This version adds Reviewed-by tag from Johannes.

Thanks,
Guoqing

PATCH V3: https://lore.kernel.org/linux-block/7f78132a-affc-eb03-735a-4da43e143b6e@cloud.ionos.com/T/#t
* reorgnize the patchset per Johannes's suggestion.

PATCH V2: https://lore.kernel.org/linux-block/20210201012727.28305-1-guoqing.jiang@cloud.ionos.com/T/#t
*. remove BLK_ADDITIONAL_DISKSTAT option per Christoph's comment.
*. move blk_queue_io_extra_stat into blk_additional_{latency,sector}
   per Christoph's comment.
*. simplify blk_additional_latency by pass duration time directly.

PATCH V1: https://marc.info/?l=linux-block&m=161176000024443&w=2
* add Jack's reviewed-by.

RFC V4: https://marc.info/?l=linux-block&m=161027198729158&w=2
* rebase with latest code.

RFC V3: https://marc.info/?l=linux-block&m=159730633416534&w=2
* Move the #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT into the function body
  per Johannes's comment.
* Tweak the output of two tables to make they are more intuitive

RFC V2: https://marc.info/?l=linux-block&m=159467483514062&w=2
* don't call ktime_get_ns and drop unnecessary patches.
* add io_extra_stats to avoid potential overhead.

RFC V1: https://marc.info/?l=linux-block&m=159419516730386&w=2

Guoqing Jiang (3):
  block: add io_extra_stats node
  block: add a statistic table for io latency
  block: add a statistic table for io sector

 Documentation/ABI/testing/sysfs-block | 26 ++++++++++
 Documentation/block/queue-sysfs.rst   |  5 ++
 block/blk-core.c                      | 43 ++++++++++++++++
 block/blk-sysfs.c                     |  3 ++
 block/genhd.c                         | 74 +++++++++++++++++++++++++++
 include/linux/blkdev.h                |  2 +
 include/linux/part_stat.h             |  6 +++
 7 files changed, 159 insertions(+)

-- 
2.17.1

