Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA56C64E8A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A79A4206C1
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 04:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L8th+e4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgLAEQZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 23:16:25 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21474 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgLAEQZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 23:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606796184; x=1638332184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hUhzJ651cVoNvniIQeg3wff/FCoz1DE77FDFCSJt0Zk=;
  b=L8th+e4ZXzJS1i3QJZPgxvVb3a1I/DCHS5izxrMsXxGFOD31UhQiAD6F
   wxrXilTG0+xwcEmTsIdG3EUUDW2pW8WXgJwu2F2MCO6n1g0Q7rPPPqElR
   F3NCB1Z3ybp1d22d1Yvb5M4dMkQP/JxMM3kARo6viLR7QfvWZMWIVwb3j
   voGBsTsNNlIkj0MnIHBluf0eNZMk51GVWYAxElt4t4Xe1KE0fkSMlCL1W
   kJe6YTvctO9DJAatBYKkfgGNqMqD2RIxOpIDcL1onm/GgtjkNTZieoDes
   4UUwm3Z7y0PyTdKOcEknkB7xjmW6VTzSVVHJHofzKcgGClsZEFIc1Cebe
   Q==;
IronPort-SDR: 53w5cCa5sRJK5NzY39J9XwRunGhqO2IzhJYQD7pM4YprOVRVTLjdUpt3Oryd+IhDv1rrOreVy/
 RDSWiS/V4JGkV9wM5CbWE1LfHmfvrRq7XAsd2WhymNxzXn0wErqcsRJqhgx+diEYPi9OCKuVdk
 NPfZQ75XUgzgZI1uibUCdwoqI3D01987/C6y8Eqi5WZTLsnfXAp8vTBzHKdkzFWqd30a3JAJmu
 Pa8APl0w2gq1NwHyE6HQcSf8F8p/72pLvf56DIiXpfxD+6SxlG0Gqm8bbwlyUsMW57+s/8iex9
 LTo=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; 
   d="scan'208";a="264005915"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:15:19 +0800
IronPort-SDR: UqEen0blP2gIFgKZV2ap2uXdX9PGwE1wqVWGaNt0kUgL5gLBIkiojg/OpVbDdudGBahNChkCXA
 4EPKc5QvVbSnufeRo3hNBCtH6OyEKhxuA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 20:00:55 -0800
IronPort-SDR: //xZ+qNsQRcAGeKCluZYuo0aHD1Fp1gdnJAggnvul6GPdSwObZMVXcGJymVr1bni4SUp1y9Rwi
 3XYh8f/KljCg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:15:19 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 7/9] nvmet: add zns cmd effects to support zbdev
Date:   Mon, 30 Nov 2020 20:14:14 -0800
Message-Id: <20201201041416.16293-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update the target side command effects logs with support for
ZNS commands for zbdev.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index cd368cbe3855..0099275951da 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -191,6 +191,8 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
 	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
 
+	nvmet_zns_add_cmd_effects(log);
+
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 
 	kfree(log);
-- 
2.22.1

