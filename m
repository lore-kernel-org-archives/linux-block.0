Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFAFC56201
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB177206C0
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RLsKpijx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732814AbgKZCls (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 21:41:48 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32166 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732808AbgKZCls (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 21:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606358507; x=1637894507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m/bvl+lK7ll6HRYiQ0kG1ndR5SFePuzrxfzuz5g9atQ=;
  b=RLsKpijxeoWaCjPEJqwuwUcZWiNLLreRm42sdMgesQ0xmNRo1J5PejFu
   tSlwJp4l2n6LEXpojuK2BFaLga2EmBR7WPr5eGA6Q2R8O2ntD6YreL1HH
   7Pglrb4kecQkyKnYhZ6yDfgkqsebhZgUF+CLdpkag9CsIv1do08Fslbyg
   Z4pePU1DnvVKvdVaGem6dyVZc01hv3nZgfOjgD+Lzx0JQMXWYiTnjqaGB
   yG3k791lL6xT1OBuV9Esi7E594p+jiaURQU4iSnqfGkm2rpzKcxTrZj/u
   K8nsCaWgZj4HTDLsLgo5C7oWXUoqLFDnElKKY0t1gggHvsSbcb+id3UBK
   w==;
IronPort-SDR: atUXOjgOc+XeNH3a4uwaT8W47/4Od4jlUYNSTs1zdl/stiqECLDfFUTsfGS+jzHboUVl68Ixy+
 NgupnI//zLtKVCcQ+qxXrNSx0tvMs0bIQm7Tqq4d7lnEDEUNUuSTXCfdb02Mj8il2eKJ5S2Nt7
 9LlgokzPveQISz6DoYmQLrHn87o/aKvQi6YrSsz7XjyiIZAnyt56mTPLAtlLNYu2GLy3uv+kvi
 0Nz70g0RLeE50fNumYcxx176//ouZFCCYrr9wef3GkQaG4nmdVxODIDTqjY2aHSm5kWpIbc85l
 GZg=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; 
   d="scan'208";a="153445815"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:41:47 +0800
IronPort-SDR: GPqklYS4MhXPtuFScMcMrlLheJHOKS+ztswqH/HCKAIeUS4KASJ3mjXqDAgTDzPTCW+AaYmyyn
 C+a6BD9zgnGmAdaq6sANjDXFZE8tg9Vog=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 18:27:29 -0800
IronPort-SDR: +iWkemWLEus9/qEDz+arSjP994rS0injMOm4Whacc+3WhZcSMUYFyUUIhPFKqwO10GgcjboJCV
 6FfkLyZHkgLQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:41:47 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 6/9] nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
Date:   Wed, 25 Nov 2020 18:40:40 -0800
Message-Id: <20201126024043.3392-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
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

