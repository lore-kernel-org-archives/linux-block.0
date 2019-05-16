Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF4DC04AB4
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723852082E
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X1mSguPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfEPI0b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 04:26:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfEPI0b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 04:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tFkwuSbjKRw3aP9g9I77W8f+CUpdyFBR4Mjd812PS5o=; b=X1mSguPcvUMUx4VS8svbcvcSRu
        DIyNB2sgF4xtPKXaMOgTxmNAbmTfmq6Znldmr96nSMEWVK1E5Lb2ey2ZBXY5uruKLzUKGh7eRWp/4
        QNiuf21D9DYkZ6IGw/d1rrBjYTkmjkiI7rBZxpnH0xmzVbPAIFkDgsBocOb+iGwNcSqT9WTzoqJ7+
        /wqbA+vTixNjODGdrXiNkz31ch3uqqoyBpbJ/AM1l+7z5XsTxZcdDXoFotYk5v29IPDIojSZo5W5W
        IgyTGx6lhAWvRlC32BtmDC1+MwAS+9O2TqbQ3H6nuCmTlyqZLg3LJsR5clhJvRd/6axl19KJfeI9S
        85eHCLfw==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRBig-00078N-2V; Thu, 16 May 2019 08:26:30 +0000
Date:   Thu, 16 May 2019 10:25:42 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.2
Message-ID: <20190516082541.GA19383@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 936b33f7243fa1e54c8f4f2febd3472cc00e66fd:

  brd: add cond_resched to brd_free_pages (2019-05-09 12:51:27 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.2

for you to fetch changes up to 1b1031ca63b2ce1d3b664b35b77ec94e458693e9:

  nvme: validate cntlid during controller initialisation (2019-05-14 17:19:50 +0200)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme: trace all async notice events

Christoph Hellwig (2):
      nvme: change locking for the per-subsystem controller list
      nvme: validate cntlid during controller initialisation

Gustavo A. R. Silva (1):
      nvme-pci: mark expected switch fall-through

Hannes Reinecke (2):
      nvme-fc: use separate work queue to avoid warning
      nvme-multipath: avoid crash on invalid subsystem cntlid enumeration

Max Gurtovoy (1):
      nvme-rdma: remove redundant reference between ib_device and tagset

Maxim Levitsky (2):
      nvme-pci: init shadow doorbell after each reset
      nvme-pci: add known admin effects to augument admin effects log page

Minwoo Im (2):
      nvme-fabrics: remove unused argument
      nvme: fix typos in nvme status code values

 drivers/nvme/host/core.c      | 79 ++++++++++++++++++++++---------------------
 drivers/nvme/host/fabrics.c   |  4 +--
 drivers/nvme/host/fc.c        | 14 ++++++--
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/pci.c       |  4 +--
 drivers/nvme/host/rdma.c      | 34 +++----------------
 drivers/nvme/host/trace.h     |  1 +
 include/linux/nvme.h          |  4 +--
 8 files changed, 64 insertions(+), 78 deletions(-)
