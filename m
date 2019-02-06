Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C41C169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 15:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE12217F9
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 15:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z6eCDj0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfBFPie (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:38:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbfBFPie (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Feb 2019 10:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qWY1Ot6aXxcduPSgIWq24hhF09/Hl5gi8wVKMCLzZ20=; b=Z6eCDj0sYoLFVTc6o6PtH+IJPD
        bkXadgiKal56lTUW/9tD9wJOEq/LxCbhbts6Ix6oOxQ7UH/wNftpO7LuieWG3CfP8k5eQUGn/ephB
        im3dA5vioXI2sBBYW5HFehI4mg0yiQCArAgX8AZI4ncdEH3OXinHoenfW0JR/8w/Uc8PMH7Nk1EIU
        YIX88uV3hMF3gCbzP/z569NbRtRcthTUGwcVcO+IJJ/w4fiyaIxMApoMg7VrgQMRo2BdhogFvy8VY
        /ZZvi5BOwtRdMrXKYBy/Xm0Xg5H3Tqyhd3egtpncP4ahQfKfTCL8ba223UuTkJVMYVycj89AYwKv7
        FS9Cu2lg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grPHT-0005L0-V1; Wed, 06 Feb 2019 15:38:32 +0000
Date:   Wed, 6 Feb 2019 16:38:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.0
Message-ID: <20190206153828.GA14994@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit ec51f8ee1e63498e9f521ec0e5a6d04622bb2c67:

  aio: initialize kiocb private in case any filesystems expect it. (2019-02-06 08:04:22 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.0

for you to fetch changes up to 5c959d73dba6495ec01d04c206ee679d61ccb2b0:

  nvme-pci: fix rapid add remove sequence (2019-02-06 16:35:33 +0100)

----------------------------------------------------------------
Keith Busch (2):
      nvme: lock NS list changes while handling command effects
      nvme-pci: fix rapid add remove sequence

 drivers/nvme/host/core.c |  8 +++++++-
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 22 ++++++++++++----------
 3 files changed, 20 insertions(+), 11 deletions(-)
