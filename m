Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E11C48BCF
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 01:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B4061059
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 01:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhFJBfB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 21:35:01 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55790 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJBfB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 21:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623288785; x=1654824785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/M7v9KrjoblbSKdC++kyP3aEZLqjL2cSbgHauomV+YM=;
  b=HFezatGNIbnOjio22Wt7o5cjdF4MXVeCdi55ct57wsvEtLuJZLkFEeKB
   pfm4KAyz2c57BYTprIeX7Y0G23DRD9Po0rC4FWKpGtqkxEKrYh2Rt0V9o
   kXBa09Nm/8R0n7tz1Et+2lFNfYlb9aXwTIKLRRl/lAyUqdL3hP9QhdYvH
   LmCF7Zfr4U2bKECVQTg2IAacVgNRpbS8l+GZlvTEOYxMpT/lJ2+jzGUoN
   n9j63TeOlhz8lwm7fSWq/PvP7hPLXY1YIUxEUjGW7WGGSQYCDqU4VWNOr
   VWKd98lah6iXV6Y/baEsc9GrUKurcu9DrS8/Oj5Yhdh1Pdp1XNJ6VzoAl
   Q==;
IronPort-SDR: HeilPyuKaRcZmUQOIb+iF232OpFCgMbSUVKO8Fd5+idtCZ5zpE6CIzdQZci5znI2P/qomtdVHE
 E9jquwwmD/DFLl5U16mwtW4eC7DZapO1geHNI5luSnqZlhd+cifXdN1ZM0Hb3R/ENu0fuGnGx2
 1JRngqEos5g9BroKjBNh/QSp9IbM37buTPld70MExYiShgdEgwRU30mrIOQKbcG/0LAKKLLpjh
 X9rbonAVap5kK8l6qP6lLPMnvcd7rkRbDDkAPLEGUIh50q7uzj0uYSf95HyV3zDuXAjFtpIXmp
 hzE=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; 
   d="scan'208";a="171382255"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 09:33:05 +0800
IronPort-SDR: 661uaQ8U6V9s2XS7jlL3DsqoHrLp+XnZYAsXkxfKyvxoQjAvjxe0r6iEM+naFb6kOqtI5JPZIn
 R8TqyTLCdYB+IMvbvenU2yUUpAYFZAvRN3XYmwkGwFgW+oLewdthFfCTJQlgNQgY28K0CAXrDZ
 zqJ6uNn0eXy5sGKMsv6FhBqLit8nVDIFgXioEqhuNhit24uh5tMvdxfEwRv+xo1Z9e0tSyLI6f
 l0KBEE1gTGhKQfIx9EWCn2FACWUYKyzAEIVbj4EULjQssm6AksdNnfqesWEbD6SxzxtBz0oVFd
 KUWHw6IvL3p7Qw5sEQEc5K9s
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 18:10:45 -0700
IronPort-SDR: j8CTu3QY5Pi2uCvsUK/srx86rlk/v4c2+4di1Lp05Qpk4TlG+vUR9huSY8NSGgqlU774mvH+p8
 C562OgdC7kf9FZJ/kKdVFFPQsitGsufmd9enhZ6TBv8cQY0skNo/5KpfaHU/rnYP30XKYRmci7
 RzPGtEFlQjCsEaCsJuGhDENWwWArEI3vlmUJboeGA/2hEwNMvSvdskq6cRoliAdOcRTnmPCjk+
 qdbkow16dUoAxM4cZALj684qEOmlyX8owLNyA4cZQPFN2y+iQSyF7hRntBwX6wLSMcsoAG6fbB
 0lc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jun 2021 18:33:06 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     axboe@kernel.dk, sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH V15 1/5] block: export blk_next_bio()
Date:   Wed,  9 Jun 2021 18:32:48 -0700
Message-Id: <20210610013252.53874-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
References: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer provides emulation of zone management operations
targeting all zones of a zoned block device only for the zone reset
operation (REQ_OP_ZONE_RESET). In order to correctly implement
exporting of zoned block devices with NVMeOF, emulating zone management
operations targeting all zones of a device is also necessary for the
open, close and finish zone operations (REQ_OP_ZONE_OPEN,
REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH).

Instead of duplicating the code, export the existing helper from block
layer so we can use a bio chaining pattern that is present in the block
layer for REQ_OP_ZONE RESET all emulation in the NVMeOF zoned block
device backend.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-lib.c     | 1 +
 include/linux/bio.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 7b256131b20b..9f09beadcbe3 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -21,6 +21,7 @@ struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp)
 
 	return new;
 }
+EXPORT_SYMBOL_GPL(blk_next_bio);
 
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, int flags,
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a0b4cfdf62a4..b2491ead22a0 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -822,4 +822,6 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 		bio->bi_opf |= REQ_NOWAIT;
 }
 
+struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
+
 #endif /* __LINUX_BIO_H */
-- 
2.22.1

