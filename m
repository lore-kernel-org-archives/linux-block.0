Return-Path: <SRS0=xOsI=XD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0A6C433EF
	for <linux-block@archiver.kernel.org>; Sun,  8 Sep 2019 15:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F095214D9
	for <linux-block@archiver.kernel.org>; Sun,  8 Sep 2019 15:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfIHP0w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Sep 2019 11:26:52 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34028 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727154AbfIHP0w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Sep 2019 11:26:52 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Sep 2019 18:26:45 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x88FQjLk011361;
        Sun, 8 Sep 2019 18:26:45 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me
Cc:     shlomin@mellanox.com, israelr@mellanox.com,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH v4 3/3] nvme: remove PI values definition from NVMe subsystem
Date:   Sun,  8 Sep 2019 18:26:45 +0300
Message-Id: <1567956405-5585-3-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use block layer definition instead of re-defining it with the same
values.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---

changes from v3:
 - added Reviewed-by signature

---
 drivers/nvme/host/core.c | 12 ++++++------
 include/linux/nvme.h     |  3 ---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bdc0a64..a1c0ce0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -663,11 +663,11 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		}
 
 		switch (req->rq_disk->protection_type) {
-		case NVME_NS_DPS_PI_TYPE3:
+		case T10_PI_TYPE3_PROTECTION:
 			control |= NVME_RW_PRINFO_PRCHK_GUARD;
 			break;
-		case NVME_NS_DPS_PI_TYPE1:
-		case NVME_NS_DPS_PI_TYPE2:
+		case T10_PI_TYPE1_PROTECTION:
+		case T10_PI_TYPE2_PROTECTION:
 			control |= NVME_RW_PRINFO_PRCHK_GUARD |
 					NVME_RW_PRINFO_PRCHK_REF;
 			cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));
@@ -1498,13 +1498,13 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms)
 
 	memset(&integrity, 0, sizeof(integrity));
 	switch (disk->protection_type) {
-	case NVME_NS_DPS_PI_TYPE3:
+	case T10_PI_TYPE3_PROTECTION:
 		integrity.profile = &t10_pi_type3_crc;
 		integrity.tag_size = sizeof(u16) + sizeof(u32);
 		integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
 		break;
-	case NVME_NS_DPS_PI_TYPE1:
-	case NVME_NS_DPS_PI_TYPE2:
+	case T10_PI_TYPE1_PROTECTION:
+	case T10_PI_TYPE2_PROTECTION:
 		integrity.profile = &t10_pi_type1_crc;
 		integrity.tag_size = sizeof(u16);
 		integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 01aa6a6..8d45c3e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -381,9 +381,6 @@ enum {
 	NVME_NS_DPC_PI_TYPE1	= 1 << 0,
 	NVME_NS_DPS_PI_FIRST	= 1 << 3,
 	NVME_NS_DPS_PI_MASK	= 0x7,
-	NVME_NS_DPS_PI_TYPE1	= 1,
-	NVME_NS_DPS_PI_TYPE2	= 2,
-	NVME_NS_DPS_PI_TYPE3	= 3,
 };
 
 struct nvme_ns_id_desc {
-- 
1.8.3.1

