Return-Path: <SRS0=/Scz=CT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23102C43461
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 10:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B019E2145D
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 10:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oQlY5YWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgIJKBv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730432AbgIJKBu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Sep 2020 06:01:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18FBC061573
        for <linux-block@vger.kernel.org>; Thu, 10 Sep 2020 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=VDRch+SAmJbg4l/+gjTOYbzNgIltiodZ/qPkyx3K78k=; b=oQlY5YWwZYcqr5GafZpFn0w2aP
        bvf8uCWy9zB/dgT7Hvo8p3PTY2VZ8SN6OlR8OSEYZmHka9RYotsMPMYnDxecAEkiXTL0oSXsiwUbP
        2whDmvW94K0mceMpLdfFUdF1Zga+cfYQdK4vh7YGl+iURSnsCO5llm535hyVuGhy+PWOvLDmm/1MM
        0F0Cit5zwBhNzUvv/38onTL9mdjKMdakxGBk6UatxiTCq0bPcyFr7HkwEU4tU5e6zMHzKamB2ZAom
        zyPaCpUq/asNmRz8mZIrGAjgoPg4vRzXPdAMjywocOel4tjOf1q5GrleeEsuaN6/2s4KchVicBh+g
        ELAHrlsA==;
Received: from [2001:4bb8:184:af1:d8d0:3027:a666:4c4e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGJOZ-0006mm-4C; Thu, 10 Sep 2020 10:01:35 +0000
Date:   Thu, 10 Sep 2020 12:01:34 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@fb.com>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme fixes for 5.9
Message-ID: <20200910100134.GA613851@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 88ce2a530cc9865a894454b2e40eba5957a60e1a:

  block: restore a specific error code in bdev_del_partition (2020-09-08 08:18:24 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.9-2020-09-10

for you to fetch changes up to 73a5379937ec89b91e907bb315e2434ee9696a2c:

  nvme-fabrics: allow to queue requests for live queues (2020-09-09 08:00:50 +0200)

----------------------------------------------------------------
nvme fixes for 5.9

 - cancel async events before freeing them (David Milburn)
 - revert a broken race fix (James Smart)
 - fix command processing during resets (Sagi Grimberg)

----------------------------------------------------------------
David Milburn (3):
      nvme-fc: cancel async events before freeing event struct
      nvme-rdma: cancel async events before freeing event struct
      nvme-tcp: cancel async events before freeing event struct

James Smart (1):
      nvme: Revert: Fix controller creation races with teardown flow

Sagi Grimberg (1):
      nvme-fabrics: allow to queue requests for live queues

 drivers/nvme/host/core.c    |  5 -----
 drivers/nvme/host/fabrics.c | 12 ++++++++----
 drivers/nvme/host/fc.c      |  1 +
 drivers/nvme/host/nvme.h    |  1 -
 drivers/nvme/host/rdma.c    |  1 +
 drivers/nvme/host/tcp.c     |  1 +
 6 files changed, 11 insertions(+), 10 deletions(-)
