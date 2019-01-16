Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140FDC43444
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 16:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0FD20657
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 16:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VPn8TLLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfAPQha (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:37:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393884AbfAPQh3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 11:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=guvi/GHo/iKAReSPcz+pJILJKFMwRZ17kSWUW6ChUpU=; b=VPn8TLLb0f7vKQv7sugMysl6vd
        CzyOQXajk5vgjI8HcIMKFvFNHkVhmd/VNj/bm0sTjiUHcsxF+RhwyeuDKFbTVPehYoh68BCyyv2bH
        FJ3/sWb9rRdpV4aeAAzP+iIxLFV2Khd8kLnkABc5NzVItQURwdRwQhxSJX/giaUUVCwC+Lib2BrS5
        DSlgG1CNd/ivFJnnIxEaCkH7X4VO/JfglR6urCOKYwuyWjUtvsgSUCzPW8PAqe+GHaqiqVQlnZ6Bj
        YtVZlMIyEIDHKRVO7eY0PykTzQbnTvt3bZgFqGLns222krQl1cYwSUWXuSzif2yUeeufZ9nqUMCCe
        vCuLYLDQ==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjoBy-0002g7-Qe; Wed, 16 Jan 2019 16:37:27 +0000
Date:   Wed, 16 Jan 2019 17:37:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] two nvme fixes for 5.0-rc3
Message-ID: <20190116163724.GA24217@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 8218a55b6b911d396565da4ed5ca8b18bf0d38fb:

  sbitmap: Protect swap_lock from hardirq (2019-01-14 21:30:32 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.0

for you to fetch changes up to eda14f8977df052dce3a9c54a6bf8d8f76c96eb1:

  nvme-pci: fix nvme_setup_irqs() (2019-01-15 06:50:52 +0100)

----------------------------------------------------------------
Ming Lei (1):
      nvme-pci: fix nvme_setup_irqs()

Sagi Grimberg (1):
      nvmet-tcp: fix uninitialized variable access

 drivers/nvme/host/pci.c   | 21 +++++++++++++--------
 drivers/nvme/target/tcp.c |  2 +-
 2 files changed, 14 insertions(+), 9 deletions(-)
