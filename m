Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE549C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 15:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BDE20868
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 15:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F4StMmh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BDE20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeLACen (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:34:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLACen (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 21:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ClndmmduVRl6zquPrnozhxbfP40ENKQBMCkKNm966Mk=; b=F4StMmh9xS19BuL4L7yyCPLHtK
        Ugj1fDw+t5H+4M8naD2g4o5cdy3P8wf1RVafJITV7L0oOyN/2G/JwtRr1FIVbX4A6Ifvyl/5z/laU
        NsUWtQdKSKf6+HBClQVFT7ZpqI9GuHxCJkgD2FWB+ydy1y/Fq81e1aL/LXiGFW1EZFm3hn9A1BVSH
        RzRqt1N2U0RWFPcAJHhjDhW5yUjbbGlfDz6fyekLQ6wiRemoMxRi9+z5Hl5KDggjM1WD/B5XwXCzn
        +i6beVI2ZqbdzINNn/fEuZkOdd0QlEQl+PMmGFobDrQSELy5ROz2no5c0a9vuOe0Kfyly+aoDCtZJ
        Nh1VhI0Q==;
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSkf5-0001NQ-2I; Fri, 30 Nov 2018 15:24:59 +0000
Date:   Fri, 30 Nov 2018 16:24:30 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 4.20
Message-ID: <20181130152430.GA3107@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Various fixlets all over, including throwing in a 'default y' for the
multipath code, given that we want people to actually enable it for full
functionality.

The following changes since commit 14b04063cc994effc86f976625bf8f806d8d44cb:

  Merge branch 'nvme-4.20' of git://git.infradead.org/nvme into for-linus (2018-11-21 05:56:28 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.20

for you to fetch changes up to d4779afb08ef3f012053cdf3bebed5960587ab88:

  nvme-rdma: fix double freeing of async event data (2018-11-29 16:43:20 +0100)

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: enable multipathing by default
      nvme: warn when finding multi-port subsystems without multipathing enabled

Ewan D. Milne (1):
      nvme-fc: initialize nvme_req(rq)->ctrl after calling __nvme_fc_init_request()

Igor Konopko (1):
      nvme-pci: fix surprise removal

Keith Busch (1):
      nvme: Free ctrl device name on init failure

Prabhath Sajeepa (1):
      nvme-rdma: fix double freeing of async event data

Sagi Grimberg (1):
      nvme: flush namespace scanning work just before removing namespaces

 drivers/nvme/host/Kconfig | 8 ++++++++
 drivers/nvme/host/core.c  | 8 +++++---
 drivers/nvme/host/fc.c    | 2 +-
 drivers/nvme/host/nvme.h  | 3 +++
 drivers/nvme/host/rdma.c  | 2 ++
 5 files changed, 19 insertions(+), 4 deletions(-)
