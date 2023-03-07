Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDD1C678D5
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 22:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCGWrE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCGWrB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 17:47:01 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E87D76A1;
        Tue,  7 Mar 2023 14:46:49 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id AFBBE7A02A6;
        Tue,  7 Mar 2023 23:46:47 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/32] pata_parport-bpck6: rework bpck6 protocol driver
Date:   Tue,  7 Mar 2023 23:45:55 +0100
Message-Id: <20230307224627.28011-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch series simplifies bpck6 code, removing ppc6lnx.c file to match
the simplicity of other protocol drivers. It also converts the direct
port I/O access to paraport access functions. This conversion revealed that
there's no 8-bit and 16-bit EPP support in parport_pc so patch 11 implements
that.

Tested with Backpack CD-RW 222011 and CD-RW 19350.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 452 +++++++++++++++++++++++++++--------
 drivers/ata/pata_parport/ppc6lnx.c | 726 ---------------------------------------------------------
 drivers/parport/parport_pc.c       |  20 +-
 include/uapi/linux/parport.h       |   3 +
 4 files changed, 370 insertions(+), 831 deletions(-)


