Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:7552 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750918AbdBRAAi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 19:00:38 -0500
From: Jon Derrick <jonathan.derrick@intel.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Scott Bauer <scott.bauer@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2 5/5] block/sed: Eliminate state variable
Date: Fri, 17 Feb 2017 17:00:29 -0700
Message-Id: <1487376029-22662-6-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1487376029-22662-1-git-send-email-jonathan.derrick@intel.com>
References: <1487376029-22662-1-git-send-email-jonathan.derrick@intel.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Now that the function data is embedded with the function, there is no
need to carry a device state variable.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/sed-opal.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index e2e3228..791a40a 100644
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
@@ -1967,14 +1966,12 @@ static int end_opal_session_error(struct opal_dev *dev)
 		{ NULL, }
 	};
 	dev->funcs = error_end_session;
-	dev->state = 0;
 	return next(dev);
 }
 
 static inline void setup_opal_dev(struct opal_dev *dev,
 				  opal_step *funcs)
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
