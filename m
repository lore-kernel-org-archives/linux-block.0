Return-Path: <gustavo@embeddedor.com>
Date: Fri, 30 Mar 2018 14:17:59 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>,
	Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] rbd: remove VLA usage
Message-ID: <20180330191759.GA18176@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

In preparation to enabling -Wvla, remove the use of stack VLA.

In this particular case, variable buf_size is replaced with a constant
expression that can be computed at preprocessing time. This avoids two
VLA warnings. Also, as a consequence of the mentioned change, some code
was slightly refactored.

The use of stack Variable Length Arrays needs to be avoided, as they
can be a vector for stack exhaustion, which can be both a runtime bug
or a security flaw. Also, in general, as code evolves it is easy to
lose track of how big a VLA can get. Thus, we can end up having runtime
failures that are hard to debug.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/rbd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1e03b04..5133122 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3091,20 +3091,20 @@ static int __rbd_notify_op_lock(struct rbd_device *rbd_dev,
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_client_id cid = rbd_get_cid(rbd_dev);
-	int buf_size = 4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN;
-	char buf[buf_size];
+	char buf[4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN];
 	void *p = buf;
 
 	dout("%s rbd_dev %p notify_op %d\n", __func__, rbd_dev, notify_op);
 
 	/* encode *LockPayload NotifyMessage (op + ClientId) */
-	ceph_start_encoding(&p, 2, 1, buf_size - CEPH_ENCODING_START_BLK_LEN);
+	ceph_start_encoding(&p, 2, 1,
+			    sizeof(buf) - CEPH_ENCODING_START_BLK_LEN);
 	ceph_encode_32(&p, notify_op);
 	ceph_encode_64(&p, cid.gid);
 	ceph_encode_64(&p, cid.handle);
 
 	return ceph_osdc_notify(osdc, &rbd_dev->header_oid,
-				&rbd_dev->header_oloc, buf, buf_size,
+				&rbd_dev->header_oloc, buf, sizeof(buf),
 				RBD_NOTIFY_TIMEOUT, preply_pages, preply_len);
 }
 
@@ -3610,19 +3610,18 @@ static void __rbd_acknowledge_notify(struct rbd_device *rbd_dev,
 				     u64 notify_id, u64 cookie, s32 *result)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
-	int buf_size = 4 + CEPH_ENCODING_START_BLK_LEN;
-	char buf[buf_size];
+	char buf[4 + CEPH_ENCODING_START_BLK_LEN];
+	int buf_size = 0;
 	int ret;
 
 	if (result) {
 		void *p = buf;
 
+		buf_size = sizeof(buf);
 		/* encode ResponseMessage */
 		ceph_start_encoding(&p, 1, 1,
 				    buf_size - CEPH_ENCODING_START_BLK_LEN);
 		ceph_encode_32(&p, *result);
-	} else {
-		buf_size = 0;
 	}
 
 	ret = ceph_osdc_notify_ack(osdc, &rbd_dev->header_oid,
-- 
2.7.4
