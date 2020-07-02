Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3ACC433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F62F20884
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ofzxJvLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgGBImO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGBImO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 04:42:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2035EC08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 01:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=HqyIXCxX5IGbvY8zL762FuGxgBm61N76zi3FqGJ89lc=; b=ofzxJvLWyvRGoUt/NZ6PzEAf3A
        ezsXEv/OThq9nola+E2s/ZsB46dIJOKMYoWroQp6JV+U3SNUwvIQ8wDTy9qBWgxG0VKOpj1kSLpi1
        ArLyL1VxEoKltC8FoP9QbGfVEX1kJzif8BFgOVEfawxXnas7YgcjqGj6lWRJlAUvVEA/0zL0qTND5
        Ym+x3gxSMMHpjwB+HFNZ200PhFSMRTbQEDQ+N/veauAeytwiREkNXbcyAAHMaEQ8OSQu1EpKLDz2d
        9iupGk8D0U29QQfrdK9b92kMQtB3/9Qnc6StCR7sIZML9hORY6ELzMGNJ6lK3vlcKuoDpq6hjYnOz
        vxaHw5hA==;
Received: from [213.208.157.36] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqunJ-0001Be-Ka; Thu, 02 Jul 2020 08:42:10 +0000
Date:   Thu, 2 Jul 2020 10:42:07 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.8
Message-ID: <20200702084207.GA3718469@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit e7eea44eefbdd5f0345a0a8b80a3ca1c21030d06:

  virtio-blk: free vblk-vqs in error path of virtblk_probe() (2020-06-30 19:02:58 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.8

for you to fetch changes up to 72d447113bb751ded97b2e2c38f886e4a4139082:

  nvme: fix a crash in nvme_mpath_add_disk (2020-07-02 10:38:00 +0200)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: fix a crash in nvme_mpath_add_disk

Sagi Grimberg (1):
      nvme: fix identify error status silent ignore

 drivers/nvme/host/core.c      | 12 +++++++++---
 drivers/nvme/host/multipath.c |  7 ++++---
 2 files changed, 13 insertions(+), 6 deletions(-)
