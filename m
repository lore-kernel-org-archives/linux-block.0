Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Roger Pau Monn303251 <roger.pau@citrix.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 10/12] xen-blkback: Fix indentation
Date: Thu, 17 Aug 2017 16:23:09 -0700
Message-Id: <20170817232311.25948-11-bart.vanassche@wdc.com>
In-Reply-To: <20170817232311.25948-1-bart.vanassche@wdc.com>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Avoid that smatch reports the following warning when building with
C=2 CHECK="smatch -p=kernel":

drivers/block/xen-blkback/blkback.c:710 xen_blkbk_unmap_prepare() warn: inconsistent indenting

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Roger Pau Monn303251 <roger.pau@citrix.com>
Cc: xen-devel@lists.xenproject.org
---
 drivers/block/xen-blkback/blkback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index fe7cd58c43d0..68157a84bf4d 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -705,9 +705,9 @@ static unsigned int xen_blkbk_unmap_prepare(
 				    GNTMAP_host_map, pages[i]->handle);
 		pages[i]->handle = BLKBACK_INVALID_HANDLE;
 		invcount++;
-       }
+	}
 
-       return invcount;
+	return invcount;
 }
 
 static void xen_blkbk_unmap_and_respond_callback(int result, struct gntab_unmap_queue_data *data)
-- 
2.14.0
