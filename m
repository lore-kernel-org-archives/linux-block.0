Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67645C63777
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 03:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1838F20757
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 03:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B7zQlVUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgK3Dbd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 22:31:33 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7669 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgK3Dbd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 22:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606707092; x=1638243092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+iv8i8xvGTKjTFiSy9i/jgbNCBRhvNbZSotD5vVTWDc=;
  b=B7zQlVUjpQhB+TxGszzissP/i90gyIndK+Z50Pk2el/xVav3hiudQRbs
   SkW2IhAGqG4AGFP5ubFVewdf/Vyv4y5F8P0SlYLOIHTzUoEkMcVtQPjqX
   wWiLqBWgysGW9BOF9yGvHr/OvqGBqdMwOwDCRWr4SwaxB+jKMxPKNLysA
   JnxwLxt6D+XYRN8WUcLB0FhaE8dfUxZV3Ss1vn3wJH90T8x0FHN8UFtKY
   lLP2Kd19Rglp8gMm4jknAg2EVhOPZMoH4jiGmJDqcXXTmJ6Er9JJmzBhX
   /QsKXGgnJwlZpxq8rNV33p94KOkB5bm2Ae6K1EFY2YjblycgSDuWI4W6P
   w==;
IronPort-SDR: RfownR/igd/+cQ2lzPzDTDE4DIklwiLMHhoTEWpqPqnZX23q+7JeXFcupm8KayvIGMPMy8MSSI
 mMoEejbz2CjmRG1f65M3fDRcfn56IUpUvCq2LGEkfZbhGu+zWjmW3Smg1LO2JR7I2k4BAo79aF
 qMW6qdYNlAvFVtONp45SkaEK15g8XfZ1e7WFLu1pKhHKe7S9vFFyjAicrvO5JBQjaUpwcrnGm2
 Mg9LT+QNBDhe9xrneZ59Zk2z5CvtFliaoAkcpXQnk/uAGPKB2lTda5Q2g0DyOevPq0cVKp1dq/
 ktI=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; 
   d="scan'208";a="153844127"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:29:52 +0800
IronPort-SDR: R5Oe9Tzsnn8GQKn3IpqJfHYiS+d2AkCR9JpSW/lTwcm6J9cEolKj0sRR8Qeo8qFahiO9g9VI1x
 K9R8htegaVJrGT4MdfXPODhzI66AE22HU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 19:15:29 -0800
IronPort-SDR: ZghdTP2hUjm0I1Qgwto2KfQJ9OGlJkbo1+lSPAJEzbmb15HOrtNBh91W5okyYiyTe/4R+GSkZb
 5DTBgMLHPVUw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:29:52 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Date:   Sun, 29 Nov 2020 19:29:05 -0800
Message-Id: <20201130032909.40638-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
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

