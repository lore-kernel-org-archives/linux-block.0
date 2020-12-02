Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A25C71156
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D92622202
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgLBGYk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 01:24:40 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47407 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgLBGYj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 01:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606890935; x=1638426935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+iv8i8xvGTKjTFiSy9i/jgbNCBRhvNbZSotD5vVTWDc=;
  b=dUARt9xo9Q+7z+VIdjWVMT1ewKYfXZZRzcbcKtXoNsMddjFfx2kNsB9c
   /s6vkJaOvxQFm8Yn84Z5kjmMmfmibnzESur6DNUxtgVtzYMsVGqrhM61i
   Xzoj/poqT4mqVc8BQDOkqDfSnQWfPOH6n3OKGu4qiBSIvNf3RiIPr33WJ
   KpULKQWVliRTYZZvATYAsArZMvPug3KQUuOuOBT7Df82OTHL8IDfBcEK9
   9aM9ZeaOEX0WX3vn7XJ/DovOiX5hHMwOUVYEotsOcBKR1VIEQjmT4nry9
   kZAi6BvvZntrpOVtezjLzgsq5uln28zLiZdxZKLM8/UC2g3ohtk2l5sP7
   A==;
IronPort-SDR: UhYhGebHjfTZq2Rn1S++ooG60AakmS/6va+SGjFUPakZZ3Supqln2EgvTNYVsup2/raFF07ULt
 aRiqhS/QQuGNIyEAfjevQOXnjJGfCC90q+xvFKJw4w2tKY6225YrVSlONzVzxuAt2diTRmmF5x
 /HxggZPzwSfJaFQ0x4RemZxQ4XYGPM5Qlv6bA1eJuuJqe5IpKx9TbBbFH17q+24bATgRRlf+/N
 uWOXfyF7Q1oE7lV7S+DN8bVDtBHr4ppvdLgJkh797/snAej24Fwr8CXEUsKSOm9PRo3JoEK/R+
 rXE=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; 
   d="scan'208";a="257684127"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:33:55 +0800
IronPort-SDR: rGHMopqz6WLyUWxpnBR+qe+byti/we73b2HpGcpp38S42QtJ6J+F0/o02uGE3/T4NiSuVGqSbv
 Ccr2vnEldh1IGrH3lQudM1lyEaMqWczz0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 22:07:44 -0800
IronPort-SDR: zg3/OKT+VIIk3PyMmu7C/7OanNewa7QdNcxm71LM5rsyPJTpP40GpRbnVlBsOFpZUF+u2EvEYI
 KgII++6f+sTg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:23:33 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        johannes.thumshirn@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Date:   Tue,  1 Dec 2020 22:22:23 -0800
Message-Id: <20201202062227.9826-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
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

