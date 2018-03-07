Return-Path: <jonas.rabenstein@studium.uni-erlangen.de>
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: sed-opal: fix u64 short atom length
Date: Wed,  7 Mar 2018 17:55:56 +0100
Message-Id: <20180307165556.2618-1-jonas.rabenstein@studium.uni-erlangen.de>
References: <1520379912.4178.83.camel@intel.com> <20180301132700.1279-1-jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <1520379912.4178.83.camel@intel.com>
List-ID: <linux-block@vger.kernel.org>

The length must be given as bytes and not as 4 bit tuples.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
v2:
  - use fls64
  - shorten loop body
---
 block/sed-opal.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 36842bfa572e..38411c5c477f 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -554,15 +554,14 @@ static void add_token_u64(int *err, struct opal_dev *cmd, u64 number)
 
 	size_t len;
 	int msb;
-	u8 n;
 
 	if (!(number & ~TINY_ATOM_DATA_MASK)) {
 		add_token_u8(err, cmd, number);
 		return;
 	}
 
-	msb = fls(number);
-	len = DIV_ROUND_UP(msb, 4);
+	msb = fls64(number);
+	len = DIV_ROUND_UP(msb, 8);
 
 	if (cmd->pos >= IO_BUFFER_LENGTH - len - 1) {
 		pr_debug("Error adding u64: end of buffer.\n");
@@ -570,10 +569,8 @@ static void add_token_u64(int *err, struct opal_dev *cmd, u64 number)
 		return;
 	}
 	add_short_atom_header(cmd, false, false, len);
-	while (len--) {
-		n = number >> (len * 8);
-		add_token_u8(err, cmd, n);
-	}
+	while (len--)
+		add_token_u8(err, cmd, number >> (len * 8));
 }
 
 static void add_token_bytestring(int *err, struct opal_dev *cmd,
-- 
2.16.1
