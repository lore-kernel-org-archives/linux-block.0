Return-Path: <SRS0=7dNq=DE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D337BC4346E
	for <linux-block@archiver.kernel.org>; Sun, 27 Sep 2020 07:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FFA239E5
	for <linux-block@archiver.kernel.org>; Sun, 27 Sep 2020 07:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gdUcf1qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgI0HXu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Sep 2020 03:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730330AbgI0HXt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Sep 2020 03:23:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4963C0613CE
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2020 00:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=36mN1mB4d5Gu6vgKrDnTuZBkOpRA6jqzrm+jMSZth4g=; b=gdUcf1qkpEy4ENvvyVdXFYH37s
        xTbtfR5rKSLM21D/vOHoiHpvEvs/5Hjsg2D68xTh1kYdmYpcbOwLAQDZdGpXykPUhUN2ff8pSJ/fu
        0ywGQY9LtXqapc/y69PG4jCm0sgrmCL8mNUL7gp3HQ4fFYEULnPnZ8MumI9GRhKZZh8+CYYBzv1wf
        9TIUVOOMGG9S3ethnB3sVuF4nTej3ufxlrILv08zpAl4MQVIxVeE0yHFhtCwiA0C8Zh3We8rZY9Kg
        aNAgocfOi4xQ7G2Jha7gOdkQ1U4XqxCgu8Pj6MKm4UisG3AhqSR40W+7QsPNheea8nUKVZsg+tmZw
        g2sasiJA==;
Received: from [46.189.67.162] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMR28-0001Es-4R; Sun, 27 Sep 2020 07:23:46 +0000
Date:   Sun, 27 Sep 2020 09:23:43 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for 5.10
Message-ID: <20200927072343.GA381603@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 163090c14a42778c3ccfbdaf39133129bea68632:

  Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.10/drivers (2020-09-25 07:48:20 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.10-2020-09-27

for you to fetch changes up to 21cc2f3f799fa228f812f7ab971fa8d43c893392:

  nvme-pci: allocate separate interrupt for the reserved non-polled I/O queue (2020-09-27 09:14:19 +0200)

----------------------------------------------------------------
nvme updates for 5.10

 - fix keep alive timer modification (Amit Engel)
 - order the PCI ID list more sensibly (Andy Shevchenko)
 - cleanup the open by controller helper (Chaitanya Kulkarni)
 - use an xarray for th CSE log lookup (Chaitanya Kulkarni)
 - support ZNS in nvmet passthrough mode (Chaitanya Kulkarni)
 - fix nvme_ns_report_zones (me)
 - add a sanity check to nvmet-fc (James Smart)
 - fix interrupt allocation when too many polled queues are specified
   (Jeffle Xu)
 - small nvmet-tcp optimization (Mark Wunderlich)

----------------------------------------------------------------
Amit Engel (1):
      nvmet: handle keep-alive timer when kato is modified by a set features cmd

Andy Shevchenko (1):
      nvme-pci: Move enumeration by class to be last in the table

Chaitanya Kulkarni (3):
      nvme: lift the file open code from nvme_ctrl_get_by_path
      nvme: use an xarray to lookup the Commands Supported and Effects log
      nvmet: add passthru ZNS support

Christoph Hellwig (1):
      nvme: fix error handling in nvme_ns_report_zones

James Smart (1):
      nvmet-fc: fix missing check for no hostport struct

Jeffle Xu (1):
      nvme-pci: allocate separate interrupt for the reserved non-polled I/O queue

Mark Wunderlich (1):
      nvmet-tcp: have queue io_work context run on sock incoming cpu

 drivers/nvme/host/core.c        | 56 +++++++----------------------------------
 drivers/nvme/host/nvme.h        |  4 +--
 drivers/nvme/host/pci.c         | 35 +++++++++++++-------------
 drivers/nvme/host/zns.c         | 41 ++++++++++++------------------
 drivers/nvme/target/admin-cmd.c |  2 ++
 drivers/nvme/target/core.c      |  4 +--
 drivers/nvme/target/fc.c        |  2 +-
 drivers/nvme/target/nvmet.h     |  2 ++
 drivers/nvme/target/passthru.c  | 43 +++++++++++++++++++++++--------
 drivers/nvme/target/tcp.c       | 21 ++++++++--------
 10 files changed, 93 insertions(+), 117 deletions(-)
