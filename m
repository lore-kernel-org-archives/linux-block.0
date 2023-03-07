Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF05C6FA99
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 22:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjCGWrV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjCGWrK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 17:47:10 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E823A4FAA7;
        Tue,  7 Mar 2023 14:47:04 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 65F1C7A071E;
        Tue,  7 Mar 2023 23:46:49 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/32] pata_parport-bpck6: remove ppc6_close
Date:   Tue,  7 Mar 2023 23:46:10 +0100
Message-Id: <20230307224627.28011-16-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230307224627.28011-1-linux@zary.sk>
References: <20230307224627.28011-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ppc6_close does not do anything except calling ppc6_deselect. Remove
ppc6_close and call ppc6_deselect directly.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c   | 4 ++--
 drivers/ata/pata_parport/ppc6lnx.c | 8 --------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 39ac6e1a0aee..b8135a6eed16 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -51,7 +51,7 @@ static void bpck6_disconnect(struct pi_adapter *pi)
 {
 	dev_dbg(&pi->dev, "disconnect\n");
 	ppc6_wr_extout(pi, 0x0);
-	ppc6_close(pi);
+	ppc6_deselect(pi);
 }
 
 static int bpck6_test_port(struct pi_adapter *pi)   /* check for 8-bit port */
@@ -83,7 +83,7 @@ static int bpck6_probe_unit(struct pi_adapter *pi)
 
   	if(out)
  	{
-		ppc6_close(pi);
+		ppc6_deselect(pi);
 		dev_dbg(&pi->dev, "leaving probe\n");
 		pi->mode = saved_mode;
                return(1);
diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
index 9a166f396112..5b7796083e7e 100644
--- a/drivers/ata/pata_parport/ppc6lnx.c
+++ b/drivers/ata/pata_parport/ppc6lnx.c
@@ -81,7 +81,6 @@ static void ppc6_rd_port16_blk(struct pi_adapter *pi, u8 port, u8 *data, long le
 static void ppc6_wr_port16_blk(struct pi_adapter *pi, u8 port, u8 *data, long length);
 static void ppc6_wr_extout(struct pi_adapter *pi, u8 regdata);
 static int ppc6_open(struct pi_adapter *pi);
-static void ppc6_close(struct pi_adapter *pi);
 
 //***************************************************************************
 
@@ -573,10 +572,3 @@ static int ppc6_open(struct pi_adapter *pi)
 
 //***************************************************************************
 
-static void ppc6_close(struct pi_adapter *pi)
-{
-	ppc6_deselect(pi);
-}
-
-//***************************************************************************
-
-- 
Ondrej Zary

