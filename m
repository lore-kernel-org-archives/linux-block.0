Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF3DC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 19:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3832420882
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 19:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oBog5kAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3832420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLGTUy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:20:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGTUy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 14:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iloseggn8JUm0M1jKvkwBGi8KKhzMdDs4VMxwFepW38=; b=oBog5kAUV2r8qBsuN0OHtAM7CS
        ZgAoF+82TxaimnMInB7+ZLhBhBv7/rJaBF53+9qv0ePhx3Pz5PJFPR+4I+zyzeuZollHz19tQMOBx
        0DCfF01+L+wnZDdcSmzzcqtac0zqJwMq1wAujK71Gb/Wvpnw1uCuJ/qiLL9okdvbwffdG3UgQaWg5
        GBnTPIr5FgHn4SkNkAgLTTCV2FI07wuVUiq/JymDc397+wlJ+bdY71hyCwhcvomRiDKf5JhIfvcqW
        et3xVM3Rp4Dbv7Xr3B5zwjtY4zM+A2M3kkZhBJMambF+A6/poYwkkKELqzamcxSD5uB9D7JftTkKK
        Ncgbq3DQ==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVLgD-00064m-2e; Fri, 07 Dec 2018 19:20:53 +0000
Date:   Fri, 7 Dec 2018 11:20:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] first batch of nvme updates for 4.21
Message-ID: <20181207192046.GA19243@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

please pull this first batch of nvme updates for Linux 4.21.

Highlights:
 - target support for persistent discovery controllers (Jay Sternberg)
 - target optimizations to use non-blocking reads (Chaitanya Kulkarni)
 - host side support for the Enhanced Command Retry TP (Keith Busch)
 - host and target support for traffic based keep alive (Sagi Grimberg)
 - host and target support for disabling SQ based flow control (Sagi Grimberg)

Plus all kinds of optimizations and cleanups from the usual suspects.

The following changes since commit 43e497feb3987c868f87c7ca1470c5937689fe01:

  blk-mq: re-build queue map in case of kdump kernel (2018-12-06 22:52:59 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.21

for you to fetch changes up to 48fd68b3c5c66af6e0004787a54765a8d040989b:

  nvme: remove unused function nvme_ctrl_ready (2018-12-07 11:16:38 -0800)

----------------------------------------------------------------
Chaitanya Kulkarni (4):
      nvme: consolidate memset calls in the nvme_setup_cmd path
      nvmet: use IOCB_NOWAIT for file-ns buffered I/O
      nvmet: use unlikely for req status check
      nvmet: fix the structure member indentation

Christoph Hellwig (1):
      nvmet: mark nvmet_genctr static

Hannes Reinecke (1):
      nvme: add a numa_node field to struct nvme_ctrl

Israel Rukshin (3):
      nvme: Remove unused forward declaration
      nvmet-rdma: Add unlikely for response allocated check
      nvme: remove unused function nvme_ctrl_ready

James Smart (1):
      nvmet-fc: remove the IN_ISR deferred scheduling options

Jay Sternberg (7):
      nvmet: provide aen bit functions for multiple controller types
      nvmet: change aen mask functions to use bit numbers
      nvmet: allow Keep Alive for Discovery controller
      nvmet: make kato and AEN processing for use by other controllers
      nvmet: add defines for discovery change async events
      nvmet: add support to Discovery controllers for commands
      nvmet: enable Discovery Controller AENs

Keith Busch (1):
      nvme: implement Enhanced Command Retry

Sagi Grimberg (9):
      nvme: introduce ctrl attributes enumeration
      nvme: cache controller attributes
      nvme: support traffic based keep-alive
      nvmet: support for traffic based keep-alive
      nvmet: allow host connect even if no allowed subsystems are exported
      nvmet: support fabrics sq flow control
      nvmet: don't override treq upon modification.
      nvmet: expose support for fabrics SQ flow control disable in treq
      nvme: disable fabrics SQ flow control when asked by the user

 drivers/nvme/host/core.c          |  70 ++++++++++++++++++--
 drivers/nvme/host/fabrics.c       |  13 +++-
 drivers/nvme/host/fabrics.h       |   2 +
 drivers/nvme/host/fc.c            |   5 +-
 drivers/nvme/host/multipath.c     |   4 +-
 drivers/nvme/host/nvme.h          |  13 ++--
 drivers/nvme/host/rdma.c          |   5 +-
 drivers/nvme/target/admin-cmd.c   |  76 ++++++++++++----------
 drivers/nvme/target/configfs.c    |  42 ++++++++----
 drivers/nvme/target/core.c        | 118 +++++++++++++---------------------
 drivers/nvme/target/discovery.c   | 129 +++++++++++++++++++++++++++++++++++--
 drivers/nvme/target/fabrics-cmd.c |   6 ++
 drivers/nvme/target/fc.c          |  66 +------------------
 drivers/nvme/target/io-cmd-file.c | 130 ++++++++++++++++++++++++--------------
 drivers/nvme/target/nvmet.h       |  53 +++++++++++++---
 drivers/nvme/target/rdma.c        |   2 +-
 include/linux/nvme-fc-driver.h    |  16 -----
 include/linux/nvme.h              |  51 +++++++++++++--
 18 files changed, 514 insertions(+), 287 deletions(-)
