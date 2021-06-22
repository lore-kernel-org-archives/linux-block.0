Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18356C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00282600D1
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 07:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFVHKb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 03:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFVHKa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 03:10:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452EEC061574
        for <linux-block@vger.kernel.org>; Tue, 22 Jun 2021 00:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cPwsZUdKMdeYStCh+AYG64czcvnOgEFwbVdG8qC+jaQ=; b=AmBRRZCgUWeZYvRZpvJ9sUOF71
        LzEzBwK0OrhaAlMJi3XXK1VjnYsSRjdDDLBWUdL4r70lnRCmBPKdZyL6GfB25eCHxTIZQqLnZbIAP
        /T4T+/X1KKpn2jguwfH20IqMfk2/iNerAW22zGyCmqRqXnW3mgCO4Nd7EHmVD9dup2+FN9eNl2WoA
        iBkjEyxVFHgnNJOer6P4dslTuHiCix2IR1jtNwiGdv1sgpxUYNcuHClW7nECXHAgtmkOhUjUqgnwI
        0/N2HmUZwwmpGsLEgof4tdofxOpPdCeSXxml0PSU2Ebv3+cCpeAzpZPdrhW0eX3etYBa8GQaAb5iN
        TDfojqVg==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvaV8-00DzYk-LC; Tue, 22 Jun 2021 07:07:22 +0000
Date:   Tue, 22 Jun 2021 09:05:03 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] second round of nvme updates for Linux 5.14
Message-ID: <YNGLn2MsJDwwbZbv@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit e0d245e2230998e66dfda10fb8c413f29196eb1c:

  Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.14/drivers (2021-06-15 15:42:56 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.14-2021-06-22

for you to fetch changes up to 3c3ee16532c1be92350a2a88bd19283b7bdf32e9:

  nvmet: use NVMET_MAX_NAMESPACES to set nn value (2021-06-21 08:34:10 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.14:

 - move the ACPI StorageD3 code to drivers/acpi/ and add quirks for
   certain AMD CPUs (Mario Limonciello)
 - zoned device support for nvmet (Chaitanya Kulkarni)
 - fix the rules for changing the serial number in nvmet (Noam Gottlieb)
 - various small fixes and cleanups (Dan Carpenter, JK Kim,
   Chaitanya Kulkarni, Hannes Reinecke, Wesley Sheng, Geert Uytterhoeven,
   Daniel Wagner)

----------------------------------------------------------------
Chaitanya Kulkarni (25):
      nvme: factor out a nvme_validate_passthru_nsid helper
      nvme-pci: remove trailing lines for helpers
      nvme: add a helper to check ctrl sgl support
      nvme-fc: use ctrl sgl check helper
      nvme-pci: use ctrl sgl check helper
      nvme-tcp: use ctrl sgl check helper
      nvme-fabrics: remove memset in nvmf_reg_read64()
      nvme-fabrics: remove memset in nvmf_reg_write32()
      nvme-fabrics: remove memset in connect admin q
      nvme-fabrics: remove memset in connect io q
      nvmet: use req->cmd directly in bdev-ns fast path
      nvmet: use req->cmd directly in file-ns fast path
      nvmet: use u32 for nvmet_subsys max_nsid
      nvmet: use u32 type for the local variable nsid
      nvmet: use nvme status value directly
      nvmet: remove local variable
      block: export blk_next_bio()
      nvmet: add req cns error complete helper
      nvmet: add nvmet_req_bio put helper for backends
      nvmet: add Command Set Identifier support
      nvmet: add ZBD over ZNS backend support
      nvmet: remove zeroout memset call for struct
      nvme-pci: remove zeroout memset call for struct
      nvme: remove zeroout memset call for struct
      nvmet: use NVMET_MAX_NAMESPACES to set nn value

Dan Carpenter (1):
      nvme-tcp: fix error codes in nvme_tcp_setup_ctrl()

Daniel Wagner (2):
      nvme: verify MNAN value if ANA is enabled
      nvme: remove superfluous bio_set_dev in nvme_requeue_work

Geert Uytterhoeven (1):
      nvme: fix grammar in the CONFIG_NVME_MULTIPATH kconfig help text

Hannes Reinecke (1):
      nvmet-fc: do not check for invalid target port in nvmet_fc_handle_fcp_rqst()

JK Kim (1):
      nvme-pci: fix var. type for increasing cq_head

Mario Limonciello (2):
      ACPI: Check StorageD3Enable _DSD property in ACPI code
      ACPI: Add quirks for AMD Renoir/Lucienne CPUs to force the D3 hint

Noam Gottlieb (4):
      nvmet: change sn size and check validity
      nvmet: make sn stable once connection was established
      nvmet: allow mn change if subsys not discovered
      nvmet: make ver stable once connection established

Wesley Sheng (1):
      nvme.h: add missing nvme_lba_range_type endianness annotations

 block/blk-lib.c                   |   1 +
 drivers/acpi/device_pm.c          |  32 ++
 drivers/acpi/internal.h           |   9 +
 drivers/acpi/x86/utils.c          |  25 ++
 drivers/nvme/host/Kconfig         |   2 +-
 drivers/nvme/host/core.c          |  19 +-
 drivers/nvme/host/fabrics.c       |  12 +-
 drivers/nvme/host/fc.c            |   2 +-
 drivers/nvme/host/ioctl.c         |  26 +-
 drivers/nvme/host/multipath.c     |  12 +-
 drivers/nvme/host/nvme.h          |   5 +
 drivers/nvme/host/pci.c           |  60 +---
 drivers/nvme/host/tcp.c           |   4 +-
 drivers/nvme/target/Makefile      |   1 +
 drivers/nvme/target/admin-cmd.c   | 155 +++++++---
 drivers/nvme/target/configfs.c    | 102 +++++--
 drivers/nvme/target/core.c        |  98 ++++--
 drivers/nvme/target/discovery.c   |   8 +-
 drivers/nvme/target/fc.c          |  10 +-
 drivers/nvme/target/io-cmd-bdev.c |  33 +-
 drivers/nvme/target/io-cmd-file.c |   4 +-
 drivers/nvme/target/nvmet.h       |  41 ++-
 drivers/nvme/target/passthru.c    |   3 +-
 drivers/nvme/target/rdma.c        |   3 +-
 drivers/nvme/target/zns.c         | 615 ++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h              |   5 +
 include/linux/bio.h               |   2 +
 include/linux/nvme.h              |  12 +-
 28 files changed, 1073 insertions(+), 228 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c
