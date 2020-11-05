Return-Path: <SRS0=FEuC=EL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C1FC00A89
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 07:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBA721556
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 07:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LPb9G5ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKEH6S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Nov 2020 02:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEH6S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Nov 2020 02:58:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAFFC0613CF
        for <linux-block@vger.kernel.org>; Wed,  4 Nov 2020 23:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=yAaWE6YiBPWxpGMIEhFoF9waXKR3XlNbXx2sWm1BO3Y=; b=LPb9G5wwPQtAT9kuIU5aDlWWlY
        mNSwPGlKpTRw5odKEWu0Riz7GiyWCpwyLzhcCqBBu5qHPW7TBZQqb8f0ZRWi9EpsMIODHyetrO2k+
        AVJtIjIAsaHKvTN1+NQ6cusYqxTbMJCx3oyFHQj72d0U9BaJFxiWHomGVD0RmZ/DfgdtXbGlsDI2L
        LUBwe9E9SBC28oEH+FPuwIIkwOwgPpCqSMn4oWm5jgYwDYq6oTSgFqFcIYzsyv0FpRIlFQekrnJct
        L2kSAiaP6ojaZpN/bKwdFZ2n/c5fo1cSuvEVqslZT2u3JLyf0Ug98Sr5BaHGc8v4KpFyacym5m6F9
        kWP2ZmxA==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaa9v-0005Mi-0B; Thu, 05 Nov 2020 07:58:15 +0000
Date:   Thu, 5 Nov 2020 08:56:04 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.10
Message-ID: <20201105075604.GA1690984@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 65ff5cd04551daf2c11c7928e48fc3483391c900:

  blk-mq: mark flush request as IDLE in flush_end_io() (2020-10-30 08:33:49 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.10-2020-11-05

for you to fetch changes up to 0a8a2c85b83589a5c10bc5564b796836bf4b4984:

  nvme-tcp: avoid repeated request completion (2020-11-03 10:26:02 +0100)

----------------------------------------------------------------
nvme fixes for 5.10:

 - revert a nvme_queue size optimization (Keith Bush)
 - fabrics timeout races fixes (Chao Leng and Sagi Grimberg)

----------------------------------------------------------------
Chao Leng (3):
      nvme: introduce nvme_sync_io_queues
      nvme-rdma: avoid race between time out and tear down
      nvme-tcp: avoid race between time out and tear down

Keith Busch (1):
      Revert "nvme-pci: remove last_sq_tail"

Sagi Grimberg (2):
      nvme-rdma: avoid repeated request completion
      nvme-tcp: avoid repeated request completion

 drivers/nvme/host/core.c |  8 ++++++--
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 23 +++++++++++++++++++----
 drivers/nvme/host/rdma.c | 14 +++-----------
 drivers/nvme/host/tcp.c  | 16 ++++------------
 5 files changed, 33 insertions(+), 29 deletions(-)
