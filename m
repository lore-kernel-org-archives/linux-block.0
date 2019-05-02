Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C00EC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 21:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B5D2064A
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 21:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o2438WIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfEBV7F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 17:59:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfEBV7F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 17:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fG7/Q2IWG4WwVZ2teR342x3lDPJ4PDtDGZa/oJuGUi8=; b=o2438WIAK/BBC7h9qNjMLs3tvh
        qK3XgphbeXR4oH2Oq2RCkdY5cDqhVZM3IaWKD3fqwXh79aQ0aBiJvQm1eHs4Jve43ksnlmLEe8th8
        auzZeA1BLXd+E+9F0sMhM8ZlxHUlWfioAEV6KXxrJ9IEc357QJxTV8+8dpx+6owzJQissEaHi4mwe
        YB5Uo1SWywMB492vJzcDweEdQswE0GfQj3+Y8TRinXAGiBTBWesVwR0PSpJbS/taCShn3uaBaDV6a
        BJ7pqheEiqfRMuJCTnvPQ0PJqX6TeNp2jHf8bMoGGRODQ6Qgm7PqXcx8tm4GtZzevKi7OHb3GCRU4
        erH+qdBw==;
Received: from [65.119.211.164] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMJjL-0003fT-C5; Thu, 02 May 2019 21:59:03 +0000
Date:   Thu, 2 May 2019 17:58:25 -0400
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] last round of nvme updates for 5.2
Message-ID: <20190502215825.GA27894@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A couple more fixes and small cleanups for this merge window.

The following changes since commit 2d5abb9a1e8e92b25e781f0c3537a5b3b4b2f033:

  bcache: make is_discard_enabled() static (2019-05-01 06:34:09 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.2

for you to fetch changes up to 6f53e73b9ec5b3cd097077c5ffcb76df708ce3f8:

  nvmet: protect discovery change log event list iteration (2019-05-01 09:18:47 -0400)

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: move command size checks to the core
      nvme: mark nvme_core_init and nvme_core_exit static

Hannes Reinecke (2):
      nvme-multipath: split bios with the ns_head bio_set before submitting
      nvme-multipath: don't print ANA group state by default

Keith Busch (2):
      nvme-pci: shutdown on timeout during deletion
      nvme-pci: unquiesce admin queue on shutdown

Klaus Birkelund Jensen (1):
      nvme-pci: fix psdt field for single segment sgls

Minwoo Im (3):
      nvme-pci: remove an unneeded variable initialization
      nvme-pci: check more command sizes
      nvme-fabrics: check more command sizes

Sagi Grimberg (2):
      nvme-tcp: fix possible null deref on a timed out io queue connect
      nvmet: protect discovery change log event list iteration

 drivers/nvme/host/core.c        | 31 +++++++++++++++++++++++++++++--
 drivers/nvme/host/fabrics.c     |  1 +
 drivers/nvme/host/multipath.c   | 10 +++++++++-
 drivers/nvme/host/nvme.h        |  3 ---
 drivers/nvme/host/pci.c         | 37 +++++++++++++------------------------
 drivers/nvme/host/tcp.c         |  3 ++-
 drivers/nvme/target/discovery.c |  5 +++++
 7 files changed, 59 insertions(+), 31 deletions(-)
