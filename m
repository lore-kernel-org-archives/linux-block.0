Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B35C67869
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447C920851
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gunojxzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447C920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeLKXfa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:35:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeLKXf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=keZBXNn5i9SGPrATJHqttY/fDz7LxQtdny4y43AZQaw=; b=GunojxzkbNoFK62R6WQyNaOBY
        VTyKSPvQKpFtKuO4WFHZkyCZ5W5dAP17VP3s7zOcOyE/46vJucjXMbOIZwdhER08vRiLfbGSWA889
        6lEHWrrhWERhJA6G1i0dQZmT/Rq5eyPxa9G759tb0xUnSIUIJlg/yle9Iq5e4kdxqwReO2IsyeVox
        tMB74UEcw4nR0NiBsjxYzrfTjgk4JtzoaMhs0y6rvYDTlAuPQ+P+mAsosd9O9qwycst8QhsHv9KKv
        6P6jS9UcWHUsnmgfPoOOgDJ9bFZcpyVykXRXmrZNXBorHCWPPxsILK2EolFvhDR6MxF//92Y2fFpD
        ysElo1uEQ==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWrYg-0002L4-Mq; Tue, 11 Dec 2018 23:35:22 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v2 0/5] implement nvmf read/write queue maps
Date:   Tue, 11 Dec 2018 15:35:13 -0800
Message-Id: <20181211233519.9350-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This set implements read/write queue maps to nvmf (implemented in tcp
and rdma). We basically allow the users to pass in nr_write_queues
argument that will basically maps a separate set of queues to host
write I/O (or more correctly non-read I/O) and a set of queues to
hold read I/O (which is now controlled by the known nr_io_queues).

A patchset that restores nvme-rdma polling is in the pipe.
The polling is less trivial because:
1. we can find non I/O completions in the cq (i.e. memreg)
2. we need to start with non-polling for a sane connect and
   then switch to polling which is not trivial behind the
   cq API we use.

Note that read/write separation for rdma but especially tcp this can be
very clear win as we minimize the risk for head-of-queue blocking for
mixed workloads over a single tcp byte stream.

Changes from v1:
- simplified map_queues in nvme-tcp and nvme-rdma
- improved change logs
- collected review tags
- added nr-write-queues entry in nvme-cli docuementation

Sagi Grimberg (5):
  blk-mq-rdma: pass in queue map to blk_mq_rdma_map_queues
  nvme-fabrics: add missing nvmf_ctrl_options documentation
  nvme-fabrics: allow user to set nr_write_queues for separate queue
    maps
  nvme-tcp: support separate queue maps for read and write
  nvme-rdma: support separate queue maps for read and write

 block/blk-mq-rdma.c         |  8 +++----
 drivers/nvme/host/fabrics.c | 15 ++++++++++++-
 drivers/nvme/host/fabrics.h |  6 +++++
 drivers/nvme/host/rdma.c    | 28 ++++++++++++++++++++---
 drivers/nvme/host/tcp.c     | 44 ++++++++++++++++++++++++++++++++-----
 include/linux/blk-mq-rdma.h |  2 +-
 6 files changed, 88 insertions(+), 15 deletions(-)

-- 
2.17.1

