Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63362 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752785AbdCFPlq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Mar 2017 10:41:46 -0500
From: Jon Derrick <jonathan.derrick@intel.com>
To: Jens Axboe <axboe@fb.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        David Binderman <dcb314@hotmail.com>,
        Scott Bauer <scott.bauer@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH] block/sed: Fix opal user range check and unused variables
Date: Mon,  6 Mar 2017 08:41:04 -0700
Message-Id: <1488814864-28478-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Fixes check that the opal user is within the range, and cleans up unused
method variables.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/sed-opal.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 1e18dca..14035f8 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1023,7 +1023,6 @@ static int finalize_and_send(struct opal_dev *dev, cont_fn cont)
 
 static int gen_key(struct opal_dev *dev, void *data)
 {
-	const u8 *method;
 	u8 uid[OPAL_UID_LENGTH];
 	int err = 0;
 
@@ -1031,7 +1030,6 @@ static int gen_key(struct opal_dev *dev, void *data)
 	set_comid(dev, dev->comid);
 
 	memcpy(uid, dev->prev_data, min(sizeof(uid), dev->prev_d_len));
-	method = opalmethod[OPAL_GENKEY];
 	kfree(dev->prev_data);
 	dev->prev_data = NULL;
 
@@ -1669,7 +1667,6 @@ static int add_user_to_lr(struct opal_dev *dev, void *data)
 static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 {
 	u8 lr_buffer[OPAL_UID_LENGTH];
-	const u8 *method;
 	struct opal_lock_unlock *lkul = data;
 	u8 read_locked = 1, write_locked = 1;
 	int err = 0;
@@ -1677,7 +1674,6 @@ static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 	clear_opal_cmd(dev);
 	set_comid(dev, dev->comid);
 
-	method = opalmethod[OPAL_SET];
 	if (build_locking_range(lr_buffer, sizeof(lr_buffer),
 				lkul->session.opal_key.lr) < 0)
 		return -ERANGE;
@@ -1733,14 +1729,12 @@ static int lock_unlock_locking_range_sum(struct opal_dev *dev, void *data)
 {
 	u8 lr_buffer[OPAL_UID_LENGTH];
 	u8 read_locked = 1, write_locked = 1;
-	const u8 *method;
 	struct opal_lock_unlock *lkul = data;
 	int ret;
 
 	clear_opal_cmd(dev);
 	set_comid(dev, dev->comid);
 
-	method = opalmethod[OPAL_SET];
 	if (build_locking_range(lr_buffer, sizeof(lr_buffer),
 				lkul->session.opal_key.lr) < 0)
 		return -ERANGE;
@@ -2133,7 +2127,7 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 		pr_err("Locking state was not RO or RW\n");
 		return -EINVAL;
 	}
-	if (lk_unlk->session.who < OPAL_USER1 &&
+	if (lk_unlk->session.who < OPAL_USER1 ||
 	    lk_unlk->session.who > OPAL_USER9) {
 		pr_err("Authority was not within the range of users: %d\n",
 		       lk_unlk->session.who);
@@ -2316,7 +2310,7 @@ static int opal_activate_user(struct opal_dev *dev,
 	int ret;
 
 	/* We can't activate Admin1 it's active as manufactured */
-	if (opal_session->who < OPAL_USER1 &&
+	if (opal_session->who < OPAL_USER1 ||
 	    opal_session->who > OPAL_USER9) {
 		pr_err("Who was not a valid user: %d\n", opal_session->who);
 		return -EINVAL;
-- 
1.8.3.1
