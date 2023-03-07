Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4FFC74A44
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 22:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjCGWtK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCGWrf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 17:47:35 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E68AA9BA45;
        Tue,  7 Mar 2023 14:47:08 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 5AE3D7A0755;
        Tue,  7 Mar 2023 23:46:50 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/32] pata_parport-bpck6: move ppc6_open to bpck6.c and rename
Date:   Tue,  7 Mar 2023 23:46:19 +0100
Message-Id: <20230307224627.28011-25-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230307224627.28011-1-linux@zary.sk>
References: <20230307224627.28011-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move ppc6_open to bpck6.c and rename it to bpck6_open

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 23 +++++++++++++++++++++--
 drivers/ata/pata_parport/ppc6lnx.c | 28 ----------------------------
 2 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 968c9f3297e3..02f16dedfd29 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -174,6 +174,25 @@ static void bpck6_read_block(struct pi_adapter *pi, char *buf, int len)
 	ppc6_send_cmd(pi, CMD_PREFIX_RESET | PREFIX_IO16 | PREFIX_BLK);
 }
 
+static int bpck6_open(struct pi_adapter *pi)
+{
+	int ret = ppc6_select(pi);
+
+	if (ret == 0)
+		return ret;
+
+	pi->private = 0;
+
+	ppc6_send_cmd(pi, ACCESS_REG | ACCESS_WRITE | REG_RAMSIZE);
+	ppc6_wr_data_byte(pi, RAMSIZE_128K);
+
+	ppc6_send_cmd(pi, ACCESS_REG | ACCESS_READ | REG_VERSION);
+	if ((ppc6_rd_data_byte(pi) & 0x3F) == 0x0C)
+		pi->private |= fifo_wait;
+
+	return ret;
+}
+
 static void bpck6_wr_extout(struct pi_adapter *pi, u8 regdata)
 {
 	ppc6_send_cmd(pi, REG_VERSION | ACCESS_REG | ACCESS_WRITE);
@@ -184,7 +203,7 @@ static void bpck6_connect(struct pi_adapter *pi)
 {
 	dev_dbg(&pi->dev, "connect\n");
 
-	ppc6_open(pi);
+	bpck6_open(pi);
 	bpck6_wr_extout(pi, 0x3);
 }
 
@@ -218,7 +237,7 @@ static int bpck6_probe_unit(struct pi_adapter *pi)
 	/*LOWER DOWN TO UNIDIRECTIONAL*/
 	pi->mode = 0;
 
-	out = ppc6_open(pi);
+	out = bpck6_open(pi);
 
 	dev_dbg(&pi->dev, "ppc_open returned %2x\n", out);
 
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index 931bf67fabb9..a902ede5ecc5 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -72,7 +72,6 @@ static void ppc6_deselect(struct pi_adapter *pi);
 static void ppc6_send_cmd(struct pi_adapter *pi, u8 cmd);
 static void ppc6_wr_data_byte(struct pi_adapter *pi, u8 data);
 static u8 ppc6_rd_data_byte(struct pi_adapter *pi);
-static int ppc6_open(struct pi_adapter *pi);
 
 //***************************************************************************
 
@@ -277,30 +276,3 @@ static u8 ppc6_rd_data_byte(struct pi_adapter *pi)
 
 	return(data);
 }
-
-//***************************************************************************
-
-static int ppc6_open(struct pi_adapter *pi)
-{
-	int ret;
-
-	ret = ppc6_select(pi);
-
-	if (ret == 0)
-		return(ret);
-
-	pi->private = 0;
-
-	ppc6_send_cmd(pi, ACCESS_REG | ACCESS_WRITE | REG_RAMSIZE);
-	ppc6_wr_data_byte(pi, RAMSIZE_128K);
-
-	ppc6_send_cmd(pi, ACCESS_REG | ACCESS_READ | REG_VERSION);
-
-	if ((ppc6_rd_data_byte(pi) & 0x3F) == 0x0C)
-		pi->private |= fifo_wait;
-
-	return(ret);
-}
-
-//***************************************************************************
-
-- 
Ondrej Zary

