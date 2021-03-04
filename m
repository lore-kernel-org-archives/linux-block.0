Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69467C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 18:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279D664F5C
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 18:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhCDSAo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Mar 2021 13:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbhCDSAn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Mar 2021 13:00:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1101C061574
        for <linux-block@vger.kernel.org>; Thu,  4 Mar 2021 10:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=5T1ovpkkZ9KpD4mFuBcOtRnbMPcS5jtbDEuen2p06/8=; b=bBCETx0E8gBiJ17Q2hI+pFEYqf
        J3LBFSHSlvrpxTQi2jKYR0ez/tIFlqptQBb5NGvpTL3XfwlwiWkvS40zTBxr6kcLhs521A/CbvjLm
        FsY1PVjIt3N8GoVhtIZCSoVJVZ1nked1DYROs5gszAIMNoDzE1Hg9VJAp3p9bOPUG7nn7+IHg05aX
        cTERsUzBWx4w3awt19AJuGmUSVgPD5S2fX/gjwnHVB/3tbP+mb6ni2eQE2wjirEq5Gigpy37vITUy
        wwBR21PY8oiOc1k0b6muwTNoc2WPJFEyNBqSkuHX4G9Z4ViJvbIte5tQesKSguwQ7tDzx2D/oJRXc
        376rTqAA==;
Received: from [2001:4bb8:180:9884:c7d1:752e:bee8:ebce] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lHsFz-0086VT-Gu; Thu, 04 Mar 2021 17:59:36 +0000
Date:   Thu, 4 Mar 2021 18:59:26 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.12
Message-ID: <YEEf/hvMMuqpp63T@infradead.org>
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

  git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-04

for you to fetch changes up to fc45c3b2b8e3cb11b2c89449760b8d82321df29e:

  nvmet: model_number must be immutable once set (2021-03-04 18:51:44 +0100)

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
