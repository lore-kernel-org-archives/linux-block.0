Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, "Omar
 Sandoval" <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 10/12] block: Constify disk_type
Date: Wed, 31 May 2017 15:52:44 -0700
Message-ID: <20170531225246.26261-11-bart.vanassche@sandisk.com>
In-Reply-To: <20170531225246.26261-1-bart.vanassche@sandisk.com>
References: <20170531225246.26261-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

The variable 'disk_type' is never modified so constify it.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index d252d29fe837..7f520fa25d16 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -36,7 +36,7 @@ struct kobject *block_depr;
 static DEFINE_SPINLOCK(ext_devt_lock);
 static DEFINE_IDR(ext_devt_idr);
 
-static struct device_type disk_type;
+static const struct device_type disk_type;
 
 static void disk_check_events(struct disk_events *ev,
 			      unsigned int *clearing_ptr);
@@ -1183,7 +1183,7 @@ static char *block_devnode(struct device *dev, umode_t *mode,
 	return NULL;
 }
 
-static struct device_type disk_type = {
+static const struct device_type disk_type = {
 	.name		= "disk",
 	.groups		= disk_attr_groups,
 	.release	= disk_release,
-- 
2.12.2
