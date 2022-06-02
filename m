Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E055C433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 05:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiFBF2I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 01:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiFBF2H (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 01:28:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B29C3D10
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 22:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=5TNlqvLrz3phczbzU5AJU0+CyFLEnpzfxRuuPLATMYk=; b=a/a/yRRNIzqfVtgVFtCIclE+sM
        jJvdv+IDXQI880eiQD391nVwK5xRXBaEltEb5aoXfILahpp+qvD/J/KLO38G3DaFZ9ttdjDBNQ6Td
        4kUkszpp5JkfdHjPLFlqSIpipd3W9I/RSto11TngV8RTDpK4u6smCNelOVec3/gwoVytyvYv7p/Sb
        wHBvPGYjh/DS6bBy+R4L8Hq0fqcejl/TC1AaGjOhORi28uksRP1SFZ7c5UCPFR+H9K2CRt7OH1nxB
        FGIK9j+tw4z1uuo9tQ8lpyIqAnJvi73oCiMu2JjGttW7erIT2+sDOr9GaVYQwSk6w3KX6SJ5RayMN
        b19hQDEQ==;
Received: from 213-225-2-232.nat.highway.a1.net ([213.225.2.232] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwdNN-001Rxv-Dq; Thu, 02 Jun 2022 05:28:05 +0000
Date:   Thu, 2 Jun 2022 07:28:04 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <YphKZBtmtKFRNIPL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit a1a2d8f0162b27e85e7ce0ae6a35c96a490e0559:

  bcache: avoid unnecessary soft lockup in kworker update_writeback_rate() (2022-05-28 06:48:26 -0600)

are available in the Git repository at:

  ssh://git.infradead.org/var/lib/git/nvme.git tags/nvme-5.19-2022-06-02

for you to fetch changes up to cbf84dbf0600b0efe1134cc3f98ae29c523a3a23:

  nvmet: fix typo in comment (2022-05-31 07:41:25 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.19

 - set controller enable bit in a separate write (Niklas Cassel)
 - disable namespace identifiers for the MAXIO MAP1001 (me)
 - fix a comment typo (Julia Lawall)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme-pci: disable namespace identifiers for the MAXIO MAP1001

Julia Lawall (1):
      nvmet: fix typo in comment

Niklas Cassel (1):
      nvme: set controller enable bit in a separate write

 drivers/nvme/host/core.c       | 10 +++++++++-
 drivers/nvme/host/pci.c        |  2 ++
 drivers/nvme/target/passthru.c |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)
