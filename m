Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899FEC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 19:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA4123B83
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 19:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbhANTa4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jan 2021 14:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbhANTaz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jan 2021 14:30:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985F6C061575
        for <linux-block@vger.kernel.org>; Thu, 14 Jan 2021 11:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iMbL6fqf8zt3Caal0LFmwWvyAtg2qmkvjNKB8hnyUHg=; b=DC7GehA3Lx6enHNSQ6zd66cNmx
        hR+OG6MHYRLYpzQUjMfJ0p5q5BBaTT8nfjaqX80ibAfuR6XnT8KfK/gFxRb0uGd8XBtIUa/w5k45b
        Rt4lop9F/AedObd/7Noip+q7TmTeyFBrtpp0fbcvx828uedz3ZYF1A8RJge7tBK6/sTpS/cEYRNQA
        DIJJV5IhXbmowTWSl2+qLomA9SWGWR7P0c+n1IuhMiJN0jqZfodTOBfJ8hLKaDY6Lg32F5uCdnRjx
        K4WxragZQHWJXjCGaH8e+YFOKz0WdGYShqBt6ZoHSgP//pFpqCiPQd5txRtPqxGNs5HTcF1QsMVme
        wBpeX3uA==;
Received: from [2001:4bb8:188:1954:a479:70de:a137:a166] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l08JZ-007yd6-Kq; Thu, 14 Jan 2021 19:30:02 +0000
Date:   Thu, 14 Jan 2021 20:29:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.11
Message-ID: <YACbrIes4r8Qa1mA@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 5342fd4255021ef0c4ce7be52eea1c4ebda11c63:

  bcache: set bcache device into read-only mode for BCH_FEATURE_INCOMPAT_OBSO_LARGE_BUCKET (2021-01-09 09:21:03 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.11-2021-01-14

for you to fetch changes up to 5ab25a32cd90ce561ac28b9302766e565d61304c:

  nvme: don't intialize hwmon for discovery controllers (2021-01-14 20:27:35 +0100)

----------------------------------------------------------------
nvme fixes for 5.11:

 - don't initialize hwmon for discover controllers (Sagi Grimberg)
 - fix iov_iter handling in nvme-tcp (Sagi Grimberg)
 - fix a preempt warning in nvme-tcp (Sagi Grimberg)
 - fix a possible NULL pointer dereference in nvme (Israel Rukshin)

----------------------------------------------------------------
Israel Rukshin (1):
      nvmet-rdma: Fix NULL deref when setting pi_enable and traddr INADDR_ANY

Sagi Grimberg (3):
      nvme-tcp: Fix warning with CONFIG_DEBUG_PREEMPT
      nvme-tcp: fix possible data corruption with bio merges
      nvme: don't intialize hwmon for discovery controllers

 drivers/nvme/host/core.c   | 11 ++++++++---
 drivers/nvme/host/tcp.c    |  4 ++--
 drivers/nvme/target/rdma.c | 16 ++++++++--------
 3 files changed, 18 insertions(+), 13 deletions(-)
