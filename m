Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C64C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 14:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F866136E
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 14:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhGOOQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 10:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhGOOQy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 10:16:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD1EC06175F
        for <linux-block@vger.kernel.org>; Thu, 15 Jul 2021 07:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=d9XYhqbnZzXlls4a/lVNXnEkJpYRRO5mq5R83zsatt8=; b=KIU+fNCxMnISwjv1MjgkeM7oFA
        TDNNhoR7Ou6An7/nSY5ZhiFhB5B9OtctUxI40lKzk+F1NJrucsitbq3GySSjdAGzkaX8iQ1sVCmad
        wLQmzMkbWD8bVv4sp09O/w6YUvT7zIFXaBlaq6HQG2FELUTK755wDV1qANbkjiZCW3cZ4Tc1DpvXc
        Ud9gc36OkW9mlVE2KKM6/jmHg6Ptr/hUezQAGw3STPTip/0YdtLjteTh23HJsVaTgRrf8PAvwptKY
        qalqnD5qrSEsmJVVY+EfoNHatENYrgVrpF+wg+I0iaegm6T7cx6URegG1YWp4oZOddVLAGj5kzrpW
        tdQRQZCQ==;
Received: from [2001:4bb8:184:8b7c:799f:7892:b8a2:a8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m426g-003QC4-9u; Thu, 15 Jul 2021 14:13:10 +0000
Date:   Thu, 15 Jul 2021 16:12:51 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.14
Message-ID: <YPBCY6IjDBwYTceO@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit a731763fc479a9c64456e0643d0ccf64203100c9:

  blk-cgroup: prevent rcu_sched detected stalls warnings while iterating blkgs (2021-07-07 09:36:36 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.14-2021-07-15

for you to fetch changes up to 251ef6f71be2adfd09546a26643426fe62585173:

  nvme-pci: do not call nvme_dev_remove_admin from nvme_remove (2021-07-13 12:03:20 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.14

 - fix various races in nvme-pci when shutting down just after probing
   (Casey Chen)
 - fix a net_device leak in nvme-tcp (Prabhakar Kushwaha)

----------------------------------------------------------------
Casey Chen (2):
      nvme-pci: fix multiple races in nvme_setup_io_queues
      nvme-pci: do not call nvme_dev_remove_admin from nvme_remove

Prabhakar Kushwaha (1):
      nvme-tcp: use __dev_get_by_name instead dev_get_by_name for OPT_HOST_IFACE

 drivers/nvme/host/pci.c | 67 ++++++++++++++++++++++++++++++++++++++++++-------
 drivers/nvme/host/tcp.c |  4 +--
 2 files changed, 59 insertions(+), 12 deletions(-)
