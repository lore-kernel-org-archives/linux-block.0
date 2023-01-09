Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C80C54EBD
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjAIX2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbjAIX1s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:27:48 -0500
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816D5B49B
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:27:46 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id 7so7015547pga.1
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 15:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ur2Mgs4IEu2RJHAffHLyaQIsfgT3ET08D3vZoVug2IU=;
        b=sOhXMEft0rA+TtCPU8V4YcCG0equMenh2H30JloBDDRdFuGbcddcuSkZCKCr6AOQmb
         WY2w+lNu8X851Q8aV4Ttr43tdwN9jl8gsv35A581isd36j+IrHgLlDO3nydOCr3OY6Ad
         YUXHH0s+J4WxDHX8iy+hSTQzNbUvLrgjSJBcCJrENbCzdXzGRWrbtJUk+L2ylXm/7Bg1
         ZYJV+fGR/F/LgOg8g0c2J0oU1HixFZ8LmcQybDb4CtFmuoRP82y1vFWJcToY+NAMh5xF
         /+xDMb23a0Lp1uKSL15YJ1laGBSHxljDNkaluyFfIjsIRR2Li1SHQ98tNnU67IT1Nnkk
         BoOg==
X-Gm-Message-State: AFqh2kpaTPns6TioWpyYIb4d1blu/FacdW8F8Y+uahRHKyNKJTuUFZVQ
        Y0dLxl61+2EJ1nqUUs0O62moJcX2lP4=
X-Google-Smtp-Source: AMrXdXsOdiz4WWY7RobWdtaFeV5a+owMqzVW8+S9iBnfRt+wjtTcMUxMAlojtnuky+pZ7Qn/q7yryw==
X-Received: by 2002:a05:6a00:1485:b0:575:b783:b6b3 with SMTP id v5-20020a056a00148500b00575b783b6b3mr85338560pfu.28.1673306865694;
        Mon, 09 Jan 2023 15:27:45 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id s2-20020a625e02000000b0057ef155103asm5032244pfb.155.2023.01.09.15.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:27:44 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/8] Enable zoned write pipelining for UFS devices
Date:   Mon,  9 Jan 2023 15:27:30 -0800
Message-Id: <20230109232738.169886-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series improves write performance for zoned UFS devices that
implement the host-managed (sequential write required) model. Please consider
these patches for the next merge window.

Thanks,

Bart.

Bart Van Assche (8):
  block: Document blk_queue_zone_is_seq() and blk_rq_zone_is_seq()
  block: Introduce the blk_rq_is_seq_zone_write() function
  block: Introduce a request queue flag for pipelining zoned writes
  block/mq-deadline: Only use zone locking if necessary
  block/null_blk: Refactor null_queue_rq()
  block/null_blk: Add support for pipelining zoned writes
  scsi: Retry unaligned zoned writes
  scsi: ufs: Enable zoned write pipelining

 block/blk-zoned.c                 |  3 ++-
 block/mq-deadline.c               | 14 +++++++++-----
 drivers/block/null_blk/main.c     | 30 ++++++++++++++++++++----------
 drivers/block/null_blk/null_blk.h |  3 +++
 drivers/block/null_blk/zoned.c    | 13 ++++++++++++-
 drivers/scsi/scsi_error.c         |  7 +++++++
 drivers/scsi/sd.c                 |  3 +++
 drivers/ufs/core/ufshcd.c         |  1 +
 include/linux/blk-mq.h            | 30 ++++++++++++++++++++++++++++++
 include/linux/blkdev.h            | 16 ++++++++++++++++
 10 files changed, 103 insertions(+), 17 deletions(-)

