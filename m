Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC7FC38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 15:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888292173E
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 15:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JPmS/l6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgEHPow (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 11:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbgEHPov (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 11:44:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA17C061A0C
        for <linux-block@vger.kernel.org>; Fri,  8 May 2020 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nrLRbCNPIr7fybBus2WgKRHXWM7I21nQc1ruzpDho8Y=; b=JPmS/l6bnVkth2pvRkv8msJ5Rk
        kqWMWfAyhqj7qevUop6YjJEwjjsPJqYsvcRqjKsXt5rTflvcZQgyiy4I0mAxSa0+XVYlORGazvOI4
        ZYQuC1HWCaAFyN4VNxIeMFGjn1RJhL4k+dwo9lsEjlWD3PC5fT9ECH9QBdUmj0VCXlZyELwtDnlEn
        TKhNi7zj635LTr/MePSmBKAmxzp1IhWIPpX/rD2uqP5WLvTTCuxeU4bGIoqZO1S8MGPNUYRtZJHLj
        mZ3WcDXxdQqC/nu0jDJ7xORhVk+shyP/8JhD/RQu/qr9j0nKRMMasmORFW33P2YdqdIAAaviOB97A
        tVZflROw==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX5BC-0008Pu-7g; Fri, 08 May 2020 15:44:50 +0000
Date:   Fri, 8 May 2020 17:44:48 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@fb.com>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [GIT PULL] first batch of nvme updates for 5.8
Message-ID: <20200508154448.GA250683@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

here are the first 60+ nvme patches for Linux 5.8:

 - NVMe over Fibre Channel protocol updates, which also reach over to
   drivers/scsi/lpfc (James Smart)
 - namespace revalidation support on the target (Anthony Iliopoulos)
 - gcc zero length array fix (Arnd Bergmann)
 - nvmet cleanups (Chaitanya Kulkarni)
 - misc cleanups and fixes (me, Keith Busch, Sagi Grimberg)
 - use a SRQ per completion vector (Max Gurtovoy)
 - fix handling of runtime changes to the queue count (Weiping Zhang)


The following changes since commit 8b075e5ba459c7afdd7b2fde14cbc01c51e25eac:

  udf: stop using ioctl_by_bdev (2020-05-04 10:13:42 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.8

for you to fetch changes up to 8f17cfe04d1a0e8e9a5433bfa27b2db4856df9be:

  nvme: define constants for identification values (2020-05-06 08:54:46 +0200)

----------------------------------------------------------------
Anthony Iliopoulos (1):
      nvmet: add ns revalidation support

Arnd Bergmann (1):
      nvme-fc: avoid gcc-10 zero-length-bounds warning

Chaitanya Kulkarni (6):
      nvmet: add generic type-name mapping
      nvmet: use type-name map for address family
      nvmet: use type-name map for ana states
      nvmet: use type-name map for address treq
      nvmet: centralize port enable access for configfs
      nvmet: align addrfam list to spec

Christoph Hellwig (7):
      nvme: refine the Qemu Identify CNS quirk
      nvme: clean up nvme_scan_work
      nvme: factor out a nvme_ns_remove_by_nsid helper
      nvme: avoid an Identify Controller command for each namespace scan
      nvme: remove the magic 1024 constant in nvme_scan_ns_list
      nvme: clean up error handling in nvme_init_ns_head
      nvme-multipath: stop using ->queuedata

James Smart (27):
      nvme-fc: Sync header to FC-NVME-2 rev 1.08
      nvme-fc and nvmet-fc: revise LLDD api for LS reception and LS request
      nvme-fc nvmet-fc: refactor for common LS definitions
      nvmet-fc: Better size LS buffers
      nvme-fc: Ensure private pointers are NULL if no data
      nvme-fc: convert assoc_active flag to bit op
      nvme-fc: Update header and host for common definitions for LS handling
      nvmet-fc: Update target for common definitions for LS handling
      nvme-fc: Add Disconnect Association Rcv support
      nvmet-fc: add LS failure messages
      nvmet-fc: perform small cleanups on unneeded checks
      nvmet-fc: track hostport handle for associations
      nvmet-fc: rename ls_list to ls_rcv_list
      nvmet-fc: Add Disconnect Association Xmt support
      nvme-fcloop: refactor to enable target to host LS
      nvme-fcloop: add target to host LS request support
      lpfc: Refactor lpfc nvme headers
      lpfc: Refactor nvmet_rcv_ctx to create lpfc_async_xchg_ctx
      lpfc: Commonize lpfc_async_xchg_ctx state and flag definitions
      lpfc: Refactor NVME LS receive handling
      lpfc: Refactor Send LS Request support
      lpfc: Refactor Send LS Abort support
      lpfc: Refactor Send LS Response support
      lpfc: nvme: Add Receive LS Request and Send LS Response support to nvme
      lpfc: nvmet: Add support for NVME LS request hosthandle
      lpfc: nvmet: Add Send LS Request and Abort LS Request support
      nvmet-fc: slight cleanup for kbuild test warnings

Keith Busch (15):
      nvme: provide num dword helper
      nvme: remove unused parameter
      nvme: unlink head after removing last namespace
      nvme: release namespace head reference on error
      nvme: always search for namespace head
      nvme: check namespace head shared property
      nvme-multipath: set bdi capabilities once
      nvme: revalidate after verifying identifiers
      nvme: consolidate chunk_sectors settings
      nvme: revalidate namespace stream parameters
      nvme: consolodate io settings
      nvme: flush scan work on passthrough commands
      nvme-pci: remove volatile cqes
      nvme-pci: remove last_sq_tail
      nvme: define constants for identification values

Max Gurtovoy (1):
      nvmet-rdma: use SRQ per completion vector

Sagi Grimberg (3):
      nvme-tcp: use bh_lock in data_ready
      nvme-tcp: avoid scheduling io_work if we are already polling
      nvme-tcp: try to send request in queue_rq context

Weiping Zhang (1):
      nvme-pci: align io queue count with allocted nvme_queue in nvme_probe

 drivers/nvme/host/core.c           | 235 ++++++-----
 drivers/nvme/host/fc.c             | 571 ++++++++++++++++++++------
 drivers/nvme/host/fc.h             | 227 +++++++++++
 drivers/nvme/host/multipath.c      |  16 +-
 drivers/nvme/host/nvme.h           |  10 +-
 drivers/nvme/host/pci.c            |  89 ++--
 drivers/nvme/host/tcp.c            |  53 ++-
 drivers/nvme/target/admin-cmd.c    |   5 +
 drivers/nvme/target/configfs.c     | 184 ++++-----
 drivers/nvme/target/fc.c           | 805 +++++++++++++++++++++++++++----------
 drivers/nvme/target/fcloop.c       | 155 ++++++-
 drivers/nvme/target/io-cmd-bdev.c  |   5 +
 drivers/nvme/target/io-cmd-file.c  |  17 +-
 drivers/nvme/target/nvmet.h        |   2 +
 drivers/nvme/target/rdma.c         | 178 ++++++--
 drivers/scsi/lpfc/lpfc.h           |   2 +-
 drivers/scsi/lpfc/lpfc_attr.c      |   3 -
 drivers/scsi/lpfc/lpfc_crtn.h      |   9 +-
 drivers/scsi/lpfc/lpfc_ct.c        |   1 -
 drivers/scsi/lpfc/lpfc_debugfs.c   |   5 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c   |   8 +-
 drivers/scsi/lpfc/lpfc_init.c      |   7 +-
 drivers/scsi/lpfc/lpfc_mem.c       |   4 -
 drivers/scsi/lpfc/lpfc_nportdisc.c |  13 +-
 drivers/scsi/lpfc/lpfc_nvme.c      | 491 ++++++++++++++--------
 drivers/scsi/lpfc/lpfc_nvme.h      | 180 +++++++++
 drivers/scsi/lpfc/lpfc_nvmet.c     | 804 +++++++++++++++++++++---------------
 drivers/scsi/lpfc/lpfc_nvmet.h     | 158 --------
 drivers/scsi/lpfc/lpfc_sli.c       | 126 +++++-
 include/linux/nvme-fc-driver.h     | 368 ++++++++++++-----
 include/linux/nvme-fc.h            |  11 +-
 include/linux/nvme.h               |   8 +
 32 files changed, 3297 insertions(+), 1453 deletions(-)
 create mode 100644 drivers/nvme/host/fc.h
 delete mode 100644 drivers/scsi/lpfc/lpfc_nvmet.h
