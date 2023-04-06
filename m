Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4601BC7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 13:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbjDFN5M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 09:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238861AbjDFN5K (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 09:57:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AE49ED2
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=XiCu8MZTq6itawMnWEnNpiWUQ6jMWRUJO21SnKerX2Q=; b=XZtbapH2aasjogNGGkFvXyNp05
        Gg5MGm8w697zOzbQob72BPJlvau5UiAAalbVGwPA7Eved7D4BqPNPGCTUsFEWtdH/mJLGRsEPSldq
        716P/58M7e7q6jUYsSZFVt+RR74OWkO4gvQVwf24hjeYKMuOx064Nx8U4q+qF0dq9VErd0wufxDt/
        kfqoQgsslSG8+6MdWiXN+hcqHDjkUTdPEfVXhKQ61TPTz6RvNyE+UamWlNXz900HB8/HKyGFqGLX2
        /TFEPiRspOWuAuSiNSnJX0HUjx7XTeqbf1Pbtb9ZVMaLKkwu1jbwOkAnZcRbL3UKglaEAmyNGZzxi
        MtjeYTvw==;
Received: from [2001:4bb8:191:a744:e487:acf4:4793:eb02] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkQ6P-007TUy-04;
        Thu, 06 Apr 2023 13:56:37 +0000
Date:   Thu, 6 Apr 2023 15:56:33 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for Linux 6.3
Message-ID: <ZC7PkTumUFAzsKNJ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 38a8c4d1d45006841f0643f4cb29b5e50758837c:

  blk-mq: directly poll requests (2023-04-04 16:11:47 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.3-2023-04-06

for you to fetch changes up to d3205ab75e99a47539ec91ef85ba488f4ddfeaa9:

  nvme: fix discard support without oncs (2023-04-05 17:13:17 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.3

 - fix discard support without oncs (Keith Busch)

----------------------------------------------------------------
Keith Busch (1):
      nvme: fix discard support without oncs

 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
