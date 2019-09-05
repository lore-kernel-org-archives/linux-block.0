Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999AAC43331
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 16:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9812082E
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 16:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbfIEQoC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:44:02 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:55238 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388362AbfIEQoC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Sep 2019 12:44:02 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 5 Sep 2019 19:43:57 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x85Ghux3018224;
        Thu, 5 Sep 2019 19:43:56 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me
Cc:     shlomin@mellanox.com, israelr@mellanox.com,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 2/3] block: don't remap ref tag for T10 PI type 0
Date:   Thu,  5 Sep 2019 19:43:55 +0300
Message-Id: <1567701836-29725-2-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567701836-29725-1-git-send-email-maxg@mellanox.com>
References: <1567701836-29725-1-git-send-email-maxg@mellanox.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only type 1 and type 2 have a reference tag by definition.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 block/t10-pi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 7d9a151..088c3c7 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -178,7 +178,7 @@ static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
  * likely to be different. Remap protection information to match the
  * physical LBA.
  *
- * Type 3 does not have a reference tag so no remapping is required.
+ * Types 0 and 3 don't have a reference tag so no remapping is required.
  */
 void t10_pi_prepare(struct request *rq)
 {
@@ -186,7 +186,8 @@ void t10_pi_prepare(struct request *rq)
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	struct bio *bio;
 
-	if (rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
+	if (rq->rq_disk->protection_type == T10_PI_TYPE0_PROTECTION ||
+	    rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
 		return;
 
 	__rq_for_each_bio(bio, rq) {
@@ -234,7 +235,7 @@ void t10_pi_prepare(struct request *rq)
  * to the device, we should remap it back to virtual values expected by the
  * block layer.
  *
- * Type 3 does not have a reference tag so no remapping is required.
+ * Types 0 and 3 don't have a reference tag so no remapping is required.
  */
 void t10_pi_complete(struct request *rq, unsigned int nr_bytes)
 {
@@ -243,7 +244,8 @@ void t10_pi_complete(struct request *rq, unsigned int nr_bytes)
 	u32 ref_tag = t10_pi_ref_tag(rq);
 	struct bio *bio;
 
-	if (rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
+	if (rq->rq_disk->protection_type == T10_PI_TYPE0_PROTECTION ||
+	    rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
 		return;
 
 	__rq_for_each_bio(bio, rq) {
-- 
1.8.3.1

