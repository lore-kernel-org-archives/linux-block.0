Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B37DC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590FD206B6
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 17:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UzT2LzqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfC1RTr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:19:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1RTr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 13:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XDv98yuGwtM6MhbpnY7yJ84TRVg5Tdo6lMw+KaVvm0E=; b=UzT2LzqFiOcYQyVtfrN5BpWtOQ
        NJDmWanqeccVs8IwAtUbFBKGcJ5hN1hH9mBwJNGRx/t8885jDiDEnF4vwsfcoXyTLqzq2nWsRA42d
        ABPrGI27Ym1RjfGbFgrOUU9ew6teDP23dZYU0G5HpGxtbMNtB6A4QPBhSBk/Ol7A4RUL3bwAd9tay
        6dX1FWT8lPe12RmQJubnQdXwaiH9+vPzX5RGRHGKcYycHMX1ka6d2Wwpa/2+NVvz/vlNEoEPEidEA
        vBd6tdu0a53evCIX4Hw1yuV7/cpzNPiAXwLl7LvhpHIxTwHqelwtvFkp5idB9cFfQYT25XLon2CqV
        VlbBhD5w==;
Received: from 213-225-14-48.nat.highway.a1.net ([213.225.14.48] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9Ygr-0000a3-Vg; Thu, 28 Mar 2019 17:19:46 +0000
Date:   Thu, 28 Mar 2019 18:19:28 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.1
Message-ID: <20190328171928.GA26641@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A few accumulated small fixes:

 - fix an endianess misannotation that sneaked in this merge window in
   nvme-tcp (me)
 - fix nvme-loop to handle multi-page segments (Ming)
 - fix error handling in the nvmet configfs code (Max)
 - add a missing requeue point in the multipath code (Martin George)

The following changes since commit dd08a8d9a66de4b54575c294a92630299f7e0fe7:

  libata: fix using DMA buffers on stack (2019-03-28 08:16:04 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.1

for you to fetch changes up to a536b49785759bf99465fdf6e248d34322123fcd:

  nvmet: fix error flow during ns enable (2019-03-28 18:15:03 +0100)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme-tcp: fix an endianess miss-annotation

Martin George (1):
      nvme-multipath: relax ANA state check

Max Gurtovoy (1):
      nvmet: fix error flow during ns enable

Ming Lei (1):
      nvmet: fix building bvec from sg list

 drivers/nvme/host/multipath.c     |  5 +----
 drivers/nvme/host/tcp.c           |  2 +-
 drivers/nvme/target/core.c        |  4 ++--
 drivers/nvme/target/io-cmd-file.c | 20 ++++++++++----------
 4 files changed, 14 insertions(+), 17 deletions(-)
