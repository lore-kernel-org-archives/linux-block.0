Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Yan Zheng <zyan@redhat.com>,
	Sage Weil <sage@redhat.com>
Cc: y2038@lists.linaro.org,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Alex Elder <elder@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	"David S. Miller" <davem@davemloft.net>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 4/5] ceph: use timespec64 for r_mtime
Date: Fri, 13 Jul 2018 22:18:37 +0200
Message-Id: <20180713201923.3200799-4-arnd@arndb.de>
In-Reply-To: <20180713201923.3200799-1-arnd@arndb.de>
References: <20180713201923.3200799-1-arnd@arndb.de>
List-ID: <linux-block@vger.kernel.org>

The request mtime field is used all over ceph, and is currently
represented as a 'timespec' structure in Linux. This changes it to
timespec64 to allow times beyond 2038, modifying all users at the
same time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: undo an unneeded change pointed out by Yan Zheng.
---
 drivers/block/rbd.c             |  2 +-
 fs/ceph/addr.c                  | 12 ++++++------
 fs/ceph/file.c                  |  8 ++++----
 include/linux/ceph/osd_client.h |  6 +++---
 net/ceph/osd_client.c           |  8 ++++----
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d81c653b9bf6..a9a11fe484e5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1452,7 +1452,7 @@ static void rbd_osd_req_format_write(struct rbd_obj_request *obj_request)
 	struct ceph_osd_request *osd_req = obj_request->osd_req;
 
 	osd_req->r_flags = CEPH_OSD_FLAG_WRITE;
-	ktime_get_real_ts(&osd_req->r_mtime);
+	ktime_get_real_ts64(&osd_req->r_mtime);
 	osd_req->r_data_offset = obj_request->ex.oe_off;
 }
 
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 292b3d72d725..d44d51e69e76 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -574,7 +574,7 @@ static u64 get_writepages_data_length(struct inode *inode,
  */
 static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 {
-	struct timespec ts;
+	struct timespec64 ts;
 	struct inode *inode;
 	struct ceph_inode_info *ci;
 	struct ceph_fs_client *fsc;
@@ -625,7 +625,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		set_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
 
 	set_page_writeback(page);
-	ts = timespec64_to_timespec(inode->i_mtime);
+	ts = inode->i_mtime;
 	err = ceph_osdc_writepages(&fsc->client->osdc, ceph_vino(inode),
 				   &ci->i_layout, snapc, page_off, len,
 				   ceph_wbc.truncate_seq,
@@ -1134,7 +1134,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			pages = NULL;
 		}
 
-		req->r_mtime = timespec64_to_timespec(inode->i_mtime);
+		req->r_mtime = inode->i_mtime;
 		rc = ceph_osdc_start_request(&fsc->client->osdc, req, true);
 		BUG_ON(rc);
 		req = NULL;
@@ -1734,7 +1734,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 		goto out;
 	}
 
-	req->r_mtime = timespec64_to_timespec(inode->i_mtime);
+	req->r_mtime = inode->i_mtime;
 	err = ceph_osdc_start_request(&fsc->client->osdc, req, false);
 	if (!err)
 		err = ceph_osdc_wait_request(&fsc->client->osdc, req);
@@ -1776,7 +1776,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 			goto out_put;
 	}
 
-	req->r_mtime = timespec64_to_timespec(inode->i_mtime);
+	req->r_mtime = inode->i_mtime;
 	err = ceph_osdc_start_request(&fsc->client->osdc, req, false);
 	if (!err)
 		err = ceph_osdc_wait_request(&fsc->client->osdc, req);
@@ -1937,7 +1937,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 				     0, false, true);
 	err = ceph_osdc_start_request(&fsc->client->osdc, rd_req, false);
 
-	wr_req->r_mtime = timespec64_to_timespec(ci->vfs_inode.i_mtime);
+	wr_req->r_mtime = ci->vfs_inode.i_mtime;
 	err2 = ceph_osdc_start_request(&fsc->client->osdc, wr_req, false);
 
 	if (!err)
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index e2679e8a2535..732d14726e80 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -720,7 +720,7 @@ struct ceph_aio_request {
 	struct list_head osd_reqs;
 	unsigned num_reqs;
 	atomic_t pending_reqs;
-	struct timespec mtime;
+	struct timespec64 mtime;
 	struct ceph_cap_flush *prealloc_cf;
 };
 
@@ -922,7 +922,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	int num_pages = 0;
 	int flags;
 	int ret;
-	struct timespec mtime = timespec64_to_timespec(current_time(inode));
+	struct timespec64 mtime = current_time(inode);
 	size_t count = iov_iter_count(iter);
 	loff_t pos = iocb->ki_pos;
 	bool write = iov_iter_rw(iter) == WRITE;
@@ -1130,7 +1130,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	int flags;
 	int ret;
 	bool check_caps = false;
-	struct timespec mtime = timespec64_to_timespec(current_time(inode));
+	struct timespec64 mtime = current_time(inode);
 	size_t count = iov_iter_count(from);
 
 	if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
@@ -1662,7 +1662,7 @@ static int ceph_zero_partial_object(struct inode *inode,
 		goto out;
 	}
 
-	req->r_mtime = timespec64_to_timespec(inode->i_mtime);
+	req->r_mtime = inode->i_mtime;
 	ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
 	if (!ret) {
 		ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 0d6ee04b4c41..2e6611c1e9a0 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -199,7 +199,7 @@ struct ceph_osd_request {
 	/* set by submitter */
 	u64 r_snapid;                         /* for reads, CEPH_NOSNAP o/w */
 	struct ceph_snap_context *r_snapc;    /* for writes */
-	struct timespec r_mtime;              /* ditto */
+	struct timespec64 r_mtime;            /* ditto */
 	u64 r_data_offset;                    /* ditto */
 	bool r_linger;                        /* don't resend on failure */
 
@@ -253,7 +253,7 @@ struct ceph_osd_linger_request {
 	struct ceph_osd_request_target t;
 	u32 map_dne_bound;
 
-	struct timespec mtime;
+	struct timespec64 mtime;
 
 	struct kref kref;
 	struct mutex lock;
@@ -508,7 +508,7 @@ extern int ceph_osdc_writepages(struct ceph_osd_client *osdc,
 				struct ceph_snap_context *sc,
 				u64 off, u64 len,
 				u32 truncate_seq, u64 truncate_size,
-				struct timespec *mtime,
+				struct timespec64 *mtime,
 				struct page **pages, int nr_pages);
 
 /* watch/notify */
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a00c74f1154e..a87a021ca9d0 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1978,7 +1978,7 @@ static void encode_request_partial(struct ceph_osd_request *req,
 	p += sizeof(struct ceph_blkin_trace_info);
 
 	ceph_encode_32(&p, 0); /* client_inc, always 0 */
-	ceph_encode_timespec(p, &req->r_mtime);
+	ceph_encode_timespec64(p, &req->r_mtime);
 	p += sizeof(struct ceph_timespec);
 
 	encode_oloc(&p, end, &req->r_t.target_oloc);
@@ -4512,7 +4512,7 @@ ceph_osdc_watch(struct ceph_osd_client *osdc,
 	ceph_oid_copy(&lreq->t.base_oid, oid);
 	ceph_oloc_copy(&lreq->t.base_oloc, oloc);
 	lreq->t.flags = CEPH_OSD_FLAG_WRITE;
-	ktime_get_real_ts(&lreq->mtime);
+	ktime_get_real_ts64(&lreq->mtime);
 
 	lreq->reg_req = alloc_linger_request(lreq);
 	if (!lreq->reg_req) {
@@ -4570,7 +4570,7 @@ int ceph_osdc_unwatch(struct ceph_osd_client *osdc,
 	ceph_oid_copy(&req->r_base_oid, &lreq->t.base_oid);
 	ceph_oloc_copy(&req->r_base_oloc, &lreq->t.base_oloc);
 	req->r_flags = CEPH_OSD_FLAG_WRITE;
-	ktime_get_real_ts(&req->r_mtime);
+	ktime_get_real_ts64(&req->r_mtime);
 	osd_req_op_watch_init(req, 0, lreq->linger_id,
 			      CEPH_OSD_WATCH_OP_UNWATCH);
 
@@ -5136,7 +5136,7 @@ int ceph_osdc_writepages(struct ceph_osd_client *osdc, struct ceph_vino vino,
 			 struct ceph_snap_context *snapc,
 			 u64 off, u64 len,
 			 u32 truncate_seq, u64 truncate_size,
-			 struct timespec *mtime,
+			 struct timespec64 *mtime,
 			 struct page **pages, int num_pages)
 {
 	struct ceph_osd_request *req;
-- 
2.9.0
