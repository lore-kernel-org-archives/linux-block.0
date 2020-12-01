Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4182C64E7A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631B620796
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S2U7WHUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgLAEPv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 23:15:51 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21420 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgLAEPv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 23:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606796151; x=1638332151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AZ0ASPEdFnz/BJCpcrFT1z2buOCvE1xQZBqdQG2WuUM=;
  b=S2U7WHUuVv9rNCvZ6d9/56llFmIeuBA5y+aVb1jiKvOPjbpGJmG5u5DL
   V6vCca1odLzeBz6T/HYdbxfEDRIaksxtA3xX8O2yWBdne2MwMdpa/nf0P
   jw51MpIv5N7L7j1hjR8VPdHkX2bQ6c9ibtw1J2EwVh1ictNHgXWO/iwoM
   h07J6mfvI9dAoevOzxRfldmkPKoAPALLk3vS7BHU+mhry3CjBAExINK2S
   cRiQl0QK0adTIRrboGD5sEx6D/+PFCmYquFRKtk/gWT8xoJ4cMvx7LS3N
   hBBFYyKsBEyRvllHhm8KzzkiycNV5c9PpAI20tyPa89naRCYWIKHr+f5b
   g==;
IronPort-SDR: vPo+zzEAi2w8tyblE86A/fl80m7TY7iidQxPO/jKwZISTYo2r9hkrzD4ER8pdUiAGxQjk4gBF5
 93iJR5oA62q9faikss/a1dtntvH15FlYe522N+koglMQP2LnEOFeLtevP6aHBEoJJjYHp/46NQ
 KEkpR3h8dRk6Trj4bbxAyjbUfImhMf1l0aWLxm7eNMfGOAYHTBPtkub/cVIzGXupoHyDIUMz86
 QOx4ryDg/VhH43L92zmY/FMT8LGKkCd4g+D3BVoLDnNDOmheuMHTYcJd4TrCOoXGlKiihih4Gw
 xms=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; 
   d="scan'208";a="264005871"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:14:45 +0800
IronPort-SDR: fNKvf890FM/Gmur8DEm99DEBgNnJhbv+0e/My9nR3p9Z6Aex3fVuL3m+MhHmM7xr15ZABFbt2v
 EFVMP3yOUmhi2hkhwiaBCuj061vfYgsoc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 19:58:58 -0800
IronPort-SDR: YvkqHILlm6UWCuUEr04BRGq+HsD/5gFFCyYnGnQb47az3BFy7WnmUU7GIP53Lz78rLo1DN91hP
 I5qbVG31pwJA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:14:46 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 3/9] nvmet: trim down id-desclist to use req->ns
Date:   Mon, 30 Nov 2020 20:14:10 -0800
Message-Id: <20201201041416.16293-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In this prep patch we remove the extra local variable struct nvmet_ns
in nvmet_execute_identify_desclist() since req already has the member
that can be reused, this also eliminates the explicit call to
nvmet_put_namespace() which is already present in the request
completion path.

This reduces the arguments to the function in the following patch to
implement the ZNS for bdev-ns so we can get away with passing the req
argument instead of req and ns.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 509fd8dcca0c..c64b40c631e0 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -603,37 +603,35 @@ u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
 
 static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 {
-	struct nvmet_ns *ns;
 	u16 status = 0;
 	off_t off = 0;
 
-	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
-	if (!ns) {
+	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+	if (!req->ns) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
 		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 		goto out;
 	}
 
-	if (memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {
+	if (memchr_inv(&req->ns->uuid, 0, sizeof(req->ns->uuid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
 						  NVME_NIDT_UUID_LEN,
-						  &ns->uuid, &off);
+						  &req->ns->uuid, &off);
 		if (status)
-			goto out_put_ns;
+			goto out;
 	}
-	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid))) {
+	if (memchr_inv(req->ns->nguid, 0, sizeof(req->ns->nguid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_NGUID,
 						  NVME_NIDT_NGUID_LEN,
-						  &ns->nguid, &off);
+						  &req->ns->nguid, &off);
 		if (status)
-			goto out_put_ns;
+			goto out;
 	}
 
 	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
 			off) != NVME_IDENTIFY_DATA_SIZE - off)
 		status = NVME_SC_INTERNAL | NVME_SC_DNR;
-out_put_ns:
-	nvmet_put_namespace(ns);
+
 out:
 	nvmet_req_complete(req, status);
 }
-- 
2.22.1

