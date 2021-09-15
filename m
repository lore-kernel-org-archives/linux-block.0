Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088FDC433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 13:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A3E61164
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 13:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhIONwZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 09:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhIONwZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 09:52:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D71BC061574
        for <linux-block@vger.kernel.org>; Wed, 15 Sep 2021 06:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=R/oDDB1X8KW8mjUHzbdJN1KMLEZY1CFlvWgnnv8S4Uc=; b=eJFDDrmJbK90k6a0a75NFmWkuB
        nXjV3EjRTRIJIPCGDZsgHcbcsb+6CA1FC/YyZVXiKOW6MciuWRYZ51nVnQ0/GlEimrHIdyYVpy/ej
        dDVyJ07p/SG0a0A8prkXHLF7urXHOBQFs0sGlbnHpaL/t1PeDs085yaMqKswIwIo2Z08Cbo/Iw/bl
        aeY1TnwSljwMXNiRKlX2IlotiOvk3omIo9NUDGOwzSqZZyfNjZf0Pb809tgmQ5ezLcTiaZtN5fc07
        hSSvhioFPsypl6b0Zke1AgjM6bvUVOWj2YDUcKtySSh7435rEGWBSWtuTn/FQTCSA9IQuvldz6+0H
        5rkQNRXQ==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQVIS-00FinU-K2; Wed, 15 Sep 2021 13:50:12 +0000
Date:   Wed, 15 Sep 2021 15:49:55 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.15
Message-ID: <YUH6AxwHYm+FN1Au@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 67f3b2f822b7e71cfc9b42dbd9f3144fa2933e0b:

  blk-mq: avoid to iterate over stale request (2021-09-12 19:32:43 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.15-2021-09-15

for you to fetch changes up to 70f437fb4395ad4d1d16fab9a1ad9fbc9fc0579b:

  nvme-tcp: fix io_work priority inversion (2021-09-14 10:32:05 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.15

 - fix ANA state updates when a namespace is not present (Anton Eidelman)
 - nvmet: fix a width vs precision bug in nvmet_subsys_attr_serial_show
   (Dan Carpenter)
 - avoid race in shutdown namespace removal (Daniel Wagner)
 - fix io_work priority inversion in nvme-tcp (Keith Busch)
 - destroy cm id before destroy qp to avoid use after free (Ruozhu Li)

----------------------------------------------------------------
Anton Eidelman (1):
      nvme-multipath: fix ANA state updates when a namespace is not present

Dan Carpenter (1):
      nvmet: fix a width vs precision bug in nvmet_subsys_attr_serial_show()

Daniel Wagner (1):
      nvme: avoid race in shutdown namespace removal

Keith Busch (1):
      nvme-tcp: fix io_work priority inversion

Ruozhu Li (1):
      nvme-rdma: destroy cm id before destroy qp to avoid use after free

 drivers/nvme/host/core.c       | 15 +++++++--------
 drivers/nvme/host/multipath.c  |  7 +++++--
 drivers/nvme/host/rdma.c       | 16 +++-------------
 drivers/nvme/host/tcp.c        | 20 ++++++++++----------
 drivers/nvme/target/configfs.c |  2 +-
 5 files changed, 26 insertions(+), 34 deletions(-)
