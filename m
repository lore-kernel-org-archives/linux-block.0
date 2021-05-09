Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69240C433B4
	for <linux-block@archiver.kernel.org>; Sun,  9 May 2021 23:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9D46113E
	for <linux-block@archiver.kernel.org>; Sun,  9 May 2021 23:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhEIXtN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 May 2021 19:49:13 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49544 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhEIXtM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 May 2021 19:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620604089; x=1652140089;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G1ckVO12SAt7cCvFDrQl6+DbViusyEHq9l3e9lgIx4g=;
  b=lbhMIj2I/cYTU3OKieY7ESMk6iehHynDUvnCRPz/cjBU64T+aASp7LZD
   z+3A2JGcltN1EIRVNVW4WyeQqHS8YK+th5aNN50RGa0gfMOrZi3qN/wcJ
   mi+ef8llyBxq5yfiiFMXSmfDH/t6IUBfJVFkUiI9LWEiLzct3yhqQzh2X
   BLO4l4y0ZCYviMTeSELI/sYzEaLFiHicZS6OT5W/UKhY/nnJNPlQZJGOP
   Yi+f1G34ABYl2l1FR983t/zDxlGoIg8aa2Sm+rmpR5YgZmqh2uo40JFRn
   kE2K3PUGWJbBEfGq84B7ll9+OIllPw936AZPs0o2Cg+52gEkOyFaK8f7q
   Q==;
IronPort-SDR: 1JkXZcIijRmGNYjjGFO5wyRoETEiaU6+Lp4FiyxJAvVMyh/ukrTkSaMsAztz6vmlSGCg7LAMYP
 pkaSqDQyzO/7W5iN7e4x3Q4cyFLMYzK11O2ZHpa/i2UPErwIR/1a2y+BbLQ92rej5+NvSeCq/R
 tTkEvzI59vAZWwFlEXxXTLnzasLeYFbK03QIev3jNgcATaPu/FoAGJ+Rr2cxfiroVCGrtxx3Bd
 ZGtAEiOD0uqwWnIq92QSDuj4aB8GYW87WoaH0UcBYo4jYtY9pd6O9KCCedgpLa1qhg/oJkLuHi
 DBI=
X-IronPort-AV: E=Sophos;i="5.82,286,1613404800"; 
   d="scan'208";a="278706987"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2021 07:48:07 +0800
IronPort-SDR: YL8qQvJT/mwatjs7oNnbbSHtRI8PJOZSUG7/rXLS+i7bGyoxehAW9rxat+CzZrCI1K5l45x6X8
 LHSVwk3NRGhPfdMP70fZGHX83aFO6vROv+EyuTXz6WCeNQZo85kyzRu43oGv4ZPfMq/uLTx3Yf
 ij/2THyicc5GCrfrjRw1/YTkGwdr8a2OFbhuBIT4hfOzkRfPQPJAOs1xNeY5p8eKeiunJrkgqj
 QwWZrOs7QyRJ28jYxCerEcimUEjCnJsgUQvi6fpRICiQe2pzbU+6oL0NtZrQaNUgmVbINsAaIe
 F5lRWqAQUOgDJfkY0iI+xE8k
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2021 16:26:43 -0700
IronPort-SDR: iuGJm+XEKXfl7yOzVH7WbYBKvmeGUWohXgiUXTSc9kKhw2i6D6YDumzib3FodvwS4wLQKSNGBF
 OSzGsBO1aa3oBQ3Qgd58cZUNqalZA8ViUTifGVCFrIT9r2QizhvKcmgJZyYGbCtsggtpSSNiNE
 9+/EbSuBjSTQdqO/McNLjJBbvql1vsi/hXvNx2MBO6w/QoRqLthhHm8qUaudfankEQbylgRxLP
 uOnppzRoURFvA0eqEzwCDN1c025LxuWiQoY4KNomdI9V96ogaxLYg+eXZW6aOCSit1hkoDtuWG
 xhE=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 May 2021 16:48:07 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] block: uapi: fix comment about block device ioctl
Date:   Mon, 10 May 2021 08:48:06 +0900
Message-Id: <20210509234806.3000-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the comment mentioning ioctl command range used for zoned block
devices to reflect the range of commands actually implemented.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/uapi/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index f44eb0a04afd..4c32e97dcdf0 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -185,7 +185,7 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 /*
- * A jump here: 130-131 are reserved for zoned block devices
+ * A jump here: 130-136 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
  */
 
-- 
2.31.1

