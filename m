Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066F2C433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 01:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD3364E22
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 01:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhBAB2U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jan 2021 20:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhBAB2S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jan 2021 20:28:18 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A53C061573
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 17:27:38 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id q9so14106438ilo.1
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 17:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=w2R66GrXpazSjE8LBSunmF7vsqmhGDNqtkYbIVGpyr0=;
        b=YYQZC+bG2NN9/CM1MAjk21l14HENVmLoM9dkcuzDv3F/0qPFHTUnCK6CnCxirEMyFI
         xnV89pwHDgnpkJXqa78VvM+AduhNiKpWRsHqVvDE2svxTHLTKFWR8+E/0Y5Ir8bsWcsm
         8cIvYmsBDvvlXZJg/L8figted/rCfgqnj4fTrRBZc6BQluPnz3QfGHKCTfZDleqmcccn
         XSZ69EJ2fONMQH7aGyfHX+qusOIbIp5Nyy8K9zLlnEKkRpG0VrBeLr8U5TCCbGnJrmmy
         mcavc+tNTxXzBBifPruCAzQhqUxE/J5epI4mc+kLWti7VV2OLCqdjedA3F7bqzj12vFV
         1qaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w2R66GrXpazSjE8LBSunmF7vsqmhGDNqtkYbIVGpyr0=;
        b=EOyTaKSeDCavFpVCSr1yDikhRFM3t9hjcb4JGuq8qAL1/ke3VbulG0ZL6xwQmRQlcT
         kxTXRc2M8LU3kx9rGydannStLdfHYTDiKrDQZ2dzfvpv36sgimQMcXXglwR4BxJPCohZ
         THjmzbASXF3d8K8cUvaGAmBPj0ZUZc2GCqlGcVztHhv8O32siw1tVfJ8G0Z3MXCGHdng
         BRrJCypUt4ZwlvpIvoqxfnNn0tnY3hsD9JrsMCsFknrhFgojjJVlYf4BY1Z/S5JCmSVO
         22SscHs73gUuDMOw/oXyDvvQNSLJO+n8vDkEAQ15YSNTjDrhsvbeiSC5ms5ewvBWhbu7
         Begw==
X-Gm-Message-State: AOAM532UB7XC2mbSrc7aoc3GQ8HPM2zelqdHfkfI4VKP6lU0IzUzD4VC
        hI0IjBmdMMXM9OIqUsGhB3U9Dg==
X-Google-Smtp-Source: ABdhPJzDLmirJGv3g2QbQdB/KierGN54ExMl/iVvSpntBkDkJoV5YHUVeAji7GlaGJ42lnfOfnvqnA==
X-Received: by 2002:a92:6f0b:: with SMTP id k11mr11039017ilc.53.1612142856648;
        Sun, 31 Jan 2021 17:27:36 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:994d:fb60:3536:26f])
        by smtp.gmail.com with ESMTPSA id c19sm8539627ile.17.2021.01.31.17.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 17:27:35 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, hch@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 0/4] block: add two statistic tables
Date:   Mon,  1 Feb 2021 02:27:23 +0100
Message-Id: <20210201012727.28305-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This version has below changes:

1. remove BLK_ADDITIONAL_DISKSTAT option per Christoph's comment.
2. move blk_queue_io_extra_stat into blk_additional_{latency,sector}
   per Christoph's comment.
3. simplify blk_additional_latency by pass duration time directly.

Thanks,
Guoqing


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

Guoqing Jiang (4):
  block: add a statistic table for io latency
  block: add a statistic table for io sector
  block: add io_extra_stats node
  block: call blk_additional_{latency,sector} only when io_extra_stats
    is true

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

