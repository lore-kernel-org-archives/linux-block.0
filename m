Return-Path: <keescook@chromium.org>
Return-Path: <keescook@chromium.org>
Date: Wed, 5 Sep 2018 17:09:26 -0700
From: Kees Cook <keescook@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sunvdc: Remove VLA usage
Message-ID: <20180906000926.GA18830@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

In the quest to remove all stack VLA usage from the kernel[1], this
moves the math for cookie calculation into macros and allocates a fixed
size array for the maximum number of cookies and adds a runtime sanity check.
(Note that the size was always fixed, but just hidden from the compiler.)

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/block/sunvdc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 5ca56bfae63c..f68e9baffad7 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -36,6 +36,10 @@ MODULE_VERSION(DRV_MODULE_VERSION);
 #define VDC_TX_RING_SIZE	512
 #define VDC_DEFAULT_BLK_SIZE	512
 
+#define MAX_XFER_BLKS		(128 * 1024)
+#define MAX_XFER_SIZE		(MAX_XFER_BLKS / VDC_DEFAULT_BLK_SIZE)
+#define MAX_RING_COOKIES	((MAX_XFER_BLKS / PAGE_SIZE) + 2)
+
 #define WAITING_FOR_LINK_UP	0x01
 #define WAITING_FOR_TX_SPACE	0x02
 #define WAITING_FOR_GEN_CMD	0x04
@@ -450,7 +454,7 @@ static int __send_request(struct request *req)
 {
 	struct vdc_port *port = req->rq_disk->private_data;
 	struct vio_dring_state *dr = &port->vio.drings[VIO_DRIVER_TX_RING];
-	struct scatterlist sg[port->ring_cookies];
+	struct scatterlist sg[MAX_RING_COOKIES];
 	struct vdc_req_entry *rqe;
 	struct vio_disk_desc *desc;
 	unsigned int map_perm;
@@ -458,6 +462,9 @@ static int __send_request(struct request *req)
 	u64 len;
 	u8 op;
 
+	if (WARN_ON(port->ring_cookies > MAX_RING_COOKIES))
+		return -EINVAL;
+
 	map_perm = LDC_MAP_SHADOW | LDC_MAP_DIRECT | LDC_MAP_IO;
 
 	if (rq_data_dir(req) == READ) {
@@ -984,9 +991,8 @@ static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		goto err_out_free_port;
 
 	port->vdisk_block_size = VDC_DEFAULT_BLK_SIZE;
-	port->max_xfer_size = ((128 * 1024) / port->vdisk_block_size);
-	port->ring_cookies = ((port->max_xfer_size *
-			       port->vdisk_block_size) / PAGE_SIZE) + 2;
+	port->max_xfer_size = MAX_XFER_SIZE;
+	port->ring_cookies = MAX_RING_COOKIES;
 
 	err = vio_ldc_alloc(&port->vio, &vdc_ldc_cfg, port);
 	if (err)
-- 
2.17.1


-- 
Kees Cook
Pixel Security
