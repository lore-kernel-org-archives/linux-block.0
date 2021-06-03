Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C09FC47082
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 07:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2759060E09
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 07:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhFCHHH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 03:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFCHHH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 03:07:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470A7C06174A
        for <linux-block@vger.kernel.org>; Thu,  3 Jun 2021 00:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xT5O0Opq9u5tn/WoDUi6tfqFD1xG+k4ekLP4Sd65ClI=; b=g7fK+MY7ilELzc9Pfj7oaa3/iy
        u8NOFgpWScSmCwjWCNgzuqmDprggVM7resLqiX2YwDZf+OhMf9q3wqKGhUflcKWBXutnIjEPHRI9z
        9NIpK4U4qiigPI+xpwI/3Zz+0vTuh6oguDh/tpI2IvmQ6eT/OFGuUmSi7tfeCre3pHdA4fmKspCi5
        ZOnM9rVDGUOXSJqNAQ+FAPqlFQNctKZIM5NUhek0WlehOCzsXsAAnmlWGf5/R0XKBR9S5RtMg5HA0
        Z4DExylmQc2100CxQSBhwCSuTx+Bq68pr/5UDfQqDGvKRSvXs31AUr0bhcL/a8FhRzJJ3BXb1wt1s
        T7xJ4ZGg==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lohPs-007OWW-2k; Thu, 03 Jun 2021 07:05:20 +0000
Date:   Thu, 3 Jun 2021 10:05:15 +0300
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.13
Message-ID: <YLh/K7UbJFnA2HPa@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit a4b58f1721eb4d7d27e0fdcaba60d204248dcd25:

  Merge tag 'nvme-5.13-2021-05-27' of git://git.infradead.org/nvme into block-5.13 (2021-05-27 07:38:12 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.13-2021-06-03

for you to fetch changes up to bcd9a0797d73eeff659582f23277e7ab6e5f18f3:

  nvmet: fix freeing unallocated p2pmem (2021-06-02 10:10:38 +0300)

----------------------------------------------------------------
nvme fixes for Linux 5.13:

 - fix corruption in RDMA in-capsule SGLs (Sagi Grimberg)
 - nvme-loop reset fixes (Hannes Reinecke)
 - nvmet fix for freeing unallocated p2pmem (Max Gurtovoy)

----------------------------------------------------------------
Hannes Reinecke (4):
      nvme-loop: reset queue count to 1 in nvme_loop_destroy_io_queues()
      nvme-loop: clear NVME_LOOP_Q_LIVE when nvme_loop_configure_admin_queue() fails
      nvme-loop: check for NVME_LOOP_Q_LIVE in nvme_loop_destroy_admin_queue()
      nvme-loop: do not warn for deleted controllers during reset

Max Gurtovoy (1):
      nvmet: fix freeing unallocated p2pmem

Sagi Grimberg (1):
      nvme-rdma: fix in-casule data send for chained sgls

 drivers/nvme/host/rdma.c   |  5 +++--
 drivers/nvme/target/core.c | 33 ++++++++++++++++-----------------
 drivers/nvme/target/loop.c | 11 ++++++++---
 3 files changed, 27 insertions(+), 22 deletions(-)
