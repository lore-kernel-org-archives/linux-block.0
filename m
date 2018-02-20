Return-Path: <jonas.rabenstein@studium.uni-erlangen.de>
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: sed-opal: fix u64 short atom length
Date: Tue, 20 Feb 2018 20:20:39 +0100
Message-Id: <20180220192039.3912-2-jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <20180220192039.3912-1-jonas.rabenstein@studium.uni-erlangen.de>
References: <20180220192039.3912-1-jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

The length must be given as bytes and not as 4 bit tuples.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/sed-opal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 36842bfa572e..d5f565e1557a 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -562,7 +562,7 @@ static void add_token_u64(int *err, struct opal_dev *cmd, u64 number)
 	}
 
 	msb = fls(number);
-	len = DIV_ROUND_UP(msb, 4);
+	len = DIV_ROUND_UP(msb, 8);
 
 	if (cmd->pos >= IO_BUFFER_LENGTH - len - 1) {
 		pr_debug("Error adding u64: end of buffer.\n");
-- 
2.13.6
