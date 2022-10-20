Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762EAC4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 08:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJTI54 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 04:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJTI54 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 04:57:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A436194208
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 01:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=yjUpLu0+0UVRSuM7qoEkvVCRCkHDyvMSS8FiZ0/18pM=; b=cUV7JpRAnF4pSABMS0uKkAn379
        lvy7agYUVF3RjlhShgVWDS+nMZx8cAwr3ukW8E6pyc6gp+73F4CNdt+SWoAzrMdUzvtQCEaFEfJLu
        AJgzoK6wCA5UZHH0PTUAvSNXGtkm1Ur70HaPzuHZB3iG2ig7kjnH7PF476jb+tQ1soKGWqtbn8LS3
        g4EedG8bKD0c98ETSwezraOoV9I9nykFkkGxATKMmpJbVv6Nzu84k3OoAGkvd8QuAM8+cO5aoan5h
        6VVcDLlTZwv2phTPI9QtCQofnmTjg1cM8lYcEbRZOEE0C7alCrBGHFGYR/yuJc3LVYY7DRu3lhksW
        9U/g7vRg==;
Received: from [88.128.92.117] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olRNB-00CZwN-K5; Thu, 20 Oct 2022 08:57:53 +0000
Date:   Thu, 20 Oct 2022 10:57:47 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.1
Message-ID: <Y1ENi1X5gi7yU9VS@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit e0539ae012ba5d618eb19665ff990b87b960c643:

  Documentation: document ublk user recovery feature (2022-10-18 05:12:26 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-10-22

for you to fetch changes up to 94f5a06884074dcd99606d7b329e133ee65ea6ad:

  nvmet: fix invalid memory reference in nvmet_subsys_attr_qid_max_show (2022-10-19 12:43:13 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - fix nvme-hwmon for DMA non-cohehrent architectures (Serge Semin)
 - add a nvme-hwmong maintainer (Christoph Hellwig)
 - fix error pointer dereference in error handling (Dan Carpenter)
 - fix invalid memory reference in nvmet_subsys_attr_qid_max_show
   (Daniel Wagner)
 - don't limit the DMA segment size in nvme-apple (Russell King)
 - fix workqueue MEM_RECLAIM flushing dependency (Sagi Grimberg)
 - disable write zeroes on various Kingston SSDs (Xander Li)

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: add Guenther as nvme-hwmon maintainer
      nvme-hwmon: consistently ignore errors from nvme_hwmon_init

Dan Carpenter (1):
      nvme: fix error pointer dereference in error handling

Daniel Wagner (1):
      nvmet: fix invalid memory reference in nvmet_subsys_attr_qid_max_show

Russell King (Oracle) (1):
      nvme-apple: don't limit DMA segement size

Sagi Grimberg (1):
      nvmet: fix workqueue MEM_RECLAIM flushing dependency

Serge Semin (1):
      nvme-hwmon: kmalloc the NVME SMART log buffer

Xander Li (1):
      nvme-pci: disable write zeroes on various Kingston SSD

 MAINTAINERS                    |  6 ++++++
 drivers/nvme/host/apple.c      |  2 ++
 drivers/nvme/host/core.c       |  8 ++++++--
 drivers/nvme/host/hwmon.c      | 32 ++++++++++++++++++++++----------
 drivers/nvme/host/pci.c        | 10 ++++++++++
 drivers/nvme/target/configfs.c |  4 ----
 drivers/nvme/target/core.c     |  2 +-
 7 files changed, 47 insertions(+), 17 deletions(-)
