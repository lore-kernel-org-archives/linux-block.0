Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC8FC43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 17:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7FB214C6
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 17:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iLoGcPLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfAJRJI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:09:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbfAJRJI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 12:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I/bzm35Pw942Hca27DcXxqYwqpfTEf6pGIBmWwms9tU=; b=iLoGcPLZSvgDcFTnvls1E1O+pu
        B5IOgxL1DKxAOoUBAjU6BKU9zhwtxBm9vQ8V/zbxQKfe5J8gyvDtKGAx+kXdd391+6e7CHBCDIykT
        nSQIIkUXLPge/HTQXROFRnrWk6AZAuYWEUR9flrALH11GZetRc0YGz/JiMqRGmcdmQqBwMPmQfHfl
        B2WKLJ+m/nVrPmN6gAq6LpsTX1ICt0BEoZThWKvr4GMmFEYUzMPQnvhTX11yJlwnyUkJ4SKhtM663
        QA18Nrve6ZOLhfSqs4LLU7GLEmoR0JXGRgeq4dUuShHgg6ORsKTutFC8XhwXcxzEPr8Yys7ELPY38
        hMyh8yAw==;
Received: from 089144213048.atnat0022.highway.a1.net ([89.144.213.48] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghdpK-0000UI-9w; Thu, 10 Jan 2019 17:09:06 +0000
Date:   Thu, 10 Jan 2019 18:09:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.0
Message-ID: <20190110170903.GA8025@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

please pull the set of small nvme fixes below:


The following changes since commit 47cb393ee4815e10ab66f981fed581afdcc7caac:

  block: doc: add slice_idle_us to bfq documentation (2019-01-09 07:38:48 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.0

for you to fetch changes up to b8a38ea64dc714a64f8fb76e311a4f15a3f67861:

  nvme: don't initlialize ctrl->cntlid twice (2019-01-09 13:47:08 -0500)

----------------------------------------------------------------
Andrey Smirnov (1):
      nvme: don't initlialize ctrl->cntlid twice

Hannes Reinecke (1):
      nvme-multipath: zero out ANA log buffer

Hongbo Yao (1):
      nvme-pci: fix out of bounds access in nvme_cqe_pending

James Dingwall (1):
      nvme: introduce NVME_QUIRK_IGNORE_DEV_SUBNQN

Jianchao Wang (1):
      nvme-pci: fix the wrong setting of nr_maps

Keith Busch (2):
      nvme-pci: rerun irq setup on IO queue init errors
      nvme: pad fake subsys NQN vid and ssvid with zeros

Liviu Dudau (1):
      nvme-pci: use the same attributes when freeing host_mem_desc_bufs.

Sagi Grimberg (3):
      nvme-tcp: remove dead code
      nvme-tcp: don't ask if controller is fabrics
      nvme-fabrics: unset write/poll queues for discovery controllers

 drivers/nvme/host/core.c      | 19 ++++++------
 drivers/nvme/host/fabrics.c   |  2 ++
 drivers/nvme/host/multipath.c |  2 ++
 drivers/nvme/host/nvme.h      |  5 ++++
 drivers/nvme/host/pci.c       | 67 ++++++++++++++++++++++++++++++-------------
 drivers/nvme/host/tcp.c       | 16 ++++-------
 6 files changed, 72 insertions(+), 39 deletions(-)
