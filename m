Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 20 Jun 2018 13:44:35 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Richard Russon (FlatCap)" <ldm@flatcap.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-ntfs-dev@lists.sourceforge.net,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] partitions/ldm: Off by one in ldm_relative()
Message-ID: <20180620104433.qegf5bakvcywzuga@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

If base == buflen then we read one character past the end of buffer[].

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is static analysis.  Not tested.  This code goes back to before the
start of git.

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index 0417937dfe99..8f4c302eb11b 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -636,12 +636,12 @@ static int ldm_relative(const u8 *buffer, int buflen, int base, int offset)
 {
 
 	base += offset;
-	if (!buffer || offset < 0 || base > buflen) {
+	if (!buffer || offset < 0 || base >= buflen) {
 		if (!buffer)
 			ldm_error("!buffer");
 		if (offset < 0)
 			ldm_error("offset (%d) < 0", offset);
-		if (base > buflen)
+		if (base >= buflen)
 			ldm_error("base (%d) > buflen (%d)", base, buflen);
 		return -1;
 	}
