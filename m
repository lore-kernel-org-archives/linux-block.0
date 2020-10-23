Return-Path: <SRS0=d006=D6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255F6C388F9
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 11:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A090A24182
	for <linux-block@archiver.kernel.org>; Fri, 23 Oct 2020 11:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qn6C/eVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462653AbgJWLAm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Oct 2020 07:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462651AbgJWLAl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Oct 2020 07:00:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DD3C0613CE
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2020 04:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=u+eKJ66BtwRzfpZO0koRnDJYiwMP68LngP9eep3gWf8=; b=Qn6C/eVxnjrOzLG9NQ8WpWBiCx
        7TnNDpql5SUh0VMFXYTYkc2EoK2I+5fdHiC56T+juTeTMict1E0fjiPBKFyYI/VvXNP/ETGd0KASw
        ui0iyfnZd6tq7uaZzQwPt5+JOCgOJYDLYTLkNbQGc2TeRHRLKCZj2xQA7CjUy3zYJXPFvoQhboqL5
        AjgRh2d7yN/dVLMJp9gYSp1B8EiXtFWrbtGasuSd+Ry75VpvelkpYF2cxFF7Y1tCIH4SNtKON4Lyh
        0+KpkTaselHWRBoEPUbQETcUcyU4xdc8wFuphQ58uCzymuaLhQ41UkA1nzclSQCMO6VyqkGI67gKz
        v3LGUWyw==;
Received: from [2001:4bb8:18c:20bd:88ad:7c9d:e85e:89ca] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVuoI-00057p-Lg; Fri, 23 Oct 2020 11:00:39 +0000
Date:   Fri, 23 Oct 2020 13:00:35 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.10-rc1
Message-ID: <20201023110035.GA3504312@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit cb3a92da231bcf55c243d00fa619ee36281b0001:

  block: remove unused members for io_context (2020-10-20 07:10:14 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-23

for you to fetch changes up to f673714a1247669bc90322dfb14a5cf553833796:

  nvme-fc: shorten reconnect delay if possible for FC (2020-10-23 12:54:45 +0200)

----------------------------------------------------------------
nvme fixes for 5.10

 - rdma error handling fixes (Chao Leng)
 - fc error handling and reconnect fixes (James Smart)
 - fix the qid displace when tracing ioctl command (Keith Busch)
 - don't use BLK_MQ_REQ_NOWAIT for passthru (Chaitanya Kulkarni)
 - fix MTDT for passthru (Logan Gunthorpe)
 - blacklist Write Same on more devices (Kai-Heng Feng)
 - fix an uninitialized work struct (zhenwei pi)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: don't use BLK_MQ_REQ_NOWAIT for passthru

Chao Leng (2):
      nvme-rdma: fix crash when connect rejected
      nvme-rdma: fix crash due to incorrect cqe

James Smart (4):
      nvme-fc: fix io timeout to abort I/O
      nvme-fc: fix error loop in create_hw_io_queues
      nvme-fc: wait for queues to freeze before calling update_hr_hw_queues
      nvme-fc: shorten reconnect delay if possible for FC

Kai-Heng Feng (1):
      nvme-pci: disable Write Zeroes on Sandisk Skyhawk

Keith Busch (1):
      nvme: use queuedata for nvme_req_qid

Logan Gunthorpe (2):
      nvmet: limit passthru MTDS by BIO_MAX_PAGES
      nvmet: cleanup nvmet_passthru_map_sg()

zhenwei pi (1):
      nvmet: fix uninitialized work for zero kato

 drivers/nvme/host/fc.c         | 138 ++++++++++++++++++++++++++++-------------
 drivers/nvme/host/nvme.h       |   2 +-
 drivers/nvme/host/pci.c        |   2 +
 drivers/nvme/host/rdma.c       |   6 +-
 drivers/nvme/target/core.c     |   3 +-
 drivers/nvme/target/passthru.c |  18 ++++--
 6 files changed, 115 insertions(+), 54 deletions(-)
