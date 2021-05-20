Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87610C433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 08:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6671C6101D
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 08:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhETIBz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 04:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhETIBy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 04:01:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A011CC061574
        for <linux-block@vger.kernel.org>; Thu, 20 May 2021 01:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=dE8Lo+3vJDjvMKY8HxjGzIEklnY+Y10fde7MXLYU6KQ=; b=ESJBNKmDRtma+DN/PXXmAJEdjd
        QkLpJHYP5CZ1bcxaEjghJQXHITnZJGPHRiAkW8JyzCfouoRA0g0YOnF1wQI468ZlyE/lLGzGC7N+c
        EqwVl47C7GM+iwxM6w3zbWd+iaV0O9pgX6WzpBhZLAds1akCWLNA6HbtiJQxb2BEX3KMbE7yjqWfQ
        E5drchuOA8D/S/AloXjukBNyrzqlkl7SZYfcsiJYPVwDP07w79rVc78CcE6kxhadMzXhl2QGRJqBq
        XUd/lI8Ih1Q7gk+3JFt8HYiWkCA3s4MpscFbWB7MBlc0m851Bvtxl3HtAAo5gsIDnoihhccO0ohwK
        XbjOnMaA==;
Received: from [2001:4bb8:180:5add:a633:7cce:5450:3d63] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljdbY-00G3DO-Op; Thu, 20 May 2021 08:00:29 +0000
Date:   Thu, 20 May 2021 10:00:26 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.or
Subject: [GIT PULL] nvme fixes for Linux 5.13
Message-ID: <YKYXGnF6ywgyBTsB@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 4bc2082311311892742deb2ce04bc335f85ee27a:

  block/partitions/efi.c: Fix the efi_partition() kernel-doc header (2021-05-14 09:00:06 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.13-2021-05-20

for you to fetch changes up to a7d139145a6640172516b193abf6d2398620aa14:

  nvme-fc: clear q_live at beginning of association teardown (2021-05-19 08:40:24 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.13:

 - nvme-tcp corruption and timeout fixes (Sagi Grimberg, Keith Busch)
 - nvme-fc teardown fix (James Smart)
 - nvmet/nvme-loop memory leak fixes (Wu Bo)

----------------------------------------------------------------
James Smart (1):
      nvme-fc: clear q_live at beginning of association teardown

Keith Busch (1):
      nvme-tcp: rerun io_work if req_list is not empty

Sagi Grimberg (1):
      nvme-tcp: fix possible use-after-completion

Wu Bo (2):
      nvmet: fix memory leak in nvmet_alloc_ctrl()
      nvme-loop: fix memory leak in nvme_loop_create_ctrl()

 drivers/nvme/host/fc.c     | 12 ++++++++++++
 drivers/nvme/host/tcp.c    |  5 +++--
 drivers/nvme/target/core.c |  2 +-
 drivers/nvme/target/loop.c |  4 +++-
 4 files changed, 19 insertions(+), 4 deletions(-)
