Return-Path: <SRS0=exTe=U7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88022C5B578
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 03:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4859820836
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 03:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HTWJcnpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfGBDU3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:20:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62512 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfGBDU3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 23:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562037629; x=1593573629;
  h=from:to:cc:subject:date:message-id;
  bh=jlAlEfjMjHbUxo2CI60mnsClfVWPU5MZnHqXvczZShE=;
  b=HTWJcnpmBTk55csSQ6ttYzkAHTR+vID9rkqewLeRYljZef29OfKMap5a
   31G0mpo8k5+VTdLpspDsdci4NEmNP+tafnjA0fQ/hbaQT2brSQnTu6Rf9
   rS77+Nx1MbL4LBfvfeOvkihYfXWbP4wwGory/3EpVdOTwZjtywSZsvJmS
   pm1Bmt7AqvGtqN0R2LF6OENpcHtDB5/rVeViRQ4hIRIpBlc3KGTLNDFG1
   36tnAheIt56lXnZNFt2SDkdqG9d095XPqix9VZcwlzIIy7b/BhVA2YaL3
   piRLJ/3EnTuVLX8j0tFLpodwJ+V/SNeBwEICp2EeXj64ufa3Tmef5nWL2
   w==;
X-IronPort-AV: E=Sophos;i="5.63,441,1557158400"; 
   d="scan'208";a="113211396"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 11:20:29 +0800
IronPort-SDR: aZOann87VQfgjIaqP6QDAVG3kUDH/ttVplw/O+2WN4VH2qXoMMjUq3WqL3m4wS+1tfpQ7BCL10
 mrCuzpD/sgkX57D5l2RO8IwMsc4/RC4wVq8e+MP+zS0SZDrqjvC6f9hn+U4goeQSf4C2fY1mRi
 CcuMdkJN83x7pIm9ER3aUvjldbJOZaMAdwS+yYeoCfrFFtBH1Z3+6jQ8vF71zkji3eThwQd/Ov
 VvIySZbsGnG/YNE8wFcKgasgRMh4YYaWjb+IipTZVq9UFw+kNlqQix6Kiglgsei/xgB2uqjwKI
 WCckLyDM4wc7FRciaVP4AXJk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 01 Jul 2019 20:19:32 -0700
IronPort-SDR: 9ukgcx+pCqaiCMbY9A/mdWvFodQyZli027qwVWbqs2ISwbHGV9PddscL32JOQBz5ygC+/YBaQs
 C4yap5w9dFejqUUcDIuWYP9Dj5hlepLCAq/ntzhO3h8mHv89b00CE1ceK44ni/sdMafyKp6QOm
 6BZ5sExPNaId67cFdCmzhYzkbeu1CZVvZCPbF2jXZF1JAEYlR1xJHh0COmgtKiKOIpmEVHRXca
 DzU+s0q8g1meXFe8TkwIYI1IeEi3u/xfTtEY1n2y2iO9on8z6Ue7J2OCzgGp8ygllVYDA0WG8V
 G6c=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Jul 2019 20:20:29 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] null_blk: add unlikely for REQ_OP_DISACRD handling
Date:   Mon,  1 Jul 2019 20:20:27 -0700
Message-Id: <20190702032027.24066-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since discard requests are not as common as read and write requests
mark REQ_OP_DISCARD condition unlikely in the null_handle_rq() and
null_handle_bio().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 99328ded60d1..cbbbb89e89ab 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1061,7 +1061,7 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 
 	sector = blk_rq_pos(rq);
 
-	if (req_op(rq) == REQ_OP_DISCARD) {
+	if (unlikely(req_op(rq) == REQ_OP_DISCARD)) {
 		null_handle_discard(nullb, sector, blk_rq_bytes(rq));
 		return 0;
 	}
@@ -1095,7 +1095,7 @@ static int null_handle_bio(struct nullb_cmd *cmd)
 
 	sector = bio->bi_iter.bi_sector;
 
-	if (bio_op(bio) == REQ_OP_DISCARD) {
+	if (unlikely(bio_op(bio) == REQ_OP_DISCARD)) {
 		null_handle_discard(nullb, sector,
 			bio_sectors(bio) << SECTOR_SHIFT);
 		return 0;
-- 
2.17.0

