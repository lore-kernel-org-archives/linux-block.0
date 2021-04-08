Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A371C433ED
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 13:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6440E610E5
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 13:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhDHN7J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhDHN7J (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 09:59:09 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C58C061760
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 06:58:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x15so2280377wrq.3
        for <linux-block@vger.kernel.org>; Thu, 08 Apr 2021 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pALRHDHF/BJgagDE1YxlO6csX9wiYGY21Mo2+HUxi6A=;
        b=hdy1WPMRroV0Zvhdh8oXXtKy+KWNUE3Ab/yf95tHHQQWv/d5Ta6fGU4Jp++1F4e2Kr
         7djVHyrYW7CH3pesG63jvVsmoRwrJcZg3TIFV7Xj/NhzXCROVPWX3owg6bGAPkUpFIbm
         mK67aLJYUCk+ki97FpvIDIKwdl8X8mCAaLqxPfFFWyrsZ80iIuiNyOw5K4aMrcN6nr8E
         /WLfDJqi1XtMsAAIVe31D1a0Rez2umxjVQN7jUhLWdqTzj2JvWQu1e732DReBYrBS/8P
         hop2XnJ9vaz/1wS+WvcSFAdjkqis5qu8sdSWC4oWF2yUql5dF8J7vyyzcYTicERO3aFC
         rprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pALRHDHF/BJgagDE1YxlO6csX9wiYGY21Mo2+HUxi6A=;
        b=AiJJQz7C/QQhlC5r4XD1ArYcG2eB/MZfa1qpYrxaIQYkNIV318mV0H/8guzkV04hDz
         RhRzhm16rEfUFdwFLFCN7cp1gBj1LMip3QYeJtLvKAHr4/laWwFBZO7t+CZ/ebtqkU2r
         s6jRKcISLh9hIYmCjSHOfjVSGf+Z2wWC/z+Io/BAQOCZsiiFOrDwanD8hw1TuM9HUxb8
         SXtioS8dd62Z8XXUvlUWghXUNjAlZXfwcU39qk/3ok2UKv4TPhB+hIWjaZOdj+q4XQ4g
         32dHFiSsNe3KbIEaNLvDSaf+UZaG8Ie5UxtJVRoSEABbcBDKFF7VZngSPzGFOxQQQbsR
         Q7Tg==
X-Gm-Message-State: AOAM530Ao3iHn0ehpl2V9JxD8xQgkknWStDkHZUGWm/N5cH18ak1/4tk
        YGjWG2Kugba/H0WnvRa7nBKwHw==
X-Google-Smtp-Source: ABdhPJzPyfrn6WnphChm2jWh4eFqF7BwgLOvoyAJuAaJ/7/FB9uJT6D9sIktl7ff7klALT+xyv+rTg==
X-Received: by 2002:a05:6000:2a7:: with SMTP id l7mr10853700wry.413.1617890335879;
        Thu, 08 Apr 2021 06:58:55 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:5dfa:e648:2da1:1094])
        by smtp.gmail.com with ESMTPSA id c6sm45080294wri.32.2021.04.08.06.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:58:55 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, jinpu.wang@ionos.com,
        danil.kipnis@ionos.com, Md Haris Iqbal <haris.iqbal@ionos.com>
Subject: [PATCH V5 0/3] block: add two statistic tables
Date:   Thu,  8 Apr 2021 15:58:37 +0200
Message-Id: <20210408135840.386076-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This version is rebased against the latest for-next.

Thanks,
Haris

PATCH V4: https://lore.kernel.org/linux-block/20210203151019.27036-1-guoqing.jiang@cloud.ionos.com/
* Adds Reviewed-by tag from Johannes.

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
2.25.1

