Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2D4C282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 21:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797B3218A1
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 21:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N/WM1fJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfAWVm7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:42:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfAWVm6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 16:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SmGjhd52jQtVNw8BGxHc4YUPDfUMnIqKv5sVofoMg9o=; b=N/WM1fJxIn+xWBvr68bPV/Ax9
        hc7TnfgewpN5LcMC9HwnsHD50HbHkWhTHnKOwvj1yCcOvu6BJMxenIe4nDr0ljmX/nQeFlrC95MdZ
        2EiPE/oB0TxMaGLbOmJabCgKhlGPeZ/QyPQo6KQXFKMkAnUt4M86aF06gOQSw+YEVgFLaxT51ySOl
        AFtvWv/T4bnL/NsHKOGJDLP4+ghhP+3ZQeN/lTBwDR/ZLcWkFAWUKMhm5/8BL9pw+/MqCng9aIqfp
        GqusTcP27BWVhtaIxHd4Ae3waJ2ZiCKG18He0QlrnJ+zHP8HxGu8XVQXKIJa4G3unIQHWiaHbjnfq
        fSuSolMtQ==;
Received: from 162-195-240-247.lightspeed.sntcca.sbcglobal.net ([162.195.240.247] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmQIT-0004yr-1s; Wed, 23 Jan 2019 21:42:57 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [GIT PULL] nvme fixes for 5.0-rc4
Date:   Wed, 23 Jan 2019 13:42:52 -0800
Message-Id: <20190123214252.27491-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey Jens,

Couple of nvme fixes for the next rc round.

- Fix nvme-rdma and nvme-tcp timeout handlers racing with queue
  disconnections and initial connect failuers
- fix nvme-rdma regression in queue maps assignment introduced
  in read/write queue map separation
- fix nvmet-rdma null dereference when we run out of rsps under
  heavy load
- fix multipath ana log underallocation when static group ids are used

The following changes since commit eda14f8977df052dce3a9c54a6bf8d8f76c96eb1:

  nvme-pci: fix nvme_setup_irqs() (2019-01-15 06:50:52 +0100)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.0


for you to fetch changes up to 4dd1dbde7b167cf39e43923ce6c8360498149cf6:

  nvme-multipath: drop optimization for static ANA group IDs (2019-01-21 09:48:57 -0800)

----------------------------------------------------------------
Hannes Reinecke (1):
      nvme-multipath: drop optimization for static ANA group IDs

Raju Rangoju (1):
      nvmet-rdma: fix null dereference under heavy load

Sagi Grimberg (3):
      nvme-rdma: fix timeout handler
      nvme-tcp: fix timeout handler
      nvme-rdma: rework queue maps handling

 drivers/nvme/host/multipath.c |  3 +-
 drivers/nvme/host/rdma.c      | 64 +++++++++++++++++++++++++++++--------------
 drivers/nvme/host/tcp.c       | 19 +++++++------
 drivers/nvme/target/rdma.c    | 15 +++++++++-
 4 files changed, 69 insertions(+), 32 deletions(-)
