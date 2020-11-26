Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AB9C56201
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3ADE206C0
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XE+SdTKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbgKZClk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 21:41:40 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20484 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbgKZClk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 21:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606358499; x=1637894499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+iv8i8xvGTKjTFiSy9i/jgbNCBRhvNbZSotD5vVTWDc=;
  b=XE+SdTKylP+W4dvPQIPWVm2X/afHnaSIliU/AuCEcPW/4Wz+PNOP2TcZ
   FiDDGASsK1MCygbSyKDsUTbhL67zq2IJU/U5es44MaoWLaiS0PpXRHal2
   BPiZM9Xq+TrOxql0k89/73054ALUlV4GOc6HefCQItL9UiNKUEg0Z2F0A
   rqXQvgc7uX9tpPSEd7Tbw+Cw1rIkNzt9RMKKja6uVY5REzBdYPpxvWMTV
   2YNqKENwXflFidPfMEAjzjNoIh5Zp68Q4cpoIl26XA9TgAKQBFE+1Bmcp
   JS+JNIvnp+iXMAAxVhUFHEG/X+PqAuOHmNl06EAtATO5S1Slpm5akb7SL
   g==;
IronPort-SDR: 6D9GnFGZLJfBrmFN7IW5q5mEtrYEwr9mUmaUDoCbyLs4rSXpyqBDTWGZEysHVo6MBkrug7NbMF
 zRmZx4/U24Mc+3OqoykDnai7eMpI8+jj+rvJSG4tRGKLPPGhJWUtsdAd96Bmy3Jwq4HHqgHTpg
 SRtEwvPj3BTNvUBGZZB61JlTP9btSy24tSnLOtKWg/4+nS56DyhcImTqvnIdQ/9R0yBq7CUIEu
 KhMFNFAW8ulBKoprxAT4ifEOpPZN947y6CWxyV0JpdWGzeaZHf/mYnr5hJhiBt1MTXdEyX/z+I
 3OU=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; 
   d="scan'208";a="157983135"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:41:39 +0800
IronPort-SDR: guL9Z+4mtRBQ/AX5M7YVcL0LrLSBleJA+X5MaEH2+oLSx+3bCQa2un6IHL2lOoDDgeEDeoMjXJ
 nuikTfOw5bAcAjv7MifmHO/4mifZiXXVA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 18:27:21 -0800
IronPort-SDR: gZMRNQ2cNMFz1CREp9nYzKUzsorrmFdbbsr9pGLbBkjJO79U8qt5N5saEET0FYQ9oODFC1IVYl
 NZyXdF/lcCmQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:41:39 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Date:   Wed, 25 Nov 2020 18:40:39 -0800
Message-Id: <20201126024043.3392-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update the nvmet_execute_identify() such that it can now handle
NVME_ID_CNS_CS_CTRL when identify.cis is set to ZNS. This allows
host to identify the support for ZNS.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index d4fc1bb1a318..e7d2b96cda6b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -650,6 +650,10 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		return nvmet_execute_identify_ns(req);
 	case NVME_ID_CNS_CTRL:
 		return nvmet_execute_identify_ctrl(req);
+	case NVME_ID_CNS_CS_CTRL:
+		if (req->cmd->identify.csi == NVME_CSI_ZNS)
+			return nvmet_execute_identify_cns_cs_ctrl(req);
+		break;
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
 		return nvmet_execute_identify_nslist(req);
 	case NVME_ID_CNS_NS_DESC_LIST:
-- 
2.22.1

