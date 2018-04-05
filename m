Return-Path: <zhangweiping@didichuxing.com>
Date: Thu, 5 Apr 2018 18:10:33 +0800
From: Weiping Zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <cohuck@redhat.com>, <mst@redhat.com>,
	<jasowang@redhat.com>
CC: <linux-block@vger.kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [RFC PATCH 2/2] virtio_blk: add new module parameter to set max
 request size
Message-ID: <7bdaaeb8fb56acb4ace1987b6819868c73350cbe.1522922101.git.zhangweiping@didichuxing.com>
References: <cover.1522922101.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1522922101.git.zhangweiping@didichuxing.com>
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

Actually there is no upper limitation, so add new module parameter
to provide a way to set a proper max request size for virtio block.
Using a larger request size can improve sequence performance in theory,
and reduce the interaction between guest and hypervisor.

Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>
---
 drivers/block/virtio_blk.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 4a07593c..5ac6d59 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -64,6 +64,34 @@ struct virtblk_req {
 	struct scatterlist sg[];
 };
 
+
+static int max_request_size_set(const char *val, const struct kernel_param *kp);
+
+static const struct kernel_param_ops max_request_size_ops = {
+	.set = max_request_size_set,
+	.get = param_get_uint,
+};
+
+static unsigned long max_request_size = 4096; /* in unit of KiB */
+module_param_cb(max_request_size, &max_request_size_ops, &max_request_size,
+		0444);
+MODULE_PARM_DESC(max_request_size, "set max request size, in unit of KiB");
+
+static int max_request_size_set(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+	unsigned int size_kb, page_kb = 1 << (PAGE_SHIFT - 10);
+
+	ret = kstrtouint(val, 10, &size_kb);
+	if (ret != 0)
+		return -EINVAL;
+
+	if (size_kb < page_kb)
+		return -EINVAL;
+
+	return param_set_uint(val, kp);
+}
+
 static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
 {
 	switch (vbr->status) {
@@ -730,8 +758,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 	/* We can handle whatever the host told us to handle. */
 	blk_queue_max_segments(q, vblk->sg_elems-2);
 
-	/* No real sector limit. */
-	blk_queue_max_hw_sectors(q, -1U);
+	/* No real sector limit, use 512b (max_request_size << 10) >> 9 */
+	blk_queue_max_hw_sectors_no_limit(q, max_request_size << 1);
 
 	/* Host can optionally specify maximum segment size and number of
 	 * segments. */
-- 
2.9.4
