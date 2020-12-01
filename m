Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784C7C64E8A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E18220658
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aHxX5iMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgLAEQQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 23:16:16 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:32041 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgLAEQQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 23:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606796219; x=1638332219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m/bvl+lK7ll6HRYiQ0kG1ndR5SFePuzrxfzuz5g9atQ=;
  b=aHxX5iMddtB73hy0d1LICLjrrlhqMLemkYKmdtlyKwktBS0VV5zrdbnn
   GzidwIoIrDWWewbVTGzwNCT3ACXQdcrzwbAwdZB9lixek0oOCNSVigE4K
   VW1a4cy5a6AnpangYjXA8JnH3OQxcS+uxpBkoc+urDbsqF2S04nNT54P3
   IRfjaswSgCazIm3WAM1bmlR2KzR3Tznn/waChmRT0GOf3KrePDHAjFAig
   dYRxYBL3+2gEKtxBI7kW3Em3RqioLG3gjEaoJ5TgvmnKbnnhdwagsdd3e
   rRGCbLNDkvMl6AntLVWqEr5AHvGYws7AaIgmqXV9pghDjB3RbtctbZjI7
   g==;
IronPort-SDR: mdvZ2r2JLHCHj/13DeW4qdSAMJu1whEQGt90cdRBKfdBih4AhbBD2WB59KC7VW+4GM1RlvY0Pp
 7y6z3LZihxM7AdwBAFBgekBz9YU1uK9VemtC94ZS0D+ELEcrEKMQ/5yCIMlBmngpJaz8YPyDVh
 /PBs4goamankQ9Lve3q8ZOS7B7+mbiFLchPsLnE+59S9J+sUzYJAmFGuV86w9OcN3sXUp0P+4b
 67SlkAyaDL6GC82iG7WXcgpHCsvi5QoQw217Em/qQNTQcLbbS4dQUbiDivv1pNl6xG+gZqIF7d
 G0Y=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; 
   d="scan'208";a="257559124"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:15:20 +0800
IronPort-SDR: Ou0i3QaP2qhYmnKcnHdUh1a5EcffKD3fpJL2ajmbHjUCWWKcZOtOPIxe37/c9tZkNsUn4dxlmJ
 n7GjArqndF7jllnB7Ob66eykAhbyDtPh4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 19:59:23 -0800
IronPort-SDR: lTm+QtIHs4AZ5pzzJM/3sLQrBkSC4brkGHWf+hZR2x8+VWNdXZgumZWRj6AQH6VdoUpas9u0yH
 RDvNCidrDHlQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:15:11 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 6/9] nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
Date:   Mon, 30 Nov 2020 20:14:13 -0800
Message-Id: <20201201041416.16293-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update the nvmet_execute_identify() such that it can now handle
NVME_ID_CNS_CS_NS when identify.cis is set to ZNS. This allows
host to identify the ns with ZNS capabilities.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e7d2b96cda6b..cd368cbe3855 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -648,6 +648,10 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 	switch (req->cmd->identify.cns) {
 	case NVME_ID_CNS_NS:
 		return nvmet_execute_identify_ns(req);
+	case NVME_ID_CNS_CS_NS:
+		if (req->cmd->identify.csi == NVME_CSI_ZNS)
+			return nvmet_execute_identify_cns_cs_ns(req);
+		break;
 	case NVME_ID_CNS_CTRL:
 		return nvmet_execute_identify_ctrl(req);
 	case NVME_ID_CNS_CS_CTRL:
-- 
2.22.1

