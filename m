Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A8FC433FF
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 18:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7502166E
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 18:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t/v+sSP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436792AbfHISEU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:04:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHISEU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Aug 2019 14:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ctiHtMZxsNt7cUc66ta3n8gf7/JGjo5T/E6P1KmnuJo=; b=t/v+sSP3Yz8JDXcSaKs4P1vUl
        AEV/AoHfugbGvwt6CmFwnu+ncEbYaDWbFCZ+uiwH+VjG+7YvLfao3RxKDJ4DUcMk2ij6nDHVYsmhh
        pGDDx0DdAeQvkvxXVbxGPVydfguAcs0HSRnbwxjYKEHV04RrknQchxL9rV5Bep+IMIFWwtAWstFoY
        4K6PMX7hT9rbVfekghKDmdcYxtg5fd1/4xPbQt8UCGYFuNOJYhJq56lU81g0GHPmKgiNh/7RBorAs
        A2MpH43zhqjZIhxR051ZHA377zb7VEZGxOxp0qpB6Hl8pIZiN0irR7Yx7Neu++QMfXRq/R+8lMH62
        vLr5e0RhA==;
Received: from 162-195-240-247.lightspeed.sntcca.sbcglobal.net ([162.195.240.247] helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hw9FT-0006b6-EA; Fri, 09 Aug 2019 18:04:19 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [GIT PULL] nvme fixes for the next round of 5.3-rc
Date:   Fri,  9 Aug 2019 11:04:12 -0700
Message-Id: <20190809180412.26392-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey Jens,

Few nvme fixes for the next rc round.
- detect capacity changes on the mpath disk from Anthony
- probe/remove fix from Keith
- various fixes to pass blktests from Logan
- deadlock in reset/scan race fix
- nvme-rdma use-after-free fix
- deadlock fix when passthru commands race mpath disk info update

The following changes since commit 71d6c505b4d9e6f76586350450e785e3d452b346:

  libata: zpodd: Fix small read overflow in zpodd_get_mech_type() (2019-07-29 16:00:14 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.3-rc 

for you to fetch changes up to bd46a90634302bfe791e93ad5496f98f165f7ae0:

  nvme-pci: Fix async probe remove race (2019-07-31 18:03:36 -0700)

----------------------------------------------------------------
Anthony Iliopoulos (1):
      nvme-multipath: revalidate nvme_ns_head gendisk in nvme_validate_ns

Keith Busch (1):
      nvme-pci: Fix async probe remove race

Logan Gunthorpe (4):
      nvmet: Fix use-after-free bug when a port is removed
      nvmet-loop: Flush nvme_delete_wq when removing the port
      nvmet-file: fix nvmet_file_flush() always returning an error
      nvme-core: Fix extra device_put() call on error path

Sagi Grimberg (3):
      nvme: fix a possible deadlock when passthru commands sent to a multipath device
      nvme-rdma: fix possible use-after-free in connect error flow
      nvme: fix controller removal race with scan work

 drivers/nvme/host/core.c       | 15 ++++++++-
 drivers/nvme/host/multipath.c  | 76 ++++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h       | 21 ++++++++++--
 drivers/nvme/host/pci.c        |  3 +-
 drivers/nvme/host/rdma.c       | 16 ++++++---
 drivers/nvme/target/configfs.c |  1 +
 drivers/nvme/target/core.c     | 15 +++++++++
 drivers/nvme/target/loop.c     |  8 +++++
 drivers/nvme/target/nvmet.h    |  3 ++
 9 files changed, 143 insertions(+), 15 deletions(-)
