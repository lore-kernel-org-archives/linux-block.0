Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A91C4167E
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4BF61058
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbhI0WDr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237918AbhI0WDc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:03:32 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0206C061779;
        Mon, 27 Sep 2021 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CdTBRsaYmbzthSsnr1IHgRONpjN45dt2OX2o5Pnpc8g=; b=sBTpIcoigg8KiULFYY51hM6ysP
        3SdznJnw9pLFpX/mKt0YQ/XFPDBhtgJ8uLM2I1opJ1CwVkScssxk0X9VmwwwdVvknPW8eP4XOZFts
        ilSUGFNS64pOvbHpj6x04hkvuNu2twCB8+ROLGodxKPwpYoORATQn6v4kYODtjhCvIkuN90HbMlyW
        vfegg/KWliKQTYYza8ri0VnI9GaIOn0RA1rmmrziuH/2a/GOXb1X2HUICXFiVWoUiuGlz4fgjarza
        aPM8N/P34he+9ibC8zwyJi3D8T4yZZb7WTBMvH7k1Has/QK3wHr/1EblG5qzDXxcobOD48NZDaNYi
        b+i28N4g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUygR-004TPU-VZ; Mon, 27 Sep 2021 22:01:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, chris.obbard@collabora.com,
        krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Cc:     linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 08/15] pcd: move the identify buffer into pcd_identify
Date:   Mon, 27 Sep 2021 15:01:03 -0700
Message-Id: <20210927220110.1066271-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220110.1066271-1-mcgrof@kernel.org>
References: <20210927220110.1066271-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

No need to pass it through a bunch of functions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/paride/pcd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index f9cdd11f02f5..8903fdaa2046 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -630,10 +630,11 @@ static int pcd_drive_status(struct cdrom_device_info *cdi, int slot_nr)
 	return CDS_DISC_OK;
 }
 
-static int pcd_identify(struct pcd_unit *cd, char *id)
+static int pcd_identify(struct pcd_unit *cd)
 {
-	int k, s;
 	char id_cmd[12] = { 0x12, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0 };
+	char id[18];
+	int k, s;
 
 	pcd_bufblk = -1;
 
@@ -664,15 +665,15 @@ static int pcd_identify(struct pcd_unit *cd, char *id)
  * returns  0, with id set if drive is detected
  *	    -1, if drive detection failed
  */
-static int pcd_probe(struct pcd_unit *cd, int ms, char *id)
+static int pcd_probe(struct pcd_unit *cd, int ms)
 {
 	if (ms == -1) {
 		for (cd->drive = 0; cd->drive <= 1; cd->drive++)
-			if (!pcd_reset(cd) && !pcd_identify(cd, id))
+			if (!pcd_reset(cd) && !pcd_identify(cd))
 				return 0;
 	} else {
 		cd->drive = ms;
-		if (!pcd_reset(cd) && !pcd_identify(cd, id))
+		if (!pcd_reset(cd) && !pcd_identify(cd))
 			return 0;
 	}
 	return -1;
@@ -709,7 +710,6 @@ static void pcd_probe_capabilities(void)
 
 static int pcd_detect(void)
 {
-	char id[18];
 	int k, unit;
 	struct pcd_unit *cd;
 
@@ -727,7 +727,7 @@ static int pcd_detect(void)
 		cd = pcd;
 		if (cd->disk && pi_init(cd->pi, 1, -1, -1, -1, -1, -1,
 			    pcd_buffer, PI_PCD, verbose, cd->name)) {
-			if (!pcd_probe(cd, -1, id)) {
+			if (!pcd_probe(cd, -1)) {
 				cd->present = 1;
 				k++;
 			} else
@@ -744,7 +744,7 @@ static int pcd_detect(void)
 				     conf[D_UNI], conf[D_PRO], conf[D_DLY],
 				     pcd_buffer, PI_PCD, verbose, cd->name)) 
 				continue;
-			if (!pcd_probe(cd, conf[D_SLV], id)) {
+			if (!pcd_probe(cd, conf[D_SLV])) {
 				cd->present = 1;
 				k++;
 			} else
-- 
2.30.2

