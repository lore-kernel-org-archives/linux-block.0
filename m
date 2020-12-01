Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88E9C64E8A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7918E20796
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U6j0KcC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgLAEQA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 23:16:00 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19764 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgLAEP7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 23:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606796159; x=1638332159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hpoI1V55y5gwFhJlJIS3F+nAY0E41Z5thazQ0M5y7lA=;
  b=U6j0KcC4z8M4J6iZnTSo7GT88QNX9QXJKUurKhz0QYZfrls3tkOKc7/R
   Qgk9Sx0HY2fczuVPh7AfnmHnbaA4Ye/qIHo+RO6zh8rEVEJKHak7N2jbi
   B8LsEFexNlPSHvCaR0i/wkQH+2WSyAdC3T4lWY0jkw7AqLoYycryO8ZrO
   f3S1wE6y/7Z6gm+72wSURjUxoqTcoLrQqyjzmbtu3kvxM1DLYonOul28r
   Rdn6La4znez0JEpwcMhoA4WSiWogPjAaCzjaCuteYb0LxGHGWe/Y1tho0
   6t4XADQPyljg2Xo2UqSLzjJVe9LQXQhzWD95Q84VUts0pMA7uEReJe4vC
   A==;
IronPort-SDR: l6KQ5wBbQruii7E7o803hMgR3YW1tIDXepIB4Rs2yWr/YaHpHP+UU9WSgqmxfABanNl4lYNhBa
 lZ4wUqcY8brWoBt9f/ymGzmBOa90mwFgVM5jd7yAw2LYIEgs42r23wL0mKoq6Lz5ctpGTLR3R6
 TO86YHGFMZkjN9OomBs2O5gR0wk648nwxwdvX7M3uaPKwZpxxbBJIo8nYacdPKgpdIJqN9Cdbp
 HG3boA3BX8T1sFrZwcY1RRFCh6dCdmFmG3tXUh/giCEiXghq29ei7ZEBi+5v9QlrWXwISALk4l
 Juo=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; 
   d="scan'208";a="153814555"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:14:53 +0800
IronPort-SDR: T3D3pWuj2lJsNtYC4XCQ1MPKRM9AYTGU3ZxeU/+rFLmlm7/WzJYiS3ukoA9YkSMhQyRze6Sra1
 z7qKHrdL7PFACexJ8CHnG3vBknaA1pIqk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 20:00:29 -0800
IronPort-SDR: 5htoikVM1SkY+ej8If5dpDTgcxoRwylrhnTsqR9sjWeSXn0Wk4fe7mQrlNd1wtGAyq8PXTCm/X
 aJRr4nVlpHSQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:14:54 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 4/9] nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
Date:   Mon, 30 Nov 2020 20:14:11 -0800
Message-Id: <20201201041416.16293-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
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

