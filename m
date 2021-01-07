Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CAAC433DB
	for <linux-block@archiver.kernel.org>; Sat,  9 Jan 2021 04:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5183823A69
	for <linux-block@archiver.kernel.org>; Sat,  9 Jan 2021 04:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbhAIEPo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jan 2021 23:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbhAIEPn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jan 2021 23:15:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DCCC061573
        for <linux-block@vger.kernel.org>; Fri,  8 Jan 2021 20:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZjYLRPMvHaT9Jek8mcD0b2kBL6w1IQg5zbFqtKQ8NdQ=; b=vYe0tl/oadyBwcF9GOeXoXFBIP
        xmN7hOZyyOUdfqiC9IbXSvgSdxQ8xNu63QsTwwFNBHZXSbmile/SfgilunIT/FT9jIoaHq1R+UmUg
        fXpT7Iy/6BhaePm1Q68lxn64o0h1fKPh0WsGrcD/RLJ85WumaAIRq4YEzFN+i9UbpEPHb7Rs9ytGG
        alNzO3uKg7WA68AwkUcuzFXmi7XULxdMufBdeaaLl9aDq3N0paypiFZk+pTLXSjGqU+MkVh/wOXfS
        aVtF6GOAkjWkRwKEnDESOm+baQ003321LyqmUNRm7q5xt5JJJyO553oJsUrt7PD8zTVef+tI8AGaN
        k+ShU4HA==;
Received: from 213-225-33-181.nat.highway.a1.net ([213.225.33.181] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxZLK-000HxI-LA; Thu, 07 Jan 2021 17:45:27 +0000
Date:   Thu, 7 Jan 2021 18:42:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.11
Message-ID: <X/dIG7478C6ahGvo@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit aebf5db917055b38f4945ed6d621d9f07a44ff30:

  block: fix use-after-free in disk_part_iter_next (2021-01-05 11:35:17 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.11-2021-01-07

for you to fetch changes up to 2b59787a223b79228fed9ade1bf6936194ddb8cd:

  nvme: remove the unused status argument from nvme_trace_bio_complete (2021-01-06 10:30:37 +0100)

----------------------------------------------------------------
nvme updates for 5.11:

 - fix a race in the nvme-tcp send code (Sagi Grimberg)
 - fix a list corruption in an nvme-rdma error path (Israel Rukshin)
 - avoid a possible double fetch in nvme-pci (Lalithambika Krishnakumar)
 - add the susystem NQN quirk for a Samsung driver (Gopal Tiwari)
 - fix two compiler warnings in nvme-fcloop (James Smart)
 - don't call sleeping functions from irq context in nvme-fc (James Smart)
 - remove an unused argument (Max Gurtovoy)
 - remove unused exports (Minwoo Im)

----------------------------------------------------------------
Gopal Tiwari (1):
      nvme-pci: mark Samsung PM1725a as IGNORE_DEV_SUBNQN

Israel Rukshin (1):
      nvmet-rdma: Fix list_del corruption on queue establishment failure

James Smart (2):
      nvme-fc: avoid calling _nvme_fc_abort_outstanding_ios from interrupt context
      nvme-fcloop: Fix sscanf type and list_first_entry_or_null warnings

Lalithambika Krishnakumar (1):
      nvme: avoid possible double fetch in handling CQE

Max Gurtovoy (1):
      nvme: remove the unused status argument from nvme_trace_bio_complete

Minwoo Im (1):
      nvme: unexport functions with no external caller

Sagi Grimberg (1):
      nvme-tcp: Fix possible race of io_work and direct send

 drivers/nvme/host/core.c     |  8 +++-----
 drivers/nvme/host/fc.c       | 15 ++++++++++++++-
 drivers/nvme/host/nvme.h     |  9 ++-------
 drivers/nvme/host/pci.c      | 10 ++++++----
 drivers/nvme/host/tcp.c      | 12 +++++++++++-
 drivers/nvme/target/fcloop.c |  7 ++++---
 drivers/nvme/target/rdma.c   | 10 ++++++++++
 7 files changed, 50 insertions(+), 21 deletions(-)
