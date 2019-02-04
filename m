Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEF2C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5420E2082E
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="htZ0CAzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfBDPK6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:10:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfBDPK6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 10:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kTb+UlVtFYsmvzBzgVBv0f79NYsXHZTJmriQS/4IGJo=; b=htZ0CAzV5V5AtH9W4Yx+hvQU0z
        iIQFAGvJiX8XVkuAW71EL+kbytTBlTvv0c1Ah5GV1jYGji9qZlL78m+hwJcPNKs5++hzcqCAYeQae
        FZ+8185KL1K+5qqvT8xwJxK3X/jcx7YxO23YikgEEhqU7hAaYTQGlz5ZH6tVXMwqyZANzrXiyUthU
        Dw1UZIFefpTA3/eU6d+PR/Ycgjcjdt6uvK7I70m9LRE0tMvxm1ATAnU6OXOL+9YNRqIgfVKng/eoU
        bxXsb5+4xD38CR0GDsljhiJPJHewcfTWEm/5IMIAsfwhoV1xpPH0blhpHMuTQLG2wRqrMJXSCV8v2
        kFASjMqw==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqfth-00026x-E2; Mon, 04 Feb 2019 15:10:57 +0000
Date:   Mon, 4 Feb 2019 16:10:54 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] early nvme pull request for 5.1
Message-ID: <20190204151054.GA32678@infradead.org>
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

below is our current (small) queue of NVMe patches for Linux 5.1.  We
want the re-addition of the Write Zeroes support to be in linu-next for
a few weeks as it caused some problems last time.  The only other
patch is a cleanup from Sagi.

The following changes since commit bb94aea1444b9859faa8d72aff3713fcd11c6696:

  blk-mq: save default hctx into ctx->hctxs for not-supported type (2019-02-01 08:33:43 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.1

for you to fetch changes up to 794a4cb3d2f7c105112f9b59525533f00ac06006:

  nvme: remove the .stop_ctrl callout (2019-02-04 15:41:25 +0100)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme: add support for the Write Zeroes command

Sagi Grimberg (1):
      nvme: remove the .stop_ctrl callout

 drivers/nvme/host/core.c | 54 ++++++++++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |  1 -
 drivers/nvme/host/rdma.c | 12 +++--------
 drivers/nvme/host/tcp.c  | 10 +++------
 4 files changed, 56 insertions(+), 21 deletions(-)
