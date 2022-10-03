Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD3CC433FE
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 09:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJCJrB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 05:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiJCJqe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 05:46:34 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212CA5814D
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 02:43:48 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 130-20020a1c0288000000b003b494ffc00bso8164638wmc.0
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 02:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ELo8dLo8R9gKdevwXg1T9ddeDjUEA9y1TimZiBY1kMY=;
        b=ebesxGoAufnsPzXWgULUWkj4Ei9z257129gHe3y8HAQ0rUNOYsfYEv26x8Cfa0++ZH
         HzfFRpIM6VnYMTJrP1l2NCZjdC8v96EvCVVAhZ3jl8hVRXVztTrTDAAp5/g7R50yyRIf
         5qLNMzsHXVS8sXXoIPM/QNqReX4qhrxNuugqrfSsgJsRI0ZPMszOT/zQy2qQJyNDPP4t
         ExkMefUs2SrabzeQ7hjqi3Ypvj4w+qZlnsxyOqXmVs4TIMHS4vmQUMYxraJQGptpMusp
         wlurUCDP00JaTwRIvUS/+PsqlIJX/kX/oNj0d9baUKGRv2IK9rqJeyxV6JV+BwqULXFf
         Cr9A==
X-Gm-Message-State: ACrzQf1X4tkVr8t2t1HPdfrZ3/80bY10hCaItp3wrxSqcJRtMRfWSHfv
        IQIYl58gW7ADZFIiKiKyQFc=
X-Google-Smtp-Source: AMsMyM77o9080Y6cjd9/mDSo5KqUGKdxlffz7oxtIUwxuss5Qq9dQvDwBGyWwoL7avK0CfvSG4j2uw==
X-Received: by 2002:a05:600c:1e24:b0:3b4:6c1e:8bb7 with SMTP id ay36-20020a05600c1e2400b003b46c1e8bb7mr6589942wmb.1.1664790226711;
        Mon, 03 Oct 2022 02:43:46 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bk14-20020a0560001d8e00b00228d67db06esm3545586wrb.21.2022.10.03.02.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 02:43:46 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Subject: [PATCH v2 0/2] nvme-mpath: Add IO stats support
Date:   Mon,  3 Oct 2022 12:43:42 +0300
Message-Id: <20221003094344.242593-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've been hearing complaints about the fact that the nvme mpath stack
device does not expose IO stats just like any normal block device,
instead people need to check the bottom namespaces hidden devices,
mapping back to the mpath device node.

This really sucks, especially for observability hooks/plugins that
I've seen people do.

This series make the nvme mpath device expose normal IO stats. Given
that nvme-mpath doesn't have any context after submitting the bio, we
use the core completion path to start/end stats accounting on its
behalf, a similar practice that we use for other multipath related stuff.

While we are "double" accounting every request, this is a preferable
approach as opposed to try and locally collect/combine accurate stats
from multiple bottom hidden devices in the driver, or teach the block
layer to do so.

Local tests with null-blk + nvme-loop did not show any noticeable
performance degradation (within 1%).

Feedback is welcome.

Changes from v1:
- split into 2 patches, one prep and second is nvme-mpath stats
- fix possible use-after-free when ending request and accounting mpath io
  stats
- mark REQ_NVME_MPATH_IO_STATS to allow user to disable stats on the mpath
  device (also in the middle of a request).

Sagi Grimberg (2):
  nvme: introduce nvme_start_request
  nvme: support io stats on the mpath device

 drivers/nvme/host/apple.c     |  2 +-
 drivers/nvme/host/core.c      | 10 ++++++++++
 drivers/nvme/host/fc.c        |  2 +-
 drivers/nvme/host/multipath.c | 25 +++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      | 13 +++++++++++++
 drivers/nvme/host/pci.c       |  2 +-
 drivers/nvme/host/rdma.c      |  2 +-
 drivers/nvme/host/tcp.c       |  2 +-
 drivers/nvme/target/loop.c    |  2 +-
 9 files changed, 54 insertions(+), 6 deletions(-)

-- 
2.34.1

