Return-Path: <jonas.rabenstein@studium.uni-erlangen.de>
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 11/11] block: sed-opal: check size of shadow mbr
Date: Mon, 19 Mar 2018 19:36:53 +0100
Message-Id: <72e19ec70ffac23fff658c60eaae0db850150ca1.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

Check whether the shadow mbr does fit in the provided space on the
target. Also a proper firmware should handle this case and return an
error we may prevent problems or even damage with crappy firmwares.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 51f8034edbf7..9c73bd24c55f 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1545,6 +1545,20 @@ static int write_shadow_mbr(struct opal_dev *dev, void *data)
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
 	 *        Instead of having a constant value, it would be nice to
 	 *        compute the actual value depending on IO_BUFFER_LENGTH
-- 
2.16.1
