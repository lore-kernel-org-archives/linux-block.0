Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB67C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA042084D
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QhOqFu3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfBUPt3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:49:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfBUPt2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 10:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0KIykkXEpauvQ/Hriyyqv9c//cX0GWt8a3FrqdRZ5xk=; b=QhOqFu3ggaRTC+O6Dr1PxyPvNa
        BN9ZbHkLAiq+DYV6eOYTmBHB98raJUARUHTeUrnwSxjru0ry4i2A58UtAv6CUcWMRD82aUlyCKNv5
        /SgZIsl07vYLaZHcHeGmHGTk6kfUHDlOW8B3lSlTujL+yww6ArcFqZvxBhiw4GqUM1mG3wrXxpLO4
        9WXAbiBBNXoifcj+l5RzoncNRScFbLONPDo+n3Pv1TtIIyp5Myt9wTHqyo43wtQ95SeOoNfnuTsS3
        bNk3PtWE2txh/854AswfRPobfPSg0mmHgqcmMzN3Qb2Fb5IQTrRR8TWcpMzmNfihzlEmI1mZziTCA
        vTY7Yo3Q==;
Received: from 65-19-226-100.vnet-inc.com ([65.19.226.100] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwqbG-0000m1-Gp; Thu, 21 Feb 2019 15:49:26 +0000
Date:   Thu, 21 Feb 2019 08:49:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for 5.1
Message-ID: <20190221154919.GA19128@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 49b1f22b567ba1d7d8174950be4398a69d0effb7:

  block: avoid to READ fields of null bio (2019-02-19 09:19:06 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.1

for you to fetch changes up to 34e08191b146a363d72be1a488d55ecdc01a5c7d:

  nvme-rdma: use nr_phys_segments when map rq to sgl (2019-02-21 06:39:20 -0700)

----------------------------------------------------------------
Bart Van Assche (6):
      nvmet: fix indentation
      nvme-fabrics: document the poll function argument
      nvme-pci: check kstrtoint() return value in queue_count_set()
      nvme: unexport nvme_delete_ctrl_sync()
      nvme: introduce a helper function for controller deletion
      nvme: avoid that deleting a controller triggers a circular locking complaint

Chaitanya Kulkarni (1):
      nvme-rdma: use nr_phys_segments when map rq to sgl

Christoph Hellwig (13):
      nvme_ioctl.h: remove duplicate GPL boilerplate
      nvme-tcp.h: fix SPDX header
      nvme-fabrics: convert to SPDX identifiers
      nvme-fc: convert to SPDX identifiers
      nvme-rdma: convert to SPDX identifiers
      nvme-lightnvm: convert to SPDX identifiers
      nvme-pci: convert to SPDX identifiers
      nvme: convert to SPDX identifiers
      nvmet-fc: convert to SPDX identifiers
      nvmet-fcloop: convert to SPDX identifiers
      nvme-loop: convert to SPDX identifiers
      nvmet-rdma: convert to SPDX identifiers
      nvmet: convert to SPDX identifiers

Hannes Reinecke (2):
      nvme-multipath: round-robin I/O policy
      nvme: return error from nvme_alloc_ns()

 drivers/nvme/host/core.c          | 68 ++++++++++++++++-----------
 drivers/nvme/host/fabrics.c       | 11 +----
 drivers/nvme/host/fabrics.h       | 10 +---
 drivers/nvme/host/fault_inject.c  |  2 +-
 drivers/nvme/host/fc.c            | 14 +-----
 drivers/nvme/host/lightnvm.c      | 16 +------
 drivers/nvme/host/multipath.c     | 96 +++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h          | 20 ++++----
 drivers/nvme/host/pci.c           | 12 ++---
 drivers/nvme/host/rdma.c          | 14 ++----
 drivers/nvme/host/trace.c         | 10 +---
 drivers/nvme/host/trace.h         | 10 +---
 drivers/nvme/target/admin-cmd.c   | 10 +---
 drivers/nvme/target/configfs.c    | 10 +---
 drivers/nvme/target/core.c        | 10 +---
 drivers/nvme/target/discovery.c   | 12 +----
 drivers/nvme/target/fabrics-cmd.c | 10 +---
 drivers/nvme/target/fc.c          | 14 +-----
 drivers/nvme/target/fcloop.c      | 13 +-----
 drivers/nvme/target/io-cmd-bdev.c | 10 +---
 drivers/nvme/target/loop.c        | 10 +---
 drivers/nvme/target/nvmet.h       | 10 +---
 drivers/nvme/target/rdma.c        | 10 +---
 include/linux/nvme-fc-driver.h    | 10 +---
 include/linux/nvme-fc.h           | 14 +-----
 include/linux/nvme-rdma.h         | 10 +---
 include/linux/nvme-tcp.h          |  2 +-
 include/linux/nvme.h              | 10 +---
 include/uapi/linux/nvme_ioctl.h   |  9 ----
 29 files changed, 168 insertions(+), 289 deletions(-)
