Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099AAC433DF
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69982074B
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UTSJtdNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFKGXB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgFKGXA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 02:23:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6ABC08C5C1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 23:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cXhXlSJlRvFZ2s8fVGfNis0ws3isnv3c6OwMpkoIkvA=; b=UTSJtdNCnNcU+T24uZh4It5rou
        EU548sDF4DI/oPKBV1WKEZfOd5YOhwu2EwrCO4Lv//e305edQG+QyqzK8xm56X4ds4IUK5kfgi7j2
        tGyovDiTYuu3O0E8gS8n0QbP1mSmeAtYPEd4Ou6wdUFfZiziITX2bcrxWH4XtRZT31vkqElqHdHtN
        ewSQDcS/AyigIq0t7i/4Zk3/lPaB/wHvBVKZuRrru5TR/pd3PHOzxreTO9KFfct9sxm5i7k3MiT2S
        ikiT/tg05f9V94VjWdpLb37JP77iiJKofa09tGubY5ls80XEGiIGkRl/iYHarZviKir0nd32qp/Rb
        VFD/Ol2w==;
Received: from [2001:4bb8:18c:317f:efe9:d6fc:cdd9:b4ec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjGc7-0001TF-Ei; Thu, 11 Jun 2020 06:22:59 +0000
Date:   Thu, 11 Jun 2020 08:22:57 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.8
Message-ID: <20200611062257.GA11119@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit abfbb29297c27e3f101f348dc9e467b0fe70f919:

  Merge tag 'rproc-v5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc (2020-06-08 13:01:08 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.8

for you to fetch changes up to 103ab3d94987ec18f222e78851807574fe59e6c2:

  nvmet: fail outstanding host posted AEN req (2020-06-11 08:15:15 +0200)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: fail outstanding host posted AEN req

Christoph Hellwig (1):
      nvme-pci: use simple suspend when a HMB is enabled

Daniel Wagner (1):
      nvme-fc: don't call nvme_cleanup_cmd() for AENs

Max Gurtovoy (1):
      nvmet-tcp: constify nvmet_tcp_ops

Niklas Cassel (1):
      nvme: do not call del_gendisk() on a disk that was never added

Rikard Falkeborn (1):
      nvme-tcp: constify nvme_tcp_mq_ops and nvme_tcp_admin_mq_ops

 drivers/nvme/host/core.c   |  4 +---
 drivers/nvme/host/fc.c     |  5 +++--
 drivers/nvme/host/pci.c    |  6 ++++++
 drivers/nvme/host/tcp.c    |  8 ++++----
 drivers/nvme/target/core.c | 27 ++++++++++++++++++++-------
 drivers/nvme/target/tcp.c  |  4 ++--
 6 files changed, 36 insertions(+), 18 deletions(-)
