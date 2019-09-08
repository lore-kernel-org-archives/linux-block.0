Return-Path: <SRS0=xOsI=XD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFEEC4332F
	for <linux-block@archiver.kernel.org>; Sun,  8 Sep 2019 15:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE88B214D9
	for <linux-block@archiver.kernel.org>; Sun,  8 Sep 2019 15:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfIHP0s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Sep 2019 11:26:48 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34015 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729077AbfIHP0r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Sep 2019 11:26:47 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 8 Sep 2019 18:26:45 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x88FQjLj011361;
        Sun, 8 Sep 2019 18:26:45 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me
Cc:     shlomin@mellanox.com, israelr@mellanox.com,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH v4 2/3] block: don't remap ref tag for T10 PI type 0
Date:   Sun,  8 Sep 2019 18:26:44 +0300
Message-Id: <1567956405-5585-2-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only type 1 and type 2 have a reference tag by definition.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---

changes from v3:
 - added blk_integrity_need_remap helper

---
 block/t10-pi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index a33eac4..753b5a8 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -168,6 +168,12 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
 };
 EXPORT_SYMBOL(t10_pi_type3_ip);
 
+static inline bool blk_integrity_need_remap(struct gendisk *disk)
+{
+	return disk->protection_type == T10_PI_TYPE1_PROTECTION ||
+		disk->protection_type == T10_PI_TYPE2_PROTECTION;
+}
+
 /**
  * t10_pi_prepare - prepare PI prior submitting request to device
  * @rq:              request with PI that should be prepared
@@ -178,7 +184,7 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
  * likely to be different. Remap protection information to match the
  * physical LBA.
  *
- * Type 3 does not have a reference tag so no remapping is required.
+ * Types 0 and 3 don't have a reference tag so no remapping is required.
  */
 void t10_pi_prepare(struct request *rq)
 {
@@ -186,7 +192,7 @@ void t10_pi_prepare(struct request *rq)
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	struct bio *bio;
 
-	if (rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
+	if (!blk_integrity_need_remap(rq->rq_disk))
 		return;
 
 	__rq_for_each_bio(bio, rq) {
@@ -234,7 +240,7 @@ void t10_pi_prepare(struct request *rq)
  * to the device, we should remap it back to virtual values expected by the
  * block layer.
  *
- * Type 3 does not have a reference tag so no remapping is required.
+ * Types 0 and 3 don't have a reference tag so no remapping is required.
  */
 void t10_pi_complete(struct request *rq, unsigned int nr_bytes)
 {
@@ -243,7 +249,7 @@ void t10_pi_complete(struct request *rq, unsigned int nr_bytes)
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	struct bio *bio;
 
-	if (rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
+	if (!blk_integrity_need_remap(rq->rq_disk))
 		return;
 
 	__rq_for_each_bio(bio, rq) {
-- 
1.8.3.1

