Return-Path: <jonas.rabenstein@studium.uni-erlangen.de>
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8.4/8.4] block: sed-opal: check size of shadow mbr
Date: Wed, 14 Mar 2018 07:15:45 +0100
Message-Id: <33f9dab3352e95588a7e4a4680beb068db285b7f.1521006596.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1521006595.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1521006595.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1521006595.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <20180313154416.sgptuw7jcn7l76vn@sbauer-Z170X-UD5> <cover.1521006595.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <b0b34fc0132312c09629c868d33b74fe5a19854e.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <20180313154416.sgptuw7jcn7l76vn@sbauer-Z170X-UD5>
List-ID: <linux-block@vger.kernel.org>

Check whether the shadow mbr does fit in the provided space on the
target. Also a proper firmware should handle this case and return an
error we may prevent problem with crappy firmwares.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/sed-opal.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 4d93a6097ec0..8a08ae91bc25 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1544,6 +1544,20 @@ static int write_shadow_mbr(struct opal_dev *dev, void *data)
 	u64 len;
 	int err = 0;
 
+	/* do we fit in the available shadow mbr space? */
+	err = generic_get_table_info(dev, OPAL_MBR, OPAL_TABLE_ROWS);
+	if (err) {
+		pr_debug("MBR: could not get shadow size\n");
+		return err;
+	}
+
+	len = response_get_u64(&dev->parsed, 4);
+	if (shadow->offset + shadow->size > len) {
+		pr_debug("MBR: does not fit in shadow (%llu vs. %llu)\n",
+			 shadow->offset + shadow->size, len);
+		return -ENOSPC;
+	}
+
 	/* FIXME: this is the maximum we can use for IO_BUFFER_LENGTH=2048.
 	 *        Instead of having constant, it would be nice to compute the
 	 *        actual value depending on IO_BUFFER_LENGTH
-- 
2.16.1
