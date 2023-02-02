Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6CEC61DA4
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 15:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjBBPXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 10:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjBBPXX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 10:23:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3647D16303
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 07:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xhTmDKWbL2Q+ADomHwmZKFLODShjxozhC5a0dwbcc4k=; b=gfG5LPW7ErRL1mDW8RGmRuRXe8
        j0ruYEl+cQBBot0usXF5NtKl6CIBeYfJjx/aB8Vji8En8Wdu0BLgTKL8YsxQaiylJ9aOkwkK31VCZ
        tcFsBSAX6WyJgra8T9Hkf+SwFdWlJyHZNx7LDe/4fxsoUXoHkENUZ5HFMJGkJwzUxeKO2UArwqfmi
        Ga7CJexX1dw0/m6dhdLWe/o6bXgBzVZCeKQ77+TO0zuDkS+yxuSi1Dev5tMYOtWDH8LK4aIhbVf35
        2ThTs49dU+WQL9ZWthjxZOYTIOOy2QITAYcHqRwVHJUY0tCGqOgDzIFl773KGzLmvs7VMu28BBUBO
        KiLgAnmw==;
Received: from [2001:4bb8:19a:272a:3196:5eba:213b:e6aa] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNbQe-00GK9B-QC; Thu, 02 Feb 2023 15:23:13 +0000
Date:   Thu, 2 Feb 2023 16:23:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y9vVXvMeTgA4bC2R@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 81ea42b9c3d61ea34d82d900ed93f4b4851f13b0:

  block: Fix the blk_mq_destroy_queue() documentation (2023-01-31 11:46:15 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2023-02-02

for you to fetch changes up to bd97a59da6a866e3dee5d2a2d582ec71dbbc84cd:

  nvme-auth: use workqueue dedicated to authentication (2023-02-01 16:11:20 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - fix a missing queue put in nvmet_fc_ls_create_association (Amit Engel)
 - clear queue pointers on tag_set initialization failure
   (Maurizio Lombardi)
 - use workqueue dedicated to authentication (Shin'ichiro Kawasaki)

----------------------------------------------------------------
Amit Engel (1):
      nvme-fc: fix a missing queue put in nvmet_fc_ls_create_association

Maurizio Lombardi (2):
      nvme: clear the request_queue pointers on failure in nvme_alloc_admin_tag_set
      nvme: clear the request_queue pointers on failure in nvme_alloc_io_tag_set

Shin'ichiro Kawasaki (1):
      nvme-auth: use workqueue dedicated to authentication

 drivers/nvme/host/auth.c | 14 ++++++++++++--
 drivers/nvme/host/core.c |  5 ++++-
 drivers/nvme/target/fc.c |  4 +++-
 3 files changed, 19 insertions(+), 4 deletions(-)
