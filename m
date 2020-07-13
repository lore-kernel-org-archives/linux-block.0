Return-Path: <SRS0=ze0F=AY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E0EC433E3
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 12:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B943D20771
	for <linux-block@archiver.kernel.org>; Mon, 13 Jul 2020 12:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgGMMfX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:35:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:33194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGMMfX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jul 2020 08:35:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48D5BADC1;
        Mon, 13 Jul 2020 12:35:23 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Jens Axboe <axboe@fb.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: [PATCH 1/2] block: change REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL to be odd numbers
Date:   Mon, 13 Jul 2020 20:35:10 +0800
Message-Id: <20200713123511.19441-2-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200713123511.19441-1-colyli@suse.de>
References: <20200713123511.19441-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL are defined as
even numbers 6 and 8, such zone reset bios are treated as READ bios by
bio_data_dir(), which is obviously misleading.

The macro bio_data_dir() is defined in include/linux/bio.h as,
 55 #define bio_data_dir(bio) \
 56         (op_is_write(bio_op(bio)) ? WRITE : READ)

And op_is_write() is defined in include/linux/blk_types.h as,
397 static inline bool op_is_write(unsigned int op)
398 {
399         return (op & 1);
400 }

The convention of op_is_write() is when there is data transfer then the
op code should be odd number, and treat as a write op. bio_data_dir()
treats all bio direction as READ if op_is_write() reports false, and
WRITE if op_is_write() reports true.

Because REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL are even numbers,
although they don't transfer data but reporting them as READ bio by
bio_data_dir() is misleading and might be wrong. Because these two
commands will reset the writer pointers of the resetting zones, and all
content after the reset write pointer will be invalid and unaccessible,
obviously they are not READ bios in any means.

This patch changes REQ_OP_ZONE_RESET from 6 to 15, and changes
REQ_OP_ZONE_RESET_ALL from 8 to 17. Now bios with these two op code
can be treated as WRITE by bio_data_dir(). Although they don't transfer
data, now we keep them consistent with REQ_OP_DISCARD and
REQ_OP_WRITE_ZEROES with the ituition that they change on-media content
and should be WRITE request.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@fb.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Shaun Tancheff <shaun.tancheff@seagate.com>
---
 include/linux/blk_types.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ccb895f911b1..447b46a0accf 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -300,12 +300,8 @@ enum req_opf {
 	REQ_OP_DISCARD		= 3,
 	/* securely erase sectors */
 	REQ_OP_SECURE_ERASE	= 5,
-	/* reset a zone write pointer */
-	REQ_OP_ZONE_RESET	= 6,
 	/* write the same sector many times */
 	REQ_OP_WRITE_SAME	= 7,
-	/* reset all the zone present on the device */
-	REQ_OP_ZONE_RESET_ALL	= 8,
 	/* write the zero filled sector many times */
 	REQ_OP_WRITE_ZEROES	= 9,
 	/* Open a zone */
@@ -316,6 +312,10 @@ enum req_opf {
 	REQ_OP_ZONE_FINISH	= 12,
 	/* write data at the current zone write pointer */
 	REQ_OP_ZONE_APPEND	= 13,
+	/* reset a zone write pointer */
+	REQ_OP_ZONE_RESET	= 15,
+	/* reset all the zone present on the device */
+	REQ_OP_ZONE_RESET_ALL	= 17,
 
 	/* SCSI passthrough using struct scsi_request */
 	REQ_OP_SCSI_IN		= 32,
-- 
2.26.2

