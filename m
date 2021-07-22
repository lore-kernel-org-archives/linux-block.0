Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EECC4338F
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 18:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9756360EB2
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 18:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhGVSQi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jul 2021 14:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGVSQi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 14:16:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C2CC061575
        for <linux-block@vger.kernel.org>; Thu, 22 Jul 2021 11:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=vPzicTsQNqzpGuhcoSCNUmZQidereeyfqguWHkqWm6U=; b=WBQSD29hHDGyqKeKwTFSs2KFho
        Yzez0oJCjMaXx/1JmNW7WPOhLJpLlpQMuLFmNfzKzqIXs9uDHsSnSZrd2M38IT2iyVGHKQZaDOFnF
        HNDR8ArI3tjPe5KA1LvxRnumhKKdsSR5mvTvbrSNyxw0LgnRxIBmqoAizRYY8k1wtWCWMLfmEDtJ+
        KpvPCGK51S7SZjYLsBxdGtMh3OzAg4ZQgZ3BlvUrLugwlKvs5fj+cvvrigECxh2dygVLaElQCBNdL
        ekxC5s33w7JQE21soMgSW97sNGiO5Xo2PKNayzZcBqbbDLsIaaDwN2s2xadyPyldPIjHc67apSoar
        vqJcM6iQ==;
Received: from [2001:4bb8:193:7660:c4c4:42f6:7449:aaf8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6dsK-00Aaka-Lp; Thu, 22 Jul 2021 18:56:57 +0000
Date:   Thu, 22 Jul 2021 20:56:48 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.14
Message-ID: <YPm/cHUBGJpVOS4n@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit ec645dc96699ea6c37b6de86c84d7288ea9a4ddf:

  block: increase BLKCG_MAX_POLS (2021-07-17 13:07:24 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.14-2021-07-22

for you to fetch changes up to aaeb7bb061be545251606f4d9c82d710ca2a7c8e:

  nvme: set the PRACT bit when using Write Zeroes with T10 PI (2021-07-21 17:24:10 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.14:

 - tracing fix (Keith Busch)
 - fix multipath head refcounting (Hannes Reinecke)
 - Write Zeroes vs PI fix (me)
 - drop a bogus WARN_ON (Zhihao Cheng)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: set the PRACT bit when using Write Zeroes with T10 PI

Hannes Reinecke (1):
      nvme: fix refcounting imbalance when all paths are down

Keith Busch (1):
      nvme: fix nvme_setup_command metadata trace event

Zhihao Cheng (1):
      nvme-pci: don't WARN_ON in nvme_reset_work if ctrl.state is not RESETTING

 drivers/nvme/host/core.c      | 19 +++++++++++++++----
 drivers/nvme/host/multipath.c |  9 ++++++++-
 drivers/nvme/host/nvme.h      | 11 ++---------
 drivers/nvme/host/pci.c       |  4 +++-
 drivers/nvme/host/trace.h     |  6 +++---
 5 files changed, 31 insertions(+), 18 deletions(-)
