Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAE4C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 09:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348894AbiCPJnt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 05:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244653AbiCPJnr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 05:43:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB5B6548B
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 02:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=AsIUq7+RSnqQQnR7oUJiLxsWazVuQ1qtZlXnVGn+QTU=; b=1/uLy0v/FCjpGeFg5RGjFTCn/q
        O6FcRKVxY32cZph4lEKD6NOFJZCY6NAPeBOsDvTT0oq0tY6HbNMjP8yw/HxlS8ruvJjyH7/yoXbTh
        qpTDcquMbUjxJnUA+SUlG+o4Rsrt2iqMn1DIe4O/H3BaE2yK3z4lcpRuKphbcjW/XSzbt5PslM4gj
        2jIpORFOv3bHPZsuq8JjKAU+FHeOfccVmK/3Y/ynv1Ta/6NFrCjq+ljvNfK9LocG864tAfp1SYQ5N
        CetnLyHZaSTCb2tFNsfIsmoo0pDUoTF69ljGsta1K2kD9jduxGcUcMTt5s0Ul+ph6i4OUHFUGa6Ud
        4zxkSG7Q==;
Received: from [46.140.54.162] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUQAp-00CLip-7J; Wed, 16 Mar 2022 09:42:31 +0000
Date:   Wed, 16 Mar 2022 10:42:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for Linux 5.17
Message-ID: <YjGxBNRRK/VLVYsF@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit c2700d2886a87f83f31e0a301de1d2350b52c79b:

  nvme-tcp: send H2CData PDUs based on MAXH2CDATA (2022-02-23 14:43:11 +0100)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.17-2022-03-16

for you to fetch changes up to 0c48645a7f3988a624767d025fa3275ae24b6ca1:

  nvmet: revert "nvmet: make discovery NQN configurable" (2022-03-15 10:39:26 +0100)

----------------------------------------------------------------
nvme fix for Linux 5.17

 - last minute revert of a nvmet feature added in Linux 5.16
   (Hannes Reinecke)

----------------------------------------------------------------
Hannes Reinecke (1):
      nvmet: revert "nvmet: make discovery NQN configurable"

 drivers/nvme/target/configfs.c | 39 ---------------------------------------
 drivers/nvme/target/core.c     |  3 +--
 2 files changed, 1 insertion(+), 41 deletions(-)
