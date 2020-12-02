Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4149C64E8A
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4538722202
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgLBGYq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 01:24:46 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:64091 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgLBGYq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 01:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606890285; x=1638426285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m/bvl+lK7ll6HRYiQ0kG1ndR5SFePuzrxfzuz5g9atQ=;
  b=UmMT1AHjF+PQ6W1tX+5Ve9nuL3LrlN+uqpMc9PkPaKxiRhHBuXyKfz5W
   KWvBRmaL1XCcMom3W4MyJXY55HEr+P/65xm7cIftlO/nKADC6z6ykWHUE
   VecpQkgPkvOpwDgT+LSMjEID+hnfSBS0eXLFQ5W9JMy7E91il5G/zdI4c
   bMcR7ehmwLh9NRhTIc8GHUZsc42wer8qVathm5BwaKlKh4EZbgR9n4Su3
   gkwzpzNEYB06XBOTzGEXc+bo2CvbhNyAxDMWo1cpIKBHgc1d2VJ0aZmnc
   vcWgxmxmXNjo1mleSnXD3/iX0591LXANjiwsMDuNsSb8iG1walfXm/w2A
   A==;
IronPort-SDR: N9Q0JKyxBY2Mm2bReMOXRpqlAvv3j9wCcai/yoR+1u23pfM8QenfBhRANyH0lkyyG0tf7VxveM
 XuZp35caUapKy4UW5gxeNV0BX4Vtl8yFAW8ToiaRo2pUn/fLDjOqJ68T9a4qGdXh8/4SZD3RWF
 EMr9/uaZJ/M4FqxL/X8wEk9kc/ruoWL/G6TSM+qBwkGSZp8P19k7SzSXzo+P7UNZSQr104ygqy
 rV2hJ5yi0bBauxKTudweRNuNAdcW0S29N5n6OM1p3qEjbfZOW+5MfTfU/wvo+xnhg8k3SWdyM9
 dZ0=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; 
   d="scan'208";a="153932884"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:23:40 +0800
IronPort-SDR: /uWq/Wyl2fIeqLakbDkMLsFRiqYmfxzVPsbe80zjs9i6lxBErjnKAvbDLCLLcfPnRAEfydOect
 NxJDxCGlD7p9ABfoPjYCCWOIu0WWPlFpw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 22:07:52 -0800
IronPort-SDR: uAvQnVjL1BD+KQuTygNy/y8RUkvVQGlyDCNHcfrpeh6fTnotxPc4aT5mSLjG9SdiUup1AE/oVO
 gYiUxrgjPNWg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:23:40 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        johannes.thumshirn@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 6/9] nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
Date:   Tue,  1 Dec 2020 22:22:24 -0800
Message-Id: <20201202062227.9826-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
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

