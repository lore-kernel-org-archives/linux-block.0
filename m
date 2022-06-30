Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD20C43334
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 19:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiF3TqH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 15:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiF3TqH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 15:46:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C4043ED6
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qKA/0EDphzmE7teYjAVKD3Zy6wo8eZpKG69ysKigGm4=; b=e7vLdT2P8M5VU2+c/EZiwm9JOJ
        zLMErjAF/sHkj5SZYDIs7zf4MGqjXOge4/LBMFrkkZLfuTukJZjNvPWN+o0UKpsm4NScRax3g+QOo
        SMajPC8HS0SORtaUfo6G49txeO43yzOUA8SzH/A+Rf9gJLKHQFYEYwB/SsS7uBgtu3INpO/fnubWO
        nrgCs8yb1bL+jHkmyRgPTXpOOnVZLu6p45s2Lv+zdJ+yN0s5MAjKD7xPinJIuyHPZAj1H6+xGeFXL
        WdiNZn0i3hkRvgRcKxBZNnkDnUIoNk4j3wdm7BIcIz5eiXOWXj2xsvn1z5Je6chlBvCQE0hY2qByH
        2NaYvMoQ==;
Received: from [2001:4bb8:199:3788:3ea8:4fde:60a4:7dbf] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o706w-001FhN-Iv; Thu, 30 Jun 2022 19:45:59 +0000
Date:   Thu, 30 Jun 2022 21:45:56 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <Yr39dC2Hf2/LtgXq@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit fbb564a557809466c171b95f8d593a0972450ff2:

  lib/sbitmap: Fix invalid loop in __sbitmap_queue_get_batch() (2022-06-25 10:58:55 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-30

for you to fetch changes up to e1c70d79346356bb1ede3f79436df80917845ab9:

  nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA IM2P33F8ABR1 (2022-06-30 08:24:33 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.19

 - more quirks (Lamarque Vieira Souza, Pablo Greco)
 - fix a fabrics disconnect regression (Ruozhu Li)
 - fix a nvmet-tcp data_digest calculation regression (Sagi Grimberg)
 - fix nvme-tcp send failure handling (Sagi Grimberg)
 - fix a regression with nvmet-loop and passthrough controllers
   (Alan Adamson)

----------------------------------------------------------------
Alan Adamson (1):
      nvmet: add a clear_ids attribute for passthru targets

Lamarque Vieira Souza (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA IM2P33F8ABR1

Pablo Greco (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG SX6000LNP (AKA SPECTRIX S40G)

Ruozhu Li (1):
      nvme: fix regression when disconnect a recovering ctrl

Sagi Grimberg (2):
      nvmet-tcp: fix regression in data_digest calculation
      nvme-tcp: always fail a request when sending it failed

 drivers/nvme/host/core.c       |  2 ++
 drivers/nvme/host/nvme.h       |  1 +
 drivers/nvme/host/pci.c        |  5 +++-
 drivers/nvme/host/rdma.c       | 12 ++++++---
 drivers/nvme/host/tcp.c        | 13 ++++++----
 drivers/nvme/target/configfs.c | 20 +++++++++++++++
 drivers/nvme/target/core.c     |  6 +++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 55 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/tcp.c      | 23 +++---------------
 10 files changed, 109 insertions(+), 29 deletions(-)
