Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D819C636CC
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 18:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBOSPC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 13:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBOSPB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 13:15:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DA93B66B
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 10:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=JQDo9eSogJXBMc9CSfG/vB0RLOaVwYu0XKME5Qid7hM=; b=KeEyPqXshJ3hQRaCt0l7F27nor
        iit6ghh7LK19xsliUMZDYM1bUHVdxiPol6ghJ5SHC5QYWvb6f/fvoE4ZXf9U126+tYXJ1jlVk/6Ri
        T/AlCVLNg76PM7Me05OvJZS25lWCzNKKiMqrf+R6zFd0CQ5fgWRsdw6rbiuKBau+2/KEbmllOn7km
        PNpa/JesjyP+qgMTwNGgej/Z0pR0I+ka031OOmF/OddARTclF4/cTXUM9CM5hMLq/7x7oUJj+wEMy
        lqh3Zt/Qfr6dbwTzFnzr3QEMyszLh/GwHTJZ9SUIaeh20VIDDUhuV0RRj36sjDwHQ/mEpC2y2e67h
        wLSDP6yA==;
Received: from [2001:4bb8:181:6771:d204:2f73:7b8d:611c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSMIy-006oc2-9s; Wed, 15 Feb 2023 18:14:56 +0000
Date:   Wed, 15 Feb 2023 19:14:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y+0hG6t1gTse7yfo@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 38c33ece232019c5b18b4d5ec0254807cac06b7c:

  Merge tag 'nvme-6.2-2023-02-09' of git://git.infradead.org/nvme into block-6.2 (2023-02-09 08:12:06 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2023-02-15

for you to fetch changes up to dc785d69d753a3894c93afc23b91404652382ead:

  nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev (2023-02-14 06:39:02 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - always return an ERR_PTR from nvme_pci_alloc_dev (Irvin Cote)
 - add bogus ID quirk for ADATA SX6000PNP (Daniel Wagner)
 - set the DMA mask earlier (Christoph Hellwig)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme-pci: set the DMA mask earlier

Daniel Wagner (1):
      nvme-pci: add bogus ID quirk for ADATA SX6000PNP

Irvin Cote (1):
      nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev

 drivers/nvme/host/pci.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)
