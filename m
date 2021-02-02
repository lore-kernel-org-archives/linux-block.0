Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB2AC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 03:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B9264DA5
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 03:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhBBDLE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhBBDLD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 22:11:03 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997E1C06174A
        for <linux-block@vger.kernel.org>; Mon,  1 Feb 2021 19:10:23 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e1so17737451ilu.0
        for <linux-block@vger.kernel.org>; Mon, 01 Feb 2021 19:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bh/yPaYykxJvP+tNpPFp99QRxjgsKGKp9M92I6o/4Rw=;
        b=ii9RcOYKm3lmLnKk13hGsdfK4H4rx3nxZECzIXMqJVr/dZVpWwmuhkUCaDTQsC/og/
         A12Rug1oE2XGCpOxCFY6/MClnj8XZA+3YYIdN9WhUpLCTGtEDC//4/w2XcfAwCn7KyCu
         T3vdSOz2TerRXzY4pWVJIu8lnE0rc/t0c/hfD2oj/L8cSOxG7gfiloS0ffZrr2Lfrv7j
         KsYR3fKQVTvxTO/TfzUSq0UGopbJVD4DLOt4j+rL5CugCEV7djphTUs0gCcUkVJXLEM2
         +v2FeM8kSGWA/9iAxgki9EfXUHG7OHvQCCfdp82a98y0hc1DOBVl0JndiZ9M5HCx0joi
         Ugkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bh/yPaYykxJvP+tNpPFp99QRxjgsKGKp9M92I6o/4Rw=;
        b=YLivAzz/pJPqK1+muzMOvIf5Ssszbd9i1pxQxRz66Yk7q/KW5OMbSB+IZzVwGfkRU4
         Q0EvxAW1UzOGQCR722vBK1m42VH+ND/+cBFK6xABt+FsCS8U2V4hf4Mb43WI8mnM7R9k
         KrCXy7Yh7s3cOeWJ6/+YmXzmMs/ptVrbhBQ+p11zVvOP+uYASTF33T89tdWW5s8JVd/1
         g8rkte8ltOxrQGT9+VyZuITCwtU4TYoS+7ataZlMHT+V3jPx/cuOXLZhVbu7wruvX5Dt
         Tm3bYG7zQAqo5RbmI5/muRxjAIUiPIJKm+szXVWhmq7DGyLn1yANp4+H9niW2TLXSL6M
         totQ==
X-Gm-Message-State: AOAM533I3Ncvzb+Xsv1Rj9hKe4JCYgOkrcn/UsRMLdj8ChjV1Wh07WEz
        vlCjAhkdmtqXuuqAx14J4bXDrpGj6YszsrI9
X-Google-Smtp-Source: ABdhPJzD+5/8wUUSXFSlaH1nSrDLFs1qibDsdbYSUCEFeHYjvbwUSIiZ/pqeOcZTuWMvFy8zUGiOtg==
X-Received: by 2002:a92:404d:: with SMTP id n74mr16521367ila.88.1612235421841;
        Mon, 01 Feb 2021 19:10:21 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:c05c:3bba:187c:cddb])
        by smtp.gmail.com with ESMTPSA id q5sm9099307ioi.43.2021.02.01.19.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 19:10:21 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 0/3] block: add two statistic tables
Date:   Tue,  2 Feb 2021 04:10:06 +0100
Message-Id: <20210202031009.11584-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

I reorganized the patch set based on Johannes's suggestion.

Thanks,
Guoqing

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

