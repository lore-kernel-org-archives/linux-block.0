Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5BBC38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 15:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F9D207DD
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 15:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZQ6+L0ii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEHPjz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 11:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgEHPjz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 11:39:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A3EC061A0C
        for <linux-block@vger.kernel.org>; Fri,  8 May 2020 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4ZXIhWeQtMsx8PQEY7iapHNgjrI8iMi2OLLnPqcfvBw=; b=ZQ6+L0iiaZOw2vq0wZ+a/mCEBs
        qhsytno9lt3McZsi5TtWGvTqpNySunHgD+VkPK7KQDOS1/FUW0IMTkKPCOW6QaNyTgYprzLah0piR
        7hJ7V/YkEiXaGF59sVTT+FWlyPxUpRceVx+exIYVKiuYl8/s5HxBhvdXceH0RBH8ttqJnj5m968oq
        UXXUfTG1pJYABFpvCEcic1Ics9B+uzrdnh48xVUvOfqc4boNxBzKEMLraZ21wBVfLVwEPaVE0t+1p
        M0IV1/sT8gZ1MAWvXjLry+PNOJhcIzPMJjeI3dQJbV52NKepLWEjQqWfjDJtxhspLHVrWwcp96m8Z
        EALuMY6g==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX56P-0004qA-FU; Fri, 08 May 2020 15:39:53 +0000
Date:   Fri, 8 May 2020 17:39:51 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@fb.com>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme fixes for 5.7
Message-ID: <20200508153951.GA250474@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 860a93ff87acd001eea827b70f4a7a64c0854b81:

  bdi: add a ->dev_name field to struct backing_dev_info (2020-05-07 08:45:47 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.7

for you to fetch changes up to 8874d040ff34285e8b8458a75f9434e19ed06174:

  nvme: fix possible hang when ns scanning fails during error recovery (2020-05-08 17:04:15 +0200)

----------------------------------------------------------------
Alexey Dobriyan (1):
      nvme-pci: fix "slimmer CQ head update"

Sagi Grimberg (1):
      nvme: fix possible hang when ns scanning fails during error recovery

 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/pci.c  | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)
