Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1B1FA3740
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 13:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiJ0Nr1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 09:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiJ0Nr0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 09:47:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BE4183E11
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/ROsJgpE9rEMRCM5qmh8UCJsLoFKZuXuJf1k45OIp/M=; b=JDSWNNqlyOvBbKyi085bBHaMbh
        W+W5r5l5d8t6yVLovl7Z3ZQMTjDMs1IDQ7NDn+UN5LrHpquyBXDYU1+laNQ66ljbuJfkAZbcW6nqf
        ne55ZgeDzBmW1qgLWUXXF7ROoI9KJ00iWxBinPAD41YuOxFzU6UaJ03hFfeq9NDKhSfpHFQe3hWDW
        OP7jTi9GBlw4st/aWGrB3/ZA+OrSjmL+Gq9x+6lmvWQdnd0V+p6IwxJ4wn/1DMB3b5sncjL4DliOL
        iKV2ZMPIHiXnzKRc9S9n0j66Nxu45xw9FSoe+YQKj+DLEpQpasqCNlLvpbEwU5a1JTx3csJp/ojl3
        yAOgRLEg==;
Received: from [88.128.92.137] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oo3E4-00DfsB-Rd; Thu, 27 Oct 2022 13:47:17 +0000
Date:   Thu, 27 Oct 2022 15:47:03 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.1
Message-ID: <Y1qL1zsNFc6w2WTd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 02341a08c9dec5a88527981b0bdf0fb6f7499cbf:

  block: fix memory leak for elevator on add_disk failure (2022-10-22 15:14:38 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-10-27

for you to fetch changes up to fe8714b04fb137aa62e9a69424c48b5301b721b9:

  nvme-multipath: set queue dma alignment to 3 (2022-10-25 08:07:53 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - make the multipath dma alignment to match the non-multipath one
   (Keith Busch)
 - fix a bogus use of sg_init_marker() (Nam Cao)
 - fix circulr locking in nvme-tcp (Sagi Grimberg)

----------------------------------------------------------------
Keith Busch (1):
      nvme-multipath: set queue dma alignment to 3

Nam Cao (1):
      nvme-tcp: replace sg_init_marker() with sg_init_table()

Sagi Grimberg (1):
      nvme-tcp: fix possible circular locking when deleting a controller under memory pressure

 drivers/nvme/host/multipath.c |  1 +
 drivers/nvme/host/tcp.c       | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)
