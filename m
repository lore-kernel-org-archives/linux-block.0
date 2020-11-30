Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564D5C63777
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 03:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF65220705
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 03:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HDdVQZ01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgK3DbF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 22:31:05 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30921 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgK3DbE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 22:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606707063; x=1638243063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m/bvl+lK7ll6HRYiQ0kG1ndR5SFePuzrxfzuz5g9atQ=;
  b=HDdVQZ01MelWNtD4omtMk96mCMAdp3PoCrbvIsilr9UObMQAvjj2lHqX
   XRbBl5oktdVwm2eS9qflP/s5b7+BGGt4pS5P4C3rAY5izwi2SbwIVOEta
   vBwF8CApDSZhlRQEMO6e4ybImHQhxDxeabTslDtTh42aPKuJOviGU9L8/
   VgO4tSH7v8/jYjzumGYdXcTlAv4RicdwAXdhSvvKqMthMREugnkaH/taA
   sIKmx5+5aMZEfcHzRQtmMgBjcrSNfSJoW3x2QlcnJFo+Ptn//zmRuxbvM
   WXSGBAnUMw/SIft8/6XZw4Cnt3aXKxKrdbj4h2yU6cfYN9c9vTDjJvu3E
   Q==;
IronPort-SDR: TxAlE2An9q/CVwARNiv3zPizoccRASYFHdu6VkWih2bhZ3O/rY+jRdjxJFoCTt+ScanTur48CB
 NMI8IS32AQdMzMhMRcTf+/ecBfpJqyhoVNs5U1kuWArWdXBEFiAxN/wMvxSc02r/JmuvfrX5x4
 709tcp8WaTZ1z2KvjBszRaOaE82LOe0cpfM3i0Vv2CBvd8MnQzPldY7SWJVzdPV7mdX9xhxyZ/
 2jOgNZ/5r2hGDB6Fj5Mhrt7azHBMtoCro1HxJ6MqIZGbZPsFpZjju0M49LaLlz7uW7nVzECnA8
 Edc=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; 
   d="scan'208";a="158242330"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:29:58 +0800
IronPort-SDR: 1etDQ/Q0tYF3kMPjJDYy8Le5jbF0l3SN+0HgnXXLyjkEg94TO2igzVAmJWPEKVU7UVWsLiBtap
 5Wr5Ot5iJ98JlJbRcHxtx7+xitvEG5BLo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 19:15:35 -0800
IronPort-SDR: 1cd6sDZyQ0eW+cQgh9SqyaYRHq8ZG37xwpOgg+VbZJJk9PztxYllEcyJRy/LJq1CZAp2FZGK55
 q0ZDYSBiUV9g==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:29:58 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 6/9] nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
Date:   Sun, 29 Nov 2020 19:29:06 -0800
Message-Id: <20201130032909.40638-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
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

