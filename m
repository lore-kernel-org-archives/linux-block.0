Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0C1C43603
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 15:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2400E61166
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 15:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhDOPFj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 11:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbhDOPFA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 11:05:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EC8C06175F
        for <linux-block@vger.kernel.org>; Thu, 15 Apr 2021 08:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=1chVD+lnFTrVAPP6auZupDADHAAPrZga5y+mhXcHQ8c=; b=dN4LvVMDiBcpw/OJ5d4efLiG6j
        3tqdZT67J4BvoxoW/0XsSUPeF2t/AXHtM+IqTxKFWRWxvxvlpNxPbqgP+hnAWuQOXvuvtC0/4DcFq
        GY0yYBGJSVv6RHnxpmA/W+MvduDqt5MwN/tEpJJbmIjN2wHZNQuoXGSRpMuXCt+PXY2ShfP72eLP8
        vo88UUnNPD/LLNvp3Sl58EuHEmP9kIBHztckJKekpLyKjxEcnism5t7Wr863Wc/jI5AwYlXmD5RUt
        IxpqTdRpKdSQE75pDgiy9VA2k79PkJKTfvurJ93gXNFhSET3QrKLXP2Et0M0j2+0ZmjRbJ48r/oLi
        Q8x6Wn5A==;
Received: from [2001:4bb8:180:9e0b:e540:ecff:fd3e:ba09] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lX3WR-008gLj-TZ; Thu, 15 Apr 2021 15:03:12 +0000
Date:   Thu, 15 Apr 2021 17:03:09 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] second round of nvme updates for Linux 5.13
Message-ID: <YHhVrZD7/Q4qtFjL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit f8ee34a929a4adf6d29a7ef2145393e6865037ad:

  lightnvm: deprecated OCSSD support and schedule it for removal in Linux 5.15 (2021-04-13 09:16:12 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.13-2021-04-15

for you to fetch changes up to d6609084b0b81abc74dc9db0281cdd0e074df5d4:

  nvme: fix NULL derefence in nvme_ctrl_fast_io_fail_tmo_show/store (2021-04-15 08:12:56 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.13

 - refactor the ioctl coee
 - fix a segmentation fault during io parsing error in nvmet-tcp
   (Elad Grupi)
 - fix NULL derefence in nvme_ctrl_fast_io_fail_tmo_show/store
   (Gopal Tiwari)
 - properly respect the sgl_threshold flag in nvme-pci (Niklas Cassel)
 - misc cleanups (Niklas Cassel, Amit Engel, Minwoo Im, Colin Ian King)

----------------------------------------------------------------
Amit Engel (1):
      nvmet-fc: simplify nvmet_fc_alloc_hostport

Christoph Hellwig (11):
      nvme: cleanup setting the disk name
      nvme: pass a user pointer to nvme_nvm_ioctl
      nvme: factor out a nvme_ns_ioctl helper
      nvme: simplify the compat ioctl handling
      nvme: simplify block device ioctl handling for the !multipath case
      nvme: don't bother to look up a namespace for controller ioctls
      nvme: move the ioctl code to a separate file
      nvme: factor out a nvme_tryget_ns_head helper
      nvme: move nvme_ns_head_ops to multipath.c
      nvme: factor out nvme_ns_open and nvme_ns_release helpers
      nvme: let namespace probing continue for unsupported features

Colin Ian King (1):
      nvmet: fix a spelling mistake "nubmer" -> "number"

Elad Grupi (1):
      nvmet-tcp: fix a segmentation fault during io parsing error

Gopal Tiwari (1):
      nvme: fix NULL derefence in nvme_ctrl_fast_io_fail_tmo_show/store

Minwoo Im (1):
      nvme: add a nvme_ns_head_multipath helper

Niklas Cassel (4):
      nvme-pci: don't simple map sgl when sgls are disabled
      nvme-pci: remove single trailing whitespace
      nvme-multipath: remove single trailing whitespace
      nvme: remove single trailing whitespace

 drivers/nvme/host/Makefile     |   2 +-
 drivers/nvme/host/core.c       | 562 +++++------------------------------------
 drivers/nvme/host/ioctl.c      | 455 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/lightnvm.c   |   8 +-
 drivers/nvme/host/multipath.c  |  51 +++-
 drivers/nvme/host/nvme.h       |  40 +--
 drivers/nvme/host/pci.c        |   4 +-
 drivers/nvme/host/zns.c        |   4 +-
 drivers/nvme/target/configfs.c |   2 +-
 drivers/nvme/target/fc.c       |  77 +++---
 drivers/nvme/target/tcp.c      |  39 ++-
 11 files changed, 669 insertions(+), 575 deletions(-)
 create mode 100644 drivers/nvme/host/ioctl.c
