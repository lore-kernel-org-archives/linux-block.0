Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE73C6FA89
	for <linux-block@archiver.kernel.org>; Thu,  8 Sep 2022 15:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiIHPfe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Sep 2022 11:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiIHPfc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Sep 2022 11:35:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D62B248B
        for <linux-block@vger.kernel.org>; Thu,  8 Sep 2022 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Zk3pK1fMADHPvgH2vaLLhOL6VnBqBDqbgLBUcfh+dYI=; b=x5OTHRdOLeTXJtkuIgY4/w41oS
        HGfRkUsOMG/aLT+YUkCIDKcktiJMKa7ykztHXFyZf6X6kfw2m2gLhhihVFyQvu0xvhBTeb1Q+2Xws
        XHHBQGUbMK9rKCxgHI8OgQqQ7LencrQeeQWsy99ZuSGyR8zRVw3GqiBqJAmO7Ev91b89gkx/c2vkU
        sW7E48mGF3BigaItitmguXxX6Knawzh0XYKnCXJ1j/6dNx/2ksdFiA+ijvbsp1HtSSxXa3sZnA4GX
        hfhZT2rVquzrsKhJ6vGJrLhRP3FO9MQakU4btCyk2EgkVL76XTbEEkt5ebXlem5erHDST7vc8lB8l
        96uTBemA==;
Received: from [2001:4bb8:198:38af:d1ad:8412:49b8:c1d3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWJYn-005H08-Co; Thu, 08 Sep 2022 15:35:21 +0000
Date:   Thu, 8 Sep 2022 17:35:13 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.0
Message-ID: <YxoLsUEjritZcoK9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 748008e1da926a814cc0a054c81ca614408b1b0c:

  block: don't add partitions if GD_SUPPRESS_PART_SCAN is set (2022-09-03 11:29:03 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.0-2022-09-08

for you to fetch changes up to 371a982cd2b01487295cd87abec82357e268457b:

  nvme: requeue aen after firmware activation (2022-09-07 08:38:25 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - fix a use after free in nvmet (Bart Van Assche)
 - fix a use after free when detecting digest errors (Sagi Grimberg)
 - fix regression that causes sporadic TCP requests to time out
   (Sagi Grimberg)
 - fix two off by ones errors in the nvmet ZNS support
   (Dennis Maisenbacher)
 - requeue aen after firmware activation (Keith Busch)

----------------------------------------------------------------
Bart Van Assche (1):
      nvmet: fix a use-after-free

Dennis Maisenbacher (1):
      nvmet: fix mar and mor off-by-one errors

Keith Busch (1):
      nvme: requeue aen after firmware activation

Sagi Grimberg (2):
      nvme-tcp: fix UAF when detecting digest errors
      nvme-tcp: fix regression that causes sporadic requests to time out

 drivers/nvme/host/core.c   | 14 +++++++++++---
 drivers/nvme/host/tcp.c    |  7 ++-----
 drivers/nvme/target/core.c |  6 ++++--
 drivers/nvme/target/zns.c  | 17 +++++++++++++++--
 4 files changed, 32 insertions(+), 12 deletions(-)
