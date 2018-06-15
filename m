Return-Path: <prvs=697b38d23=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Matias Bjorling <mb@lightnvm.io>
Subject: [PATCH 2/5] include/uapi/linux/blkzoned.h: Remove a superfluous __packed directive
Date: Fri, 15 Jun 2018 14:55:18 -0700
Message-Id: <20180615215521.27435-3-bart.vanassche@wdc.com>
In-Reply-To: <20180615215521.27435-1-bart.vanassche@wdc.com>
References: <20180615215521.27435-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Using the __packed directive for a structure that does not need
it is wrong because it makes gcc generate suboptimal code on some
architectures. Hence remove the __packed directive from the
blk_zone_report structure definition. See also
http://digitalvampire.org/blog/index.php/2006/07/31/why-you-shouldnt-use-__attribute__packed/.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Matias Bjorling <mb@lightnvm.io>
Cc: Christoph Hellwig <hch@lst.de>
---
 include/uapi/linux/blkzoned.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index e3c70fe6bf0f..ff5a5db8906a 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -117,7 +117,7 @@ struct blk_zone_report {
 	__u32		nr_zones;
 	__u8		reserved[4];
 	struct blk_zone zones[0];
-} __packed;
+};
 
 /**
  * struct blk_zone_range - BLKRESETZONE ioctl request
-- 
2.17.0
