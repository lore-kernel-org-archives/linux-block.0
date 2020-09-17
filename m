Return-Path: <SRS0=JXuJ=C2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CDFC433E2
	for <linux-block@archiver.kernel.org>; Thu, 17 Sep 2020 18:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E44921D92
	for <linux-block@archiver.kernel.org>; Thu, 17 Sep 2020 18:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sNvZ85ZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgIQSGX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgIQRjQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Sep 2020 13:39:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AABC061788
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2020 10:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cVjYCdQq6oWYwx7BQKEnoBv/QOUczwpDqncGM7xXaZo=; b=sNvZ85ZJgoDRaVw19sn7RIawZi
        mmwlFqyBej05oqFFfOQUralWYX3+8PuNo6+2nKM5j7mGOU/0zw88zoVDfzcuGC3QuHV4YquTT19kU
        uMzEtoCjD7eTvXX57aG5PSQ3ANQcLmYshkOoS2MtdwDqPQNq9VxvPqI23riUZTvmBw+K8AOvbcAUm
        FPXzsXjKRYDfye0ym08rmDzb2ZIiJAAvRNChQmj0GZRYSTOzOGlPcs6eC4WGe4NXFw/L9SZk6XB5i
        rnelzRxTOuRj+eHpnzCi4OvzTHbnW5bSUDl7fVTcLRFfpEjE1VB2dr+YiMmOIADfXPNFoXrGkhJ0z
        Qakz6frQ==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIxsA-0003Bm-C5; Thu, 17 Sep 2020 17:39:06 +0000
Date:   Thu, 17 Sep 2020 19:36:54 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme fixes for 5.9
Message-ID: <20200917173654.GA3311729@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 709192d531e5b0a91f20aa14abfe2fc27ddd47af:

  s390/dasd: Fix zero write for FBA devices (2020-09-14 19:40:21 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.9-2020-09-17

for you to fetch changes up to 3a6b076168e20a50289d71f601f1dd02be0f8e88:

  nvmet: get transport reference for passthru ctrl (2020-09-17 10:36:25 +0200)

----------------------------------------------------------------
nvme fixes for 5.9

 - another quirk for the controller from hell (David Milburn)
 - fix a Kconfig dependency (Necip Fazil Yildiran)
 - char devices / passthrough refcount fixes (Chaitanya Kulkarni)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme-core: get/put ctrl and transport module in nvme_dev_open/release()

Christoph Hellwig (1):
      nvmet: get transport reference for passthru ctrl

David Milburn (1):
      nvme-pci: disable the write zeros command for Intel 600P/P3100

Necip Fazil Yildiran (1):
      nvme-tcp: fix kconfig dependency warning when !CRYPTO

 drivers/nvme/host/Kconfig      |  1 +
 drivers/nvme/host/core.c       | 15 +++++++++++++++
 drivers/nvme/host/pci.c        |  3 ++-
 drivers/nvme/target/passthru.c |  2 ++
 4 files changed, 20 insertions(+), 1 deletion(-)
