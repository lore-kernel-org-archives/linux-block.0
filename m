Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5670CC28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C6C25972
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfEaABC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 20:01:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38545 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfEaABC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 20:01:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id v11so2926611pgl.5
        for <linux-block@vger.kernel.org>; Thu, 30 May 2019 17:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9mb9MX1cBEl/kboX27g56m/1N/exFhBqGR6m9l5vZA=;
        b=EN8vg/Q7Lw4HXlmXLnlVJdKHg0NBqILBC11HSqsCAj9IaiCH9vCNRZ6Dh3VhifK/zj
         LgTAK43TjSLeHFNXM81AN4mQctkIrvomOTQ8Uy2/guATaea1BmOF4KFVIuTJrV0LxMDT
         gsUv90bKhuKPqB+Q8BZThV9zd5gNA+Ixu/z/fO4h5RBFNEYJR8dsoEhzXyeiMojx6Rny
         u38QQnh+2X+T2V8pg6OY2WC1V1pB+54OTnl3A6iD+Wj6u2c/qVZ83ZNKYGo9fVfAV1lZ
         +Fg6ii08rZf3KP13/A02pTVH6d/mgQdGbnKR0HZmbnUyEM8z1WsCqiNA5cMhyvrXYwk5
         kokQ==
X-Gm-Message-State: APjAAAUQoPudNr0kTbRMr3DRU2f6X8tDxiaH/3dJFn6E3Eg0/CCajwE4
        hVOTE7tBkxUAZxoEsx4e+13jVjL+
X-Google-Smtp-Source: APXvYqxurB+/rG6g8b68pe4CC+uysrEEI0TuTgqj0SO6lFhzhqZ73mexvIOuZdofuxZh8f6oKO995g==
X-Received: by 2002:a63:ee10:: with SMTP id e16mr6245135pgi.207.1559260861348;
        Thu, 30 May 2019 17:01:01 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g8sm3539851pjp.17.2019.05.30.17.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 17:01:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/8] Improve block layer function documentation
Date:   Thu, 30 May 2019 17:00:45 -0700
Message-Id: <20190531000053.64053-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This is a series with eight patches that address source code comments. Most
patches suppress kernel-doc warnings that appear when building with W=1. Please
consider these patches.

Thanks,

Bart.

Bart Van Assche (8):
  block/partitions/ldm: Convert a kernel-doc header into a
    non-kernel-doc header
  block: Convert blk_invalidate_devt() header into a non-kernel-doc
    header
  block: Fix throtl_pending_timer_fn() kernel-doc header
  block: Fix blk_mq_*_map_queues() kernel-doc headers
  block: Fix rq_qos_wait() kernel-doc header
  block: Fix bsg_setup_queue() kernel-doc header
  blk-mq: Fix spelling in a source code comment
  blk-mq: Document the blk_mq_hw_queue_to_node() arguments

 block/blk-mq-cpumap.c  | 10 +++++++---
 block/blk-mq-pci.c     |  2 +-
 block/blk-mq-rdma.c    |  4 ++--
 block/blk-mq-virtio.c  |  4 ++--
 block/blk-rq-qos.c     |  7 ++++---
 block/blk-throttle.c   |  2 +-
 block/bsg-lib.c        |  1 +
 block/genhd.c          |  4 ++--
 block/partitions/ldm.c |  2 +-
 9 files changed, 21 insertions(+), 15 deletions(-)

-- 
2.22.0.rc1

