Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39695 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932967AbeAITNg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jan 2018 14:13:36 -0500
Received: by mail-pf0-f195.google.com with SMTP id e11so5524994pff.6
        for <linux-block@vger.kernel.org>; Tue, 09 Jan 2018 11:13:36 -0800 (PST)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH] bcache: closures: move control bits one bit right
Date: Tue,  9 Jan 2018 11:13:23 -0800
Message-Id: <20180109191323.5816-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Otherwise, architectures that do negated adds of atomics (e.g. s390)
to do atomic_sub fail in closure_set_stopped.

Signed-off-by: Michael Lyle <mlyle@lyle.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/md/bcache/closure.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/closure.h b/drivers/md/bcache/closure.h
index 392a87cf1b92..3b9dfc9962ad 100644
--- a/drivers/md/bcache/closure.h
+++ b/drivers/md/bcache/closure.h
@@ -127,10 +127,10 @@ enum closure_state {
 	 * annotate where references are being transferred.
 	 */
 
-	CLOSURE_BITS_START	= (1U << 27),
-	CLOSURE_DESTRUCTOR	= (1U << 27),
-	CLOSURE_WAITING		= (1U << 29),
-	CLOSURE_RUNNING		= (1U << 31),
+	CLOSURE_BITS_START	= (1U << 26),
+	CLOSURE_DESTRUCTOR	= (1U << 26),
+	CLOSURE_WAITING		= (1U << 28),
+	CLOSURE_RUNNING		= (1U << 30),
 };
 
 #define CLOSURE_GUARD_MASK					\
-- 
2.14.1
