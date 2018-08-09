Return-Path: <lkp@intel.com>
Date: Fri, 10 Aug 2018 06:33:17 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Juergen Gross <jgross@suse.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
	konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
	boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [RFC PATCH] xen/blkback: xen_blkif_pgrant_timeout can be static
Message-ID: <20180809223317.GA3009@lkp-ivb-ep02>
References: <20180808142528.31029-2-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180808142528.31029-2-jgross@suse.com>
List-ID: <linux-block@vger.kernel.org>


Fixes: 5bed25379565 ("xen/blkback: don't keep persistent grants too long")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 blkback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index f341ac8..9eae7b24 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -88,7 +88,7 @@ MODULE_PARM_DESC(max_persistent_grants,
  * use. The time is in seconds, 0 means indefinitely long.
  */
 
-unsigned int xen_blkif_pgrant_timeout = 60;
+static unsigned int xen_blkif_pgrant_timeout = 60;
 module_param_named(persistent_grant_unused_seconds, xen_blkif_pgrant_timeout,
 		   uint, 0644);
 MODULE_PARM_DESC(persistent_grant_unused_seconds,
