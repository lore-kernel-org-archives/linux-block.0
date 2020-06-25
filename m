Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A537C433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 16:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3A9206BE
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 16:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GmrGiSe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390841AbgFYQx4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390448AbgFYQx4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 12:53:56 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6558BC08C5DB
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Ovbcs12mvJLszoemDpWBQMsw9noi17CuGO1me0ZW8EI=; b=GmrGiSe0Cn0dLfIls2yj5qr3YB
        yfIGj/KxWmRTkfLnu+S9mrQgFWaPZqQU8QRtbclgttgsiL0FZLEyFt0Qd3WWzPZ7SmoBvAlVcGlzZ
        LhNf7BzzANmBWrL9YA1OyfjrfwPI21knLIIm3/t0PVuvcSCN3JuwsF1LI02apQhopqc9ghmgGtu62
        WAtWf33wK74U3hXclFTgr/dNeYeORLGDumstRPcIsMSkQPcTy9emrmkA+Osn5OwCyRXwB1WkD0Emj
        2QBWYg5WkRTHkAYG7Rh4I8dQ7HT+YnJYVvY0jT9znKfYFH8vnDjMn5Cs7zgmGgXaKJVs9Vk4LwueR
        4s5ozfjA==;
Received: from [2001:4bb8:184:76e3:ac72:d772:f6e1:212] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joV83-0000DB-4N; Thu, 25 Jun 2020 16:53:35 +0000
Date:   Thu, 25 Jun 2020 18:53:33 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme fixes for 5.8
Message-ID: <20200625165333.GA1982738@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 0b8eb629a700c0ef15a437758db8255f8444e76c:

  block: release bip in a right way in error path (2020-06-24 08:49:07 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.8

for you to fetch changes up to c31244669f57963b6ce133a5555b118fc50aec95:

  nvme-multipath: fix bogus request queue reference put (2020-06-24 18:41:20 +0200)

----------------------------------------------------------------
Anton Eidelman (2):
      nvme-multipath: fix deadlock between ana_work and scan_work
      nvme-multipath: fix deadlock due to head->lock

Max Gurtovoy (6):
      nvme: set initial value for controller's numa node
      nvme-pci: override the value of the controller's numa node
      nvme-pci: initialize tagset numa value to the value of the ctrl
      nvme-tcp: initialize tagset numa value to the value of the ctrl
      nvme-loop: initialize tagset numa value to the value of the ctrl
      nvme-rdma: assign completion vector correctly

Sagi Grimberg (3):
      nvme: fix possible deadlock when I/O is blocked
      nvme: don't protect ns mutation with ns->head->lock
      nvme-multipath: fix bogus request queue reference put

 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 46 +++++++++++++++++++++++++++----------------
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/pci.c       |  6 ++++--
 drivers/nvme/host/rdma.c      |  2 +-
 drivers/nvme/host/tcp.c       |  4 ++--
 drivers/nvme/target/loop.c    |  4 ++--
 7 files changed, 41 insertions(+), 25 deletions(-)
