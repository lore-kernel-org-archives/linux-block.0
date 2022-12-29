Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2C6C4332F
	for <linux-block@archiver.kernel.org>; Thu, 29 Dec 2022 16:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiL2Qlq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Dec 2022 11:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiL2Qlp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 11:41:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F923A199
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 08:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=avvqaRN2SjmRVsthHLPqt7SLtudB6a3Mbu7hhPbcWa4=; b=Pxp1fPI/AhHcj4TxfDq7pndvvI
        INS7Rf7Zp1jfwunXHxVj3BTp8rUHEezAvKBYrgwlDmTRUh0T/l/uzfX/z2xepuhy9cf3mEFpIKmt4
        Ite1giYXeGxt+FnaIJFYj8t87sppi7M+NR9cH2m2CQex/6ns3cR3EhmvBfID+XXYfWYpBpivTP6DZ
        CpgXdjMM931/hxbS3g1eO4bZlhSGtBW8s3i4eYpmjyQxtWxqu3cCzf+A5RW6NYXyMAso3aO2ORT54
        X4+IH7MgKlm56aYicLj36DfcRUsRB0wg+xwaL6gb1LCdej/NOeDW7fgWDBDs661dRe79inkgX9rLo
        2gtr+J3A==;
Received: from rrcs-67-53-201-206.west.biz.rr.com ([67.53.201.206] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pAvyM-00HaGJ-6u; Thu, 29 Dec 2022 16:41:38 +0000
Date:   Thu, 29 Dec 2022 06:41:37 -1000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y63DQSUSW4aQlVJ+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 88d356ca41ba1c3effc2d4208dfbd4392f58cd6d:

  nvme-pci: update sqsize when adjusting the queue depth (2022-12-26 12:10:51 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2022-12-29

for you to fetch changes up to 76807fcd73b818eb9f245ef1035aed34ecdd9813:

  nvme-auth: fix smatch warning complaints (2022-12-28 06:26:35 -1000)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - fix various problems in handling the Command Supported and Effects log
   (Christoph Hellwig)
 - don't allow unprivileged passthrough of commands that don't transfer
   data but modify logical block content (Christoph Hellwig)
 - add a features and quirks policy document (Christoph Hellwig)
 - fix some really nasty code that was correct but made smatch complain
   (Sagi Grimberg)

----------------------------------------------------------------
Christoph Hellwig (7):
      docs, nvme: add a feature and quirk policy document
      nvme: fix the NVME_CMD_EFFECTS_CSE_MASK definition
      nvmet: use NVME_CMD_EFFECTS_CSUPP instead of open coding it
      nvmet: set the LBCC bit for commands that modify data
      nvmet: don't defer passthrough commands with trivial effects to the workqueue
      nvme: also return I/O command effects from nvme_command_effects
      nvme: consult the CSE log page for unprivileged passthrough

Sagi Grimberg (1):
      nvme-auth: fix smatch warning complaints

 .../maintainer/maintainer-entry-profile.rst        |  1 +
 Documentation/nvme/feature-and-quirk-policy.rst    | 77 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 drivers/nvme/host/auth.c                           |  2 +-
 drivers/nvme/host/core.c                           | 32 +++++++--
 drivers/nvme/host/ioctl.c                          | 28 ++++++--
 drivers/nvme/target/admin-cmd.c                    | 37 ++++++-----
 drivers/nvme/target/passthru.c                     | 11 ++--
 include/linux/nvme.h                               |  4 +-
 9 files changed, 159 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/nvme/feature-and-quirk-policy.rst
