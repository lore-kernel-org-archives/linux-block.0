Return-Path: <dan.carpenter@oracle.com>
Date: Sat, 13 Oct 2018 13:38:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Richard Russon (FlatCap)" <ldm@flatcap.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-ntfs-dev@lists.sourceforge.net,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] partitions/ldm: Off by one in ldm_relative()
Message-ID: <20181013103840.GA22816@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

The > should be >= or otherwise we could end up reading one element
beyond the end of the array.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 block/partitions/ldm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index 16766f267559..f48bcd2f5226 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -636,7 +636,7 @@ static int ldm_relative(const u8 *buffer, int buflen, int base, int offset)
 {
 
 	base += offset;
-	if (!buffer || offset < 0 || base > buflen) {
+	if (!buffer || offset < 0 || base >= buflen) {
 		if (!buffer)
 			ldm_error("!buffer");
 		if (offset < 0)
-- 
2.18.0
