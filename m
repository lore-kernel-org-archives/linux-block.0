Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:46218 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964811AbdBQW4e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 17:56:34 -0500
From: Jon Derrick <jonathan.derrick@intel.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Scott Bauer <scott.bauer@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/5] block/sed: Eliminate state variable
Date: Fri, 17 Feb 2017 15:56:18 -0700
Message-Id: <1487372178-15715-6-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1487372178-15715-1-git-send-email-jonathan.derrick@intel.com>
References: <1487372178-15715-1-git-send-email-jonathan.derrick@intel.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Now that the function data is embedded with the function, there is no
need to carry a device state variable.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/sed-opal.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 9fc323c..791a40a 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -85,7 +85,6 @@ struct opal_dev {
 	sec_send_recv *send_recv;
 
 	opal_step *funcs;
-	int state;
 	struct mutex dev_lock;
 	u16 comid;
 	u32 hsn;
@@ -377,17 +376,17 @@ static void check_geometry(struct opal_dev *dev, const void *data)
 static int next(struct opal_dev *dev)
 {
 	opal_step *func;
-	int error = 0;
+	int state = 0, error = 0;
 
 	do {
-		func = &dev->funcs[dev->state];
+		func = &dev->funcs[state];
 		if (!func->fn)
 			break;
 
 		error = func->fn(dev, func->data);
 		if (error) {
 			pr_err("Error on step function: %d with error %d: %s\n",
-			       dev->state, error,
+			       state, error,
 			       opal_error_to_human(error));
 
 			/* For each OPAL command we do a discovery0 then we
@@ -397,10 +396,10 @@ static int next(struct opal_dev *dev)
 			 * session. Therefore we shouldn't attempt to terminate
 			 * a session, as one has not yet been created.
 			 */
-			if (dev->state > 1)
+			if (state > 1)
 				return end_opal_session_error(dev);
 		}
-		dev->state++;
+		state++;
 	} while (!error);
 
 	return error;
@@ -1285,7 +1284,7 @@ static int start_generic_opal_session(struct opal_dev *dev,
 	return finalize_and_send(dev, start_opal_session_cont);
 }
 
-static int start_anybodyASP_opal_session(struct opal_dev *dev)
+static int start_anybodyASP_opal_session(struct opal_dev *dev, void *data)
 {
 	return start_generic_opal_session(dev, OPAL_ANYBODY_UID,
 					  OPAL_ADMINSP_UID, NULL, 0);
@@ -1376,7 +1375,7 @@ static int start_auth_opal_session(struct opal_dev *dev, void *data)
 	return finalize_and_send(dev, start_opal_session_cont);
 }
 
-static int revert_tper(struct opal_dev *dev)
+static int revert_tper(struct opal_dev *dev, void *data)
 {
 	int err = 0;
 
@@ -1461,7 +1460,7 @@ static int erase_locking_range(struct opal_dev *dev, void *data)
 
 static int set_mbr_done(struct opal_dev *dev, void *data)
 {
-	u8 mbr_done_tf = data;
+	u8 mbr_done_tf = *(u8 *)data;
 	int err = 0;
 
 	clear_opal_cmd(dev);
@@ -1493,7 +1492,7 @@ static int set_mbr_done(struct opal_dev *dev, void *data)
 
 static int set_mbr_enable_disable(struct opal_dev *dev, void *data)
 {
-	u8 mbr_en_dis = data;
+	u8 mbr_en_dis = *(u8 *)data;
 	int err = 0;
 
 	clear_opal_cmd(dev);
@@ -1962,19 +1961,17 @@ static int end_opal_session(struct opal_dev *dev, void *data)
 
 static int end_opal_session_error(struct opal_dev *dev)
 {
-	const opal_step error_end_session[] = {
+	opal_step error_end_session[] = {
 		{ end_opal_session, },
 		{ NULL, }
 	};
 	dev->funcs = error_end_session;
-	dev->state = 0;
 	return next(dev);
 }
 
 static inline void setup_opal_dev(struct opal_dev *dev,
-				  const opal_step *funcs)
+				  opal_step *funcs)
 {
-	dev->state = 0;
 	dev->funcs = funcs;
 	dev->tsn = 0;
 	dev->hsn = 0;
@@ -2320,7 +2317,6 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 	setup_opal_dev(dev, NULL);
 
 	list_for_each_entry(suspend, &dev->unlk_lst, node) {
-		dev->state = 0;
 		dev->tsn = 0;
 		dev->hsn = 0;
 
-- 
1.8.3.1
