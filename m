Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7001BC433E6
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323A820674
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbhAZV6q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 16:58:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405161AbhAZUFY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 15:05:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5399C221FB;
        Tue, 26 Jan 2021 20:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611691483;
        bh=50IElFkqvX0hF3h0uej8Jaf5/Vimb3qq/rsU2N0qf5Y=;
        h=From:To:Cc:Subject:Date:From;
        b=OzaLfOgjinqt7fdJoezgSh/Vm/uKfAxNaH6cwqTkO4BblJHvrYHOpJ0zkkE7E4c/Q
         c8ASsYsxFFoVAitOELzFQEfIFcFY/kTjpFrxbAiQbe3AAWAXudhwXruVGezRnHmtWF
         XxiUBKWWWgXgw5Mrf+IOXAK6weYo92NqAI1Ib1E73pWkci0iKPaql0Pm3OsMyNEbtJ
         8ujUOcEWxpgH5C8rhRMXPaGL7aI/WDaWyI0uHRkWy+6Kfqihh8o3j8jFhseBq7dEXb
         g+MGERNac417ckR0AaFQwPe5LfSZ8TDvzDJuVjdt03ABiPhmAaoLEEg5hVLlHQaQXI
         VAm/y4RZc+NIQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] mtip32xx: minor PCI cleanups
Date:   Tue, 26 Jan 2021 14:04:31 -0600
Message-Id: <20210126200433.2911982-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use PCI #defines and the special accessors for the PCIe capability.

Bjorn Helgaas (2):
  mtip32xx: use PCI #defines instead of numbers
  mtip32xx: prefer pcie_capability_read_word()

 drivers/block/mtip32xx/mtip32xx.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

-- 
2.25.1

