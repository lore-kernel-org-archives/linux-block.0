Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13350C4708D
	for <linux-block@archiver.kernel.org>; Wed,  7 Dec 2022 18:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLGS2V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Dec 2022 13:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLGS2T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Dec 2022 13:28:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6A254768
        for <linux-block@vger.kernel.org>; Wed,  7 Dec 2022 10:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kiK0JwG5mTuuEr7z0kUmCZLlpQoHhD/Ddo0Cxmejecc=; b=FnAI2RWf+vzTQYS+WGmzlHNN8F
        Qp5hcAprc35SMQmbzsJmTfK9OiAjukGkDuTKIAdi5SZXIaXgzOsu8OAzgbiLsTdxweeRXSYiLMYhk
        8C8cYERz3OKJFNvQP/r6zUf8bbywbm79VQetdDcKrCbayup67DOhzRLV9PR6x4GRRpzgHmyEpjvVR
        bL27sQTPMqbkbtJ4icwOw+GuIxPwTU/IZIul86us1XVQI8GQdasb9lFnFJsaDAPNUJCYr2c+5r0O6
        vPQ9uGKGPPoQA3jW8KUQcO+8+pOxlVCt6i/8phQWPn6NTJ9i5LNrqQesCeMekkKlijSFBi/wjk29C
        HZ9ghiIQ==;
Received: from [2001:4bb8:19a:6deb:1e50:ef0a:649d:fd9d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2z9M-008cps-SL; Wed, 07 Dec 2022 18:28:09 +0000
Date:   Wed, 7 Dec 2022 19:28:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.2
Message-ID: <Y5DbMySCBMWI7CbE@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit eea3e8b74aa1648fc96b739458d067a6e498c302:

  blk-throttle: Use more suitable time_after check for update of slice_start (2022-12-05 13:45:31 -0700)

are available in the Git repository at:

  ssh://git.infradead.org/var/lib/git/nvme.git tags/nvme-6.2-2022-12-07

for you to fetch changes up to 19b00e0069a3819eac0e0ea685899aba29e545d6:

  nvmet: don't open-code NVME_NS_ATTR_RO enumeration (2022-12-07 15:03:09 +0100)

----------------------------------------------------------------
nvme updates for Linux 6.2

 - fix and cleanup nvme-fc req allocation (Chaitanya Kulkarni)
 - use the common tagset helpers in nvme-pci driver (Christoph Hellwig)
 - cleanup the nvme-pci removal path (Christoph Hellwig)
 - use kstrtobool() instead of strtobool (Christophe JAILLET)
 - allow unprivileged passthrough of Identify Controller (Joel Granados)
 - support io stats on the mpath device (Sagi Grimberg)
 - minor nvmet cleanup (Sagi Grimberg)

----------------------------------------------------------------
Chaitanya Kulkarni (2):
      nvme-fc: avoid null pointer dereference
      nvme-fc: move common code into helper

Christoph Hellwig (15):
      nvme: don't call blk_mq_{,un}quiesce_tagset when ctrl->tagset is NULL
      nvme-apple: fix controller shutdown in apple_nvme_disable
      nvme: use nvme_wait_ready in nvme_shutdown_ctrl
      nvme: merge nvme_shutdown_ctrl into nvme_disable_ctrl
      nvme-pci: remove nvme_disable_admin_queue
      nvme-pci: remove nvme_pci_disable
      nvme-pci: cleanup nvme_suspend_queue
      nvme-pci: rename nvme_disable_io_queues
      nvme-pci: return early on ctrl state mismatch in nvme_reset_work
      nvme-pci: split out a nvme_pci_ctrl_is_dead helper
      nvme: pass nr_maps explicitly to nvme_alloc_io_tag_set
      nvme: consolidate setting the tagset flags
      nvme: only set reserved_tags in nvme_alloc_io_tag_set for fabrics controllers
      nvme: add the Apple shared tag workaround to nvme_alloc_io_tag_set
      nvme-pci: use the tagset alloc/free helpers

Christophe JAILLET (1):
      nvme: use kstrtobool() instead of strtobool()

Joel Granados (1):
      nvme: allow unprivileged passthrough of Identify Controller

Sagi Grimberg (3):
      nvme: introduce nvme_start_request
      nvme-multipath: support io stats on the mpath device
      nvmet: don't open-code NVME_NS_ATTR_RO enumeration

 drivers/nvme/host/apple.c       |   6 +-
 drivers/nvme/host/core.c        |  98 +++++++++----------
 drivers/nvme/host/fc.c          |  30 ++++--
 drivers/nvme/host/ioctl.c       |   2 +
 drivers/nvme/host/multipath.c   |  26 +++++
 drivers/nvme/host/nvme.h        |  29 +++++-
 drivers/nvme/host/pci.c         | 209 ++++++++++++++--------------------------
 drivers/nvme/host/rdma.c        |  12 +--
 drivers/nvme/host/tcp.c         |  13 +--
 drivers/nvme/target/admin-cmd.c |   2 +-
 drivers/nvme/target/configfs.c  |  17 ++--
 drivers/nvme/target/loop.c      |   8 +-
 12 files changed, 214 insertions(+), 238 deletions(-)
