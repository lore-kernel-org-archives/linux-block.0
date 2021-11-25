Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93038C433F5
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 14:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355290AbhKYOKI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 09:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355491AbhKYOII (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 09:08:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A1DC061759
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 06:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ptEcs74jg7JXVCFnq9EvP8cDmSWilpR23/XJsWuuo+o=; b=ocieuV+Zu2gxYyTLvXmR9ER4MK
        CbzUfLoSpOsn71He4D44KX3aQin603TvLfOgomAmtcNJ78ea3mvDbFwlFHzoEixEl6REramUFCOet
        AsVqmLry/eUQ+zTPZUdy3Zs3CbRSdce7+6OoyIgFllg8a20wsTDEpuGf2yvhIl9W6+Pkc2rElAxgG
        M5efugb/cW9EPGDpYUQjvic1dEuayM0tZepPKMbaEIpwTGCEkCwDtoMGvzJUMDS6GWr8CATEj6ESa
        MmYcEricJgZrlJheyMpNQt+4sT0Atl5ivee3jT1isFKiaIG6XLf825yeWo/Ab6vUrX+XPVI59GRx3
        kI6IUBtg==;
Received: from [2001:4bb8:191:f9ce:91e3:dc54:365:7d33] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqFMk-006YBt-T7; Thu, 25 Nov 2021 14:04:47 +0000
Date:   Thu, 25 Nov 2021 15:04:46 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.16
Message-ID: <YZ+X/qGC6/w3bp2c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit efcf5932230b9472cfdbe01c858726f29ac5ec7d:

  block: avoid to touch unloaded module instance when opening bdev (2021-11-22 18:35:37 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.16-2021-11-25

for you to fetch changes up to 95ec70a9f3f9133304a0295af58d4f05ed27661c:

  nvmet: use IOCB_NOWAIT only if the filesystem supports it (2021-11-23 17:22:43 +0100)

----------------------------------------------------------------
nvme fixes for Linux 5.16

 - add a NO APST quirk for a Kioxia device (Enzo Matsumiya)
 - fix write zeroes pi (Klaus Jensen)
 - various TCP transport fixes (Maurizio Lombardi and Varun Prakash)
 - ignore invalid fast_io_fail_tmo values (Maurizio Lombardi)
 - use IOCB_NOWAIT only if the filesystem supports it (Maurizio Lombardi)

----------------------------------------------------------------
Enzo Matsumiya (1):
      nvme-pci: add NO APST quirk for Kioxia device

Klaus Jensen (1):
      nvme: fix write zeroes pi

Maurizio Lombardi (6):
      nvmet-tcp: fix a race condition between release_queue and io_work
      nvmet-tcp: add an helper to free the cmd buffers
      nvmet-tcp: fix memory leak when performing a controller reset
      nvme-tcp: fix memory leak when freeing a queue
      nvme-fabrics: ignore invalid fast_io_fail_tmo values
      nvmet: use IOCB_NOWAIT only if the filesystem supports it

Varun Prakash (2):
      nvmet-tcp: fix incomplete data digest send
      nvme-tcp: validate R2T PDU in nvme_tcp_handle_r2t()

 drivers/nvme/host/core.c          | 29 +++++++++++++++++--
 drivers/nvme/host/fabrics.c       |  3 ++
 drivers/nvme/host/tcp.c           | 61 +++++++++++++++++++--------------------
 drivers/nvme/target/io-cmd-file.c |  2 ++
 drivers/nvme/target/tcp.c         | 44 ++++++++++++++++++++--------
 5 files changed, 93 insertions(+), 46 deletions(-)
