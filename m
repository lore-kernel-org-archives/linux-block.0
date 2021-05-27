Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA75C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 11:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9EE61006
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 11:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhE0L77 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 07:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbhE0L77 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 07:59:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DC0C061574
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 04:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bnLmqn3ePl+fKi/T3mJ1H66v8Ij9uwqxBwTkJO8w3/A=; b=lhV4f07dSatTFLHuWFRf6rM5eY
        /e1L4HNOSXujJlkXJNoWrLtoimesYalosVBuorvmRi9hlZ9hm1DnORJgeqN7VjAdxiRcPTkmlIM33
        +xvkpuQfc1ZL1WwfSzYnsOXG9U5GPQcdwxNaQe3AH4o4c++sYm6TfqnUOY5sGqqm+rg0fXK8M4Scx
        z5dggFEbNoO8ZpvlA9HcPHDem+EEeCRBEnVrhxkIMGUAIQRdV74ec0pvuHK+XMGtBX31m265zQrwf
        ufwbPmgqoDO/hXnzx7LRfFFAMKppoBx+wZLq3h9QpfYvVZRt/N/JbeBUL/ehI5k/ks6+v95OWaQBK
        +GRv9H6Q==;
Received: from [2001:4bb8:190:7543:4a62:72ba:8559:b110] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmEed-005XMd-Sw; Thu, 27 May 2021 11:58:24 +0000
Date:   Thu, 27 May 2021 13:58:21 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.13
Message-ID: <YK+JXQOdbaoUH4Zr@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit bc6a385132601c29a6da1dbf8148c0d3c9ad36dc:

  block: fix a race between del_gendisk and BLKRRPART (2021-05-20 07:59:35 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.13-2021-05-27

for you to fetch changes up to aaeadd7075dc9e184bc7876e9dd7b3bada771df2:

  nvmet: fix false keep-alive timeout when a controller is torn down (2021-05-26 16:18:22 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.13

 - fix a memory leak in nvme_cdev_add (Guoqing Jiang)
 - fix inline data size comparison in nvmet_tcp_queue_response (Hou Pu)
 - fix false keep-alive timeout when a controller is torn down
   (Sagi Grimberg)
 - fix a nvme-tcp Kconfig dependency (Sagi Grimberg)
 - short-circuit reconnect retries for FC (Hannes Reinecke)
 - decode host pathing error for connect (Hannes Reinecke)

----------------------------------------------------------------
Guoqing Jiang (1):
      nvme: fix potential memory leaks in nvme_cdev_add

Hannes Reinecke (2):
      nvme-fc: short-circuit reconnect retries
      nvme-fabrics: decode host pathing error for connect

Hou Pu (1):
      nvmet-tcp: fix inline data size comparison in nvmet_tcp_queue_response

Sagi Grimberg (2):
      nvme-tcp: remove incorrect Kconfig dep in BLK_DEV_NVME
      nvmet: fix false keep-alive timeout when a controller is torn down

 drivers/nvme/host/Kconfig   |  3 ++-
 drivers/nvme/host/core.c    |  4 +++-
 drivers/nvme/host/fabrics.c |  5 +++++
 drivers/nvme/host/fc.c      | 25 +++++++++++++++++--------
 drivers/nvme/target/core.c  | 15 +++++++++++----
 drivers/nvme/target/nvmet.h |  2 +-
 drivers/nvme/target/tcp.c   |  2 +-
 7 files changed, 40 insertions(+), 16 deletions(-)
