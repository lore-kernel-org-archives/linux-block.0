Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A04AC54EBD
	for <linux-block@archiver.kernel.org>; Thu, 12 Jan 2023 08:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjALIZ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Jan 2023 03:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjALIZ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2023 03:25:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B3762D8
        for <linux-block@vger.kernel.org>; Thu, 12 Jan 2023 00:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=e2kI7aQUDYcH/lJiomT62w0Uil99ZHDntE95VjNwqqk=; b=CFdQElbGGpR28An47QVTz9lIFJ
        a9O7+0T6vKJd21v7yiwWpOW6gVxoVR17BfQYoxHEJW13yLqGqyO98ha586Ci89Cj/qdbdHaaOh1yl
        yIS0lY0MmRMHmozZN/5DdxIsCCxcZio6wp1n+slxaMOEh/2CX04p3tlnDdN41CGMSMYyck8GjAU/B
        IoA5r+yH5dQfydI5f0sGbkTrO+mQxSI1mKLzm/GEAcfuU+KwbhcsIP9Zsbo/MMM6uFTLOho4PzmIw
        pb2ndK9Iu/A/RBvtx3F4c3kacz5S5tgR7IyDKINdaxKqTERN3TVWydZODLotlxeWoojXob4MSYlrA
        uJcthpkA==;
Received: from [2001:4bb8:181:656b:c87d:36c9:914c:c2ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFsth-00E5sD-HA; Thu, 12 Jan 2023 08:25:17 +0000
Date:   Thu, 12 Jan 2023 09:25:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y7/D64Qubtqmdv04@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 49e4d04f0486117ac57a97890eb1db6d52bf82b3:

  block: Drop spurious might_sleep() from blk_put_queue() (2023-01-08 20:29:28 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2023-01-12

for you to fetch changes up to c7c0644ead24c59cc5e0f2ff0ade89b21783614a:

  MAINTAINERS: stop nvme matching for nvmem files (2023-01-10 08:16:39 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - Identify quirks for Apple controllers (Hector Martin)
 - fix error handling in nvme_pci_enable (Tong Zhang)
 - refuse unprivileged passthrough on partitions (Christoph Hellwig)
 - fix MAINTAINERS to not match nvmem subsystem headers (Russell King)

----------------------------------------------------------------
Christoph Hellwig (3):
      nvme: remove __nvme_ioctl
      nvme: replace the "bool vec" arguments with flags in the ioctl path
      nvme: don't allow unprivileged passthrough on partitions

Hector Martin (2):
      nvme-apple: add NVME_QUIRK_IDENTIFY_CNS quirk to fix regression
      nvme-pci: add NVME_QUIRK_IDENTIFY_CNS quirk to Apple T2 controllers

Russell King (Oracle) (1):
      MAINTAINERS: stop nvme matching for nvmem files

Tong Zhang (1):
      nvme-pci: fix error handling in nvme_pci_enable()

 MAINTAINERS               |   3 +-
 drivers/nvme/host/apple.c |   2 +-
 drivers/nvme/host/ioctl.c | 110 ++++++++++++++++++++++++++--------------------
 drivers/nvme/host/pci.c   |  12 +++--
 4 files changed, 75 insertions(+), 52 deletions(-)
