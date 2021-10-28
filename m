Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B23C433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 14:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8462760F70
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 14:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhJ1Oad (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 10:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhJ1Oad (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 10:30:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB32C061570
        for <linux-block@vger.kernel.org>; Thu, 28 Oct 2021 07:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=00vLC3ywJaxbSWyX1jfgr2zOVXdj2tUeKln34fWMng4=; b=snYHSVHXdxCEriRGobsX8muvM7
        PnN0O0TO88zM5CdO32hhShTNyw0jkDoTu9whRYfSjF8iow2hyHZgwMBauIfb1m1aeHFc6JHB2fJMS
        rVegr245yCu16fC7lP6MBJjjTtlrr2/Vym0XrU7C87jwX3Req+wYIp4Ns0t73HOPU9KX+DaleSt6F
        6mel7bjCfc+o7roNWAXHIoXHFIdEp3QckCbytxYT5R2B2lKOM3H4Y+UtUoXIgkMlXo+BNy6r8PFZa
        kTrRZAeF8oTX1UNIslX/4Ki4t+HLxxLWD8isl2sp9m8shMvG4rFv7KSgDopTrREQyh7K33F0m/ImA
        Jd2Hc+tw==;
Received: from [2001:4bb8:199:7b1d:487c:3190:e387:3394] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mg6Nu-0089gT-0r; Thu, 28 Oct 2021 14:28:02 +0000
Date:   Thu, 28 Oct 2021 16:27:59 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] second round of nvme updates for Linux 5.16
Message-ID: <YXqzb6dj0DCrIbGY@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit d28e4dff085c5a87025c9a0a85fb798bd8e9ca17:

  block: ataflop: more blk-mq refactoring fixes (2021-10-25 07:54:32 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.16-2021-10-28

for you to fetch changes up to d156cfcafbd0eae4224ea007d95ebda467eb0c46:

  nvmet: use flex_array_size and struct_size (2021-10-27 08:06:41 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.16

 - support the current discovery subsystem entry (Hannes Reinecke)
 - use flex_array_size and struct_size (Len Baker)

----------------------------------------------------------------
Hannes Reinecke (3):
      nvme: add new discovery log page entry definitions
      nvmet: switch check for subsystem type
      nvmet: register discovery subsystem as 'current'

Len Baker (1):
      nvmet: use flex_array_size and struct_size

 drivers/nvme/host/multipath.c   |  2 +-
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/core.c      |  1 +
 drivers/nvme/target/discovery.c | 17 +++++++++++------
 drivers/nvme/target/nvmet.h     |  2 +-
 include/linux/nvme.h            | 19 ++++++++++++++++---
 6 files changed, 31 insertions(+), 12 deletions(-)
