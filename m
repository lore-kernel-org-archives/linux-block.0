Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801CCC5B578
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AD421479
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 21:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KADS1dQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfGAV55 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:57:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:61244 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGAV55 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 17:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562018277; x=1593554277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=MbHOnCWpKU9OhNQ3wNRN8l4gA1/62SoaCYINRxhsjOE=;
  b=KADS1dQg4EU8mbhayi4lwtDMVqy1/AZq7XFlZ0iE2MZq93d3hNbrTWlL
   mLtH4gklBoX+iXQOE0f6PiuSdl5xN6sewsBYu5sJx180CvwQzCSC5WWIL
   vX66LVl8ju69JpJueAnZN5PjuH0yQ/4o1Y1OqfjPkIQ8a7YDTZSXmYNE+
   0K7aJeHvWizPSjGbAYz0ex3sgXj2BhUPLDPu5CDVEnpBbunPDOpJt3vGw
   VwOABnPAN3QHh/kBdVJUGyIEAMN1ji1crbYs4krByxz7GUPIfIcj2/JeS
   9MlVySUBYlhFni5o0CzChLLYuDsGoJKPPv0OdWJ0BjLVZyIDh8vv8MKqp
   g==;
X-IronPort-AV: E=Sophos;i="5.63,440,1557158400"; 
   d="scan'208";a="113190428"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 05:57:57 +0800
IronPort-SDR: +DvYhdhzlO9VHk6HS5cu89hX56AqM2iSrCon2n4SEzVCON3Tfsx6jInRgo4tOVCWv8wGEWL3x+
 bb24qAiqw4sDGGK7RNokGWnsM/1/hX/pIo/an1S3P93TLecSdT38rcXdULhj43TJUQS39vgKrl
 3fnn8iDG23PWnahrRgzbzakWbCdFvRr4hLx0Hng2YARVKu3q/umb7+3HbWoyG+w/ppXSoyLzuf
 qe5EWAPZHDltUlg1jGD5eK8ILPE80WA6KXHJ0VppKDPZlH+e5Hv2EOM7F+Vn2a2vJ0cYC+4rVp
 c0q5jg9MrVqhpVwit5v5g2v/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 01 Jul 2019 14:56:57 -0700
IronPort-SDR: CL+xf59TlgjtZyTlFRdcDLuFt75xQy3gXKfSxFmbCWJT5LpCjDOhLvVhJA8iyfcFX8teiNIU61
 JS6nyhX2Ks1O0rTthsOcqUEA8YwUv0TSYQVGKXjnChLzxvglb4z6E2l2b22Mx69PqCKDUgabxq
 z+flC2nm/UzUtye/ZE8/A8OzzamaJyVuGujFyj+kM5z3Ul371Uu9BPqEO6baKu5HavSUMM/V2z
 T3UMAzRyJNRY+iQgrLC/LgbFgJNzaxW0R7TuHnASZhh7TGWl6LIKon4o4jEMddBsNPFxtsL3Cn
 T7w=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Jul 2019 14:57:57 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-mm@kvack.org, linux-block@vger.kernel.org
Cc:     bvanassche@acm.org, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/5] block: allow block_dump to print all REQ_OP_XXX
Date:   Mon,  1 Jul 2019 14:57:24 -0700
Message-Id: <20190701215726.27601-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
References: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In the current implementation when block_dump is enabled we only report
bios with data. In this way we are not logging the REQ_OP_WRITE_ZEROES,
REQ_OP_DISCARD or any other operations without data etc.

This patch allows all bios with and without data to be reported when
block_dump is enabled and adjust the existing code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
---
 block/blk-core.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5143a8e19b63..9855c5d5027d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1127,17 +1127,15 @@ EXPORT_SYMBOL_GPL(direct_make_request);
  */
 blk_qc_t submit_bio(struct bio *bio)
 {
+	unsigned int count = bio_sectors(bio);
 	/*
 	 * If it's a regular read/write or a barrier with data attached,
 	 * go through the normal accounting stuff before submission.
 	 */
 	if (bio_has_data(bio)) {
-		unsigned int count;
 
 		if (unlikely(bio_op(bio) == REQ_OP_WRITE_SAME))
 			count = queue_logical_block_size(bio->bi_disk->queue) >> 9;
-		else
-			count = bio_sectors(bio);
 
 		if (op_is_write(bio_op(bio))) {
 			count_vm_events(PGPGOUT, count);
@@ -1145,15 +1143,16 @@ blk_qc_t submit_bio(struct bio *bio)
 			task_io_account_read(bio->bi_iter.bi_size);
 			count_vm_events(PGPGIN, count);
 		}
+	}
 
-		if (unlikely(block_dump)) {
-			char b[BDEVNAME_SIZE];
-			printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",
-			current->comm, task_pid_nr(current),
-				blk_op_str(bio_op(bio)),
-				(unsigned long long)bio->bi_iter.bi_sector,
-				bio_devname(bio, b), count);
-		}
+	if (unlikely(block_dump)) {
+		char b[BDEVNAME_SIZE];
+
+		printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",
+		current->comm, task_pid_nr(current),
+			blk_op_str(bio_op(bio)),
+			(unsigned long long)bio->bi_iter.bi_sector,
+			bio_devname(bio, b), count);
 	}
 
 	return generic_make_request(bio);
-- 
2.21.0

