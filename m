Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E204AC43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 14:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiGNOeU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 10:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiGNOeO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 10:34:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB90343E46
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 07:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=PXZSyT7Qc60lozx/M4d1lcHQ0kN6+4N3VjfFxuRG5U4=; b=hx4hNejNe7MGiX4GqT0ev8yQOB
        UP9KNEbkTFn7J5rx/KVnItP58t55IRC8sZ1L2HSangiEch8uKqsw8LvxKGJjnbRvGx5n8OCeFc29a
        TLJnaT6Y917DtSrt/69y004varHRmxD6nM4tZH6rkqAT8tiawxzib4z7m/S+y8qX1HFd4i+UvD+hp
        VOwwUVFVrEkfMAOYXTMlubDGC6C6pUmTnY52cGce6TlWrJYNdiaHwng0ZIctIofk+LLvlEkpegcWD
        MmXoaW9mfwkaAYU+Yx58QnUpg9IWPZpVPG739KMld/gni2dEnv/qH17SlPHaBh2LXvZKIu/jJceOk
        l3D3YlMg==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBzus-00FEZD-Fy; Thu, 14 Jul 2022 14:34:10 +0000
Date:   Thu, 14 Jul 2022 16:34:07 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 5.20
Message-ID: <YtApX8HC+BcN3NvL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 3b56590b1715b998cb5c73a5bd2e9d340ccb42dc:

  rnbd-clt: make rnbd_clt_change_capacity return void (2022-07-06 07:38:40 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.20-2022-07-14

for you to fetch changes up to 7b20ea4f3911c86bee698f1b23ba7f59ec890ceb:

  nvme-multipath: refactor nvme_mpath_add_disk (2022-07-12 17:37:31 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.20

 - add support for In-Band authentication (Hannes Reinecke)
 - handle the persistent internal error AER (Michael Kelley)
 - use in-capsule data for TCP I/O queue connect (Caleb Sander)
 - remove timeout for getting RDMA-CM established event (Israel Rukshin)
 - misc cleanups (Joel Granados, Sagi Grimberg, Chaitanya Kulkarni,
   Guixin Liu, Xiang wangx)

----------------------------------------------------------------
Caleb Sander (1):
      nvme-tcp: use in-capsule data for I/O connect

Chaitanya Kulkarni (2):
      nvme: remove unused timeout parameter
      nvme: fix qid param blk_mq_alloc_request_hctx

Guixin Liu (2):
      nvme-pci: use nvme core helper to cancel requests in tagset
      nvme-apple: use nvme core helper to cancel requests in tagset

Hannes Reinecke (11):
      crypto: add crypto_has_shash()
      crypto: add crypto_has_kpp()
      lib/base64: RFC4648-compliant base64 encoding
      nvme: add definitions for NVMe In-Band authentication
      nvme-fabrics: decode 'authentication required' connect error
      nvme: implement In-Band authentication
      nvme-auth: Diffie-Hellman key exchange support
      nvmet: parse fabrics commands on io queues
      nvmet: implement basic In-Band Authentication
      nvmet-auth: Diffie-Hellman key exchange support
      nvmet-auth: expire authentication sessions

Israel Rukshin (1):
      nvme-rdma: remove timeout for getting RDMA-CM established event

Joel Granados (1):
      nvme-multipath: refactor nvme_mpath_add_disk

Michael Kelley (1):
      nvme: handle the persistent internal error AER

Sagi Grimberg (1):
      nvme-loop: use nvme core helpers to cancel all requests in a tagset

Xiang wangx (1):
      nvme: remove a double word in a comment

 crypto/kpp.c                           |    6 +
 crypto/shash.c                         |    6 +
 drivers/nvme/Kconfig                   |    1 +
 drivers/nvme/Makefile                  |    1 +
 drivers/nvme/common/Kconfig            |    4 +
 drivers/nvme/common/Makefile           |    7 +
 drivers/nvme/common/auth.c             |  482 +++++++++++++++
 drivers/nvme/host/Kconfig              |   15 +
 drivers/nvme/host/Makefile             |    1 +
 drivers/nvme/host/apple.c              |    7 +-
 drivers/nvme/host/auth.c               | 1017 ++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c               |  190 +++++-
 drivers/nvme/host/fabrics.c            |   94 ++-
 drivers/nvme/host/fabrics.h            |    7 +
 drivers/nvme/host/multipath.c          |    6 +-
 drivers/nvme/host/nvme.h               |   39 +-
 drivers/nvme/host/pci.c                |    6 +-
 drivers/nvme/host/rdma.c               |   14 +-
 drivers/nvme/host/tcp.c                |   13 +-
 drivers/nvme/host/trace.c              |   32 +
 drivers/nvme/target/Kconfig            |   15 +
 drivers/nvme/target/Makefile           |    1 +
 drivers/nvme/target/admin-cmd.c        |    4 +-
 drivers/nvme/target/auth.c             |  525 +++++++++++++++++
 drivers/nvme/target/configfs.c         |  138 ++++-
 drivers/nvme/target/core.c             |   15 +
 drivers/nvme/target/fabrics-cmd-auth.c |  545 +++++++++++++++++
 drivers/nvme/target/fabrics-cmd.c      |   55 +-
 drivers/nvme/target/loop.c             |    8 +-
 drivers/nvme/target/nvmet.h            |   75 ++-
 include/crypto/hash.h                  |    2 +
 include/crypto/kpp.h                   |    2 +
 include/linux/base64.h                 |   16 +
 include/linux/nvme-auth.h              |   41 ++
 include/linux/nvme.h                   |  213 ++++++-
 lib/Makefile                           |    2 +-
 lib/base64.c                           |  103 ++++
 37 files changed, 3640 insertions(+), 68 deletions(-)
 create mode 100644 drivers/nvme/common/Kconfig
 create mode 100644 drivers/nvme/common/Makefile
 create mode 100644 drivers/nvme/common/auth.c
 create mode 100644 drivers/nvme/host/auth.c
 create mode 100644 drivers/nvme/target/auth.c
 create mode 100644 drivers/nvme/target/fabrics-cmd-auth.c
 create mode 100644 include/linux/base64.h
 create mode 100644 include/linux/nvme-auth.h
 create mode 100644 lib/base64.c
