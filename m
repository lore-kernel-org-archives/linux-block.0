Return-Path: <gustavo@embeddedor.com>
Date: Sat, 4 Aug 2018 19:08:59 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>, Jens Axboe <axboe@kernel.dk>
Cc: xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] xen-blkfront: use true and false for boolean values
Message-ID: <20180805000859.GA20132@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/xen-blkfront.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 94300db..8986ada 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1436,7 +1436,7 @@ static bool blkif_completion(unsigned long *id,
 
 		/* Wait the second response if not yet here. */
 		if (s2->status == REQ_WAITING)
-			return 0;
+			return false;
 
 		bret->status = blkif_get_final_status(s->status,
 						      s2->status);
@@ -1537,7 +1537,7 @@ static bool blkif_completion(unsigned long *id,
 		}
 	}
 
-	return 1;
+	return true;
 }
 
 static irqreturn_t blkif_interrupt(int irq, void *dev_id)
-- 
2.7.4
