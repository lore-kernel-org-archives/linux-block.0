Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF971C6FD1F
	for <linux-block@archiver.kernel.org>; Thu, 16 Mar 2023 07:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCPH7I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Mar 2023 03:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjCPH7H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Mar 2023 03:59:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1C32CC71
        for <linux-block@vger.kernel.org>; Thu, 16 Mar 2023 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XTBXPgJaAS/Rk+rOJ2daFp/gw2en9Iwyy0SadIzG7Oo=; b=b8ZdSEa8hvhtb7D0gEjRpezPsx
        7V3umsxINJnwDpF/KFmrDtt9GjhZ8WC/ChWqNylgUfElMZP9CrNg+IYXzsdLjfDX0hXRdm1RKkZlE
        +/QpeoiBEZhRoAAxKMmOy5DhLDvfK8U+564xcLtyA0k5n/ctRyk6DS7xzHhM55VRuwAuC/PL8iCfL
        PfphBeVLU3hqUWS5warRGZ/zd8fqteE0jAdVPFp2cvjEIBUMEK+zgxgaltPNcbF6RHzNB3g59kKXw
        8e9hDgpb/XqO6aMBNEMKIh/81qiJwWaXpVPAj5iDUnWB3uL4/4yebn31Y5QunjBc8fCf3/UCDvXT1
        G3Gfu2Tg==;
Received: from 213-225-12-242.nat.highway.a1.net ([213.225.12.242] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pciVZ-00FZUS-1r;
        Thu, 16 Mar 2023 07:58:45 +0000
Date:   Thu, 16 Mar 2023 08:58:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.3
Message-ID: <ZBLMMaLFyRsgOvGp@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit b6402014cab0481bdfd1ffff3e1dad714e8e1205:

  block: null_blk: cleanup null_queue_rq() (2023-03-15 06:50:24 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.3-2022-03-16

for you to fetch changes up to 6173a77b7e9d3e202bdb9897b23f2a8afe7bf286:

  nvmet: avoid potential UAF in nvmet_req_complete() (2023-03-15 14:58:53 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.3

 - avoid potential UAF in nvmet_req_complete (Damien Le Moal)
 - more quirks (Elmer Miroslav Mosher Golovin, Philipp Geulen)
 - fix a memory leak in the nvme-pci probe teardown path (Irvin Cote)
 - repair the MAINTAINERS entry (Lukas Bulwahn)
 - fix handling single range discard request (Ming Lei)
 - show more opcode names in trace events (Minwoo Im)
 - fix nvme-tcp timeout reporting (Sagi Grimberg)

----------------------------------------------------------------
Damien Le Moal (1):
      nvmet: avoid potential UAF in nvmet_req_complete()

Elmer Miroslav Mosher Golovin (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Netac NV3000

Irvin Cote (1):
      nvme-pci: fixing memory leak in probe teardown path

Lukas Bulwahn (1):
      MAINTAINERS: repair malformed T: entries in NVM EXPRESS DRIVERS

Ming Lei (1):
      nvme: fix handling single range discard request

Minwoo Im (1):
      nvme-trace: show more opcode names

Philipp Geulen (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM620

Sagi Grimberg (2):
      nvme-tcp: fix opcode reporting in the timeout handler
      nvme-tcp: add nvme-tcp pdu size build protection

 MAINTAINERS                |  8 ++++----
 drivers/nvme/host/core.c   | 28 +++++++++++++++++++---------
 drivers/nvme/host/pci.c    |  5 +++++
 drivers/nvme/host/tcp.c    | 33 +++++++++++++++++++++++++++------
 drivers/nvme/target/core.c |  4 +++-
 include/linux/nvme.h       |  5 +++++
 6 files changed, 63 insertions(+), 20 deletions(-)
