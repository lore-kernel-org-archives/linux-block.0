Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BABC433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Feb 2022 07:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiBXHeQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Feb 2022 02:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiBXHeP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Feb 2022 02:34:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E065E36692
        for <linux-block@vger.kernel.org>; Wed, 23 Feb 2022 23:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=LbFS9C+3gXb5be9xi8m5bFC27t57KtOCBKFV3poBquM=; b=DSbmd+t2RzC/dgSK91oy3oYXq8
        SkbwircdiPetvelV9WjCTplH3VapCk36ahBr/tBHV1D/xaQwuBVaMp3vMHSL7WA9LOsHoXjh2FVmB
        4Ya0+ftfTN9BQf80AExG+lzW72XZjL+1JJUTqbu9mNrd2lnFC3CqBk5r67OJ2PuHIKd8avOp4zF78
        u9xftvcrsj1Q0yFbUBemGybWDdANfmtT1l+5xpJYPJdmiFOB5ZGZJm2tBUdn9E0bHUiDqJ6uLbQm8
        H5ZPs9mjOxrOcI/ABy0fV6YGPxk55CkIi/HwkATmO/9ot7cRGfm9m0GAXiiMkv2wTni7u/17GFXiP
        9SGV4aVQ==;
Received: from [2001:4bb8:198:f8fc:e55d:3b08:349b:3812] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nN8dC-00H8VM-Rn; Thu, 24 Feb 2022 07:33:43 +0000
Date:   Thu, 24 Feb 2022 08:33:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.17
Message-ID: <Yhc01AadzWuqPuAe@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit bb49c6fa8b845591b317b0d7afea4ae60ec7f3aa:

  block: clear iocb->private in blkdev_bio_end_io_async() (2022-02-22 06:59:49 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-24

for you to fetch changes up to c2700d2886a87f83f31e0a301de1d2350b52c79b:

  nvme-tcp: send H2CData PDUs based on MAXH2CDATA (2022-02-23 14:43:11 +0100)

----------------------------------------------------------------
nvme fixes for Linux 5.17

 - send H2CData PDUs based on MAXH2CDATA (Varun Prakash)
 - fix passthrough to namespaces with unsupported features (me)

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: don't return an error from nvme_configure_metadata
      nvme: also mark passthrough-only namespaces ready in nvme_update_ns_info

Varun Prakash (1):
      nvme-tcp: send H2CData PDUs based on MAXH2CDATA

 drivers/nvme/host/core.c | 19 ++++++---------
 drivers/nvme/host/tcp.c  | 63 +++++++++++++++++++++++++++++++++++++-----------
 include/linux/nvme-tcp.h |  1 +
 3 files changed, 58 insertions(+), 25 deletions(-)
