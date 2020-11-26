Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E213C56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3558B206C0
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 02:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RMhGWu22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbgKZClc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 21:41:32 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36141 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732531AbgKZClc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 21:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606358491; x=1637894491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hpoI1V55y5gwFhJlJIS3F+nAY0E41Z5thazQ0M5y7lA=;
  b=RMhGWu22i/AYkX9LAz6ixHcFMI+klOKOrn83dfVnWFAj11R5qeGzm94p
   4+YHyqSbv5/AOlUJZaV0FDaBEUQgjmfs6eVtMmuj+WhIejrtckml1Vrid
   YqTvH1c+k+OCHanb46Xciv0cX7pwi4FCQrR1SWGCpNMDrcjlYPiqeYKk9
   Otv11MMWfrfK8ZkEEJPqFTsQBKODL8ZY/j/fVmNwlWxXuRTY0qhufqdqk
   WIMqScxgrUvZ4KV9g4nRIu/HEUOMqMxkyrfWFVqe8S5smpTReeh+2aZ40
   Sm6KZk3bpvHlmo+WH5cSGAxWfchlObq72KovWOf4MmsfPUdzVGxR/0cvH
   g==;
IronPort-SDR: pK/P8cy2BIy6OeUmIxooW/baixnxk2YGEo+gYjXN9PEzYMBqG0uV8ewPisvR/AYkrLvk+t2dN3
 LJlhPns8317lPgAA7D7hWsa0avQHErc3rE4QF4Ky4TGeJONpsa4fzgmk7h3ELGyDas3nKxEC8+
 Not+Yy+1izwzj+2nNEX+HXXP8A6Ka5GEjzRQ0WJ7m/vl0ckP0EfrVcA+GsdgFo7dj9kzFXW8QC
 N4n9pIrlcOKjVUFQc1cxjb8iwbb8BN+awZhivftsbvZw9RSHid+8DAuY5MdcoHw8tEj4wgVJCt
 /lU=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; 
   d="scan'208";a="263593234"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:41:31 +0800
IronPort-SDR: rNrbwv/6lfpqn6nOancJ0UOGNS2QXapSim5Q5UHit6Ay/u9t4sTwI1ZNZOU/q0vSsqFadJegEh
 89OXjVxtvMGIam/VH+H9D8JJ1k6u7jdYY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 18:27:14 -0800
IronPort-SDR: enmtt+Or6DoLJmp0NbpiS6ndWSSk5cAWh1INEVyXm5F8/n67xcFYFIRYGcCIFMEyViN0V8xMdi
 0oc8SJcSF1DA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:41:31 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 4/9] nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
Date:   Wed, 25 Nov 2020 18:40:38 -0800
Message-Id: <20201126024043.3392-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When discovering the ZNS, the host-side looks for the NVME_CSI_ZNS
value in the ns-desc. Update the nvmet_execute_identify_desclist()
such that it can now update the ns-desc with NVME_CSI_ZNS if bdev is
zoned.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index c64b40c631e0..d4fc1bb1a318 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -628,6 +628,10 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 			goto out;
 	}
 
+	status = nvmet_process_zns_cis(req, &off);
+	if (status)
+		goto out;
+
 	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
 			off) != NVME_IDENTIFY_DATA_SIZE - off)
 		status = NVME_SC_INTERNAL | NVME_SC_DNR;
-- 
2.22.1

