Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D490C433FE
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 07:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiA0HT2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 02:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiA0HT1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 02:19:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853CAC061714
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 23:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=p2vjoJd92tcYa7NYh6W4PPS0sqzlcejZJmZ8SEX5nyM=; b=VF1qi99ewUOoGN8UGvVMF1EGU+
        MiIMftXl0f16MvSwiOv49kNIYCVb6VKeK2O8ECPdXgIXrmqYHOsJoOhev6yifcHQmwQwZZb5J8Gys
        j3uGPxHeO4u3VaVDZjnqnGFrItoRSfYCSwS1+DD2JzdgTvth3X2Q6gY9T91Yxe7tpNMUr0yaHp5s0
        y7kG3bNHcGJ4/IKnnQaVq10yX6vpR26iw8Sl5OZE1f4NXBz/7tr3Aacv9nTZdprSfaTNPrLLWj1at
        1ef/3UgBuEfDWze4eg6+gzhl8QruV+dUjXi+ZmMaYwuE1osXRk7TZepD+wiPZAAucR918+VHo43iI
        svbyk5+A==;
Received: from 213-225-10-69.nat.highway.a1.net ([213.225.10.69] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCz40-00EcjC-LF; Thu, 27 Jan 2022 07:19:25 +0000
Date:   Thu, 27 Jan 2022 08:19:22 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.17
Message-ID: <YfJHeoRZIPt2t3aP@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 83114df32ae779df57e0af99a8ba6c3968b2ba3d:

  block: fix memory leak in disk_register_independent_access_ranges (2022-01-23 09:13:09 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.17-2022-01-27

for you to fetch changes up to a5f3851b7f7951e8d4ba0a9ba3b5308a5f250a2d:

  nvme-fabrics: remove the unneeded ret variable in nvmf_dev_show (2022-01-27 08:17:17 +0100)

----------------------------------------------------------------
nvme fixes for Linux 5.17

 - add the IGNORE_DEV_SUBNQN quirk for Intel P4500/P4600 SSDs (Wu Zheng)
 - remove the unneeded ret variable in nvmf_dev_show (Changcheng Deng)

----------------------------------------------------------------
Changcheng Deng (1):
      nvme-fabrics: remove the unneeded ret variable in nvmf_dev_show

Wu Zheng (1):
      nvme-pci: add the IGNORE_DEV_SUBNQN quirk for Intel P4500/P4600 SSDs

 drivers/nvme/host/fabrics.c | 3 +--
 drivers/nvme/host/pci.c     | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)
