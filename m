Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E73C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 14:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A528E2084A
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 14:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B84DkrWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeLSOUU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:20:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729323AbeLSOUU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 09:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lIpQgA0nbVjG5cS6Y3emdcp/477lZ1qJEPobct/fUwY=; b=B84DkrWNOwoxLg570f1cHxOYGw
        A9L00A2m9cgn3D0vNSh0304ePbxmFjfxwOAc2reVrSepY+JY/2XR7oFvm5LdZT4Ra/oFC6S8qTsds
        e/O1DwHfXQBqVQIjgOtWUCEw2WayTMrRsKtpJm4lZz1khC04fzowdsVz99D9PghfP317BGgYz+pPS
        13zlr+YrgNsXah1z6LDVumPHJjsS5J4d9R1y0F84lW9o8/8n/SHcP3Ad09Bkl74hfN2s4r2pW//+U
        cMk8LNXnsUUOKdbzNBl+YuX4sS/vAxyJSkRgCLDNjBjp1hiICkO32YaFFJ/VYHT5mT2+b0BLgw8i0
        L2RJSbWA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZchu-0004yY-Dy; Wed, 19 Dec 2018 14:20:18 +0000
Date:   Wed, 19 Dec 2018 15:20:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] third batch of nvme updates for 4.21
Message-ID: <20181219142015.GA960@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

the remaining nvme updates for this merge window below.  This contains
a series from Sagi to restore poll support for nvme-rdma, a new
tracepoint from yupeng and various fixes.


The following changes since commit cd19181bf9ad4b7f40f2a4e0355d052109c76529:

  blk-mq: enable IO poll if .nr_queues of type poll > 0 (2018-12-17 21:35:07 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.21

for you to fetch changes up to 604c01d567cb9ee7d19dc598272cb90ab6229a8a:

  nvme-pci: trace SQ status on completions (2018-12-19 08:35:36 +0100)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: use a macro for default error location

Christoph Hellwig (4):
      nvme-pci: only set nr_maps to 2 if poll queues are supported
      nvme-pci: refactor nvme_poll_irqdisable to make sparse happy
      nvmet-tcp: fix endianess annotations
      nvme-tcp: fix endianess annotations

Colin Ian King (2):
      nvmet: fix comparison of a u16 with -1
      nvme-tcp: fix spelling mistake "attepmpt" -> "attempt"

Sagi Grimberg (5):
      block: make request_to_qc_t public
      nvme-core: optionally poll sync commands
      nvme-fabrics: allow nvmf_connect_io_queue to poll
      nvme-fabrics: allow user to pass in nr_poll_queues
      nvme-rdma: implement polling queue map

yupeng (1):
      nvme-pci: trace SQ status on completions

 block/blk-mq.c              |  8 --------
 drivers/nvme/host/core.c    | 38 ++++++++++++++++++++++++++++++-----
 drivers/nvme/host/fabrics.c | 25 +++++++++++++++++------
 drivers/nvme/host/fabrics.h |  5 ++++-
 drivers/nvme/host/fc.c      |  2 +-
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/pci.c     | 17 ++++++++++------
 drivers/nvme/host/rdma.c    | 49 +++++++++++++++++++++++++++++++++++++++------
 drivers/nvme/host/tcp.c     | 13 ++++++------
 drivers/nvme/host/trace.c   |  3 +++
 drivers/nvme/host/trace.h   | 23 +++++++++++++++++++++
 drivers/nvme/target/core.c  |  4 ++--
 drivers/nvme/target/loop.c  |  2 +-
 drivers/nvme/target/nvmet.h |  1 +
 drivers/nvme/target/tcp.c   |  4 ++--
 include/linux/blk-mq.h      | 10 +++++++++
 include/linux/blk_types.h   | 11 ----------
 17 files changed, 161 insertions(+), 56 deletions(-)
