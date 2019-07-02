Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBACC06510
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 00:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC73C218EA
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 00:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EQLsmuMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfGCAue (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:50:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:52767 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfGCAud (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 20:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562115033; x=1593651033;
  h=from:to:cc:subject:date:message-id;
  bh=wEIkFBPqXVLkAHRjVu0iLrwwsuBBJAJ7BB94GnIzxYE=;
  b=EQLsmuMmep7jvUprYjUAuXa758DIuZHR7V26U32fh7KAfHj3zAc27xFM
   zZj+i8BTOG+jS5PswMv86UXThW34IERg+3vqTjBsJ0vkfDWOaT2Zswkm+
   UapiUNoE/1LX6kr+MihetE4qH1HIFseb5KEcEawh9sRoipNacDUnaHM28
   HUq2Aa1WXdZCFVjI7rRUYEjUWkUkP4yEsQr5R1gQZIstyaYiM/nm8EM1b
   agK0EJ7xkxL8z5EmDj0/A42hTJHhd8aKReWLTQ+V4ot68NCjQbtmbUtSH
   FV6UWfzITG76lTTB5JpEVoMwQzS98BoP+mUxgmx5BTfRNSpZNvnv1rdj0
   g==;
IronPort-SDR: cyGEtSjrFE6558BjihlDU9tt4MWAIfXCAT+lH+td0d7sIv8IOMb6xkdSJjBzuFEq19K8vLVOoa
 deaj+3H0zQ5VN68AyaW4kJCfVCy7dd4zQ6Ssa5rEWScQrR7x6jyrIeFwqKDdsrW54KsuRddsy7
 RmId/k+dRXSIBWeTl6vIpZZeeDBHiwAA80kF9z31h4b4Wj9Ssc1Ms1OJQsL2OLlgZBFMMV5eXd
 yQUi+4KlEkq84w4Jp3kwKA8zD3fYa/1T5RN0lvR1vF6x9rHXSsaKz7Pc6eJnV1Npy9TLmQNo9Q
 2x4=
X-IronPort-AV: E=Sophos;i="5.63,444,1557158400"; 
   d="scan'208";a="113703821"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2019 04:29:00 +0800
IronPort-SDR: gFfCTmaI1a9ag6HHVOYA29/eEdxiul502QUUq4Hc0VeswDSHy4/UUIPLtizbm+nZZsl+iIRsCC
 IVyyML8dDPMbGPo88y/YzUrw3UhgrARTTPR6/2Ed4l+wKfqRuQ/59HYydBxVnh8uPHxoyhuMNH
 qvg5zmGITXn4NCSX67wEvDBuhTJG/+c8gXv+NqZJb8o+P7Hd49lFP0JG5eL3OIqb65e79HbM58
 B/d8BjbakTRGYSU0wGWcK6oloGSSryR8v2kXJkCY4MTO7Y64VYDmMgU49F7WjBWSuPt5w2RSZM
 xIyPOueBnW0VYJJFs5Zs36Eb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 02 Jul 2019 13:27:58 -0700
IronPort-SDR: YmkhUb3mMijoNmXoADl8y9ZbWPhaXtpbLdj+QofGRbpd/J1yV8zb3OWP1Wa0Y/q6xSzr8tiBtD
 7E048QWkllh5C4qYH3t8xJVMNUOa1f0w7DTV+4l7xHiixKOIC5BM065eKNE5ytBkiu8UUMq9wK
 HrR4fymB5THMcR363aTFC6xypbPO1Ca+JflU3ltKp3rNA+iCv3V8eKXjMuBAgIDPagk2Wmr83G
 fvWLhHY/7bypKsYBQwHm+qiNdVUTy3aGNLTkEHHnP/gcrRTzdgFoNZvtzMSxvY22YeHqBZksoW
 Evw=
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2019 13:29:00 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] null_blk: use SECTOR_SHIFT consistently
Date:   Tue,  2 Jul 2019 13:28:57 -0700
Message-Id: <20190702202857.4433-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a pure cleanup patch and doesn't change any functionality.
In null_blk_main.c we use mixed style of the code SECTOR_SHIFT and
>> 9. Get rid of the >> 9 and use SECTOR_SHIFT everywhere.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/null_blk_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index cbbbb89e89ab..860d9c17b615 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1203,7 +1203,7 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 		if (dev->queue_mode == NULL_Q_BIO) {
 			op = bio_op(cmd->bio);
 			sector = cmd->bio->bi_iter.bi_sector;
-			nr_sectors = cmd->bio->bi_iter.bi_size >> 9;
+			nr_sectors = cmd->bio->bi_iter.bi_size >> SECTOR_SHIFT;
 		} else {
 			op = req_op(cmd->rq);
 			sector = blk_rq_pos(cmd->rq);
@@ -1408,7 +1408,7 @@ static void null_config_discard(struct nullb *nullb)
 		return;
 	nullb->q->limits.discard_granularity = nullb->dev->blocksize;
 	nullb->q->limits.discard_alignment = nullb->dev->blocksize;
-	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
+	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> SECTOR_SHIFT);
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, nullb->q);
 }
 
@@ -1521,7 +1521,7 @@ static int null_gendisk_register(struct nullb *nullb)
 	if (!disk)
 		return -ENOMEM;
 	size = (sector_t)nullb->dev->size * 1024 * 1024ULL;
-	set_capacity(disk, size >> 9);
+	set_capacity(disk, size >> SECTOR_SHIFT);
 
 	disk->flags |= GENHD_FL_EXT_DEVT | GENHD_FL_SUPPRESS_PARTITION_INFO;
 	disk->major		= null_major;
-- 
2.17.0

