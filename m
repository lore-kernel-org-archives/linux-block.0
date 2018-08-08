Return-Path: <jgross@suse.com>
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Cc: konrad.wilk@oracle.com,
	roger.pau@citrix.com,
	axboe@kernel.dk,
	boris.ostrovsky@oracle.com,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 5/5] xen/blkback: remove unused pers_gnts_lock from struct xen_blkif_ring
Date: Wed,  8 Aug 2018 16:25:28 +0200
Message-Id: <20180808142528.31029-6-jgross@suse.com>
In-Reply-To: <20180808142528.31029-1-jgross@suse.com>
References: <20180808142528.31029-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

pers_gnts_lock isn't being used anywhere. Remove it.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
---
 drivers/block/xen-blkback/common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 2339b8d39c5e..1d3002d773f7 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -269,7 +269,6 @@ struct xen_blkif_ring {
 	wait_queue_head_t	pending_free_wq;
 
 	/* Tree to store persistent grants. */
-	spinlock_t		pers_gnts_lock;
 	struct rb_root		persistent_gnts;
 	unsigned int		persistent_gnt_c;
 	atomic_t		persistent_gnt_in_use;
-- 
2.13.7
