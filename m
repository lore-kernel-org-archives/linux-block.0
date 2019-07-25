Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF6EC7618B
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 14:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D02522BF5
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 14:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fzgOjweO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfGYOMx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:12:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfGYOMx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 10:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+4E4lZssCctCWVfjKoqc+Tj2zmP8rN3Ob2M5Bqs4iLQ=; b=fzgOjweOdWP9aK4IbNFbYSzAhO
        olbHbdiz6mfa8reC4O35SEvDTeUKoOmi0fnDDY7hpuYXpeNvzQfCBB5RglQ0uZ4cXCSiG6KxVSaZG
        vmSEYkBxY+/0py98FVgwSQP07OHp2Xs82tMd1285xU1HHbT80vyx7HS+HPwAQpcGozme27UPnjqEi
        I4blL47duUsffHw8zgZfrcOuQwzHrL3mazOxpvoh71EitzoDoFx3zNVMlBtI39A7zMsRceCT4O7BD
        mtQ10j2B/6M7EQdYQQ9d9dWrRdbJG37qFosFT+cOqUXAkp47SEClgYIjfcO7zoy4vslC9CE40b5aI
        ZHsoMx3w==;
Received: from p57b3f613.dip0.t-ipconnect.de ([87.179.246.19] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqeUF-0004iD-3O; Thu, 25 Jul 2019 14:12:51 +0000
Date:   Thu, 25 Jul 2019 16:12:45 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.3
Message-ID: <20190725141245.GA4339@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


The following changes since commit 77ce56e2bfaa64127ae5e23ef136c0168b818777:

  drbd: dynamically allocate shash descriptor (2019-07-23 07:35:18 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.3

for you to fetch changes up to 8fe34be14ecb5eb0ef8d8d44aa7ab62d9e2911ca:

  Revert "nvme-pci: don't create a read hctx mapping without read queues" (2019-07-23 17:47:02 +0200)

----------------------------------------------------------------
Logan Gunthorpe (1):
      nvme: fix memory leak caused by incorrect subsystem free

Marta Rybczynska (1):
      nvme: fix multipath crash when ANA is deactivated

Misha Nasledov (1):
      nvme: ignore subnqn for ADATA SX6000LNP

yangerkun (1):
      Revert "nvme-pci: don't create a read hctx mapping without read queues"

 drivers/nvme/host/core.c      | 12 +++++-------
 drivers/nvme/host/multipath.c |  8 ++------
 drivers/nvme/host/nvme.h      |  6 +++++-
 drivers/nvme/host/pci.c       |  6 +++---
 4 files changed, 15 insertions(+), 17 deletions(-)
