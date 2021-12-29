Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F414AC433F5
	for <linux-block@archiver.kernel.org>; Wed, 29 Dec 2021 17:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbhL2RG5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Dec 2021 12:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237399AbhL2RG4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Dec 2021 12:06:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB15CC061574
        for <linux-block@vger.kernel.org>; Wed, 29 Dec 2021 09:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=0hnaJET3hwZ2jGvK632Sz8P5rXvQJFDNFzu4B3INbiE=; b=2KdJT80vaxQwffVdU2h4Q+mIQX
        29+P9uLkjayDxencoPgi+klVhBeUwj4pNmA+dUKMlCv1VhHZKtWgwld7xx7JnZF6ugqSg6Ayj9/fP
        gj12OSkthiWUk+lYmUQglAD6HpWgEaCCPKmlpG02LqehDAX7lUtwV+JBgPrKHWCtXg2kHqDqen8y2
        gXYPCpqcMYvN0fjzNne/HZ4jdM4TjjBXal5bv/FkGnI8r4HO0BYDFScNKfCCrM81G7kGPmbsxUaIm
        P78ZKpWfb9/uPj4YyGrcjTESWfkpjZBy6Pp2LJdOAWmtQPy1sYT3kPWXSnOymgi9v4s/Z7ECGGRyA
        xMK6g/HQ==;
Received: from [2001:4bb8:188:43d3:df02:51d9:650c:3c4d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n2cPd-003Ayt-MG; Wed, 29 Dec 2021 17:06:54 +0000
Date:   Wed, 29 Dec 2021 18:06:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 5.17
Message-ID: <YcyVq0hj1dPtRiGp@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


The following changes since commit 3427f2b2c533d97bcc57b4237c2af21a8bd2cdbc:

  block: remove the rsxx driver (2021-12-16 10:57:04 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.17-2021-12-29

for you to fetch changes up to e3d347943919f35ccdeed8d2cc62e8c6c12b36cd:

  nvme: add 'iopolicy' module parameter (2021-12-23 11:22:46 +0100)

----------------------------------------------------------------
nvme updates for Linux 5.17

 - increment request genctr on completion (Keith Busch, Geliang Tang)
 - add a 'iopolicy' module parameter (Hannes Reinecke)
 - print out valid arguments when reading from /dev/nvme-fabrics
   (Hannes Reinecke)

----------------------------------------------------------------
Geliang Tang (1):
      nvme: drop unused variable ctrl in nvme_setup_cmd

Hannes Reinecke (2):
      nvme-fabrics: print out valid arguments when reading from /dev/nvme-fabrics
      nvme: add 'iopolicy' module parameter

Keith Busch (1):
      nvme: increment request genctr on completion

 drivers/nvme/host/core.c      |  7 +------
 drivers/nvme/host/fabrics.c   | 22 +++++++++++++++++++++-
 drivers/nvme/host/multipath.c | 41 ++++++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h      |  8 ++++++++
 4 files changed, 66 insertions(+), 12 deletions(-)
