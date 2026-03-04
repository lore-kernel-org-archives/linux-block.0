Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B2838645C
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653798; cv=none; b=hJtMG0v8wZAcYFR4E51tTHjD29Dt+6Q1n5pnKAyRKT7PkoJFuzLk8MBOGsYcGsTB8rvaV2wxgZXhZuQ2s84/5UcdfHNYGtL87OJXVD84I1luJ2nPyQM/4oZHkSSSdnZpBDJU9qY88vWHeaWc8bHUu2gBOUmzhBwtEp8ljY1hujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653798; c=relaxed/simple;
	bh=VR6eG54OV70OqlxjRfj5ejU0ycCjf/vmjppdtG2go3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5uSUrzSAPfTqkP/Zx8hIosNvssKegLf2mtFM9lQ7UydYzKXhDvFLUlDVsrz3+duf1OEwxkz5ywlB/O6M9o8lYNtVPF2MweiwI7kb3TkaSPigvAYWFUgV9kWGoROcq9GklVVSr4CnrrZh3f7sAyltdAMiKjuMBkiKbZEWIi+7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NRqufPg6; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NRqufPg6"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR3D42Xtgz1XLyhG;
	Wed,  4 Mar 2026 19:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1772653755; x=1775245756; bh=ow0zp
	m5KDY3B++RWtSd3p1+2PAt2r2Ld880ibCNNAxg=; b=NRqufPg6uxp4UYkzi1xSm
	mTvNW68ykVs4hgH/8MZgrHMANnJlXt5teEoTR4U82b0qqkuASKwHazzZb+xdcJZW
	i71nyl4Ge9oG1+rD3MdiT4LkkWUwOd+IVAF+rvDRhOD3UCW/DM39FV53zd2U7PJq
	8tNNvWzGeLRYf46JLgZsLzjNy25IT2unUE/yYB4Sr4Y+sMljyh7FXp9CebuIH3+P
	OmS+3IPpQTRIb7CZpC7sc4APU8U5sodaBAc3Kx/etpXAxKGhTSOoUq/0JwDOMNLR
	N8rAh/8rsQLwRuRbWoRvSkVZnmAsu3QYqxG6RuWZsdRtbUamylK5eo8w8VHYAwom
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MmpXoBvLc1uh; Wed,  4 Mar 2026 19:49:15 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR3CF1b0Mz1XMFjq;
	Wed,  4 Mar 2026 19:49:12 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 05/14] drbd: Make the lock context annotations compatible with Clang
Date: Wed,  4 Mar 2026 11:48:24 -0800
Message-ID: <20260304194843.760669-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260304194843.760669-1-bvanassche@acm.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Clang performs more strict checking of lock context annotations than
sparse. This patch makes the DRBD lock context annotations compatible
with Clang and prepares for enabling lock context analysis.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_bitmap.c   | 20 +++++++------
 drivers/block/drbd/drbd_int.h      | 46 ++++++++++++++----------------
 drivers/block/drbd/drbd_main.c     | 45 ++++++++++++++++++++++-------
 drivers/block/drbd/drbd_nl.c       |  5 ++--
 drivers/block/drbd/drbd_receiver.c | 20 +++++++------
 drivers/block/drbd/drbd_req.c      |  2 ++
 drivers/block/drbd/drbd_state.c    |  3 ++
 drivers/block/drbd/drbd_worker.c   |  6 ++--
 8 files changed, 91 insertions(+), 56 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_b=
itmap.c
index 65ea6ec66bfd..eeeeba9840ea 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -122,12 +122,14 @@ static void __bm_print_lock_info(struct drbd_device=
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
+		__acquire(&b->bm_change);
 		return;
 	}
=20
@@ -149,10 +151,12 @@ void drbd_bm_lock(struct drbd_device *device, char =
*why, enum bm_flag flags)
 }
=20
 void drbd_bm_unlock(struct drbd_device *device)
+	__releases(&device->bitmap->bm_change)
 {
 	struct drbd_bitmap *b =3D device->bitmap;
 	if (!b) {
 		drbd_err(device, "FIXME no bitmap in drbd_bm_unlock!?\n");
+		__release(&b->bm_change);
 		return;
 	}
=20
@@ -987,7 +991,7 @@ static inline sector_t drbd_md_last_bitmap_sector(str=
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
@@ -1060,7 +1064,7 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx=
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
@@ -1215,7 +1219,7 @@ static int bm_rw(struct drbd_device *device, const =
unsigned int flags, unsigned
  * @device:	DRBD device.
  */
 int drbd_bm_read(struct drbd_device *device,
-		 struct drbd_peer_device *peer_device) __must_hold(local)
+		 struct drbd_peer_device *peer_device)
=20
 {
 	return bm_rw(device, BM_AIO_READ, 0);
@@ -1228,7 +1232,7 @@ int drbd_bm_read(struct drbd_device *device,
  * Will only write pages that have changed since last IO.
  */
 int drbd_bm_write(struct drbd_device *device,
-		 struct drbd_peer_device *peer_device) __must_hold(local)
+		 struct drbd_peer_device *peer_device)
 {
 	return bm_rw(device, 0, 0);
 }
@@ -1240,7 +1244,7 @@ int drbd_bm_write(struct drbd_device *device,
  * Will write all pages.
  */
 int drbd_bm_write_all(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local)
+		struct drbd_peer_device *peer_device)
 {
 	return bm_rw(device, BM_AIO_WRITE_ALL_PAGES, 0);
 }
@@ -1250,7 +1254,7 @@ int drbd_bm_write_all(struct drbd_device *device,
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
@@ -1267,7 +1271,7 @@ int drbd_bm_write_lazy(struct drbd_device *device, =
unsigned upper_idx) __must_ho
  * pending resync acks are still being processed.
  */
 int drbd_bm_write_copy_pages(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local)
+		struct drbd_peer_device *peer_device)
 {
 	return bm_rw(device, BM_AIO_COPY_PAGES, 0);
 }
@@ -1276,7 +1280,7 @@ int drbd_bm_write_copy_pages(struct drbd_device *de=
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
index f6d6276974ee..fea8e870781e 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1056,14 +1056,14 @@ extern void conn_md_sync(struct drbd_connection *=
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
@@ -1080,9 +1080,9 @@ extern int drbd_bitmap_io_from_worker(struct drbd_d=
evice *device,
 		char *why, enum bm_flag flags,
 		struct drbd_peer_device *peer_device);
 extern int drbd_bmio_set_n_write(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local);
+		struct drbd_peer_device *peer_device);
 extern int drbd_bmio_clear_n_write(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local);
+		struct drbd_peer_device *peer_device);
=20
 /* Meta data layout
  *
@@ -1292,17 +1292,17 @@ extern void _drbd_bm_set_bits(struct drbd_device =
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
@@ -1389,7 +1389,8 @@ enum determine_dev_size {
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
@@ -1470,10 +1471,10 @@ extern bool drbd_rs_should_slow_down(struct drbd_=
peer_device *peer_device, secto
 		bool throttle_if_app_is_waiting);
 extern int drbd_submit_peer_request(struct drbd_peer_request *peer_req);
 extern int drbd_free_peer_reqs(struct drbd_device *, struct list_head *)=
;
-extern struct drbd_peer_request *drbd_alloc_peer_req(struct drbd_peer_de=
vice *, u64,
+extern struct drbd_peer_request *drbd_alloc_peer_req(struct drbd_peer_de=
vice *device, u64,
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
@@ -1488,7 +1489,6 @@ void drbd_set_my_capacity(struct drbd_device *devic=
e, sector_t size);
 static inline void drbd_submit_bio_noacct(struct drbd_device *device,
 					     int fault_type, struct bio *bio)
 {
-	__release(local);
 	if (!bio->bi_bdev) {
 		drbd_err(device, "drbd_submit_bio_noacct: bio->bi_bdev =3D=3D NULL\n")=
;
 		bio->bi_status =3D BLK_STS_IOERR;
@@ -1975,8 +1975,7 @@ static inline bool is_sync_state(enum drbd_conns co=
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
@@ -1991,7 +1990,6 @@ static inline void put_ldev(struct drbd_device *dev=
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
index 200d464e984b..c014a89e224c 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -589,6 +589,7 @@ static void *__conn_prepare_command(struct drbd_conne=
ction *connection,
 }
=20
 void *conn_prepare_command(struct drbd_connection *connection, struct dr=
bd_socket *sock)
+	__cond_acquires(true, sock->mutex)
 {
 	void *p;
=20
@@ -601,6 +602,7 @@ void *conn_prepare_command(struct drbd_connection *co=
nnection, struct drbd_socke
 }
=20
 void *drbd_prepare_command(struct drbd_peer_device *peer_device, struct =
drbd_socket *sock)
+	__cond_acquires(true, sock->mutex)
 {
 	return conn_prepare_command(peer_device->connection, sock);
 }
@@ -646,6 +648,7 @@ static int __conn_send_command(struct drbd_connection=
 *connection, struct drbd_s
 int conn_send_command(struct drbd_connection *connection, struct drbd_so=
cket *sock,
 		      enum drbd_packet cmd, unsigned int header_size,
 		      void *data, unsigned int size)
+	__releases(sock->mutex)
 {
 	int err;
=20
@@ -657,6 +660,7 @@ int conn_send_command(struct drbd_connection *connect=
ion, struct drbd_socket *so
 int drbd_send_command(struct drbd_peer_device *peer_device, struct drbd_=
socket *sock,
 		      enum drbd_packet cmd, unsigned int header_size,
 		      void *data, unsigned int size)
+	__releases(sock->mutex)
 {
 	int err;
=20
@@ -667,6 +671,7 @@ int drbd_send_command(struct drbd_peer_device *peer_d=
evice, struct drbd_socket *
 }
=20
 int drbd_send_ping(struct drbd_connection *connection)
+	__cond_acquires(true, connection->meta.mutex)
 {
 	struct drbd_socket *sock;
=20
@@ -677,6 +682,7 @@ int drbd_send_ping(struct drbd_connection *connection=
)
 }
=20
 int drbd_send_ping_ack(struct drbd_connection *connection)
+	__cond_acquires(true, connection->meta.mutex)
 {
 	struct drbd_socket *sock;
=20
@@ -687,6 +693,7 @@ int drbd_send_ping_ack(struct drbd_connection *connec=
tion)
 }
=20
 int drbd_send_sync_param(struct drbd_peer_device *peer_device)
+	__cond_acquires(true, peer_device->connection->data.mutex)
 {
 	struct drbd_socket *sock;
 	struct p_rs_param_95 *p;
@@ -800,6 +807,7 @@ int drbd_send_protocol(struct drbd_connection *connec=
tion)
 }
=20
 static int _drbd_send_uuids(struct drbd_peer_device *peer_device, u64 uu=
id_flags)
+	__cond_acquires(true, peer_device->connection->data.mutex)
 {
 	struct drbd_device *device =3D peer_device->device;
 	struct drbd_socket *sock;
@@ -862,6 +870,7 @@ void drbd_print_uuids(struct drbd_device *device, con=
st char *text)
 }
=20
 void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *peer_device)
+	__cond_acquires(true, peer_device->connection->data.mutex)
 {
 	struct drbd_device *device =3D peer_device->device;
 	struct drbd_socket *sock;
@@ -888,6 +897,7 @@ void drbd_gen_and_send_sync_uuid(struct drbd_peer_dev=
ice *peer_device)
 }
=20
 int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_re=
ply, enum dds_flags flags)
+	__cond_acquires(true, peer_device->connection->data.mutex)
 {
 	struct drbd_device *device =3D peer_device->device;
 	struct drbd_socket *sock;
@@ -969,6 +979,7 @@ int drbd_send_sizes(struct drbd_peer_device *peer_dev=
ice, int trigger_reply, enu
  * @peer_device:	DRBD peer device.
  */
 int drbd_send_current_state(struct drbd_peer_device *peer_device)
+	__cond_acquires(true, peer_device->connection->data.mutex)
 {
 	struct drbd_socket *sock;
 	struct p_state *p;
@@ -992,6 +1003,7 @@ int drbd_send_current_state(struct drbd_peer_device =
*peer_device)
  * want to send each intermediary state in the order it occurred.
  */
 int drbd_send_state(struct drbd_peer_device *peer_device, union drbd_sta=
te state)
+	__cond_acquires(true, peer_device->connection->data.mutex)
 {
 	struct drbd_socket *sock;
 	struct p_state *p;
@@ -1005,6 +1017,7 @@ int drbd_send_state(struct drbd_peer_device *peer_d=
evice, union drbd_state state
 }
=20
 int drbd_send_state_req(struct drbd_peer_device *peer_device, union drbd=
_state mask, union drbd_state val)
+	__cond_acquires(true, peer_device->connection->data.mutex)
 {
 	struct drbd_socket *sock;
 	struct p_req_state *p;
@@ -1019,6 +1032,7 @@ int drbd_send_state_req(struct drbd_peer_device *pe=
er_device, union drbd_state m
 }
=20
 int conn_send_state_req(struct drbd_connection *connection, union drbd_s=
tate mask, union drbd_state val)
+	__cond_acquires(true, connection->data.mutex)
 {
 	enum drbd_packet cmd;
 	struct drbd_socket *sock;
@@ -1035,6 +1049,7 @@ int conn_send_state_req(struct drbd_connection *con=
nection, union drbd_state mas
 }
=20
 void drbd_send_sr_reply(struct drbd_peer_device *peer_device, enum drbd_=
state_rv retcode)
+	__cond_acquires(true, peer_device->connection->data.mutex)
 {
 	struct drbd_socket *sock;
 	struct p_req_state_reply *p;
@@ -1048,6 +1063,7 @@ void drbd_send_sr_reply(struct drbd_peer_device *pe=
er_device, enum drbd_state_rv
 }
=20
 void conn_send_sr_reply(struct drbd_connection *connection, enum drbd_st=
ate_rv retcode)
+	__cond_acquires(true, connection->data.mutex)
 {
 	struct drbd_socket *sock;
 	struct p_req_state_reply *p;
@@ -1381,6 +1397,7 @@ int drbd_send_ack_ex(struct drbd_peer_device *peer_=
device, enum drbd_packet cmd,
=20
 int drbd_send_rs_deallocated(struct drbd_peer_device *peer_device,
 			     struct drbd_peer_request *peer_req)
+	__cond_acquires(true, peer_device->connection->data.mutex)
 {
 	struct drbd_socket *sock;
 	struct p_block_desc *p;
@@ -1397,6 +1414,7 @@ int drbd_send_rs_deallocated(struct drbd_peer_devic=
e *peer_device,
=20
 int drbd_send_drequest(struct drbd_peer_device *peer_device, int cmd,
 		       sector_t sector, int size, u64 block_id)
+	__cond_acquires(true, peer_device->connection->data.mutex)
 {
 	struct drbd_socket *sock;
 	struct p_block_req *p;
@@ -1413,6 +1431,7 @@ int drbd_send_drequest(struct drbd_peer_device *pee=
r_device, int cmd,
=20
 int drbd_send_drequest_csum(struct drbd_peer_device *peer_device, sector=
_t sector, int size,
 			    void *digest, int digest_size, enum drbd_packet cmd)
+	__cond_acquires(true, peer_device->connection->data.mutex)
 {
 	struct drbd_socket *sock;
 	struct p_block_req *p;
@@ -1430,6 +1449,7 @@ int drbd_send_drequest_csum(struct drbd_peer_device=
 *peer_device, sector_t secto
 }
=20
 int drbd_send_ov_request(struct drbd_peer_device *peer_device, sector_t =
sector, int size)
+	__cond_acquires(true, peer_device->connection->data.mutex)
 {
 	struct drbd_socket *sock;
 	struct p_block_req *p;
@@ -3282,7 +3302,7 @@ void drbd_md_mark_dirty(struct drbd_device *device)
 		mod_timer(&device->md_sync_timer, jiffies + 5*HZ);
 }
=20
-void drbd_uuid_move_history(struct drbd_device *device) __must_hold(loca=
l)
+void drbd_uuid_move_history(struct drbd_device *device)
 {
 	int i;
=20
@@ -3290,7 +3310,7 @@ void drbd_uuid_move_history(struct drbd_device *dev=
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
@@ -3305,7 +3325,7 @@ void __drbd_uuid_set(struct drbd_device *device, in=
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
@@ -3313,7 +3333,7 @@ void _drbd_uuid_set(struct drbd_device *device, int=
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
@@ -3332,7 +3352,7 @@ void drbd_uuid_set(struct drbd_device *device, int =
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
@@ -3354,7 +3374,7 @@ void drbd_uuid_new_current(struct drbd_device *devi=
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
@@ -3387,7 +3407,7 @@ void drbd_uuid_set_bm(struct drbd_device *device, u=
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
@@ -3414,7 +3434,7 @@ int drbd_bmio_set_n_write(struct drbd_device *devic=
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
@@ -3541,7 +3561,7 @@ int drbd_bitmap_io(struct drbd_device *device,
 	return rv;
 }
=20
-void drbd_md_set_flag(struct drbd_device *device, int flag) __must_hold(=
local)
+void drbd_md_set_flag(struct drbd_device *device, int flag)
 {
 	if ((device->ldev->md.flags & flag) !=3D flag) {
 		drbd_md_mark_dirty(device);
@@ -3549,7 +3569,7 @@ void drbd_md_set_flag(struct drbd_device *device, i=
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
@@ -3649,6 +3669,7 @@ const char *cmdname(enum drbd_packet cmd)
  *		struct drbd_peer_request
  */
 int drbd_wait_misc(struct drbd_device *device, struct drbd_interval *i)
+	__must_hold(&device->resource->req_lock)
 {
 	struct net_conf *nc;
 	DEFINE_WAIT(wait);
@@ -3678,6 +3699,8 @@ int drbd_wait_misc(struct drbd_device *device, stru=
ct drbd_interval *i)
 }
=20
 void lock_all_resources(void)
+	__acquires(&resources_mutex)
+	__no_context_analysis /* locking loop */
 {
 	struct drbd_resource *resource;
 	int __maybe_unused i =3D 0;
@@ -3689,6 +3712,8 @@ void lock_all_resources(void)
 }
=20
 void unlock_all_resources(void)
+	__releases(&resources_mutex)
+	__no_context_analysis /* unlock loop */
 {
 	struct drbd_resource *resource;
=20
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 728ecc431b38..cf505b31d040 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -927,7 +927,7 @@ void drbd_resume_io(struct drbd_device *device)
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
@@ -3025,7 +3025,7 @@ static int drbd_adm_simple_request_state(struct sk_=
buff *skb, struct genl_info *
 }
=20
 static int drbd_bmio_set_susp_al(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local)
+		struct drbd_peer_device *peer_device)
 {
 	int rv;
=20
@@ -3453,6 +3453,7 @@ int drbd_adm_dump_connections_done(struct netlink_c=
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
index 58b95bf4bdca..9c49b977bc22 100644
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
@@ -733,6 +734,7 @@ int drbd_connected(struct drbd_peer_device *peer_devi=
ce)
  *  -2 We do not have a network config...
  */
 static int conn_connect(struct drbd_connection *connection)
+	__no_context_analysis /* conditional locking */
 {
 	struct drbd_socket sock, msock;
 	struct drbd_peer_device *peer_device;
@@ -1657,7 +1659,7 @@ static void drbd_csum_ee_size(struct crypto_shash *=
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
@@ -1869,7 +1871,7 @@ static int e_end_resync_block(struct drbd_work *w, =
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
@@ -2230,6 +2232,7 @@ static blk_opf_t wire_flags_to_bio(struct drbd_conn=
ection *connection, u32 dpf)
=20
 static void fail_postponed_requests(struct drbd_device *device, sector_t=
 sector,
 				    unsigned int size)
+	__must_hold(&device->resource->req_lock)
 {
 	struct drbd_peer_device *peer_device =3D first_peer_device(device);
 	struct drbd_interval *i;
@@ -2256,6 +2259,7 @@ static void fail_postponed_requests(struct drbd_dev=
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
@@ -2826,7 +2830,7 @@ static int receive_DataRequest(struct drbd_connecti=
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
@@ -2909,7 +2913,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_dev=
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
@@ -2966,7 +2970,7 @@ static int drbd_asb_recover_1p(struct drbd_peer_dev=
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
@@ -3044,7 +3048,7 @@ static void drbd_uuid_dump(struct drbd_device *devi=
ce, char *text, u64 *uuid,
  */
=20
 static int drbd_uuid_compare(struct drbd_peer_device *const peer_device,
-		enum drbd_role const peer_role, int *rule_nr) __must_hold(local)
+		enum drbd_role const peer_role, int *rule_nr)
 {
 	struct drbd_connection *const connection =3D peer_device->connection;
 	struct drbd_device *device =3D peer_device->device;
@@ -3264,7 +3268,7 @@ static int drbd_uuid_compare(struct drbd_peer_devic=
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
index 70f75ef07945..ca7e511e83a6 100644
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
@@ -1325,6 +1326,7 @@ static void drbd_send_and_submit(struct drbd_device=
 *device, struct drbd_request
 	bool submit_private_bio =3D false;
=20
 	spin_lock_irq(&resource->req_lock);
+	__assume_ctx_lock(&req->device->resource->req_lock);
 	if (rw =3D=3D WRITE) {
 		/* This may temporarily give up the req_lock,
 		 * but will re-aquire it before it returns here.
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_st=
ate.c
index adcba7f1d8ea..2ab7208cce59 100644
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
@@ -699,6 +700,7 @@ int drbd_request_detach_interruptible(struct drbd_dev=
ice *device)
 enum drbd_state_rv
 _drbd_request_state_holding_state_mutex(struct drbd_device *device, unio=
n drbd_state mask,
 		    union drbd_state val, enum chg_state_flags f)
+	__must_hold(&device->state_mutex)
 {
 	enum drbd_state_rv rv;
=20
@@ -2292,6 +2294,7 @@ _conn_rq_cond(struct drbd_connection *connection, u=
nion drbd_state mask, union d
 enum drbd_state_rv
 _conn_request_state(struct drbd_connection *connection, union drbd_state=
 mask, union drbd_state val,
 		    enum chg_state_flags flags)
+	__no_context_analysis /* conditional locking */
 {
 	enum drbd_state_rv rv =3D SS_SUCCESS;
 	struct after_conn_state_chg_work *acscw;
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
