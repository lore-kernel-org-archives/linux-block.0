Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCC6C56201
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E434120709
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dYCeqQlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgKKNAy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:00:54 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32529 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgKKNAy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 08:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605099653; x=1636635653;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=JOR9OCgi505NbzwoU1BeXfqpiMr1MNIpYwwmtuMKfVA=;
  b=dYCeqQlCJG8Av8D8QiO48ha5Vbvg8pbPjW/gvvRG/9r1rtC5RqF9dWrO
   IFfr3SzNoWmC/OVsuGvcQhCO1yRO/nC299Q4yQ4r43GJP2PhXYJzJxIIZ
   AkyvBPpzxm62icVzFzM4B63VDEEnhQW3qRRs3fq6RUrM0OZ89jEjvcrOa
   7wp22fVp/3SGnxrpbB660QP3JW0ck4CvkdwkWk2/GGY5C8U570ag7Lz8n
   +cpscN4kvhJpv5klcaIjxf7iymbnDwZ5gIb2zJjSdNQORDv0F6f6N+ZDi
   5ofD9Sifa9wK9S2ThN9gTZojv61cvSon22L6MIyIpDK9/VK1bY/FbQpVl
   Q==;
IronPort-SDR: sI2ZGZqMKkA/AZppjmEFy1nnk7jH3djOZgrGze907CALDCdn7EgH9HhAedfY3TJEShsQnQSP6p
 v/H5tGWTyLIIFVfxKzuZFMWltJe/HRYeqCFs3FEwhz6fnqwvay5K0WMRFdaetUoZVdXyagpEwA
 22Zwpv/BZibViOQmJrjQha+ZWT9jDizFyDTn/FA0lX9+YPKdCx9kbjMGdQdtcedh3h5nCRQszv
 hwnwLq6KxuizjoE1h5liRalDViiw2rTfxZVlnCH2yM266iojJOoSt2T0x02A23dLye1s/HvS63
 Gzw=
X-IronPort-AV: E=Sophos;i="5.77,469,1596470400"; 
   d="scan'208";a="152283537"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 21:00:53 +0800
IronPort-SDR: kTTIz4zMVhdHs57+JsCH4CuBLd5mYumcXDq2Kqtf6Bm8GiHwWr42Mkj0mc6dYMoXqFgOLWLN0N
 8BvsWWsi8ayb+drTRK60l5VyoFAOreLq7sNtior00z+aK1FvexaoFI9nmSCZuYG+3BmrNBFBAC
 5wPJ3UfNXusJlLMK+3mBAEG8s7toqPB41hUAW4PlnFGH9xA6tRUWT3RjCEmKDbWna77tW3b5I0
 C6NGxYzbJ9wCO65jPTOcFl344T/Z0Q1PxyAVjloMxMdtF7E9ZO3MIyT+IOo4eMmfiguX3edgTC
 02lxZ7/h/x9lVvCBr8BUDUbi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 04:45:36 -0800
IronPort-SDR: sc+D+Wox4Y+51APTy3PcvdeZHLHZ/XWM5Y6fdX9MkDDAu36cARMJ9DcsT4/aHg3HNHb4/Br3n/
 Ih1klLvgQeAD8RL64UltEQOKA7SFxVLHpYZmdI2AmlmlrGtI9svE201K42Nwb6FLxno5x3s4aN
 3nMANCnz2ATKoWz4iFp32+e0TV9OJhofXPlgiYUS6n8A+tEMyApKpyCcAu27BlnO8Ko6TBpq4k
 5ZZ7uYHRKUyYWFmzXqo/ABRcIS3YmlrFLdmJJvdmPvmnTzRlPZgHU/pgIcOVkSeuzcanXg8lHs
 BdE=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Nov 2020 05:00:54 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 2/9] null_blk: Fail zone append to conventional zones
Date:   Wed, 11 Nov 2020 22:00:42 +0900
Message-Id: <20201111130049.967902-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111130049.967902-1-damien.lemoal@wdc.com>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Conventional zones do not have a write pointer and so cannot accept zone
append writes. Make sure to fail any zone append write command issued to
a conventional zone.

Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
Fixes: e0489ed5daeb ("null_blk: Support REQ_OP_ZONE_APPEND")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/null_blk_zoned.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 1d0370d91fe7..172f720b8d63 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -339,8 +339,11 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 
 	trace_nullb_zone_op(cmd, zno, zone->cond);
 
-	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		if (append)
+			return BLK_STS_IOERR;
 		return null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
+	}
 
 	null_lock_zone(dev, zno);
 
-- 
2.26.2

