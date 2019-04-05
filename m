Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003BDC4360F
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 06:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C463A217D7
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 06:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lkh01HBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfDEGVF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 02:21:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58264 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfDEGVF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 02:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OM6tvRtlJr2pr50Z7kKONhtzW/9AH70SGK08t67fAGg=; b=Lkh01HBFCPTnLPwE+ae964l1tR
        HO0Ut7wBeGeYXElywwlvMt/hxOwWSADnEy6T11MbH3Dj+BIGXKBdaV2+4CTj79VYTumv8LT4ExYAf
        zRllXSr1uAlbmuk/6JV+/WaLUxyNnRsKxbfHDL94Z7+FqFPKev9bYbo8OMieZnr/DnhQ52qAIDlao
        Vg3Vu7lJG9ocn4Z1wJvROGytwe8kTJLV9kuqKtr2mg0XKwKPqD5Z5O1vMVAVBw4W+Vf8oy+ZAN9tQ
        JZOVhiHLqhCtVl6MmRLReNqph0NZ/qxv6Gm3tDZzR8kQuaLiB08iKvpploTSrYTKZNc3uXW4FsD9T
        rCM7OaXg==;
Received: from 089144198096.atnat0007.highway.a1.net ([89.144.198.96] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hCIDm-0003JV-Uq; Fri, 05 Apr 2019 06:21:03 +0000
Date:   Fri, 5 Apr 2019 08:20:43 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] early nvme updates for 5.2
Message-ID: <20190405062043.GA26688@infradead.org>
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

below is the first batch of nvme updates for 5.2.  This includes the
performance improvements for single segment I/O on PCIe, which introduce
new block helpers, so it might be a good idea to get them in early.

 - various performance optimizations in the PCIe code (Keith and me)
 - new block helpers to support the above (me)
 - nvmet error conversion cleanup (me)
 - nvmet-fc variable sized array cleanup (Gustavo)
 - passthrough ioctl error printk cleanup (Kenneth)
 - small nvmet fixes (Max)
 - endianess conversion cleanup (Max)
 - nvmet-tcp faspath completion optimization (Sagi)


The following changes since commit 2b24e6f63ac9e817630424c6d8f008256348dfc4:

  block: bio: ensure newly added bio flags don't override BVEC_POOL_IDX (2019-04-04 09:30:37 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.2

for you to fetch changes up to d0de579c043c3a2ab60ce75eb6cf4d414becc676:

  nvme: log the error status on Identify Namespace failure (2019-04-05 08:07:58 +0200)

----------------------------------------------------------------
Christoph Hellwig (15):
      nvmet: avoid double errno conversions
      block: add a req_bvec helper
      block: add a rq_integrity_vec helper
      block: add a rq_dma_dir helper
      block: add dma_map_bvec helper
      nvme-pci: remove nvme_init_iod
      nvme-pci: move the call to nvme_cleanup_cmd out of nvme_unmap_data
      nvme-pci: merge nvme_free_iod into nvme_unmap_data
      nvme-pci: only call nvme_unmap_data for requests transferring data
      nvme-pci: do not build a scatterlist to map metadata
      nvme-pci: split metadata handling from nvme_map_data / nvme_unmap_data
      nvme-pci: remove the inline scatterlist optimization
      nvme-pci: optimize mapping of small single segment requests
      nvme-pci: optimize mapping single segment requests using SGLs
      nvme-pci: tidy up nvme_map_data

Gustavo A. R. Silva (1):
      nvmet-fc: use zero-sized array and struct_size() in kzalloc()

Keith Busch (3):
      nvme-pci: use a flag for polled queues
      nvme-pci: remove q_dmadev from nvme_queue
      nvme-pci: remove unused nvme_iod member

Kenneth Heitke (1):
      nvme: log the error status on Identify Namespace failure

Max Gurtovoy (3):
      nvme: avoid double dereference to convert le to cpu
      nvmet: never fail double namespace enablement
      nvmet: add safety check for subsystem lock during nvmet_ns_changed

Sagi Grimberg (1):
      nvmet-tcp: implement C2HData SUCCESS optimization

 drivers/nvme/host/core.c          |   6 +-
 drivers/nvme/host/pci.c           | 263 +++++++++++++++++++-------------------
 drivers/nvme/target/core.c        |   9 +-
 drivers/nvme/target/fc.c          |   7 +-
 drivers/nvme/target/io-cmd-bdev.c |   6 +-
 drivers/nvme/target/tcp.c         |  24 +++-
 include/linux/blkdev.h            |  34 +++++
 7 files changed, 197 insertions(+), 152 deletions(-)
