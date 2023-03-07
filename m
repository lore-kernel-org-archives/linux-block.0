Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC28AC742A7
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 22:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjCGWrK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCGWrE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 17:47:04 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC646E067;
        Tue,  7 Mar 2023 14:47:00 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 7921D7A05D5;
        Tue,  7 Mar 2023 23:46:48 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/32] pata_parport-bpck6: remove ppc_id from struct ppc_storage
Date:   Tue,  7 Mar 2023 23:46:01 +0100
Message-Id: <20230307224627.28011-7-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230307224627.28011-1-linux@zary.sk>
References: <20230307224627.28011-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ppc_id duplicates pi->unit. Remove it.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 7 -------
 drivers/ata/pata_parport/ppc6lnx.c | 5 ++---
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 50d313fc529e..176bf456c698 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -72,13 +72,9 @@ static void bpck6_disconnect(struct pi_adapter *pi)
 
 static int bpck6_test_port(struct pi_adapter *pi)   /* check for 8-bit port */
 {
-	struct ppc_storage *ppc = (void *)(pi->private);
 	dev_dbg(&pi->dev, "PARPORT indicates modes=%x for lp=0x%lx\n",
 		pi->pardev->port->modes, pi->pardev->port->base);
 
-	/*copy over duplicate stuff.. initialize state info*/
-	ppc->ppc_id = pi->unit;
-
 	/* look at the parport device to see what modes we can use */
 	if (pi->pardev->port->modes & PARPORT_MODE_EPP)
 		return 5; /* Can do EPP */
@@ -94,9 +90,6 @@ static int bpck6_probe_unit(struct pi_adapter *pi)
 
 	dev_dbg(&pi->dev, "PROBE UNIT %x on port:%x\n", pi->unit, pi->port);
 
-	/*SET PPC UNIT NUMBER*/
-	ppc->ppc_id = pi->unit;
-
 	/*LOWER DOWN TO UNIDIRECTIONAL*/
 	ppc->mode = 1;
 
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index c00e561cc833..dd9f3040f9a7 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -65,7 +65,6 @@
 //***************************************************************************
 
 struct ppc_storage {
-	u8	ppc_id;
 	u8	mode;						// operating mode
 					// 0 = PPC Uni SW
 					// 1 = PPC Uni FW
@@ -143,8 +142,8 @@ static int ppc6_select(struct pi_adapter *pi)
 
 	outb('b', pi->port);
 	outb('p', pi->port);
-	outb(ppc->ppc_id, pi->port);
-	outb(~ppc->ppc_id, pi->port);
+	outb(pi->unit, pi->port);
+	outb(~pi->unit, pi->port);
 
 	ppc->cur_ctrl &= ~port_sel;
 
-- 
Ondrej Zary

