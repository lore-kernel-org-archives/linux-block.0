Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36F7C433FE
	for <linux-block@archiver.kernel.org>; Wed, 12 Oct 2022 11:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJLLnm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Oct 2022 07:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJLLnl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 07:43:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B53DBC447
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 04:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xuI5WpzLw1rW8zeQaM0Q5WLGLHWTcZ4vvuuKWWp996U=; b=igG7i8iGVqTfUQbk7aoFbVJ1lg
        BrRH3zkssp7Yx95zt4EaeiE55lzPGLy4RNvhxGN3al5p8sKhi+opJp/re2UyzlxM/C2G3TgI7KadT
        WZe3jR4acjqbZNM808UnnHE26NDipnKRNSHXhDJ5lg300wcOyAixOECEoxUgP0XFcgbmskfMHqf0e
        dvUBYy9X8/tpgW+7l6+dMK5YmONG28QnGgCxFUpLkIDqr/sRDWai59aIbfNySgvJjFWQQ5GQRmNc1
        MH71g+XmIPVqU7rgaenKCNa9QBQgA6xXw8Fis88er/O1BFM3cF+dna0oqYQickpyauZCH7MGI5p15
        TpqKkJew==;
Received: from 089144213149.atnat0022.highway.a1.net ([89.144.213.149] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oia96-007qez-Nj; Wed, 12 Oct 2022 11:43:34 +0000
Date:   Wed, 12 Oct 2022 13:43:29 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.1
Message-ID: <Y0aoYSBCx2Wrw74I@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 24a403340d70aad3667b3ee0f9a7aa5c0a5193a0:

  Merge branch 'for-6.1/block' into block-6.1 (2022-10-10 11:26:40 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-10-12

for you to fetch changes up to 72e3b8883a36e80ebfa41015c7b6926ce31ace05:

  nvme-multipath: fix possible hang in live ns resize with ANA access (2022-10-12 11:42:58 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - add NVME_QUIRK_BOGUS_NID for Lexar NM760 (Abhijit)
 - avoid the deepest sleep state on ZHITAI TiPro5000 SSDs (Xi Ruoyao)
 - fix possible hang caused during ctrl deletion (Sagi Grimberg)
 - fix possible hang in live ns resize with ANA access (Sagi Grimberg)

----------------------------------------------------------------
Abhijit (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM760

Sagi Grimberg (3):
      nvme-rdma: fix possible hang caused during ctrl deletion
      nvme-tcp: fix possible hang caused during ctrl deletion
      nvme-multipath: fix possible hang in live ns resize with ANA access

Xi Ruoyao (1):
      nvme-pci: avoid the deepest sleep state on ZHITAI TiPro5000 SSDs

 drivers/nvme/host/multipath.c | 1 +
 drivers/nvme/host/pci.c       | 4 ++++
 drivers/nvme/host/rdma.c      | 2 +-
 drivers/nvme/host/tcp.c       | 2 +-
 4 files changed, 7 insertions(+), 2 deletions(-)
