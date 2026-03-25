Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD65B329C57
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475205; cv=none; b=CyST6ygKflpValfdlFRCETHHahzrK9M9jvc8y6XMMcmh6d9m8U819Xu10lLhOCPNdxngbStWZUNfdOfJPfaFkgpyfba7+fCQF+FrFhOd0RW8hCVzZayhjyFOwqFQSU+hD/iG638472xvgh04rKGmI2rMGRqy3ui/egGOYwUsQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475205; c=relaxed/simple;
	bh=YJfDkfn9a3bx6acvwy8nPV15rOT8wxkmqaMRfyT0WFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwGpfxSIipDRw+TjweoyyWUQrZpSJ9UPgqljSQoTFXCMbfz06FJNgLrIlyY8Eg/xHsnX2tsiehnyJlGmYCewjiEYeCnIfem2fc6y9YXN7hQff1WeIdRbE2G8+Z7Qim5HhgdLINTPjqO4vBnY1TSWuRROexlgadqdQP0kEx+5two=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yEgMWY+I; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yEgMWY+I"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0q73GWqzlgyGG;
	Wed, 25 Mar 2026 21:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received; s=mr01; t=1774475169; x=
	1777067170; bh=WBKK8+mooV5MliTXV+hcHJC/CSapb8ktND6/zu5B6vU=; b=y
	EgMWY+Id0z6KcrHzu+FgBMBTkiC4oGIbcEnum4w1hkx4HPBsZrRKH6RJmhxR0wO+
	bfkeiP6qJ2L7FIA7n+sKmYw59ygd3tKHE4YieG6ObbekzWaYc5NF6gsNo8oy9zgH
	0teLcnLYJmWUCwgm8UPQWvFXoxnuM9qQrYTEQCryIDw/Bj8HGcGlNSW3KXy4PMcw
	t0EHvDvDhwDEekdS8H2g0pOkI3UtxgA97TeNS8lZ8TWZSLWyhYi6Yyfh29jeP4Lx
	ph0iWGHqq/j4M3DWYPKNyrAYfe8O5Ocmux1eWcepSK3EoCPNn7xkq32XDJPi1D4L
	1p7Wgfp1Rj6XqLGTKf+Og==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id y_TdCr6mRqSe; Wed, 25 Mar 2026 21:46:09 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0pQ709FzlfpMC;
	Wed, 25 Mar 2026 21:46:06 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 16/26] drbd: Make the lock context annotations compatible with Clang
Date: Wed, 25 Mar 2026 14:44:57 -0700
Message-ID: <20260325214518.2854494-17-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Clang performs more strict checking of lock context annotations than
sparse. This patch makes the DRBD lock context annotations compatible
with Clang and enables lock context analysis in the Makefile.

Reviewed-by: Christoph B=C3=B6hmwalder <christoph.boehmwalder@linbit.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/Makefile        |  3 +
 drivers/block/drbd/drbd_bitmap.c   | 26 ++++++---
 drivers/block/drbd/drbd_int.h      | 88 ++++++++++++++++++------------
 drivers/block/drbd/drbd_main.c     | 40 ++++++++++----
 drivers/block/drbd/drbd_nl.c       |  5 +-
 drivers/block/drbd/drbd_receiver.c | 31 ++++++++---
 drivers/block/drbd/drbd_req.c      |  3 +
 drivers/block/drbd/drbd_state.c    |  2 +
 drivers/block/drbd/drbd_state.h    |  4 --
 drivers/block/drbd/drbd_worker.c   |  6 +-
 10 files changed, 138 insertions(+), 70 deletions(-)

diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 67a8b352a1d5..8eaa83a7592b 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+CONTEXT_ANALYSIS :=3D y
+
 drbd-y :=3D drbd_buildtag.o drbd_bitmap.o drbd_proc.o
 drbd-y +=3D drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o
 drbd-y +=3D drbd_main.o drbd_strings.o drbd_nl.o
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_b=
itmap.c
index 65ea6ec66bfd..3c521f0dc9ad 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -122,12 +122,16 @@ static void __bm_print_lock_info(struct drbd_device=
 *device, const char *func)
 }
=20
 void drbd_bm_lock(struct drbd_device *device, char *why, enum bm_flag fl=
ags)
+	__acquires(&device->bitmap->bm_change)
 {
 	struct drbd_bitmap *b =3D device->bitmap;
 	int trylock_failed;
=20
 	if (!b) {
 		drbd_err(device, "FIXME no bitmap in drbd_bm_lock!?\n");
+		/* Fake __acquire() to keep the compiler happy. */
+		__acquire(&b->bm_change);
+		__acquire(drbd_bitmap_lock);
 		return;
 	}
=20
@@ -146,13 +150,18 @@ void drbd_bm_lock(struct drbd_device *device, char =
*why, enum bm_flag flags)
=20
 	b->bm_why  =3D why;
 	b->bm_task =3D current;
+	__acquire(drbd_bitmap_lock);
 }
=20
 void drbd_bm_unlock(struct drbd_device *device)
+	__releases(&device->bitmap->bm_change)
 {
 	struct drbd_bitmap *b =3D device->bitmap;
 	if (!b) {
 		drbd_err(device, "FIXME no bitmap in drbd_bm_unlock!?\n");
+		/* Fake __release() to keep the compiler happy. */
+		__release(&b->bm_change);
+		__release(drbd_bitmap_lock);
 		return;
 	}
=20
@@ -163,6 +172,7 @@ void drbd_bm_unlock(struct drbd_device *device)
 	b->bm_why  =3D NULL;
 	b->bm_task =3D NULL;
 	mutex_unlock(&b->bm_change);
+	__release(drbd_bitmap_lock);
 }
=20
 /* we store some "meta" info about our pages in page->private */
@@ -987,7 +997,7 @@ static inline sector_t drbd_md_last_bitmap_sector(str=
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
@@ -1060,7 +1070,7 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx=
 *ctx, int page_nr) __must_ho
 /*
  * bm_rw: read/write the whole bitmap from/to its on disk location.
  */
-static int bm_rw(struct drbd_device *device, const unsigned int flags, u=
nsigned lazy_writeout_upper_idx) __must_hold(local)
+static int bm_rw(struct drbd_device *device, const unsigned int flags, u=
nsigned lazy_writeout_upper_idx)
 {
 	struct drbd_bm_aio_ctx *ctx;
 	struct drbd_bitmap *b =3D device->bitmap;
@@ -1215,7 +1225,7 @@ static int bm_rw(struct drbd_device *device, const =
unsigned int flags, unsigned
  * @device:	DRBD device.
  */
 int drbd_bm_read(struct drbd_device *device,
-		 struct drbd_peer_device *peer_device) __must_hold(local)
+		 struct drbd_peer_device *peer_device)
=20
 {
 	return bm_rw(device, BM_AIO_READ, 0);
@@ -1228,7 +1238,7 @@ int drbd_bm_read(struct drbd_device *device,
  * Will only write pages that have changed since last IO.
  */
 int drbd_bm_write(struct drbd_device *device,
-		 struct drbd_peer_device *peer_device) __must_hold(local)
+		 struct drbd_peer_device *peer_device)
 {
 	return bm_rw(device, 0, 0);
 }
@@ -1240,7 +1250,7 @@ int drbd_bm_write(struct drbd_device *device,
  * Will write all pages.
  */
 int drbd_bm_write_all(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local)
+		struct drbd_peer_device *peer_device)
 {
 	return bm_rw(device, BM_AIO_WRITE_ALL_PAGES, 0);
 }
@@ -1250,7 +1260,7 @@ int drbd_bm_write_all(struct drbd_device *device,
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
@@ -1267,7 +1277,7 @@ int drbd_bm_write_lazy(struct drbd_device *device, =
unsigned upper_idx) __must_ho
  * pending resync acks are still being processed.
  */
 int drbd_bm_write_copy_pages(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local)
+		struct drbd_peer_device *peer_device)
 {
 	return bm_rw(device, BM_AIO_COPY_PAGES, 0);
 }
@@ -1276,7 +1286,7 @@ int drbd_bm_write_copy_pages(struct drbd_device *de=
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
index f6d6276974ee..46546e6e9f6b 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -193,10 +193,14 @@ struct drbd_device_work {
=20
 #include "drbd_interval.h"
=20
-extern int drbd_wait_misc(struct drbd_device *, struct drbd_interval *);
+/*
+ * Alias for &resources_mutex because &resources_mutex is not visible in=
 this
+ * context.
+ */
+token_context_lock(all_drbd_resources);
=20
-extern void lock_all_resources(void);
-extern void unlock_all_resources(void);
+extern void lock_all_resources(void) __acquires(all_drbd_resources);
+extern void unlock_all_resources(void) __releases(all_drbd_resources);
=20
 struct drbd_request {
 	struct drbd_work w;
@@ -1056,14 +1060,14 @@ extern void conn_md_sync(struct drbd_connection *=
connection);
 extern void drbd_md_write(struct drbd_device *device, void *buffer);
 extern void drbd_md_sync(struct drbd_device *device);
 extern int  drbd_md_read(struct drbd_device *device, struct drbd_backing=
_dev *bdev);
-extern void drbd_uuid_set(struct drbd_device *device, int idx, u64 val) =
__must_hold(local);
-extern void _drbd_uuid_set(struct drbd_device *device, int idx, u64 val)=
 __must_hold(local);
-extern void drbd_uuid_new_current(struct drbd_device *device) __must_hol=
d(local);
-extern void drbd_uuid_set_bm(struct drbd_device *device, u64 val) __must=
_hold(local);
-extern void drbd_uuid_move_history(struct drbd_device *device) __must_ho=
ld(local);
-extern void __drbd_uuid_set(struct drbd_device *device, int idx, u64 val=
) __must_hold(local);
-extern void drbd_md_set_flag(struct drbd_device *device, int flags) __mu=
st_hold(local);
-extern void drbd_md_clear_flag(struct drbd_device *device, int flags)__m=
ust_hold(local);
+extern void drbd_uuid_set(struct drbd_device *device, int idx, u64 val);
+extern void _drbd_uuid_set(struct drbd_device *device, int idx, u64 val)=
;
+extern void drbd_uuid_new_current(struct drbd_device *device);
+extern void drbd_uuid_set_bm(struct drbd_device *device, u64 val);
+extern void drbd_uuid_move_history(struct drbd_device *device);
+extern void __drbd_uuid_set(struct drbd_device *device, int idx, u64 val=
);
+extern void drbd_md_set_flag(struct drbd_device *device, int flags);
+extern void drbd_md_clear_flag(struct drbd_device *device, int flags);
 extern int drbd_md_test_flag(struct drbd_backing_dev *, int);
 extern void drbd_md_mark_dirty(struct drbd_device *device);
 extern void drbd_queue_bitmap_io(struct drbd_device *device,
@@ -1080,9 +1084,15 @@ extern int drbd_bitmap_io_from_worker(struct drbd_=
device *device,
 		char *why, enum bm_flag flags,
 		struct drbd_peer_device *peer_device);
 extern int drbd_bmio_set_n_write(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local);
+		struct drbd_peer_device *peer_device);
 extern int drbd_bmio_clear_n_write(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local);
+		struct drbd_peer_device *peer_device);
+extern enum drbd_state_rv
+_drbd_request_state_holding_state_mutex(struct drbd_device *device, unio=
n drbd_state,
+					union drbd_state, enum chg_state_flags)
+	__must_hold(&device->state_mutex);
+extern int drbd_wait_misc(struct drbd_device *device, struct drbd_interv=
al *)
+	__must_hold(&device->resource->req_lock);
=20
 /* Meta data layout
  *
@@ -1292,17 +1302,17 @@ extern void _drbd_bm_set_bits(struct drbd_device =
*device,
 extern int  drbd_bm_test_bit(struct drbd_device *device, unsigned long b=
itnr);
 extern int  drbd_bm_e_weight(struct drbd_device *device, unsigned long e=
nr);
 extern int  drbd_bm_read(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local);
+		struct drbd_peer_device *peer_device);
 extern void drbd_bm_mark_for_writeout(struct drbd_device *device, int pa=
ge_nr);
 extern int  drbd_bm_write(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local);
-extern void drbd_bm_reset_al_hints(struct drbd_device *device) __must_ho=
ld(local);
-extern int  drbd_bm_write_hinted(struct drbd_device *device) __must_hold=
(local);
-extern int  drbd_bm_write_lazy(struct drbd_device *device, unsigned uppe=
r_idx) __must_hold(local);
+		struct drbd_peer_device *peer_device);
+extern void drbd_bm_reset_al_hints(struct drbd_device *device);
+extern int  drbd_bm_write_hinted(struct drbd_device *device);
+extern int  drbd_bm_write_lazy(struct drbd_device *device, unsigned uppe=
r_idx);
 extern int drbd_bm_write_all(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local);
+		struct drbd_peer_device *peer_device);
 extern int  drbd_bm_write_copy_pages(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local);
+		struct drbd_peer_device *peer_device);
 extern size_t	     drbd_bm_words(struct drbd_device *device);
 extern unsigned long drbd_bm_bits(struct drbd_device *device);
 extern sector_t      drbd_bm_capacity(struct drbd_device *device);
@@ -1321,8 +1331,16 @@ extern void drbd_bm_merge_lel(struct drbd_device *=
device, size_t offset,
 extern void drbd_bm_get_lel(struct drbd_device *device, size_t offset,
 		size_t number, unsigned long *buffer);
=20
-extern void drbd_bm_lock(struct drbd_device *device, char *why, enum bm_=
flag flags);
-extern void drbd_bm_unlock(struct drbd_device *device);
+/*
+ * Alias for &device->bitmap->bm_change because not all type information=
 for
+ * &device->bitmap->bm_change is available in this context.
+ */
+token_context_lock(drbd_bitmap_lock);
+
+extern void drbd_bm_lock(struct drbd_device *device, char *why, enum bm_=
flag flags)
+	__acquires(drbd_bitmap_lock);
+extern void drbd_bm_unlock(struct drbd_device *device)
+	__releases(drbd_bitmap_lock);
 /* drbd_main.c */
=20
 extern struct kmem_cache *drbd_request_cache;
@@ -1389,7 +1407,8 @@ enum determine_dev_size {
 	DS_GREW_FROM_ZERO =3D 3,
 };
 extern enum determine_dev_size
-drbd_determine_dev_size(struct drbd_device *, enum dds_flags, struct res=
ize_parms *) __must_hold(local);
+drbd_determine_dev_size(struct drbd_device *device, enum dds_flags,
+			struct resize_parms *);
 extern void resync_after_online_grow(struct drbd_device *);
 extern void drbd_reconsider_queue_parameters(struct drbd_device *device,
 			struct drbd_backing_dev *bdev, struct o_qlim *o);
@@ -1473,7 +1492,7 @@ extern int drbd_free_peer_reqs(struct drbd_device *=
, struct list_head *);
 extern struct drbd_peer_request *drbd_alloc_peer_req(struct drbd_peer_de=
vice *, u64,
 						     sector_t, unsigned int,
 						     unsigned int,
-						     gfp_t) __must_hold(local);
+						     gfp_t);
 extern void drbd_free_peer_req(struct drbd_device *device, struct drbd_p=
eer_request *req);
 extern struct page *drbd_alloc_pages(struct drbd_peer_device *, unsigned=
 int, bool);
 extern void _drbd_clear_done_ee(struct drbd_device *device, struct list_=
head *to_be_freed);
@@ -1488,7 +1507,6 @@ void drbd_set_my_capacity(struct drbd_device *devic=
e, sector_t size);
 static inline void drbd_submit_bio_noacct(struct drbd_device *device,
 					     int fault_type, struct bio *bio)
 {
-	__release(local);
 	if (!bio->bi_bdev) {
 		drbd_err(device, "drbd_submit_bio_noacct: bio->bi_bdev =3D=3D NULL\n")=
;
 		bio->bi_status =3D BLK_STS_IOERR;
@@ -1839,14 +1857,18 @@ static inline void request_ping(struct drbd_conne=
ction *connection)
 	wake_ack_receiver(connection);
 }
=20
-extern void *conn_prepare_command(struct drbd_connection *, struct drbd_=
socket *);
-extern void *drbd_prepare_command(struct drbd_peer_device *, struct drbd=
_socket *);
-extern int conn_send_command(struct drbd_connection *, struct drbd_socke=
t *,
+extern void *conn_prepare_command(struct drbd_connection *, struct drbd_=
socket *sock)
+	__cond_acquires(nonnull, sock->mutex);
+extern void *drbd_prepare_command(struct drbd_peer_device *, struct drbd=
_socket *sock)
+	__cond_acquires(nonnull, sock->mutex);
+extern int conn_send_command(struct drbd_connection *, struct drbd_socke=
t *sock,
 			     enum drbd_packet, unsigned int, void *,
-			     unsigned int);
-extern int drbd_send_command(struct drbd_peer_device *, struct drbd_sock=
et *,
+			     unsigned int)
+	__releases(sock->mutex);
+extern int drbd_send_command(struct drbd_peer_device *, struct drbd_sock=
et *sock,
 			     enum drbd_packet, unsigned int, void *,
-			     unsigned int);
+			     unsigned int)
+	__releases(sock->mutex);
=20
 extern int drbd_send_ping(struct drbd_connection *connection);
 extern int drbd_send_ping_ack(struct drbd_connection *connection);
@@ -1975,8 +1997,7 @@ static inline bool is_sync_state(enum drbd_conns co=
nnection_state)
  * You have to call put_ldev() when finished working with device->ldev.
  */
 #define get_ldev_if_state(_device, _min_state)				\
-	(_get_ldev_if_state((_device), (_min_state)) ?			\
-	 ({ __acquire(x); true; }) : false)
+	(_get_ldev_if_state((_device), (_min_state)))
 #define get_ldev(_device) get_ldev_if_state(_device, D_INCONSISTENT)
=20
 static inline void put_ldev(struct drbd_device *device)
@@ -1991,7 +2012,6 @@ static inline void put_ldev(struct drbd_device *dev=
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
index 200d464e984b..0bbee2afb7e5 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3282,7 +3282,7 @@ void drbd_md_mark_dirty(struct drbd_device *device)
 		mod_timer(&device->md_sync_timer, jiffies + 5*HZ);
 }
=20
-void drbd_uuid_move_history(struct drbd_device *device) __must_hold(loca=
l)
+void drbd_uuid_move_history(struct drbd_device *device)
 {
 	int i;
=20
@@ -3290,7 +3290,7 @@ void drbd_uuid_move_history(struct drbd_device *dev=
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
@@ -3305,7 +3305,7 @@ void __drbd_uuid_set(struct drbd_device *device, in=
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
@@ -3313,7 +3313,7 @@ void _drbd_uuid_set(struct drbd_device *device, int=
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
@@ -3332,7 +3332,7 @@ void drbd_uuid_set(struct drbd_device *device, int =
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
@@ -3354,7 +3354,7 @@ void drbd_uuid_new_current(struct drbd_device *devi=
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
@@ -3387,7 +3387,7 @@ void drbd_uuid_set_bm(struct drbd_device *device, u=
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
@@ -3414,7 +3414,7 @@ int drbd_bmio_set_n_write(struct drbd_device *devic=
e,
  * Clears all bits in the bitmap and writes the whole bitmap to stable s=
torage.
  */
 int drbd_bmio_clear_n_write(struct drbd_device *device,
-			  struct drbd_peer_device *peer_device) __must_hold(local)
+			  struct drbd_peer_device *peer_device)
=20
 {
 	drbd_resume_al(device);
@@ -3541,7 +3541,7 @@ int drbd_bitmap_io(struct drbd_device *device,
 	return rv;
 }
=20
-void drbd_md_set_flag(struct drbd_device *device, int flag) __must_hold(=
local)
+void drbd_md_set_flag(struct drbd_device *device, int flag)
 {
 	if ((device->ldev->md.flags & flag) !=3D flag) {
 		drbd_md_mark_dirty(device);
@@ -3549,7 +3549,7 @@ void drbd_md_set_flag(struct drbd_device *device, i=
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
@@ -3678,24 +3678,44 @@ int drbd_wait_misc(struct drbd_device *device, st=
ruct drbd_interval *i)
 }
=20
 void lock_all_resources(void)
+	__acquires(all_drbd_resources)
+	__acquires(&resources_mutex)
 {
 	struct drbd_resource *resource;
 	int __maybe_unused i =3D 0;
=20
 	mutex_lock(&resources_mutex);
 	local_irq_disable();
+	/*
+	 * context_unsafe() because the thread-safety analyzer does not support
+	 * locking inside loops.
+	 */
+	context_unsafe(
 	for_each_resource(resource, &drbd_resources)
 		spin_lock_nested(&resource->req_lock, i++);
+	);
+
+	__acquire(all_drbd_resources);
 }
=20
 void unlock_all_resources(void)
+	__releases(all_drbd_resources)
+	__releases(&resources_mutex)
 {
 	struct drbd_resource *resource;
=20
+	/*
+	 * context_unsafe() because the thread-safety analyzer does not support
+	 * locking inside loops.
+	 */
+	context_unsafe(
 	for_each_resource(resource, &drbd_resources)
 		spin_unlock(&resource->req_lock);
+	);
 	local_irq_enable();
 	mutex_unlock(&resources_mutex);
+
+	__release(all_drbd_resources);
 }
=20
 #ifdef CONFIG_DRBD_FAULT_INJECTION
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 1f8ffdf9b24e..67dec3403edc 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -993,7 +993,7 @@ void drbd_resume_io(struct drbd_device *device)
  * You should call drbd_md_sync() after calling this function.
  */
 enum determine_dev_size
-drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags=
, struct resize_parms *rs) __must_hold(local)
+drbd_determine_dev_size(struct drbd_device *device, enum dds_flags flags=
, struct resize_parms *rs)
 {
 	struct md_offsets_and_sizes {
 		u64 last_agreed_sect;
@@ -3090,7 +3090,7 @@ static int drbd_adm_simple_request_state(struct sk_=
buff *skb, struct genl_info *
 }
=20
 static int drbd_bmio_set_susp_al(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local)
+		struct drbd_peer_device *peer_device)
 {
 	int rv;
=20
@@ -3518,6 +3518,7 @@ int drbd_adm_dump_connections_done(struct netlink_c=
allback *cb)
 enum { SINGLE_RESOURCE, ITERATE_RESOURCES };
=20
 int drbd_adm_dump_connections(struct sk_buff *skb, struct netlink_callba=
ck *cb)
+	__no_context_analysis /* too complex for Clang */
 {
 	struct nlattr *resource_filter;
 	struct drbd_resource *resource =3D NULL, *next_resource;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd=
_receiver.c
index 58b95bf4bdca..b0ef6c5470f8 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -175,7 +175,7 @@ You must not have the req_lock:
  * trim: payload_size =3D=3D 0 */
 struct drbd_peer_request *
 drbd_alloc_peer_req(struct drbd_peer_device *peer_device, u64 id, sector=
_t sector,
-		    unsigned int request_size, unsigned int payload_size, gfp_t gfp_ma=
sk) __must_hold(local)
+		    unsigned int request_size, unsigned int payload_size, gfp_t gfp_ma=
sk)
 {
 	struct drbd_device *device =3D peer_device->device;
 	struct drbd_peer_request *peer_req;
@@ -287,6 +287,7 @@ static int drbd_finish_peer_reqs(struct drbd_device *=
device)
=20
 static void _drbd_wait_ee_list_empty(struct drbd_device *device,
 				     struct list_head *head)
+	__must_hold(&device->resource->req_lock)
 {
 	DEFINE_WAIT(wait);
=20
@@ -896,6 +897,11 @@ static int conn_connect(struct drbd_connection *conn=
ection)
 	if (drbd_send_protocol(connection) =3D=3D -EOPNOTSUPP)
 		return -1;
=20
+	/*
+	 * context_unsafe() because the thread-safety analyzer does not support
+	 * locking inside loops.
+	 */
+	context_unsafe(
 	/* Prevent a race between resync-handshake and
 	 * being promoted to Primary.
 	 *
@@ -905,14 +911,21 @@ static int conn_connect(struct drbd_connection *con=
nection)
 	 */
 	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
 		mutex_lock(peer_device->device->state_mutex);
+	);
=20
 	/* avoid a race with conn_request_state( C_DISCONNECTING ) */
 	spin_lock_irq(&connection->resource->req_lock);
 	set_bit(STATE_SENT, &connection->flags);
 	spin_unlock_irq(&connection->resource->req_lock);
=20
+	/*
+	 * context_unsafe() because the thread-safety analyzer does not support
+	 * locking inside loops.
+	 */
+	context_unsafe(
 	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
 		mutex_unlock(peer_device->device->state_mutex);
+	);
=20
 	rcu_read_lock();
 	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
@@ -1657,7 +1670,7 @@ static void drbd_csum_ee_size(struct crypto_shash *=
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
@@ -1869,7 +1882,7 @@ static int e_end_resync_block(struct drbd_work *w, =
int unused)
 }
=20
 static int recv_resync_read(struct drbd_peer_device *peer_device, sector=
_t sector,
-			    struct packet_info *pi) __releases(local)
+			    struct packet_info *pi)
 {
 	struct drbd_device *device =3D peer_device->device;
 	struct drbd_peer_request *peer_req;
@@ -2230,6 +2243,7 @@ static blk_opf_t wire_flags_to_bio(struct drbd_conn=
ection *connection, u32 dpf)
=20
 static void fail_postponed_requests(struct drbd_device *device, sector_t=
 sector,
 				    unsigned int size)
+	__must_hold(&device->resource->req_lock)
 {
 	struct drbd_peer_device *peer_device =3D first_peer_device(device);
 	struct drbd_interval *i;
@@ -2256,6 +2270,7 @@ static void fail_postponed_requests(struct drbd_dev=
ice *device, sector_t sector,
=20
 static int handle_write_conflicts(struct drbd_device *device,
 				  struct drbd_peer_request *peer_req)
+	__must_hold(&device->resource->req_lock)
 {
 	struct drbd_connection *connection =3D peer_req->peer_device->connectio=
n;
 	bool resolve_conflicts =3D test_bit(RESOLVE_CONFLICTS, &connection->fla=
gs);
@@ -2826,7 +2841,7 @@ static int receive_DataRequest(struct drbd_connecti=
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
@@ -2909,7 +2924,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_dev=
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
@@ -2966,7 +2981,7 @@ static int drbd_asb_recover_1p(struct drbd_peer_dev=
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
@@ -3044,7 +3059,7 @@ static void drbd_uuid_dump(struct drbd_device *devi=
ce, char *text, u64 *uuid,
  */
=20
 static int drbd_uuid_compare(struct drbd_peer_device *const peer_device,
-		enum drbd_role const peer_role, int *rule_nr) __must_hold(local)
+		enum drbd_role const peer_role, int *rule_nr)
 {
 	struct drbd_connection *const connection =3D peer_device->connection;
 	struct drbd_device *device =3D peer_device->device;
@@ -3264,7 +3279,7 @@ static int drbd_uuid_compare(struct drbd_peer_devic=
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
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.=
c
index 70f75ef07945..a758d0f66e3f 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -952,6 +952,7 @@ static bool remote_due_to_read_balancing(struct drbd_=
device *device, sector_t se
  * Only way out: remove the conflicting intervals from the tree.
  */
 static void complete_conflicting_writes(struct drbd_request *req)
+	__must_hold(&req->device->resource->req_lock)
 {
 	DEFINE_WAIT(wait);
 	struct drbd_device *device =3D req->device;
@@ -1325,6 +1326,8 @@ static void drbd_send_and_submit(struct drbd_device=
 *device, struct drbd_request
 	bool submit_private_bio =3D false;
=20
 	spin_lock_irq(&resource->req_lock);
+	/* Tell the compiler that &resource->req_lock =3D=3D &req->device->reso=
urce->req_lock. */
+	__assume_ctx_lock(&req->device->resource->req_lock);
 	if (rw =3D=3D WRITE) {
 		/* This may temporarily give up the req_lock,
 		 * but will re-aquire it before it returns here.
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_st=
ate.c
index adcba7f1d8ea..1c18d9f81e03 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -562,6 +562,7 @@ _req_st_cond(struct drbd_device *device, union drbd_s=
tate mask,
 static enum drbd_state_rv
 drbd_req_state(struct drbd_device *device, union drbd_state mask,
 	       union drbd_state val, enum chg_state_flags f)
+	__no_context_analysis /* conditional locking */
 {
 	struct completion done;
 	unsigned long flags;
@@ -2292,6 +2293,7 @@ _conn_rq_cond(struct drbd_connection *connection, u=
nion drbd_state mask, union d
 enum drbd_state_rv
 _conn_request_state(struct drbd_connection *connection, union drbd_state=
 mask, union drbd_state val,
 		    enum chg_state_flags flags)
+	__no_context_analysis /* conditional locking */
 {
 	enum drbd_state_rv rv =3D SS_SUCCESS;
 	struct after_conn_state_chg_work *acscw;
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_st=
ate.h
index cbaeb8018dbf..e6fded8b14ee 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -123,10 +123,6 @@ extern enum drbd_state_rv _drbd_request_state(struct=
 drbd_device *,
 					      union drbd_state,
 					      enum chg_state_flags);
=20
-extern enum drbd_state_rv
-_drbd_request_state_holding_state_mutex(struct drbd_device *, union drbd=
_state,
-					union drbd_state, enum chg_state_flags);
-
 extern enum drbd_state_rv _drbd_set_state(struct drbd_device *, union dr=
bd_state,
 					  enum chg_state_flags,
 					  struct completion *done);
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
