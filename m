Return-Path: <shaun@helios.aeonazure.com>
From: Shaun Tancheff <shaun@tancheff.com>
To: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	axboe@kernel.dk,
	David Drysdale <drysdale@google.com>,
	Xiong Zhou <xzhou@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	linux-nvdimm@ml01.01.org,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@fb.com>,
	bart.vanassche@sandisk.com,
	Shaun Tancheff <shaun@tancheff.com>,
	Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: [PATCH] Missing bio_put following submit_bio_wait
Date: Tue,  7 Jun 2016 11:32:13 -0500
Message-Id: <1465317133-13266-1-git-send-email-shaun@tancheff.com>
In-Reply-To: <1465316612-9649-1-git-send-email-shaun@tancheff.com>
References: <1465316612-9649-1-git-send-email-shaun@tancheff.com>
List-ID: <linux-block@vger.kernel.org>

submit_bio_wait() gives the caller an opportunity to examine
struct bio and so expects the caller to issue the put_bio()

This fixes a memory leak reported by a few people in 4.7-rc2
kmemleak report after 9082e87bfbf8 ("block: remove struct bio_batch")

Signed-off-by: Shaun Tancheff <shaun.tancheff@seagate.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Larry Finger@lwfinger.net
Tested-by: David Drysdale <drysdale@google.com>
---
 block/blk-lib.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 23d7f30..9e29dc3 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -113,6 +113,7 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		ret = submit_bio_wait(type, bio);
 		if (ret == -EOPNOTSUPP)
 			ret = 0;
+		bio_put(bio);
 	}
 	blk_finish_plug(&plug);
 
@@ -165,8 +166,10 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		}
 	}
 
-	if (bio)
+	if (bio) {
 		ret = submit_bio_wait(REQ_WRITE | REQ_WRITE_SAME, bio);
+		bio_put(bio);
+	}
 	return ret != -EOPNOTSUPP ? ret : 0;
 }
 EXPORT_SYMBOL(blkdev_issue_write_same);
@@ -206,8 +209,11 @@ static int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		}
 	}
 
-	if (bio)
-		return submit_bio_wait(WRITE, bio);
+	if (bio) {
+		ret = submit_bio_wait(WRITE, bio);
+		bio_put(bio);
+		return ret;
+	}
 	return 0;
 }
 
-- 
2.8.1
