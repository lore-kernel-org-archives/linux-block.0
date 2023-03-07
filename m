Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAEBC76188
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 22:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjCGWse (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjCGWrd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 17:47:33 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E629516332;
        Tue,  7 Mar 2023 14:47:08 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 815EB7A075A;
        Tue,  7 Mar 2023 23:46:50 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/32] pata_parport-bpck6: move ppc6_deselect to bpck6.c and rename
Date:   Tue,  7 Mar 2023 23:46:21 +0100
Message-Id: <20230307224627.28011-27-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230307224627.28011-1-linux@zary.sk>
References: <20230307224627.28011-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move ppc6_deselect to bpck6.c and rename it to bpck6_deselect

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 19 +++++++++++++++++--
 drivers/ata/pata_parport/ppc6lnx.c | 19 -------------------
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 9b05e1c827cd..46a91b04aed3 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -235,6 +235,21 @@ static int bpck6_open(struct pi_adapter *pi)
 	return 0; // FAIL
 }
 
+static void bpck6_deselect(struct pi_adapter *pi)
+{
+	if (mode_map[pi->mode] & 4)	// EPP
+		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_INIT,
+							PARPORT_CONTROL_INIT);
+	else								// PPC/ECP
+		parport_frob_control(pi->pardev->port, PARPORT_CONTROL_SELECT,
+							PARPORT_CONTROL_SELECT);
+
+	parport_write_data(pi->pardev->port, pi->saved_r0);
+	parport_write_control(pi->pardev->port,
+			pi->saved_r2 | PARPORT_CONTROL_SELECT);
+	parport_write_control(pi->pardev->port, pi->saved_r2);
+}
+
 static void bpck6_wr_extout(struct pi_adapter *pi, u8 regdata)
 {
 	ppc6_send_cmd(pi, REG_VERSION | ACCESS_REG | ACCESS_WRITE);
@@ -253,7 +268,7 @@ static void bpck6_disconnect(struct pi_adapter *pi)
 {
 	dev_dbg(&pi->dev, "disconnect\n");
 	bpck6_wr_extout(pi, 0x0);
-	ppc6_deselect(pi);
+	bpck6_deselect(pi);
 }
 
 static int bpck6_test_port(struct pi_adapter *pi)   /* check for 8-bit port */
@@ -285,7 +300,7 @@ static int bpck6_probe_unit(struct pi_adapter *pi)
 
   	if(out)
  	{
-		ppc6_deselect(pi);
+		bpck6_deselect(pi);
 		dev_dbg(&pi->dev, "leaving probe\n");
 		pi->mode = saved_mode;
                return(1);
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index 16d0497dfeaa..6c34bbbdf6db 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -67,7 +67,6 @@
 
 //***************************************************************************
 
-static void ppc6_deselect(struct pi_adapter *pi);
 static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd);
 static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data);
 static u8 ppc6_rd_data_byte(struct pi_adapter *pi);
@@ -79,24 +78,6 @@ int mode_map[] = { PPCMODE_UNI_FW, PPCMODE_BI_FW, PPCMODE_EPP_BYTE,
 
 //***************************************************************************
 
-static void ppc6_deselect(struct pi_adapter *pi)
-{
-	if (mode_map[pi->mode] & 4)	// EPP
-		parport_frob_control(pi->pardev->port,
-			PARPORT_CONTROL_INIT, PARPORT_CONTROL_INIT);
-	else								// PPC/ECP
-		parport_frob_control(pi->pardev->port,
-			PARPORT_CONTROL_SELECT, PARPORT_CONTROL_SELECT);
-
-	parport_write_data(pi->pardev->port, pi->saved_r0);
-
-	parport_write_control(pi->pardev->port, (pi->saved_r2 | PARPORT_CONTROL_SELECT));
-
-	parport_write_control(pi->pardev->port, pi->saved_r2);
-}
-
-//***************************************************************************
-
 static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd)
 {
 	switch (mode_map[pi->mode])
-- 
Ondrej Zary

