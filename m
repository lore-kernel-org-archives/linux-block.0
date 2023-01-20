Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F680C46467
	for <linux-block@archiver.kernel.org>; Fri, 20 Jan 2023 05:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjATFxN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Jan 2023 00:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjATFxL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2023 00:53:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03EB2B2A9
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2023 21:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=6ViBnn5rTvABzhDsmOUPIL37W9aUkZVjQn6d+l8lARw=; b=llhFXqZrRa5D5SlUxVEcJgwLL1
        3M0x9OIEAQ4sdbNlR1i3nekEN71TwFu7iSbHBfbe+q24bhEU8MdtZ4HY25z2dty61VJ4xFBBzJa6J
        DSibyjwDJgpqX3u1cpq1obQ0FzuqcGtCKuxuunJQBj54y0DyRByfRLOnTaaKDLmET+npG/pVBoKxl
        9uE0amBaZYRTFqIPDWOB6EdUUtBatWPz1bJJOzwVubhzaS4aJVJ/PEcH9VMSSsW+EztOE1LQKALbL
        /eofmqZGzZ/+RBN9RcnWWCNdxuY9ex5rwIhTRY4cGMehWLmDdK/8kWB4Sky2yx0oPOAN2sJ4cadXd
        mauYtzfw==;
Received: from [2001:4bb8:19a:2039:1233:6ec3:7a32:5885] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIkKT-008XpC-5T; Fri, 20 Jan 2023 05:52:45 +0000
Date:   Fri, 20 Jan 2023 06:52:42 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y8osKhxLSgeKMrSj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 7746564793978fe2f43b18a302b22dca0ad3a0e8:

  block: fix hctx checks for batch allocation (2023-01-17 09:56:52 -0700)

are available in the Git repository at:

  ssh://git.infradead.org/var/lib/git/nvme.git tags/nvme-6.2-2023-01-20

for you to fetch changes up to 1c5842085851f786eba24a39ecd02650ad892064:

  nvme-pci: fix timeout request state check (2023-01-19 09:08:01 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - fix  controller shutdown regression in nvme-apple (Janne Grunau)
 - fix a polling on timeout regression in nvme-pci (Keith Busch)

----------------------------------------------------------------
Janne Grunau (2):
      nvme-apple: reset controller during shutdown
      nvme-apple: only reset the controller when RTKit is running

Keith Busch (1):
      nvme-pci: fix timeout request state check

 drivers/nvme/host/apple.c | 24 ++++++++++++++++++++----
 drivers/nvme/host/pci.c   |  2 +-
 2 files changed, 21 insertions(+), 5 deletions(-)
