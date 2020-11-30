Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3ABC71155
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 03:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D206422240
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 03:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IeWxcpjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgK3Daw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 22:30:52 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7669 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgK3Dav (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 22:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606707051; x=1638243051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hpoI1V55y5gwFhJlJIS3F+nAY0E41Z5thazQ0M5y7lA=;
  b=IeWxcpjfcwrgjAWAWilh+lNL1Rdkq39rrmrAsHu9neWzD0KZk6LrM6Vv
   +KG+A2cAblguVGBhkWtB8hdi958dWJvkUCEsl27bPySVWnk7eIomtt+Ku
   sSYcT5LZPQpPJOHf+m5R5L/jqjiGTmRwM/7GVuhDGqgbzillEf1p6r0Lb
   QRPYIgTHlLkJ7P1bFwkct0otYr+Y9zTzphB/QkROWu9BlICQA2ptpdj8T
   9grkTXC/VdCNB9jslNvB0vrXjKjhv4xp22WyDe4LxzTZTVylxpU6szB2z
   e7XvSklKxWP48xPlS30mUnVyXJXaPylPMH788fNokERYYP6ATQwCyM7IA
   w==;
IronPort-SDR: gc34GLN1gOILGMj2J9NdQxVTnnGgQYhMLKRP3oRliCyTKiio3uVtVdpwicGlaXnzIrZRC5h2Jf
 w/jIbGPQgksW+KZ5YTF+IFQ0MmO0h6XM6xo+QXmFS2STGV7rvU9rZKMw/oXOPCzLROCKsWtpXw
 J2+t+UCP8wItc2h32YFIvIeBWp/OR//kbQrbXELLGmfQ1A5dKZj8LsbR4aOzqQCnD9oj34Lbzm
 rb5XHxIgS7i+i/l+cKkKQocwqa6wP/s9Ap/Tz4ybrntfrZHng2sZb6yxS37U2QfAO2KkMcS47H
 8SU=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; 
   d="scan'208";a="153844119"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:29:45 +0800
IronPort-SDR: GgeB9HL+m3guBQ/Xyi2DySyvq6UTW8zz9ISY6a11Q86uQvRXncMP8ijrllt/AdHJ6Ok6BpwDJx
 A5GqGHN4HuGwcnwjER3x+9Zu1rfioqQoA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 19:15:23 -0800
IronPort-SDR: 6xWCH0RaF8WNbAwW/PPWh9osExPyzV/1nidU+0Z3OEJdmdikHsqbn/84veuNpiweFXykiE+nKv
 w97dQe4exBQg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:29:46 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 4/9] nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
Date:   Sun, 29 Nov 2020 19:29:04 -0800
Message-Id: <20201130032909.40638-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
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

