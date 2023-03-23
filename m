Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA744C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 04:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjCWEHX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 00:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjCWEHW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 00:07:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0143D19101
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 21:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bF/Wd72ByyxSY9ZX1MicBMeY/tPgYwqU9VpxIRfAbu8=; b=QdX9nXOI2pvqa+Ee05SgVNQ/Sa
        0yHwkdpTzpvx84lkZgGbNPlcHV12OertSEC+GHGRPlok4xuY74waBVTM8dUHoMu1mb1to7J+Kqqca
        FE9k8f2aHeDWV4ItdYc1ViTBJdZ3lbcjFKrzUYTNX9cyw3UkjHJNhNJJIZ+Zc0EWkP1DsWbmzj14M
        a2lVZef7nup6U3KuR+55F0BEYj1fMzHWqn4Spgk0Hr2G/hefFw5KAXYywxO3lYPl/o/MyHJj/kFqF
        BlgJM/+m4gn0JeGkQoDpK9w7Dg2OSgLT4ZmExODGhlszCGDb6hrlOcJrYSYy+/tdbnnjn9S8QCoE0
        vG7HqQEQ==;
Received: from 213-147-166-156.nat.highway.webapn.at ([213.147.166.156] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pfCEJ-000iMH-2q;
        Thu, 23 Mar 2023 04:07:12 +0000
Date:   Thu, 23 Mar 2023 05:07:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.3
Message-ID: <ZBvQbMungfXYQaL8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 9d2789ac9d60c049d26ef6d3005d9c94c5a559e9:

  block/io_uring: pass in issue_flags for uring_cmd task_work handling (2023-03-20 20:01:25 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.3-2023-03-23

for you to fetch changes up to aa01c67de5926fdb276793180564f172c55fb0d7:

  nvme-tcp: fix nvme_tcp_term_pdu to match spec (2023-03-22 09:19:56 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.3

 - send Identify with CNS 06h only to I/O controllers (Martin George)
 - fix nvme_tcp_term_pdu to match spec (Caleb Sander)

----------------------------------------------------------------
Caleb Sander (1):
      nvme-tcp: fix nvme_tcp_term_pdu to match spec

Martin George (1):
      nvme: send Identify with CNS 06h only to I/O controllers

 drivers/nvme/host/core.c | 3 ++-
 include/linux/nvme-tcp.h | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)
