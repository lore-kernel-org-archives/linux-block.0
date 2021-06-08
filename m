Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53E6C47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 14:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A61166128A
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 14:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhFHOdS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbhFHOdR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 10:33:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB85C061574
        for <linux-block@vger.kernel.org>; Tue,  8 Jun 2021 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=x6zHR7jzdqv2mhnANxspf2H3n8Y3lULBOw/ckccct4c=; b=uchEoEOEHxI1JGtm2yvkGjG9ED
        1zmLSjCtv4sggh6wqzoE/VjgT3wFEXvkvnjDAVIY4uj2DOQrWo13Q+2wRzUC1IQUtqGJWP9m5M4hu
        jSx2rILEXxlz0P+n1ri8+Xgpo7AHCSqhJ/ef9FH8I1wAQ0pmnU3TpCvZsmAJ9DawAYUkZeOyrKdun
        WU+YQ15ImSoGr53Vsn2vSnW52d+8N/agGgQOTFyWcfxVZzBaCNT3k55AIiSo7YnEeBPVIuLAB6b0W
        8PaDs+xVquQlzNHNsmj6j1v8ZJrZMfm6KqdfglVWeHS9kcS0OQ2xsa+dUpcENsDXIhTXYB0Rmd0Al
        ESk1KlVg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqcky-00H1Ve-5I; Tue, 08 Jun 2021 14:31:12 +0000
Date:   Tue, 8 Jun 2021 15:31:04 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] first round of nvme updates for Linux 5.14
Message-ID: <YL9/KDQ2uGRVAh6F@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


The following changes since commit 8184035805dc87dd826101b930d3dce97758f7b1:

  rsxx: Use struct_size() in vmalloc() (2021-05-24 06:47:30 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.14-2021-06-08

for you to fetch changes up to 346ac785badf66120d8b4c7b48f87b0a536f691e:

  nvmet: remove a superfluous variable (2021-06-03 10:29:26 +0300)

----------------------------------------------------------------
nvme updates for Linux 5.14

 - improve the APST configuration algorithm (Alexey Bogoslavsky)
 - look for StorageD3Enable on companion ACPI device (Mario Limonciello)
 - allow selecting the network interface for TCP connections
   (Martin Belanger)
 - misc cleanups (Amit Engel, Chaitanya Kulkarni, Colin Ian King, me)

----------------------------------------------------------------
Alexey Bogoslavsky (1):
      nvme: extend and modify the APST configuration algorithm

Amit Engel (1):
      nvmet: move ka_work initialization to nvmet_alloc_ctrl

Chaitanya Kulkarni (5):
      nvme-fabrics: fix the kerneldco comment for nvmf_log_connect_error()
      nvme-fabrics: remove extra new lines in the switch
      nvme-fabrics: remove an extra comment
      nvme-fabrics: remove extra braces
      nvmet: remove a superfluous variable

Christoph Hellwig (7):
      nvme: open code nvme_put_ns_from_disk in nvme_ns_head_chr_ioctl
      nvme: open code nvme_{get,put}_ns_from_disk in nvme_ns_head_ioctl
      nvme: open code nvme_put_ns_from_disk in nvme_ns_head_ctrl_ioctl
      nvme: add a sparse annotation to nvme_ns_head_ctrl_ioctl
      nvme: move the CSI sanity check into nvme_ns_report_zones
      nvme: split nvme_report_zones
      nvme: remove nvme_{get,put}_ns_from_disk

Colin Ian King (1):
      nvme: remove redundant initialization of variable ret

Mario Limonciello (1):
      nvme-pci: look for StorageD3Enable on companion ACPI device instead

Martin Belanger (1):
      nvme-tcp: allow selecting the network interface for connections

 drivers/nvme/host/core.c          | 173 ++++++++++++++++++++++++++------------
 drivers/nvme/host/fabrics.c       |  49 ++++++-----
 drivers/nvme/host/fabrics.h       |   6 +-
 drivers/nvme/host/ioctl.c         |  35 ++++----
 drivers/nvme/host/multipath.c     |  21 ++++-
 drivers/nvme/host/nvme.h          |  12 +--
 drivers/nvme/host/pci.c           |  24 +-----
 drivers/nvme/host/rdma.c          |   2 +-
 drivers/nvme/host/tcp.c           |  27 +++++-
 drivers/nvme/host/zns.c           |  27 ++----
 drivers/nvme/target/core.c        |   2 +-
 drivers/nvme/target/io-cmd-bdev.c |   3 +-
 12 files changed, 230 insertions(+), 151 deletions(-)
