Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99591C64EC7
	for <linux-block@archiver.kernel.org>; Sat, 11 Feb 2023 14:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjBKOmz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Feb 2023 09:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBKOmx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Feb 2023 09:42:53 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFC2455A5;
        Sat, 11 Feb 2023 06:42:50 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id C4F617A037B;
        Sat, 11 Feb 2023 15:42:48 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/12] pata_parport: protocol drivers cleanups
Date:   Sat, 11 Feb 2023 15:42:20 +0100
Message-Id: <20230211144232.15138-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch series cleans up pata_parport protocol drivers, making the code
simpler with no changes in behavior (except logged messages).

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/aten.c                            |  45 ++++----------
 drivers/ata/pata_parport/bpck.c                            |  84 +++++++------------------
 drivers/ata/pata_parport/bpck6.c                           | 108 ++++++++-------------------------
 drivers/ata/pata_parport/comm.c                            |  52 +++++-----------
 drivers/ata/pata_parport/dstr.c                            |  45 ++++----------
 drivers/ata/pata_parport/epat.c                            |  46 +++++---------
 drivers/ata/pata_parport/epia.c                            |  55 +++++------------
 drivers/ata/pata_parport/fit2.c                            |  37 ++++-------
 drivers/ata/pata_parport/fit3.c                            |  39 ++++--------
 drivers/ata/pata_parport/friq.c                            |  56 ++++++-----------
 drivers/ata/pata_parport/frpw.c                            |  71 ++++++----------------
 drivers/ata/pata_parport/kbic.c                            |  66 +++++++++-----------
 drivers/ata/pata_parport/ktti.c                            |  38 ++++--------
 drivers/ata/pata_parport/on20.c                            |  45 ++++----------
 drivers/ata/pata_parport/on26.c                            |  52 ++++------------
 drivers/ata/pata_parport/pata_parport.c                    |  27 ++++-----
 {include/linux => drivers/ata/pata_parport}/pata_parport.h |  41 ++++---------
 17 files changed, 267 insertions(+), 640 deletions(-)


