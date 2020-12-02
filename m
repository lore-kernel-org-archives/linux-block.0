Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA05C64E8A
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5DE22202
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 06:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgLBGYS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 01:24:18 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:48080 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbgLBGYR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 01:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606890256; x=1638426256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hpoI1V55y5gwFhJlJIS3F+nAY0E41Z5thazQ0M5y7lA=;
  b=FUlL5Air6Ufw1SNg2fSg+Xj0pQJNadyeOScOADeNVtbt7zC2ivw6GlMF
   1Xbp7ThqG9jF0BFAJCs66IrRHv2Nk82iRRMm1f1RbzpKAKB1OrG6Qe6X4
   mv1ckyyzz4zJoAL0j+hxtRjJdlEROzvZD8z+ZT3cV+tFqGUZUqBrhDvKL
   fcEmUUPxnjXYPNAefSrl2FdCdNfCN97KPYF5o1M/fGi4BjPAr1W5tUfqJ
   wiwi8r0tdQhB9vu//J7aUIpiTgVqP9QZgN+AafXBbaJyx5QCefMwseUOf
   yNiqoZXUiTUT2fX/vLRFhSc/yT29oknlzV1QmvAz1TxdLxPK9I/2OSJTZ
   A==;
IronPort-SDR: sojTEOo5/HBO9N1ijjyYjac3MDVweNDY+VQK4v1qmBKELP4enAuGpjaE89Y6ARNwBcMxXbtSFA
 5wHVxK02m/qnVJhgbjKbHLi0wEQpGVm65BPbP4OxZNiqcrrO6HauFUO9YCIjjOZjc7be7eizbt
 KXq9m/UnVNUIfjW5LoGgcu4mSkReK49KFeSXh70VR6wX7SF+jspEIRSvDyp01jYUxndJCEnKq5
 i6RsHCDnVGBb7B2cyCRi9CvMDBhlhXgIQIUmjHmcNzE76Qpl27Vv1tCuaP0jtAfW5ME1gX8p0R
 3RU=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; 
   d="scan'208";a="264126127"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:23:25 +0800
IronPort-SDR: 8rFljIzY8tp7VmS/9rdL9LDtHdLI+E/DCSeUuJj4kr7HlujjEGvWM3QU83RetOdZuRg2Z3Uevy
 2fpcGY2P66VVKieFKnNa3i1cKhtc5V5Hw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 22:07:37 -0800
IronPort-SDR: hBYFBf+pPzvg+2AAdZ7UtHZh9yFsJPwZOETn77uGbTPq2L7oVh4ulBd2/rSv9txkxiTWLPLEJc
 HKdbicUob75w==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:23:25 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        johannes.thumshirn@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 4/9] nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
Date:   Tue,  1 Dec 2020 22:22:22 -0800
Message-Id: <20201202062227.9826-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
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

