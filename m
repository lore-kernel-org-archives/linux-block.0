Return-Path: <SRS0=V/uB=YN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8407CA9EAD
	for <linux-block@archiver.kernel.org>; Sun, 20 Oct 2019 23:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8B021A4A
	for <linux-block@archiver.kernel.org>; Sun, 20 Oct 2019 23:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lMyXVtRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfJTXmY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Oct 2019 19:42:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54880 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfJTXmY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Oct 2019 19:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571614945; x=1603150945;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=UvXkV9cpe7GZrCq1Z+KHdi5vNklfj7PY8s4wcUn0ltM=;
  b=lMyXVtRwXTTl2a5tAfYljCfgvfMXOTIu9qZ2uKyakVlPkgZYfVyqz/mR
   9HMxlUQ1j7+ihgX1DxkQbL2Y3B6JTLOfSNWB5CLbS1AvI6KkL0EWiBWgZ
   NUholCizlWCzv8lj99Uem+IWuFVZVZEdOL23pxO+88+gtKpw7dSGOpJuA
   k6c2SzqPLnoSKpPQug+CBqkO4TRi3j+npDqKmTY0dHjY5A4DSKNQVZujp
   0wzjhlg0z/bX+OYsvXEJix5JxD0546qRlNiGYFeFzZTRF4UVr6k3sAYLk
   PJ318s/aVAsfoHrlEBIKzGeeiIgk7F9F3q7WaGpqJ8wh/uz1tr2pqiUW1
   Q==;
IronPort-SDR: Xo+QPgKaAcmfulCjVn1AhhdFWi9nZGT9lDv1N0eaahvPUp6302wcsWD39YfkC4cQ3+lw8Mesdj
 lBvvHc5xqTcazu867CLZnByPRW1ZPt53aXUcEsoeVm9PE3HoKS62MbbdOIj0ePy63u/j7e2F5g
 2FvozIv4GyAVN1SNTVxGjqoeJvnezKkl61xiAPGAd2niHgkMdnznIg+rmuFksWbzLFbV0Eet3z
 YrxmPgB0+dTA+KSmBsK1jD7W8H6YVpd4F+jOijDiikZL7rJ3bSR6cy7llS3+hVvAnx+J9TNPEQ
 hK8=
X-IronPort-AV: E=Sophos;i="5.67,321,1566835200"; 
   d="scan'208";a="121710477"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2019 07:42:25 +0800
IronPort-SDR: Wv7vZz8tBnx8bsunE3icBZQqdmv/eFDS/9twl6Zt16cvDsczjFm3fdtt1FJI7VzYtTOQAf1vCn
 XXXv7wh+Pno5Z7HXX3+ip1fkpRYPRAa+eBfaRbfjJCTqyE/NygwMyJK423NqKqY6K8CIl5vvSU
 OlpqqBYr+N9DFrvE2/F7WgZzDdncUUKzlfwPvrc7p+IUUHjn7Z8Fjdydsf73K8l47HcihmEXsz
 gr5QRu6ulD1+6R4ZZwuRD1qRDmKO7NIcd48QvZJgrp9Pc3FJI7iKYTP1Ed+mvS5JUCkef++05f
 y26JQ3Ppa4Nt2t9KJzvETTZI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 16:37:58 -0700
IronPort-SDR: ww4o/vndLJvfTlaIG3xtUhpXPo5a0u1AiG/5HYGBKBtvaxtL3T4+siYLECqyWq5PIKjTfTfhJk
 fxPVjTvYWDdDfu3hmts3ou7uig+JoiDmRsCSO/gFat7zG5jOp5be+a+5RZSflX4WiV9frANFQj
 ASgGYdN43KLJOK2HitNFVcys0ooZwf6qRyXmrZ07RD4jKtCZt1y1VzuYLLzbzzWchZI6slcIs3
 4MGKixTmivEMfLam3vkTAiCAzRaTaqF5UnHYuAi0WoNcL20zRAoHWS/fRYIl2bZE7Dtx336u0X
 eXs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Oct 2019 16:42:23 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] nvme: Cleanup nvme_block_nr()
Date:   Mon, 21 Oct 2019 08:42:19 +0900
Message-Id: <20191020234220.14888-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020234220.14888-1-damien.lemoal@wdc.com>
References: <20191020234220.14888-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use SECTOR_SHIFT instead of its hard coded value 9. Also add a comment
to decribe this helper.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/nvme/host/nvme.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 22e8401352c2..a979b62ea4b2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -419,9 +419,12 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
 }
 
+/*
+ * Convert a 512B sector number to a block number.
+ */
 static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
 {
-	return (sector >> (ns->lba_shift - 9));
+	return sector >> (ns->lba_shift - SECTOR_SHIFT);
 }
 
 static inline void nvme_end_request(struct request *req, __le16 status,
-- 
2.21.0

