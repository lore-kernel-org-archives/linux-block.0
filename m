Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2EB2DCF41
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632984; cv=none; b=Db4eANy4nCMNIK/7CFZl7ND2PqYpS57HxwxW0HOupTfiQ5ZyBheybouxOoEpJLhuU1hgG76sXAF1/kPHubvdCx1xpXYR8fZmhQOodpWe799mZ5mm98oM9V4ZpbWlLLSlnjCkjJ3a5m0H6XDJb2enm69rgsJCJ/id+RJQ9bpyvxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632984; c=relaxed/simple;
	bh=pHQQDHAj17F+AD53Crjl0BKhIJxpbX0m05FQDygh7E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/ek9JgJEX/W0YCeUo4un/aJT3BGP45/oaEls8mR3T2KqF1gcIXxtkQ/Ow0rvd+huFjJ9ZUm9m+awu/Vlby/5AUlU1VvGhtWlVCEN/sw4Uuv5JvY8atnUvK5gB0fisXXlxETBA+JP0epN5GfCZC8Uw5rjfK+fQSUye9G6Z4aRrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=W9LyXzyz; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="W9LyXzyz"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gx7ZG3b2TzlhH01;
	Thu,  9 Jul 2026 21:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1783632962; x=1786224963; bh=A9SF3
	BiD95xewfBBzl/roHVt+p+AYgND0Fxc3/WUeY4=; b=W9LyXzyzcO7Bv35M/dsti
	3XT8LKA6/QRugsNPA7nGMEOvHAhWjfLhKUtM9c0K2Q4EGuoUAoEgd81bkTixoOLD
	09JUFraK3GzMghScTT/7S6Hs8xpWywKm8lxa9pltgF4FHKqLYDqq3+iY8aZMxcUv
	hXMFauvlKnt0KFNCQpc6x+hEIqMMX8lYZ2H7MiyZm1vrQdTd2KhooQyiFAtIiaZv
	vkpJxb23EJtLEYuPhmaE0WHGEU1hEKXoMCANZjTIawCUVARLWpWBB1MVBrvPaxNn
	LtbN++9hEBolo3d9Mjxv4EPfckxGb9xREHxlEa+Ryuafq9guThRzPu6dmwFc3wpN
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id FujmWevoMYEb; Thu,  9 Jul 2026 21:36:02 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gx7Yq62T6zlhH05;
	Thu,  9 Jul 2026 21:35:59 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	=?UTF-8?q?Cc=20=3A=20Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 04/12] drbd: Remove the 'local' lock context
Date: Thu,  9 Jul 2026 14:35:25 -0700
Message-ID: <02cd83b7e2fac54b6bdfe53f2e012048b65c1d3e.1783632330.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <cover.1783632330.git.bvanassche@acm.org>
References: <cover.1783632330.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 'local' lock context represents code sections between get_ldev() and
put_ldev() calls. Between these two calls the device->ldev pointer is
valid. Since there are multiple functions with unpaired get_ldev() /
put_ldev() calls, remove this lock context.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_bitmap.c   | 17 +++++-----
 drivers/block/drbd/drbd_int.h      | 50 ++++++++++++------------------
 drivers/block/drbd/drbd_main.c     | 20 ++++++------
 drivers/block/drbd/drbd_nl.c       |  7 +++--
 drivers/block/drbd/drbd_receiver.c | 21 +++++++------
 drivers/block/drbd/drbd_worker.c   |  6 ++--
 6 files changed, 55 insertions(+), 66 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_b=
itmap.c
index 65ea6ec66bfd..1c68f1774e28 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -987,7 +987,7 @@ static inline sector_t drbd_md_last_bitmap_sector(str=
uct drbd_backing_dev *bdev)
 	}
 }
=20
-static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) _=
_must_hold(local)
+static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr)
 {
 	struct drbd_device *device =3D ctx->device;
 	enum req_op op =3D ctx->flags & BM_AIO_READ ? REQ_OP_READ : REQ_OP_WRIT=
E;
@@ -1060,7 +1060,8 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx=
 *ctx, int page_nr) __must_ho
 /*
  * bm_rw: read/write the whole bitmap from/to its on disk location.
  */
-static int bm_rw(struct drbd_device *device, const unsigned int flags, u=
nsigned lazy_writeout_upper_idx) __must_hold(local)
+static int bm_rw(struct drbd_device *device, const unsigned int flags,
+		 unsigned lazy_writeout_upper_idx)
 {
 	struct drbd_bm_aio_ctx *ctx;
 	struct drbd_bitmap *b =3D device->bitmap;
@@ -1215,7 +1216,7 @@ static int bm_rw(struct drbd_device *device, const =
unsigned int flags, unsigned
  * @device:	DRBD device.
  */
 int drbd_bm_read(struct drbd_device *device,
-		 struct drbd_peer_device *peer_device) __must_hold(local)
+		 struct drbd_peer_device *peer_device)
=20
 {
 	return bm_rw(device, BM_AIO_READ, 0);
@@ -1228,7 +1229,7 @@ int drbd_bm_read(struct drbd_device *device,
  * Will only write pages that have changed since last IO.
  */
 int drbd_bm_write(struct drbd_device *device,
-		 struct drbd_peer_device *peer_device) __must_hold(local)
+		  struct drbd_peer_device *peer_device)
 {
 	return bm_rw(device, 0, 0);
 }
@@ -1240,7 +1241,7 @@ int drbd_bm_write(struct drbd_device *device,
  * Will write all pages.
  */
 int drbd_bm_write_all(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local)
+		      struct drbd_peer_device *peer_device)
 {
 	return bm_rw(device, BM_AIO_WRITE_ALL_PAGES, 0);
 }
@@ -1250,7 +1251,7 @@ int drbd_bm_write_all(struct drbd_device *device,
  * @device:	DRBD device.
  * @upper_idx:	0: write all changed pages; +ve: page index to stop scann=
ing for changed pages
  */
-int drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx) _=
_must_hold(local)
+int drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx)
 {
 	return bm_rw(device, BM_AIO_COPY_PAGES, upper_idx);
 }
@@ -1267,7 +1268,7 @@ int drbd_bm_write_lazy(struct drbd_device *device, =
unsigned upper_idx) __must_ho
  * pending resync acks are still being processed.
  */
 int drbd_bm_write_copy_pages(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local)
+			     struct drbd_peer_device *peer_device)
 {
 	return bm_rw(device, BM_AIO_COPY_PAGES, 0);
 }
@@ -1276,7 +1277,7 @@ int drbd_bm_write_copy_pages(struct drbd_device *de=
vice,
  * drbd_bm_write_hinted() - Write bitmap pages with "hint" marks, if the=
y have changed.
  * @device:	DRBD device.
  */
-int drbd_bm_write_hinted(struct drbd_device *device) __must_hold(local)
+int drbd_bm_write_hinted(struct drbd_device *device)
 {
 	return bm_rw(device, BM_AIO_WRITE_HINTED | BM_AIO_COPY_PAGES, 0);
 }
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.=
h
index 49383c309865..4b9d69adb9d4 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1064,18 +1064,14 @@ void conn_md_sync(struct drbd_connection *connect=
ion);
 void drbd_md_write(struct drbd_device *device, void *buffer);
 void drbd_md_sync(struct drbd_device *device);
 int drbd_md_read(struct drbd_device *device, struct drbd_backing_dev *bd=
ev);
-void drbd_uuid_set(struct drbd_device *device, int idx, u64 val)
-	__must_hold(local);
-void _drbd_uuid_set(struct drbd_device *device, int idx, u64 val)
-	__must_hold(local);
-void drbd_uuid_new_current(struct drbd_device *device) __must_hold(local=
);
-void drbd_uuid_set_bm(struct drbd_device *device, u64 val) __must_hold(l=
ocal);
-void drbd_uuid_move_history(struct drbd_device *device) __must_hold(loca=
l);
-void __drbd_uuid_set(struct drbd_device *device, int idx, u64 val)
-	__must_hold(local);
-void drbd_md_set_flag(struct drbd_device *device, int flags) __must_hold=
(local);
-void drbd_md_clear_flag(struct drbd_device *device, int flags)
-	__must_hold(local);
+void drbd_uuid_set(struct drbd_device *device, int idx, u64 val);
+void _drbd_uuid_set(struct drbd_device *device, int idx, u64 val);
+void drbd_uuid_new_current(struct drbd_device *device);
+void drbd_uuid_set_bm(struct drbd_device *device, u64 val);
+void drbd_uuid_move_history(struct drbd_device *device);
+void __drbd_uuid_set(struct drbd_device *device, int idx, u64 val);
+void drbd_md_set_flag(struct drbd_device *device, int flags);
+void drbd_md_clear_flag(struct drbd_device *device, int flags);
 int drbd_md_test_flag(struct drbd_backing_dev *, int);
 void drbd_md_mark_dirty(struct drbd_device *device);
 void drbd_queue_bitmap_io(struct drbd_device *device,
@@ -1095,11 +1091,9 @@ int drbd_bitmap_io_from_worker(struct drbd_device =
*device,
 			       char *why, enum bm_flag flags,
 			       struct drbd_peer_device *peer_device);
 int drbd_bmio_set_n_write(struct drbd_device *device,
-			  struct drbd_peer_device *peer_device)
-	__must_hold(local);
+			  struct drbd_peer_device *peer_device);
 int drbd_bmio_clear_n_write(struct drbd_device *device,
-			    struct drbd_peer_device *peer_device)
-	__must_hold(local);
+			    struct drbd_peer_device *peer_device);
=20
 /* Meta data layout
  *
@@ -1310,19 +1304,17 @@ void _drbd_bm_set_bits(struct drbd_device *device=
, const unsigned long s,
 int drbd_bm_test_bit(struct drbd_device *device, unsigned long bitnr);
 int drbd_bm_e_weight(struct drbd_device *device, unsigned long enr);
 int drbd_bm_read(struct drbd_device *device,
-		 struct drbd_peer_device *peer_device) __must_hold(local);
+		 struct drbd_peer_device *peer_device);
 void drbd_bm_mark_for_writeout(struct drbd_device *device, int page_nr);
 int drbd_bm_write(struct drbd_device *device,
-		  struct drbd_peer_device *peer_device) __must_hold(local);
-void drbd_bm_reset_al_hints(struct drbd_device *device) __must_hold(loca=
l);
-int drbd_bm_write_hinted(struct drbd_device *device) __must_hold(local);
-int drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx)
-	__must_hold(local);
+		  struct drbd_peer_device *peer_device);
+void drbd_bm_reset_al_hints(struct drbd_device *device);
+int drbd_bm_write_hinted(struct drbd_device *device);
+int drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx);
 int drbd_bm_write_all(struct drbd_device *device,
-		      struct drbd_peer_device *peer_device) __must_hold(local);
+		      struct drbd_peer_device *peer_device);
 int drbd_bm_write_copy_pages(struct drbd_device *device,
-			     struct drbd_peer_device *peer_device)
-	__must_hold(local);
+			     struct drbd_peer_device *peer_device);
 size_t drbd_bm_words(struct drbd_device *device);
 unsigned long drbd_bm_bits(struct drbd_device *device);
 sector_t drbd_bm_capacity(struct drbd_device *device);
@@ -1417,8 +1409,7 @@ enum determine_dev_size {
 };
 enum determine_dev_size drbd_determine_dev_size(struct drbd_device *,
 						enum dds_flags,
-						struct resize_parms *)
-	__must_hold(local);
+						struct resize_parms *);
 void resync_after_online_grow(struct drbd_device *);
 void drbd_reconsider_queue_parameters(struct drbd_device *device,
 				      struct drbd_backing_dev *bdev,
@@ -1502,8 +1493,7 @@ int drbd_submit_peer_request(struct drbd_peer_reque=
st *peer_req);
 int drbd_free_peer_reqs(struct drbd_device *, struct list_head *);
 struct drbd_peer_request *drbd_alloc_peer_req(struct drbd_peer_device *,=
 u64,
 					      sector_t, unsigned int,
-					      unsigned int, gfp_t)
-	__must_hold(local);
+					      unsigned int, gfp_t);
 void drbd_free_peer_req(struct drbd_device *device,
 			struct drbd_peer_request *req);
 struct page *drbd_alloc_pages(struct drbd_peer_device *, unsigned int, b=
ool);
@@ -1520,7 +1510,6 @@ void drbd_set_my_capacity(struct drbd_device *devic=
e, sector_t size);
 static inline void drbd_submit_bio_noacct(struct drbd_device *device,
 					     int fault_type, struct bio *bio)
 {
-	__release(local);
 	if (!bio->bi_bdev) {
 		drbd_err(device, "drbd_submit_bio_noacct: bio->bi_bdev =3D=3D NULL\n")=
;
 		bio->bi_status =3D BLK_STS_IOERR;
@@ -2016,7 +2005,6 @@ static inline void put_ldev(struct drbd_device *dev=
ice)
 	/* This may be called from some endio handler,
 	 * so we must not sleep here. */
=20
-	__release(local);
 	D_ASSERT(device, i >=3D 0);
 	if (i =3D=3D 0) {
 		if (disk_state =3D=3D D_DISKLESS)
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_mai=
n.c
index dbf6e413db03..d9eb95aa5c44 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3263,7 +3263,7 @@ void drbd_md_mark_dirty(struct drbd_device *device)
 		mod_timer(&device->md_sync_timer, jiffies + 5*HZ);
 }
=20
-void drbd_uuid_move_history(struct drbd_device *device) __must_hold(loca=
l)
+void drbd_uuid_move_history(struct drbd_device *device)
 {
 	int i;
=20
@@ -3271,7 +3271,7 @@ void drbd_uuid_move_history(struct drbd_device *dev=
ice) __must_hold(local)
 		device->ldev->md.uuid[i+1] =3D device->ldev->md.uuid[i];
 }
=20
-void __drbd_uuid_set(struct drbd_device *device, int idx, u64 val) __mus=
t_hold(local)
+void __drbd_uuid_set(struct drbd_device *device, int idx, u64 val)
 {
 	if (idx =3D=3D UI_CURRENT) {
 		if (device->state.role =3D=3D R_PRIMARY)
@@ -3286,7 +3286,7 @@ void __drbd_uuid_set(struct drbd_device *device, in=
t idx, u64 val) __must_hold(l
 	drbd_md_mark_dirty(device);
 }
=20
-void _drbd_uuid_set(struct drbd_device *device, int idx, u64 val) __must=
_hold(local)
+void _drbd_uuid_set(struct drbd_device *device, int idx, u64 val)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
@@ -3294,7 +3294,7 @@ void _drbd_uuid_set(struct drbd_device *device, int=
 idx, u64 val) __must_hold(lo
 	spin_unlock_irqrestore(&device->ldev->md.uuid_lock, flags);
 }
=20
-void drbd_uuid_set(struct drbd_device *device, int idx, u64 val) __must_=
hold(local)
+void drbd_uuid_set(struct drbd_device *device, int idx, u64 val)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
@@ -3313,7 +3313,7 @@ void drbd_uuid_set(struct drbd_device *device, int =
idx, u64 val) __must_hold(loc
  * Creates a new current UUID, and rotates the old current UUID into
  * the bitmap slot. Causes an incremental resync upon next connect.
  */
-void drbd_uuid_new_current(struct drbd_device *device) __must_hold(local=
)
+void drbd_uuid_new_current(struct drbd_device *device)
 {
 	u64 val;
 	unsigned long long bm_uuid;
@@ -3335,7 +3335,7 @@ void drbd_uuid_new_current(struct drbd_device *devi=
ce) __must_hold(local)
 	drbd_md_sync(device);
 }
=20
-void drbd_uuid_set_bm(struct drbd_device *device, u64 val) __must_hold(l=
ocal)
+void drbd_uuid_set_bm(struct drbd_device *device, u64 val)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
@@ -3368,7 +3368,7 @@ void drbd_uuid_set_bm(struct drbd_device *device, u=
64 val) __must_hold(local)
  * Sets all bits in the bitmap and writes the whole bitmap to stable sto=
rage.
  */
 int drbd_bmio_set_n_write(struct drbd_device *device,
-			  struct drbd_peer_device *peer_device) __must_hold(local)
+			  struct drbd_peer_device *peer_device)
=20
 {
 	int rv =3D -EIO;
@@ -3395,7 +3395,7 @@ int drbd_bmio_set_n_write(struct drbd_device *devic=
e,
  * Clears all bits in the bitmap and writes the whole bitmap to stable s=
torage.
  */
 int drbd_bmio_clear_n_write(struct drbd_device *device,
-			  struct drbd_peer_device *peer_device) __must_hold(local)
+			    struct drbd_peer_device *peer_device)
=20
 {
 	drbd_resume_al(device);
@@ -3522,7 +3522,7 @@ int drbd_bitmap_io(struct drbd_device *device,
 	return rv;
 }
=20
-void drbd_md_set_flag(struct drbd_device *device, int flag) __must_hold(=
local)
+void drbd_md_set_flag(struct drbd_device *device, int flag)
 {
 	if ((device->ldev->md.flags & flag) !=3D flag) {
 		drbd_md_mark_dirty(device);
@@ -3530,7 +3530,7 @@ void drbd_md_set_flag(struct drbd_device *device, i=
nt flag) __must_hold(local)
 	}
 }
=20
-void drbd_md_clear_flag(struct drbd_device *device, int flag) __must_hol=
d(local)
+void drbd_md_clear_flag(struct drbd_device *device, int flag)
 {
 	if ((device->ldev->md.flags & flag) !=3D 0) {
 		drbd_md_mark_dirty(device);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index f9ffcd67607b..c44b92856da3 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -968,8 +968,9 @@ void drbd_resume_io(struct drbd_device *device)
  * Returns 0 on success, negative return values indicate errors.
  * You should call drbd_md_sync() after calling this function.
  */
-enum determine_dev_size
-drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags=
, struct resize_parms *rs) __must_hold(local)
+enum determine_dev_size drbd_determine_dev_size(struct drbd_device *devi=
ce,
+						enum dds_flags flags,
+						struct resize_parms *rs)
 {
 	struct md_offsets_and_sizes {
 		u64 last_agreed_sect;
@@ -3097,7 +3098,7 @@ static int drbd_adm_simple_request_state(struct sk_=
buff *skb, struct genl_info *
 }
=20
 static int drbd_bmio_set_susp_al(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local)
+				 struct drbd_peer_device *peer_device)
 {
 	int rv;
=20
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd=
_receiver.c
index 58b95bf4bdca..4e04ff2dc65d 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -174,8 +174,9 @@ You must not have the req_lock:
  * w_same: payload_size =3D=3D logical_block_size
  * trim: payload_size =3D=3D 0 */
 struct drbd_peer_request *
-drbd_alloc_peer_req(struct drbd_peer_device *peer_device, u64 id, sector=
_t sector,
-		    unsigned int request_size, unsigned int payload_size, gfp_t gfp_ma=
sk) __must_hold(local)
+drbd_alloc_peer_req(struct drbd_peer_device *peer_device, u64 id,
+		    sector_t sector, unsigned int request_size,
+		    unsigned int payload_size, gfp_t gfp_mask)
 {
 	struct drbd_device *device =3D peer_device->device;
 	struct drbd_peer_request *peer_req;
@@ -1657,7 +1658,7 @@ static void drbd_csum_ee_size(struct crypto_shash *=
h,
  */
 static struct drbd_peer_request *
 read_in_block(struct drbd_peer_device *peer_device, u64 id, sector_t sec=
tor,
-	      struct packet_info *pi) __must_hold(local)
+	      struct packet_info *pi)
 {
 	struct drbd_device *device =3D peer_device->device;
 	const sector_t capacity =3D get_capacity(device->vdisk);
@@ -1868,8 +1869,8 @@ static int e_end_resync_block(struct drbd_work *w, =
int unused)
 	return err;
 }
=20
-static int recv_resync_read(struct drbd_peer_device *peer_device, sector=
_t sector,
-			    struct packet_info *pi) __releases(local)
+static int recv_resync_read(struct drbd_peer_device *peer_device,
+			    sector_t sector, struct packet_info *pi)
 {
 	struct drbd_device *device =3D peer_device->device;
 	struct drbd_peer_request *peer_req;
@@ -2826,7 +2827,7 @@ static int receive_DataRequest(struct drbd_connecti=
on *connection, struct packet
 /*
  * drbd_asb_recover_0p  -  Recover after split-brain with no remaining p=
rimaries
  */
-static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __m=
ust_hold(local)
+static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device)
 {
 	struct drbd_device *device =3D peer_device->device;
 	int self, peer, rv =3D -100;
@@ -2909,7 +2910,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_dev=
ice *peer_device) __must_hold
 /*
  * drbd_asb_recover_1p  -  Recover after split-brain with one remaining =
primary
  */
-static int drbd_asb_recover_1p(struct drbd_peer_device *peer_device) __m=
ust_hold(local)
+static int drbd_asb_recover_1p(struct drbd_peer_device *peer_device)
 {
 	struct drbd_device *device =3D peer_device->device;
 	int hg, rv =3D -100;
@@ -2966,7 +2967,7 @@ static int drbd_asb_recover_1p(struct drbd_peer_dev=
ice *peer_device) __must_hold
 /*
  * drbd_asb_recover_2p  -  Recover after split-brain with two remaining =
primaries
  */
-static int drbd_asb_recover_2p(struct drbd_peer_device *peer_device) __m=
ust_hold(local)
+static int drbd_asb_recover_2p(struct drbd_peer_device *peer_device)
 {
 	struct drbd_device *device =3D peer_device->device;
 	int hg, rv =3D -100;
@@ -3044,7 +3045,7 @@ static void drbd_uuid_dump(struct drbd_device *devi=
ce, char *text, u64 *uuid,
  */
=20
 static int drbd_uuid_compare(struct drbd_peer_device *const peer_device,
-		enum drbd_role const peer_role, int *rule_nr) __must_hold(local)
+			     enum drbd_role const peer_role, int *rule_nr)
 {
 	struct drbd_connection *const connection =3D peer_device->connection;
 	struct drbd_device *device =3D peer_device->device;
@@ -3264,7 +3265,7 @@ static int drbd_uuid_compare(struct drbd_peer_devic=
e *const peer_device,
  */
 static enum drbd_conns drbd_sync_handshake(struct drbd_peer_device *peer=
_device,
 					   enum drbd_role peer_role,
-					   enum drbd_disk_state peer_disk) __must_hold(local)
+					   enum drbd_disk_state peer_disk)
 {
 	struct drbd_device *device =3D peer_device->device;
 	enum drbd_conns rv =3D C_MASK;
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_w=
orker.c
index 0697f99fed18..6fec59bbf0e9 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -78,7 +78,7 @@ void drbd_md_endio(struct bio *bio)
 /* reads on behalf of the partner,
  * "submitted" by the receiver
  */
-static void drbd_endio_read_sec_final(struct drbd_peer_request *peer_req=
) __releases(local)
+static void drbd_endio_read_sec_final(struct drbd_peer_request *peer_req=
)
 {
 	unsigned long flags =3D 0;
 	struct drbd_peer_device *peer_device =3D peer_req->peer_device;
@@ -99,7 +99,7 @@ static void drbd_endio_read_sec_final(struct drbd_peer_=
request *peer_req) __rele
=20
 /* writes on behalf of the partner, or resync writes,
  * "submitted" by the receiver, final stage.  */
-void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req) __re=
leases(local)
+void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req)
 {
 	unsigned long flags =3D 0;
 	struct drbd_peer_device *peer_device =3D peer_req->peer_device;
@@ -1923,10 +1923,8 @@ static void drbd_ldev_destroy(struct drbd_device *=
device)
 	lc_destroy(device->act_log);
 	device->act_log =3D NULL;
=20
-	__acquire(local);
 	drbd_backing_dev_free(device, device->ldev);
 	device->ldev =3D NULL;
-	__release(local);
=20
 	clear_bit(GOING_DISKLESS, &device->flags);
 	wake_up(&device->misc_wait);
