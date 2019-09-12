Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03538C4CEC5
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 16:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C728D2084D
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 16:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gL37jush"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfILQly (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Sep 2019 12:41:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfILQlx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 12:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GXaYUC4tstRsXbF/7GL9yMO7jPei8IUh8BBoF7swSR4=; b=gL37jushVLmbm5U/j0JSPKVvV
        n7w+yAKZEf28w0wdR/leAcvOuixgKp8P28OK8wOnDY5QNqELzz7dalG3/4OyEU2Nr2RO7XiMWPgfH
        Tuc1yyVVyrt90im9Mo4pgP8ozzugNbHpFMEl+FPFvxueNzosAYoqmiiReh0wUvWFWXKdvy9MzbSzl
        dF0AUXzOETVDBLG8zujxsHlBfr/1uFQXTSWMRo0zlQIrdLUrEeSTV4b/yW5GxrW+yRxmkowth1AR+
        rXEvDFNzirAbcdQo7d8CvysE5KDYHUHu6ECASx2BlE8F3QC+gCrWZxPlmhgfkbzS/I5GD58yFgCU2
        VxzusSbkA==;
Received: from [2601:647:4800:973f:c36:579b:9814:69b7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8SAK-0006GY-LM; Thu, 12 Sep 2019 16:41:52 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [GIT PULL] second round of nvme updates for 5.4
Date:   Thu, 12 Sep 2019 09:41:51 -0700
Message-Id: <20190912164151.7788-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey Jens,

This is the second batch of nvme updates for 5.4.

Highlights includes:
- controller reset and namespace scan races fixes
- nvme discovery log change uevent support
- naming improvements from Keith
- multiple discovery controllers reject fix from James
- some regular cleanups from various people

The following changes since commit 0a67b5a926e63ff5492c3c675eab5900580d056d:

  block: fix race between switching elevator and removing queues (2019-09-12 07:13:22 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.4 

for you to fetch changes up to 5f8badbcbeac298a77ee634a10a375f3e66923f9:

  nvmet: fix a wrong error status returned in error log page (2019-09-12 08:50:46 -0700)

----------------------------------------------------------------
Amit (1):
      nvmet: fix a wrong error status returned in error log page

Colin Ian King (1):
      nvme: tcp: remove redundant assignment to variable ret

Edmund Nadolski (1):
      nvme: include admin_q sync with nvme_sync_queues

Israel Rukshin (1):
      nvme: Remove redundant assignment of cq vector

James Smart (2):
      nvme-fc: Fail transport errors with NVME_SC_HOST_PATH
      nvme: Treat discovery subsystems as unique subsystems

Keith Busch (1):
      nvme: Assign subsys instance from first ctrl

Markus Elfring (1):
      nvmet: Use PTR_ERR_OR_ZERO() in nvmet_init_discovery()

Sagi Grimberg (10):
      nvme: fail cancelled commands with NVME_SC_HOST_PATH_ERROR
      nvme-tcp: fail command with NVME_SC_HOST_PATH_ERROR send failed
      nvme: pass status to nvme_error_status
      nvme: make nvme_identify_ns propagate errors back
      nvme: make nvme_report_ns_ids propagate error back
      nvme: fix ns removal hang when failing to revalidate due to a transient error
      nvme-fabrics: allow discovery subsystems accept a kato
      nvme: enable aen regardless of the presence of I/O queues
      nvme: add uevent variables for controller devices
      nvme: send discovery log page change events to userspace

 drivers/nvme/host/core.c        | 158 +++++++++++++++++++++++++++++-----------
 drivers/nvme/host/fabrics.c     |  12 +--
 drivers/nvme/host/fc.c          |  37 ++++++++--
 drivers/nvme/host/pci.c         |   1 -
 drivers/nvme/host/tcp.c         |   4 +-
 drivers/nvme/target/admin-cmd.c |   8 +-
 drivers/nvme/target/discovery.c |   4 +-
 7 files changed, 153 insertions(+), 71 deletions(-)
