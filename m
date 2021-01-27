Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA31C433E6
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 15:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEAAA207FC
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 15:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhA0PFO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbhA0PBk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 10:01:40 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EDEC061797
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 06:59:44 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id c2so2779751edr.11
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 06:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=n/i7mBkO9L02J4EICgO71qWa0jBgmdm3zV9/esiIZMU=;
        b=cVnaIKRYgOIuUbtpruAxK4qq7Pdy9oYwA3B855IoWjUSQno8IDGxVd7jxfrB5duWFc
         NwFpfAPg5scVfD3DPbgKIWoYphQwfRej3zC2wtdzu0JCxEK8jsnFnDRqCm0Ny/J1CQa2
         Q2VLQVNgL+BI7/FxfCd/UIWiROIMVi7B5iMN+SQYqyHuO8YwCSOvI3qQSKUZXeC/YF/J
         KV2HadXa/ScVB4QsTyc3WPWJrz39bxSzMax//91CHsdVtkYQMi8KYwS5W3ox+637+jV9
         HVDag9LH4CqjL9KtqVvuJct62+kXYus0KHVpYF5Xh+WlPjWHQyZhYdrLnzaRRo31vr2K
         BBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n/i7mBkO9L02J4EICgO71qWa0jBgmdm3zV9/esiIZMU=;
        b=JhdXRGwNZLt77foXzRdj3CLu5fgqyVoTQ9I+3N3d/pV26FzuQCmnK9xiKPqGTK1klv
         g6yHeENm1hDw6Tpc9kSO00vVyqvhRTrZQRSxhww95kS4bef7gH7gt38IXGsbvAkXhcu7
         4P3cw/lSvaVAzIAlBHK+2eTC/sWRs2gl2/PPdEyYU2c+TWzUDzrRItcy/sUbKsGxYWhh
         7ctR1xsmD+4KzTWCucobJ3A0TMqo2VVRQgVjiyMVIBymoDKH/UoI/SPuT5bogfPHL8R0
         QSwNRUqLF3lI4f6hkIyca4MRB8R1f8x82HMEj917eAlrr68imMb322FERfkB2hmVHcPF
         3jmw==
X-Gm-Message-State: AOAM530+3G9BDOmWY3mfAT9UOf+METtZNCc5+lKwyc8PbMhhx4qsFZy1
        3+dUGBS/VNVDCvDr+Sclc60z2Q==
X-Google-Smtp-Source: ABdhPJzKcYF1nqZ/xEsAWMFXA/O1ikqVYbIMJNIy3XA6S1PAqBBEsmTv2IIWr5eylxvQnlMUnCS1oQ==
X-Received: by 2002:a50:cf02:: with SMTP id c2mr9328470edk.333.1611759582960;
        Wed, 27 Jan 2021 06:59:42 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:9172:bd00:1e95:fbc9])
        by smtp.gmail.com with ESMTPSA id j4sm1477140edt.18.2021.01.27.06.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:59:41 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 0/4] block: add two statistic tables
Date:   Wed, 27 Jan 2021 15:59:26 +0100
Message-Id: <20210127145930.8826-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This version just added reviewed-by tag from Jack since no other comments.
And I am wondering if we can make progress with this series, hence I removed 
RFC from subject.

Thanks,
Guoqing

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

