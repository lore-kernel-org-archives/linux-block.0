Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF57C742A7
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 22:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCGWrD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCGWrB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 17:47:01 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DFF240D2;
        Tue,  7 Mar 2023 14:46:49 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 2A4F67A0568;
        Tue,  7 Mar 2023 23:46:48 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/32] pata_parport-bpck6: don't cast pi->pardev to struct pardevice *
Date:   Tue,  7 Mar 2023 23:45:58 +0100
Message-Id: <20230307224627.28011-4-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230307224627.28011-1-linux@zary.sk>
References: <20230307224627.28011-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

pi->pardev is struct pardevice *, no need to cast it to the same type.
Also clean up the return mess.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 4d6edb9c1245..fa1f7d4fe3cb 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -74,30 +74,18 @@ static void bpck6_disconnect(struct pi_adapter *pi)
 static int bpck6_test_port(struct pi_adapter *pi)   /* check for 8-bit port */
 {
 	dev_dbg(&pi->dev, "PARPORT indicates modes=%x for lp=0x%lx\n",
-		((struct pardevice *)(pi->pardev))->port->modes,
-		((struct pardevice *)(pi->pardev))->port->base);
+		pi->pardev->port->modes, pi->pardev->port->base);
 
 	/*copy over duplicate stuff.. initialize state info*/
 	PPCSTRUCT(pi)->ppc_id=pi->unit;
 	PPCSTRUCT(pi)->lpt_addr=pi->port;
 
-	/* look at the parport device to see if what modes we can use */
-	if(((struct pardevice *)(pi->pardev))->port->modes & 
-		(PARPORT_MODE_EPP)
-          )
-	{
-		return 5; /* Can do EPP*/
-	}
-	else if(((struct pardevice *)(pi->pardev))->port->modes & 
-			(PARPORT_MODE_TRISTATE)
-               )
-	{
+	/* look at the parport device to see what modes we can use */
+	if (pi->pardev->port->modes & PARPORT_MODE_EPP)
+		return 5; /* Can do EPP */
+	if (pi->pardev->port->modes & PARPORT_MODE_TRISTATE)
 		return 2;
-	}
-	else /*Just flat SPP*/
-	{
-		return 1;
-	}
+	return 1; /* Just flat SPP */
 }
 
 static int bpck6_probe_unit(struct pi_adapter *pi)
-- 
Ondrej Zary

