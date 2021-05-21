Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935CBC04FF3
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 20:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7178F61004
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 20:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhEUUXL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 16:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhEUUXK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 16:23:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 852AF61353;
        Fri, 21 May 2021 20:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621628507;
        bh=dj7b7UED/cGSL8qPn+mHfw/ztN0y5qUqhQg/dbjoKy4=;
        h=From:To:Cc:Subject:Date:From;
        b=YbBpGDHjUF5NLQNDqckEbTottmvcHaNrr2gpP7uu6uhjggh/x/IYaUFVHJg22wfrr
         q/0QdR07I+XLVvMO/JFwej75VPY1yllTeZq+O9iFXIdKRiSjq8Vn7+8hwuKP+CPlgw
         Pu13FidKZQJeFkoxi7VwNEsQLiimQg8kuTlnkV2SYZaiYs6Kq+shy7JCcrbuheaRPe
         JG7QE/yNB+z6cC6wzFSzTAliNAp9NY169kYFOUzBp499l3zKA8GrO+h7Ie0wYnNcYx
         XbdXYvLed47c5x1477j/O6n19BK0FtwII2znhC6SdGImpEt8NiX8roIsKpN4uULuvX
         ppF8RjSfZj0KQ==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/4] block and nvme passthrough error handling
Date:   Fri, 21 May 2021 13:21:41 -0700
Message-Id: <20210521202145.3674904-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series gets blk_execute_rq() to process polled requests and return
queueing errors so the caller may know if their request wasn't
dispatched.

Changes since v2:

  Dropped patch 5 (ioctl polling flag) since there is currently no real
  use case.

  Move blk_execute_rq's poll handling to a small helper function
  (patch 1)

  Return blk_status_t instead of errno (patch 3)

  Removed "extern" header declaration, and named the parameters (patch 3)

  Initialize nvme status to 0 (patch 4)

  Add helper function for blk_status_t to nvme passthrough return code
  (patch 4)

Keith Busch (4):
  block: support polling through blk_execute_rq
  nvme: use blk_execute_rq() for passthrough commands
  block: return errors from blk_execute_rq()
  nvme: use return value from blk_execute_rq()

 block/blk-exec.c               | 25 ++++++++++++--
 drivers/nvme/host/core.c       | 63 ++++++++++++++--------------------
 drivers/nvme/host/fabrics.c    | 13 ++++---
 drivers/nvme/host/fabrics.h    |  2 +-
 drivers/nvme/host/fc.c         |  2 +-
 drivers/nvme/host/ioctl.c      |  6 +---
 drivers/nvme/host/nvme.h       |  4 +--
 drivers/nvme/host/rdma.c       |  3 +-
 drivers/nvme/host/tcp.c        |  2 +-
 drivers/nvme/target/loop.c     |  2 +-
 drivers/nvme/target/passthru.c |  8 ++---
 include/linux/blkdev.h         |  4 ++-
 12 files changed, 69 insertions(+), 65 deletions(-)

-- 
2.25.4

