Return-Path: <SRS0=MGRw=ID=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBD1C433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 16:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15FA96508C
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 16:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCEQLn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 11:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhCEQLe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 11:11:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6621EC061574
        for <linux-block@vger.kernel.org>; Fri,  5 Mar 2021 08:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Wb3hp7rUaFmiEPgk5Zlai5Ac7+Fj0yvLC8OgsUfflBA=; b=LEA54gjUsFK8PPNV+ub+eqnmBr
        tGXA6FqS9M0DclxcjoxC7jDMfoW8dBjxGQyZze5ruTh7Rg7n+o6nU89Fy+wp/XpoZSTMHYVjRsPc6
        dflvkEgZTfPYEWEjiEbCsGR6zlXfbDaONtKKKWZiP+t6RTB2cv+wE3RZAlHzR+vjjW6M3nRcn5h3d
        nYi4v/ujF8ybQC4TEwEw9mk8N3AD0bIYuX4tLejx0bj0vXclojX2HUW207t5SvsyCtzva6RMX6ZWe
        ez4Z/63Jh5VrhZ4bYrIJdHc8zO9eaAFJCotQwJmkchJLQx8SrlPAfPBx38M0LUMi1wARNa56bSxze
        2sQuOsAw==;
Received: from 089144194051.atnat0003.highway.a1.net ([89.144.194.51] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lID2e-00Bxob-9w; Fri, 05 Mar 2021 16:11:13 +0000
Date:   Fri, 5 Mar 2021 17:11:01 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.12
Message-ID: <YEJYFTnbec9jteOc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 77516d25f54912a7baedeeac1b1b828b6f285152:

  rsxx: Return -EFAULT if copy_to_user() fails (2021-03-03 06:48:44 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-05

for you to fetch changes up to d9f273b7585c380d7a10d4b3187ddc2d37f2740b:

  nvmet: model_number must be immutable once set (2021-03-05 13:41:03 +0100)

----------------------------------------------------------------
nvme fixes for 5.12:

 - more device quirks (Julian Einwag, Zoltán Böszörményi, Pascal Terjan)
 - fix a hwmon error return (Daniel Wagner)
 - fix the keep alive timeout initialization (Martin George)
 - ensure the model_number can't be changed on a used subsystem
   (Max Gurtovoy)

----------------------------------------------------------------
Daniel Wagner (1):
      nvme-hwmon: Return error code when registration fails

Julian Einwag (1):
      nvme-pci: mark Seagate Nytro XM1440 as QUIRK_NO_NS_DESC_LIST.

Martin George (1):
      nvme-fabrics: fix kato initialization

Max Gurtovoy (1):
      nvmet: model_number must be immutable once set

Pascal Terjan (1):
      nvme-pci: add quirks for Lexar 256GB SSD

Zoltán Böszörményi (1):
      nvme-pci: mark Kingston SKC2000 as not supporting the deepest power state

 drivers/nvme/host/fabrics.c     |  5 ++++-
 drivers/nvme/host/hwmon.c       |  1 +
 drivers/nvme/host/pci.c         |  8 ++++++-
 drivers/nvme/target/admin-cmd.c | 36 ++++++++++++++++++++---------
 drivers/nvme/target/configfs.c  | 50 +++++++++++++++++++----------------------
 drivers/nvme/target/core.c      |  2 +-
 drivers/nvme/target/nvmet.h     |  7 +-----
 7 files changed, 62 insertions(+), 47 deletions(-)
