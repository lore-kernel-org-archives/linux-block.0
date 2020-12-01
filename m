Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D6EC64E8A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6DE20796
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AuAExG45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgLAEQI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 23:16:08 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54598 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgLAEQI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 23:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606796167; x=1638332167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+iv8i8xvGTKjTFiSy9i/jgbNCBRhvNbZSotD5vVTWDc=;
  b=AuAExG45bUlIXxBXdsLaOqPxFrlopDvTLKFo44r7A/vcxA41xLhHWLO4
   VsOf+ODNfSEmO4RlsJkdjSt5M1c/SbuOLEf/66TgtlEfpTYhRZWbQaPl0
   +B7Q7oA4jnQzciOwz25fUyZU47XX2rtRqSV2Re8GIXX5QcqTlOUB/h2Hw
   PYRO6VoAj9+5h2BrLMFbELp7oudS2Ju6JLaAEi7Iv6ToMT0RikqpfhD7T
   1Tbr/Q9cIMjeuL84MnUENdFCe+Oa6jaRMVr/2QxVErG0eJC2uFKnYjQWE
   SkVVFmlgdv0sqTbT5xfVTYLUYUFmYjdM7vQnB/gBBSh+1ALiT18bTQ7QR
   w==;
IronPort-SDR: ne4kq4KBbNA/HoBMKXueltX0bMvGr4lxClY8x+ztm+vMfVkzns2VXb/wRB9Lpd0GFbSK2FT+oJ
 hD3/mmU+aGwqn4mTUFFGqYqyUs7bNcwFpPXAlw6uMgw4K2C/F9eCILfadGx0F7Lfl90bi9bpuV
 WSasD9aGHZD5+kFfqRSCQgQoT7PfDwGKN1C7bt1I54eSinCL7G+aTS1QjhSCRN6wp0d4fnt0Tb
 /LddekYk8KZaFUW2TLwFQixUNjdZhTTxsvcZKO57y8tq228m/0UW3TjyWp4dptQXZaoCi1oZwW
 HVE=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; 
   d="scan'208";a="155078165"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:15:02 +0800
IronPort-SDR: v5JmhFzi2DuU3/mGFYsFA0VbWOA6/m23T5Q3nH67xDMKw7oAPiCTBZGAdcMaHso5toboI6C470
 PmbPOLlwG5Wl5JRTH9w2hakUmH7+B6GfA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 19:59:14 -0800
IronPort-SDR: h5fnJ21debZvfkYEpcq0/DTqM3DTdw5CsfIEjan+M57FL6ex5KKZqiMpE9cwEY+RPNchNVn0+t
 z3PNOaostPmw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:15:02 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Date:   Mon, 30 Nov 2020 20:14:12 -0800
Message-Id: <20201201041416.16293-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
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

