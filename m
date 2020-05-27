Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4774C433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 05:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DFD620776
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 05:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E2/AZQqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgE0FUn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 01:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgE0FUn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 01:20:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C074C061A0F
        for <linux-block@vger.kernel.org>; Tue, 26 May 2020 22:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=f8jvMMTaNGZMB7lT6yewxLbcTKxIApp608v8kKpQTCU=; b=E2/AZQqUEpUE+txLn1pKrS06lO
        Ztt02SnwiyDLoMiQTERF+wTJzxp8USCBAJbDHGdhwvulNC9aQRUKeH3iadezvIh0xbvi4gC7fNsiZ
        AxGG5Wj6D60msDLdf50DL0mxmygzjTHSuuGu+NtZcOLY0S3TmJ8j1LbrTtivkWH2oSkXRbPzj0IzU
        vh4XQL7Pu2TR4yi9/98e9GsbB8qamH4WEmXCTDtjFP5WVImMlM9wh1wszzbJ1UpB7o6crOfJEHN4L
        v3yQWNNidu3Mixqfo2blRnF2bIC9v4/zRUwjpyy88Sc7tcnK0zhhioyroCt17nNNeqhR8DeOMpdzW
        womCxVaw==;
Received: from [2001:4bb8:18c:5da7:8164:affc:3c20:853d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdoUb-0000EN-OY; Wed, 27 May 2020 05:20:42 +0000
Date:   Wed, 27 May 2020 07:20:38 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@fb.com>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for 5.8
Message-ID: <20200527052038.GA403423@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The second large batch of nvme updates:

 - t10 protection information support for nvme-rdma and nvmet-rdma
   (Israel Rukshin and Max Gurtovoy)
 - target side AEN improvements (Chaitanya Kulkarni)
 - various fixes and minor improvements all over, icluding the nvme part
   of the lpfc driver

The following changes since commit 263c61581a38d0a5ad1f5f4a9143b27d68caeffd:

  block/floppy: fix contended case in floppy_queue_rq() (2020-05-26 15:23:54 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.8

for you to fetch changes up to 6b6e89636f51581895922780c3c4fd51bb9e1483:

  lpfc: Fix return value in __lpfc_nvme_ls_abort (2020-05-27 07:12:41 +0200)

----------------------------------------------------------------
Chaitanya Kulkarni (4):
      nvmet: add async event tracing support
      nvmet: add helper to revalidate bdev and file ns
      nvmet: generate AEN for ns revalidate size change
      nvmet: revalidate-ns & generate AEN from configfs

Chen Zhou (1):
      nvmet: replace kstrndup() with kmemdup_nul()

Christoph Hellwig (1):
      nvmet: mark nvmet_ana_state static

Damien Le Moal (1):
      nvme: fix io_opt limit setting

Dan Carpenter (1):
      nvme: delete an unnecessary declaration

David Milburn (1):
      nvmet: cleanups the loop in nvmet_async_events_process

Gustavo A. R. Silva (1):
      nvme: replace zero-length array with flexible-array

Israel Rukshin (9):
      nvme: introduce NVME_INLINE_METADATA_SG_CNT
      nvme-rdma: introduce nvme_rdma_sgl structure
      nvmet: add metadata characteristics for a namespace
      nvmet: rename nvmet_rw_len to nvmet_rw_data_len
      nvmet: rename nvmet_check_data_len to nvmet_check_transfer_len
      nvme: add Metadata Capabilities enumerations
      nvmet: add metadata/T10-PI support
      nvmet: add metadata support for block devices
      nvmet-rdma: add metadata/T10-PI support

James Smart (4):
      nvme: make nvme_ns_has_pi accessible to transports
      lpfc: Fix pointer checks and comments in LS receive refactoring
      lpfc: fix axchg pointer reference after free and double frees
      lpfc: Fix return value in __lpfc_nvme_ls_abort

Keith Busch (1):
      nvme: set dma alignment to qword

Martin George (1):
      nvme-fc: print proper nvme-fc devloss_tmo value

Max Gurtovoy (6):
      block: always define struct blk_integrity in genhd.h
      nvme: introduce namespace features flag
      nvme: introduce NVME_NS_METADATA_SUPPORTED flag
      nvme: introduce max_integrity_segments ctrl attribute
      nvme: enforce extended LBA format for fabrics metadata
      nvme-rdma: add metadata/T10-PI support

Sagi Grimberg (5):
      nvme-tcp: set MSG_SENDPAGE_NOTLAST with MSG_MORE when we have more to send
      nvmet-tcp: set MSG_SENDPAGE_NOTLAST with MSG_MORE when we have more to send
      nvmet-tcp: set MSG_EOR if we send last payload in the batch
      nvmet-tcp: move send/recv error handling in the send/recv methods instead of call-sites
      nvmet: fix memory leak when removing namespaces and controllers concurrently

Weiping Zhang (1):
      nvme-pci: make sure write/poll_queues less or equal then cpu count

Wu Bo (1):
      nvme: disable streams when get stream params failed

 drivers/nvme/host/core.c          |  97 ++++++++----
 drivers/nvme/host/fc.c            |   6 +-
 drivers/nvme/host/lightnvm.c      |   7 +-
 drivers/nvme/host/nvme.h          |  18 ++-
 drivers/nvme/host/pci.c           |  28 +++-
 drivers/nvme/host/rdma.c          | 321 ++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/tcp.c           |  11 +-
 drivers/nvme/target/Kconfig       |   1 +
 drivers/nvme/target/admin-cmd.c   |  45 ++++--
 drivers/nvme/target/configfs.c    |  90 ++++++++++-
 drivers/nvme/target/core.c        | 166 ++++++++++++++------
 drivers/nvme/target/discovery.c   |   8 +-
 drivers/nvme/target/fabrics-cmd.c |  15 +-
 drivers/nvme/target/io-cmd-bdev.c | 113 +++++++++++++-
 drivers/nvme/target/io-cmd-file.c |   6 +-
 drivers/nvme/target/nvmet.h       |  34 +++-
 drivers/nvme/target/rdma.c        | 238 +++++++++++++++++++++++++---
 drivers/nvme/target/tcp.c         |  53 ++++---
 drivers/nvme/target/trace.h       |  28 ++++
 drivers/scsi/lpfc/lpfc_nvme.c     |   2 +-
 drivers/scsi/lpfc/lpfc_nvmet.c    |  29 ++--
 drivers/scsi/lpfc/lpfc_sli.c      |  10 +-
 include/linux/genhd.h             |   4 -
 include/linux/nvme.h              |   8 +-
 24 files changed, 1116 insertions(+), 222 deletions(-)
