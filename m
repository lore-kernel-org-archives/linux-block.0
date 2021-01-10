Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683FDC433DB
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3035F2388A
	for <linux-block@archiver.kernel.org>; Sun, 10 Jan 2021 09:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbhAJJqA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 04:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbhAJJp7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 04:45:59 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4FDC061786
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:45:19 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id 6so20461196ejz.5
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 01:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2fKiWu08zz/rNPgvgctFY8RMsqi/Yww5VAAijnLxP6I=;
        b=AMXO0YcSdoMhnky+fUKhevqFL4uDskNfbXVQzA9gV0dhM8gnkBv3yqMTfsIz6l4OjF
         6oEAp56EaW7sJaNMpnTjRAhj8WKYSNve6XktRLJNiTUPCwkl3RfQWmqPL1zi20kVnjWt
         vs6mZRnymllxbdfHs1vrMMxDA7A7WcMh/jT3G7KkgUO5XpcJIwmYucJHzJ0BLZvzhuNw
         Vgmxnh3ghz49QRQ4tKaD2hseLnk4DSHNxx26TjP7QMv8ktgZVXUV8ItJpn3D+ddYmdJV
         YeXwyXx7aUCLHB5ukTkwMwP5CWrhfSceDMcTwbT+RHJ7qMHDIdVPvb6GL8fUI8xA/76D
         JkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2fKiWu08zz/rNPgvgctFY8RMsqi/Yww5VAAijnLxP6I=;
        b=FMsFzksQ3giVY0J+cy3yYWfBlUpe1vKhOApRKDIO8APA141xdz3wtedNZ3WZ1hgROR
         8lHCyBT6R96sBc5a0EFYs1RCDKC0dlCeq2R9qIIWHhxDhdVsnAvn/I+oKU53S9HNHHuY
         or8tT8BbTPKr+pRto787cfitTZAZ0iM0GUCp/+lpxih+HagIUF0a9D7p6aOLnOB/nstL
         kk/O9dnimcgcJ03+R1ZLv/YLe05mt31Z6kdOoWXLezwOtK0SvSG20yzD++olgnvfQ2dD
         nynRAE/a+ctmdps0+BnQN17i9PViGhQn3aVuvPSU6DxqKtxooZTUKeOog78P3dXFmcEa
         rcIA==
X-Gm-Message-State: AOAM53388WojkTj3xfvGCX8snuV6QZqRE1c70k5NVRpZrONBy3udC1Sh
        Wbx86zYu5Up2cE8NiW2mHWR1aQ==
X-Google-Smtp-Source: ABdhPJy+zR1RP3eVgHyJHTD5zXNJxI/wM2dq8hbszy9P6b3m+JIv4O3KGazRkPTCFGAEaktVhS49Bg==
X-Received: by 2002:a17:906:2499:: with SMTP id e25mr7592137ejb.446.1610271918085;
        Sun, 10 Jan 2021 01:45:18 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:f4fd:e8ab:2d54:e8c])
        by smtp.gmail.com with ESMTPSA id k15sm5549675ejc.79.2021.01.10.01.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 01:45:17 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH RFC V4 0/4] block: add two statistic tables
Date:   Sun, 10 Jan 2021 10:44:53 +0100
Message-Id: <20210110094457.6624-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

No more comments since the last version, so this version is just rebase
with latest tree.

To make the tables work, it is necessary to enable BLK_ADDITIONAL_DISKSTAT
option, and also enable the sysfs node.
# echo 1 > /sys/block/md0/queue/io_extra_stats

After that, the size and latency of io are recorded in each table.

Thanks,
Guoqing

RFC V3: https://marc.info/?l=linux-block&m=159730633416534&w=2
* Move the #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT into the function body
  per Johannes's comment.
* Tweak the output of two tables to make they are more intuitive

RFC V2: https://marc.info/?l=linux-block&m=159467483514062&w=2
* don't call ktime_get_ns and drop unnecessary patches.
* add io_extra_stats to avoid potential overhead.

RFC V1: https://marc.info/?l=linux-block&m=159419516730386&w=2

Guoqing Jiang (4):
  block: add a statistic table for io latency
  block: add a statistic table for io sector
  block: add io_extra_stats node
  block: call blk_additional_{latency,sector} only when io_extra_stats
    is true

 Documentation/ABI/testing/sysfs-block | 26 +++++++++
 Documentation/block/queue-sysfs.rst   |  6 +++
 block/Kconfig                         |  9 ++++
 block/blk-core.c                      | 51 ++++++++++++++++++
 block/blk-sysfs.c                     | 10 ++++
 block/genhd.c                         | 78 +++++++++++++++++++++++++++
 include/linux/blkdev.h                |  6 +++
 include/linux/part_stat.h             |  8 +++
 8 files changed, 194 insertions(+)

-- 
2.17.1

