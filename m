Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8504499AB
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632997; cv=none; b=c1NzzIXNVpDHVKdsTuJjqOleO3SBClR5Ogha+fPkptAkebSz0bJa0z7g8hXnzEeiXL/A/3lPPZWSlkGqZ9bkcTGVuaVIIf14J6MPemioxE8o9y3Zpv6Jv1U3rQcGw30cgM0ZGLvipTkv2Pq6evTbyzqVyjHmoBU9Wexiyr0qq7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632997; c=relaxed/simple;
	bh=UEIUbZN1BM3PQFtQART1SZA8mYZryYhyE5LHLXD0bY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ry1UxAt8YpKvxMkle5F+muPvLPApxAlSB5pv80hTrmuMt/UC8EtOCpScEIPxVrtQPXPHrc4nPeifu7rsORmqc+ZEaiG3s3S3kehtpIVDlZlOl7nnWzpi/QW+wtPLaBSGJr/ULZMNWnMgrJGAlHfacviRXbt0Cz1tniJCCvm4Lvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=iw+kJCkS; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="iw+kJCkS"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gx7ZV5lYHzlhH07;
	Thu,  9 Jul 2026 21:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1783632952; x=1786224953; bh=9ohmt
	JX2656tgrkUOA95jbUZ5YCaSq+fcx/UeEhgnCI=; b=iw+kJCkS0/a+l+3ctt8+u
	zx5j/EZIX8oid1sK8iuiXk5NRHhQ+6IZ8ldfomhJS+ZOjOM79XczpapuBX3FcvhE
	6hfTzaJXl7s6TbncGegN+6rHRPxsTML5O/gwPUJ6n5eHK2jsobyekSU61zHyWvqy
	4ebUgZDN4MizQYJQ+bLQBlBW5KY/Hf77Xo0Vyip4Jc1J/VLm6v1VDa5k+MiSBGvt
	OQTleyyzFzm7TKWwPRvOFBSlU9AwqvKgfs31X+hs/yqnA3MyHAAVW8RGamms9pNF
	zQqsmdMFXAps3+HodnuMeWftGBp8dSvSfz3cL8fwSpd342S8rcbxhtg87uCi07hJ
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tuq3qnujjNVI; Thu,  9 Jul 2026 21:35:52 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gx7Yf4ZQPzlffvQ;
	Thu,  9 Jul 2026 21:35:50 +0000 (UTC)
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
Subject: [PATCH 01/12] drbd: Remove "extern" from function declarations
Date: Thu,  9 Jul 2026 14:35:22 -0700
Message-ID: <d58ed9848c0933dddaf2778c21d0a6ac86aceba2.1783632330.git.bvanassche@acm.org>
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

The "extern" keyword is superfluous when declaring a function. Remove
that keyword from function declarations to improve consistency with the
rest of the kernel source code.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_config.h       |   2 +-
 drivers/block/drbd/drbd_int.h          | 576 +++++++++++++------------
 drivers/block/drbd/drbd_interval.h     |  11 +-
 drivers/block/drbd/drbd_req.h          |  24 +-
 drivers/block/drbd/drbd_state.h        |  35 +-
 drivers/block/drbd/drbd_state_change.h |  32 +-
 6 files changed, 346 insertions(+), 334 deletions(-)

diff --git a/drivers/block/drbd/drbd_config.h b/drivers/block/drbd/drbd_c=
onfig.h
index d215365c6bb1..16a985b30dd3 100644
--- a/drivers/block/drbd/drbd_config.h
+++ b/drivers/block/drbd/drbd_config.h
@@ -7,7 +7,7 @@
 #ifndef DRBD_CONFIG_H
 #define DRBD_CONFIG_H
=20
-extern const char *drbd_buildtag(void);
+const char *drbd_buildtag(void);
=20
 #define REL_VERSION "8.4.11"
 #define PRO_VERSION_MIN 86
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.=
h
index 48b45c3142f7..aa39c4d19133 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -109,7 +109,7 @@ extern struct ratelimit_state drbd_ratelimit_state;
 extern struct idr drbd_devices; /* RCU, updates: genl_lock() */
 extern struct list_head drbd_resources; /* RCU, updates: genl_lock() */
=20
-extern const char *cmdname(enum drbd_packet cmd);
+const char *cmdname(enum drbd_packet cmd);
=20
 /* for sending/receiving the bitmap,
  * possibly in some encoding scheme */
@@ -129,8 +129,8 @@ struct bm_xfer_ctx {
 	unsigned bytes[2];
 };
=20
-extern void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
-			       const char *direction, struct bm_xfer_ctx *c);
+void INFO_bm_xfer_stats(struct drbd_peer_device *peer_device,
+			const char *direction, struct bm_xfer_ctx *c);
=20
 static inline void bm_xfer_ctx_bit_to_word_offset(struct bm_xfer_ctx *c)
 {
@@ -151,7 +151,7 @@ static inline void bm_xfer_ctx_bit_to_word_offset(str=
uct bm_xfer_ctx *c)
 #endif
 }
=20
-extern unsigned int drbd_header_size(struct drbd_connection *connection)=
;
+unsigned int drbd_header_size(struct drbd_connection *connection);
=20
 /**********************************************************************/
 enum drbd_thread_state {
@@ -195,10 +195,10 @@ struct drbd_device_work {
=20
 #include "drbd_interval.h"
=20
-extern int drbd_wait_misc(struct drbd_device *, struct drbd_interval *);
+int drbd_wait_misc(struct drbd_device *, struct drbd_interval *);
=20
-extern void lock_all_resources(void);
-extern void unlock_all_resources(void);
+void lock_all_resources(void);
+void unlock_all_resources(void);
=20
 struct drbd_request {
 	struct drbd_work w;
@@ -559,7 +559,7 @@ struct fifo_buffer {
 	int total; /* sum of all values */
 	int values[] __counted_by(size);
 };
-extern struct fifo_buffer *fifo_alloc(unsigned int fifo_size);
+struct fifo_buffer *fifo_alloc(unsigned int fifo_size);
=20
 /* flag bits per connection */
 enum {
@@ -998,93 +998,108 @@ enum dds_flags {
 	DDSF_NO_RESYNC =3D 2, /* Do not run a resync for the new space */
 };
=20
-extern void drbd_init_set_defaults(struct drbd_device *device);
-extern int  drbd_thread_start(struct drbd_thread *thi);
-extern void _drbd_thread_stop(struct drbd_thread *thi, int restart, int =
wait);
+void drbd_init_set_defaults(struct drbd_device *device);
+int drbd_thread_start(struct drbd_thread *thi);
+void _drbd_thread_stop(struct drbd_thread *thi, int restart, int wait);
 #ifdef CONFIG_SMP
-extern void drbd_thread_current_set_cpu(struct drbd_thread *thi);
+void drbd_thread_current_set_cpu(struct drbd_thread *thi);
 #else
 #define drbd_thread_current_set_cpu(A) ({})
 #endif
-extern void tl_release(struct drbd_connection *, unsigned int barrier_nr=
,
-		       unsigned int set_size);
-extern void tl_clear(struct drbd_connection *);
-extern void drbd_free_sock(struct drbd_connection *connection);
-extern int drbd_send(struct drbd_connection *connection, struct socket *=
sock,
-		     void *buf, size_t size, unsigned msg_flags);
-extern int drbd_send_all(struct drbd_connection *, struct socket *, void=
 *, size_t,
-			 unsigned);
-
-extern int __drbd_send_protocol(struct drbd_connection *connection, enum=
 drbd_packet cmd);
-extern int drbd_send_protocol(struct drbd_connection *connection);
-extern int drbd_send_uuids(struct drbd_peer_device *);
-extern int drbd_send_uuids_skip_initial_sync(struct drbd_peer_device *);
-extern void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *);
-extern int drbd_send_sizes(struct drbd_peer_device *, int trigger_reply,=
 enum dds_flags flags);
-extern int drbd_send_state(struct drbd_peer_device *, union drbd_state s=
);
-extern int drbd_send_current_state(struct drbd_peer_device *);
-extern int drbd_send_sync_param(struct drbd_peer_device *);
-extern void drbd_send_b_ack(struct drbd_connection *connection, u32 barr=
ier_nr,
-			    u32 set_size);
-extern int drbd_send_ack(struct drbd_peer_device *, enum drbd_packet,
-			 struct drbd_peer_request *);
-extern void drbd_send_ack_rp(struct drbd_peer_device *, enum drbd_packet=
,
-			     struct p_block_req *rp);
-extern void drbd_send_ack_dp(struct drbd_peer_device *, enum drbd_packet=
,
-			     struct p_data *dp, int data_size);
-extern int drbd_send_ack_ex(struct drbd_peer_device *, enum drbd_packet,
-			    sector_t sector, int blksize, u64 block_id);
-extern int drbd_send_out_of_sync(struct drbd_peer_device *, struct drbd_=
request *);
-extern int drbd_send_block(struct drbd_peer_device *, enum drbd_packet,
-			   struct drbd_peer_request *);
-extern int drbd_send_dblock(struct drbd_peer_device *, struct drbd_reque=
st *req);
-extern int drbd_send_drequest(struct drbd_peer_device *, int cmd,
-			      sector_t sector, int size, u64 block_id);
-extern int drbd_send_drequest_csum(struct drbd_peer_device *, sector_t s=
ector,
-				   int size, void *digest, int digest_size,
-				   enum drbd_packet cmd);
-extern int drbd_send_ov_request(struct drbd_peer_device *, sector_t sect=
or, int size);
-
-extern int drbd_send_bitmap(struct drbd_device *device, struct drbd_peer=
_device *peer_device);
-extern void drbd_send_sr_reply(struct drbd_peer_device *, enum drbd_stat=
e_rv retcode);
-extern void conn_send_sr_reply(struct drbd_connection *connection, enum =
drbd_state_rv retcode);
-extern int drbd_send_rs_deallocated(struct drbd_peer_device *, struct dr=
bd_peer_request *);
-extern void drbd_backing_dev_free(struct drbd_device *device, struct drb=
d_backing_dev *ldev);
-extern void drbd_device_cleanup(struct drbd_device *device);
-extern void drbd_print_uuids(struct drbd_device *device, const char *tex=
t);
-extern void drbd_queue_unplug(struct drbd_device *device);
-
-extern void conn_md_sync(struct drbd_connection *connection);
-extern void drbd_md_write(struct drbd_device *device, void *buffer);
-extern void drbd_md_sync(struct drbd_device *device);
-extern int  drbd_md_read(struct drbd_device *device, struct drbd_backing=
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
-extern int drbd_md_test_flag(struct drbd_backing_dev *, int);
-extern void drbd_md_mark_dirty(struct drbd_device *device);
-extern void drbd_queue_bitmap_io(struct drbd_device *device,
-				 int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
-				 void (*done)(struct drbd_device *, int),
-				 char *why, enum bm_flag flags,
-				 struct drbd_peer_device *peer_device);
-extern int drbd_bitmap_io(struct drbd_device *device,
-		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
-		char *why, enum bm_flag flags,
-		struct drbd_peer_device *peer_device);
-extern int drbd_bitmap_io_from_worker(struct drbd_device *device,
-		int (*io_fn)(struct drbd_device *, struct drbd_peer_device *),
-		char *why, enum bm_flag flags,
-		struct drbd_peer_device *peer_device);
-extern int drbd_bmio_set_n_write(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local);
-extern int drbd_bmio_clear_n_write(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local);
+void tl_release(struct drbd_connection *, unsigned int barrier_nr,
+		unsigned int set_size);
+void tl_clear(struct drbd_connection *);
+void drbd_free_sock(struct drbd_connection *connection);
+int drbd_send(struct drbd_connection *connection, struct socket *sock,
+	      void *buf, size_t size, unsigned msg_flags);
+int drbd_send_all(struct drbd_connection *, struct socket *, void *, siz=
e_t,
+		  unsigned);
+
+int __drbd_send_protocol(struct drbd_connection *connection,
+			 enum drbd_packet cmd);
+int drbd_send_protocol(struct drbd_connection *connection);
+int drbd_send_uuids(struct drbd_peer_device *);
+int drbd_send_uuids_skip_initial_sync(struct drbd_peer_device *);
+void drbd_gen_and_send_sync_uuid(struct drbd_peer_device *);
+int drbd_send_sizes(struct drbd_peer_device *, int trigger_reply,
+		    enum dds_flags flags);
+int drbd_send_state(struct drbd_peer_device *, union drbd_state s);
+int drbd_send_current_state(struct drbd_peer_device *);
+int drbd_send_sync_param(struct drbd_peer_device *);
+void drbd_send_b_ack(struct drbd_connection *connection, u32 barrier_nr,
+		     u32 set_size);
+int drbd_send_ack(struct drbd_peer_device *, enum drbd_packet,
+		  struct drbd_peer_request *);
+void drbd_send_ack_rp(struct drbd_peer_device *, enum drbd_packet,
+		      struct p_block_req *rp);
+void drbd_send_ack_dp(struct drbd_peer_device *, enum drbd_packet,
+		      struct p_data *dp, int data_size);
+int drbd_send_ack_ex(struct drbd_peer_device *, enum drbd_packet,
+		     sector_t sector, int blksize, u64 block_id);
+int drbd_send_out_of_sync(struct drbd_peer_device *, struct drbd_request=
 *);
+int drbd_send_block(struct drbd_peer_device *, enum drbd_packet,
+		    struct drbd_peer_request *);
+int drbd_send_dblock(struct drbd_peer_device *, struct drbd_request *req=
);
+int drbd_send_drequest(struct drbd_peer_device *, int cmd, sector_t sect=
or,
+		       int size, u64 block_id);
+int drbd_send_drequest_csum(struct drbd_peer_device *, sector_t sector,
+			    int size, void *digest, int digest_size,
+			    enum drbd_packet cmd);
+int drbd_send_ov_request(struct drbd_peer_device *, sector_t sector, int=
 size);
+
+int drbd_send_bitmap(struct drbd_device *device,
+		     struct drbd_peer_device *peer_device);
+void drbd_send_sr_reply(struct drbd_peer_device *, enum drbd_state_rv re=
tcode);
+void conn_send_sr_reply(struct drbd_connection *connection,
+			enum drbd_state_rv retcode);
+int drbd_send_rs_deallocated(struct drbd_peer_device *,
+			     struct drbd_peer_request *);
+void drbd_backing_dev_free(struct drbd_device *device,
+			   struct drbd_backing_dev *ldev);
+void drbd_device_cleanup(struct drbd_device *device);
+void drbd_print_uuids(struct drbd_device *device, const char *text);
+void drbd_queue_unplug(struct drbd_device *device);
+
+void conn_md_sync(struct drbd_connection *connection);
+void drbd_md_write(struct drbd_device *device, void *buffer);
+void drbd_md_sync(struct drbd_device *device);
+int drbd_md_read(struct drbd_device *device, struct drbd_backing_dev *bd=
ev);
+void drbd_uuid_set(struct drbd_device *device, int idx, u64 val)
+	__must_hold(local);
+void _drbd_uuid_set(struct drbd_device *device, int idx, u64 val)
+	__must_hold(local);
+void drbd_uuid_new_current(struct drbd_device *device) __must_hold(local=
);
+void drbd_uuid_set_bm(struct drbd_device *device, u64 val) __must_hold(l=
ocal);
+void drbd_uuid_move_history(struct drbd_device *device) __must_hold(loca=
l);
+void __drbd_uuid_set(struct drbd_device *device, int idx, u64 val)
+	__must_hold(local);
+void drbd_md_set_flag(struct drbd_device *device, int flags) __must_hold=
(local);
+void drbd_md_clear_flag(struct drbd_device *device, int flags)
+	__must_hold(local);
+int drbd_md_test_flag(struct drbd_backing_dev *, int);
+void drbd_md_mark_dirty(struct drbd_device *device);
+void drbd_queue_bitmap_io(struct drbd_device *device,
+			  int (*io_fn)(struct drbd_device *,
+				       struct drbd_peer_device *),
+			  void (*done)(struct drbd_device *, int), char *why,
+			  enum bm_flag flags,
+			  struct drbd_peer_device *peer_device);
+int drbd_bitmap_io(struct drbd_device *device,
+		   int (*io_fn)(struct drbd_device *,
+				struct drbd_peer_device *),
+		   char *why, enum bm_flag flags,
+		   struct drbd_peer_device *peer_device);
+int drbd_bitmap_io_from_worker(struct drbd_device *device,
+			       int (*io_fn)(struct drbd_device *,
+					    struct drbd_peer_device *),
+			       char *why, enum bm_flag flags,
+			       struct drbd_peer_device *peer_device);
+int drbd_bmio_set_n_write(struct drbd_device *device,
+			  struct drbd_peer_device *peer_device)
+	__must_hold(local);
+int drbd_bmio_clear_n_write(struct drbd_device *device,
+			    struct drbd_peer_device *peer_device)
+	__must_hold(local);
=20
 /* Meta data layout
  *
@@ -1275,56 +1290,62 @@ struct bm_extent {
 #define DRBD_MAX_BATCH_BIO_SIZE	 (AL_UPDATES_PER_TRANSACTION/2*AL_EXTENT=
_SIZE)
 #define DRBD_MAX_BBIO_SECTORS    (DRBD_MAX_BATCH_BIO_SIZE >> 9)
=20
-extern int  drbd_bm_init(struct drbd_device *device);
-extern int  drbd_bm_resize(struct drbd_device *device, sector_t sectors,=
 int set_new_bits);
-extern void drbd_bm_cleanup(struct drbd_device *device);
-extern void drbd_bm_set_all(struct drbd_device *device);
-extern void drbd_bm_clear_all(struct drbd_device *device);
+int drbd_bm_init(struct drbd_device *device);
+int drbd_bm_resize(struct drbd_device *device, sector_t sectors,
+		   int set_new_bits);
+void drbd_bm_cleanup(struct drbd_device *device);
+void drbd_bm_set_all(struct drbd_device *device);
+void drbd_bm_clear_all(struct drbd_device *device);
 /* set/clear/test only a few bits at a time */
-extern int  drbd_bm_set_bits(
-		struct drbd_device *device, unsigned long s, unsigned long e);
-extern int  drbd_bm_clear_bits(
-		struct drbd_device *device, unsigned long s, unsigned long e);
-extern int drbd_bm_count_bits(
-	struct drbd_device *device, const unsigned long s, const unsigned long =
e);
+int drbd_bm_set_bits(struct drbd_device *device, unsigned long s,
+		     unsigned long e);
+int drbd_bm_clear_bits(struct drbd_device *device, unsigned long s,
+		       unsigned long e);
+int drbd_bm_count_bits(struct drbd_device *device, const unsigned long s=
,
+		       const unsigned long e);
 /* bm_set_bits variant for use while holding drbd_bm_lock,
  * may process the whole bitmap in one go */
-extern void _drbd_bm_set_bits(struct drbd_device *device,
-		const unsigned long s, const unsigned long e);
-extern int  drbd_bm_test_bit(struct drbd_device *device, unsigned long b=
itnr);
-extern int  drbd_bm_e_weight(struct drbd_device *device, unsigned long e=
nr);
-extern int  drbd_bm_read(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local);
-extern void drbd_bm_mark_for_writeout(struct drbd_device *device, int pa=
ge_nr);
-extern int  drbd_bm_write(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local);
-extern void drbd_bm_reset_al_hints(struct drbd_device *device) __must_ho=
ld(local);
-extern int  drbd_bm_write_hinted(struct drbd_device *device) __must_hold=
(local);
-extern int  drbd_bm_write_lazy(struct drbd_device *device, unsigned uppe=
r_idx) __must_hold(local);
-extern int drbd_bm_write_all(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local);
-extern int  drbd_bm_write_copy_pages(struct drbd_device *device,
-		struct drbd_peer_device *peer_device) __must_hold(local);
-extern size_t	     drbd_bm_words(struct drbd_device *device);
-extern unsigned long drbd_bm_bits(struct drbd_device *device);
-extern sector_t      drbd_bm_capacity(struct drbd_device *device);
+void _drbd_bm_set_bits(struct drbd_device *device, const unsigned long s=
,
+		       const unsigned long e);
+int drbd_bm_test_bit(struct drbd_device *device, unsigned long bitnr);
+int drbd_bm_e_weight(struct drbd_device *device, unsigned long enr);
+int drbd_bm_read(struct drbd_device *device,
+		 struct drbd_peer_device *peer_device) __must_hold(local);
+void drbd_bm_mark_for_writeout(struct drbd_device *device, int page_nr);
+int drbd_bm_write(struct drbd_device *device,
+		  struct drbd_peer_device *peer_device) __must_hold(local);
+void drbd_bm_reset_al_hints(struct drbd_device *device) __must_hold(loca=
l);
+int drbd_bm_write_hinted(struct drbd_device *device) __must_hold(local);
+int drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx)
+	__must_hold(local);
+int drbd_bm_write_all(struct drbd_device *device,
+		      struct drbd_peer_device *peer_device) __must_hold(local);
+int drbd_bm_write_copy_pages(struct drbd_device *device,
+			     struct drbd_peer_device *peer_device)
+	__must_hold(local);
+size_t drbd_bm_words(struct drbd_device *device);
+unsigned long drbd_bm_bits(struct drbd_device *device);
+sector_t drbd_bm_capacity(struct drbd_device *device);
=20
 #define DRBD_END_OF_BITMAP	(~(unsigned long)0)
-extern unsigned long drbd_bm_find_next(struct drbd_device *device, unsig=
ned long bm_fo);
+unsigned long drbd_bm_find_next(struct drbd_device *device,
+				unsigned long bm_fo);
 /* bm_find_next variants for use while you hold drbd_bm_lock() */
-extern unsigned long _drbd_bm_find_next(struct drbd_device *device, unsi=
gned long bm_fo);
-extern unsigned long _drbd_bm_find_next_zero(struct drbd_device *device,=
 unsigned long bm_fo);
-extern unsigned long _drbd_bm_total_weight(struct drbd_device *device);
-extern unsigned long drbd_bm_total_weight(struct drbd_device *device);
+unsigned long _drbd_bm_find_next(struct drbd_device *device,
+				 unsigned long bm_fo);
+unsigned long _drbd_bm_find_next_zero(struct drbd_device *device,
+				      unsigned long bm_fo);
+unsigned long _drbd_bm_total_weight(struct drbd_device *device);
+unsigned long drbd_bm_total_weight(struct drbd_device *device);
 /* for receive_bitmap */
-extern void drbd_bm_merge_lel(struct drbd_device *device, size_t offset,
-		size_t number, unsigned long *buffer);
+void drbd_bm_merge_lel(struct drbd_device *device, size_t offset, size_t=
 number,
+		       unsigned long *buffer);
 /* for _drbd_send_bitmap */
-extern void drbd_bm_get_lel(struct drbd_device *device, size_t offset,
-		size_t number, unsigned long *buffer);
+void drbd_bm_get_lel(struct drbd_device *device, size_t offset, size_t n=
umber,
+		     unsigned long *buffer);
=20
-extern void drbd_bm_lock(struct drbd_device *device, char *why, enum bm_=
flag flags);
-extern void drbd_bm_unlock(struct drbd_device *device);
+void drbd_bm_lock(struct drbd_device *device, char *why, enum bm_flag fl=
ags);
+void drbd_bm_unlock(struct drbd_device *device);
 /* drbd_main.c */
=20
 extern struct kmem_cache *drbd_request_cache;
@@ -1352,35 +1373,39 @@ extern struct bio_set drbd_io_bio_set;
=20
 extern struct mutex resources_mutex;
=20
-extern enum drbd_ret_code drbd_create_device(struct drbd_config_context =
*adm_ctx, unsigned int minor);
-extern void drbd_destroy_device(struct kref *kref);
-extern void drbd_delete_device(struct drbd_device *device);
-
-extern struct drbd_resource *drbd_create_resource(const char *name);
-extern void drbd_free_resource(struct drbd_resource *resource);
-
-extern int set_resource_options(struct drbd_resource *resource, struct r=
es_opts *res_opts);
-extern struct drbd_connection *conn_create(const char *name, struct res_=
opts *res_opts);
-extern void drbd_destroy_connection(struct kref *kref);
-extern struct drbd_connection *conn_get_by_addrs(void *my_addr, int my_a=
ddr_len,
-					    void *peer_addr, int peer_addr_len);
-extern struct drbd_resource *drbd_find_resource(const char *name);
-extern void drbd_destroy_resource(struct kref *kref);
-extern void conn_free_crypto(struct drbd_connection *connection);
+enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ct=
x,
+				      unsigned int minor);
+void drbd_destroy_device(struct kref *kref);
+void drbd_delete_device(struct drbd_device *device);
+
+struct drbd_resource *drbd_create_resource(const char *name);
+void drbd_free_resource(struct drbd_resource *resource);
+
+int set_resource_options(struct drbd_resource *resource,
+			 struct res_opts *res_opts);
+struct drbd_connection *conn_create(const char *name,
+				    struct res_opts *res_opts);
+void drbd_destroy_connection(struct kref *kref);
+struct drbd_connection *conn_get_by_addrs(void *my_addr, int my_addr_len=
,
+					  void *peer_addr, int peer_addr_len);
+struct drbd_resource *drbd_find_resource(const char *name);
+void drbd_destroy_resource(struct kref *kref);
+void conn_free_crypto(struct drbd_connection *connection);
=20
 /* drbd_req */
-extern void do_submit(struct work_struct *ws);
-extern void __drbd_make_request(struct drbd_device *, struct bio *);
+void do_submit(struct work_struct *ws);
+void __drbd_make_request(struct drbd_device *, struct bio *);
 void drbd_submit_bio(struct bio *bio);
=20
 /* drbd_nl.c */
=20
 extern struct mutex notification_mutex;
=20
-extern void drbd_suspend_io(struct drbd_device *device);
-extern void drbd_resume_io(struct drbd_device *device);
-extern char *ppsize(char *buf, unsigned long long size);
-extern sector_t drbd_new_dev_size(struct drbd_device *, struct drbd_back=
ing_dev *, sector_t, int);
+void drbd_suspend_io(struct drbd_device *device);
+void drbd_resume_io(struct drbd_device *device);
+char *ppsize(char *buf, unsigned long long size);
+sector_t drbd_new_dev_size(struct drbd_device *, struct drbd_backing_dev=
 *,
+			   sector_t, int);
 enum determine_dev_size {
 	DS_ERROR_SHRINK =3D -3,
 	DS_ERROR_SPACE_MD =3D -2,
@@ -1390,41 +1415,46 @@ enum determine_dev_size {
 	DS_GREW =3D 2,
 	DS_GREW_FROM_ZERO =3D 3,
 };
-extern enum determine_dev_size
-drbd_determine_dev_size(struct drbd_device *, enum dds_flags, struct res=
ize_parms *) __must_hold(local);
-extern void resync_after_online_grow(struct drbd_device *);
-extern void drbd_reconsider_queue_parameters(struct drbd_device *device,
-			struct drbd_backing_dev *bdev, struct o_qlim *o);
-extern enum drbd_state_rv drbd_set_role(struct drbd_device *device,
-					enum drbd_role new_role,
-					int force);
-extern bool conn_try_outdate_peer(struct drbd_connection *connection);
-extern void conn_try_outdate_peer_async(struct drbd_connection *connecti=
on);
-extern enum drbd_peer_state conn_khelper(struct drbd_connection *connect=
ion, char *cmd);
-extern int drbd_khelper(struct drbd_device *device, char *cmd);
+enum determine_dev_size drbd_determine_dev_size(struct drbd_device *,
+						enum dds_flags,
+						struct resize_parms *)
+	__must_hold(local);
+void resync_after_online_grow(struct drbd_device *);
+void drbd_reconsider_queue_parameters(struct drbd_device *device,
+				      struct drbd_backing_dev *bdev,
+				      struct o_qlim *o);
+enum drbd_state_rv drbd_set_role(struct drbd_device *device,
+				 enum drbd_role new_role, int force);
+bool conn_try_outdate_peer(struct drbd_connection *connection);
+void conn_try_outdate_peer_async(struct drbd_connection *connection);
+enum drbd_peer_state conn_khelper(struct drbd_connection *connection,
+				  char *cmd);
+int drbd_khelper(struct drbd_device *device, char *cmd);
=20
 /* drbd_worker.c */
 /* bi_end_io handlers */
-extern void drbd_md_endio(struct bio *bio);
-extern void drbd_peer_request_endio(struct bio *bio);
-extern void drbd_request_endio(struct bio *bio);
-extern int drbd_worker(struct drbd_thread *thi);
+void drbd_md_endio(struct bio *bio);
+void drbd_peer_request_endio(struct bio *bio);
+void drbd_request_endio(struct bio *bio);
+int drbd_worker(struct drbd_thread *thi);
 enum drbd_ret_code drbd_resync_after_valid(struct drbd_device *device, i=
nt o_minor);
 void drbd_resync_after_changed(struct drbd_device *device);
-extern void drbd_start_resync(struct drbd_device *device, enum drbd_conn=
s side);
-extern void resume_next_sg(struct drbd_device *device);
-extern void suspend_other_sg(struct drbd_device *device);
-extern int drbd_resync_finished(struct drbd_peer_device *peer_device);
+void drbd_start_resync(struct drbd_device *device, enum drbd_conns side)=
;
+void resume_next_sg(struct drbd_device *device);
+void suspend_other_sg(struct drbd_device *device);
+int drbd_resync_finished(struct drbd_peer_device *peer_device);
 /* maybe rather drbd_main.c ? */
-extern void *drbd_md_get_buffer(struct drbd_device *device, const char *=
intent);
-extern void drbd_md_put_buffer(struct drbd_device *device);
-extern int drbd_md_sync_page_io(struct drbd_device *device,
-		struct drbd_backing_dev *bdev, sector_t sector, enum req_op op);
-extern void drbd_ov_out_of_sync_found(struct drbd_peer_device *peer_devi=
ce,
-		sector_t sector, int size);
-extern void wait_until_done_or_force_detached(struct drbd_device *device=
,
-		struct drbd_backing_dev *bdev, unsigned int *done);
-extern void drbd_rs_controller_reset(struct drbd_peer_device *peer_devic=
e);
+void *drbd_md_get_buffer(struct drbd_device *device, const char *intent)=
;
+void drbd_md_put_buffer(struct drbd_device *device);
+int drbd_md_sync_page_io(struct drbd_device *device,
+			 struct drbd_backing_dev *bdev, sector_t sector,
+			 enum req_op op);
+void drbd_ov_out_of_sync_found(struct drbd_peer_device *peer_device,
+			       sector_t sector, int size);
+void wait_until_done_or_force_detached(struct drbd_device *device,
+				       struct drbd_backing_dev *bdev,
+				       unsigned int *done);
+void drbd_rs_controller_reset(struct drbd_peer_device *peer_device);
=20
 static inline void ov_out_of_sync_print(struct drbd_peer_device *peer_de=
vice)
 {
@@ -1438,48 +1468,48 @@ static inline void ov_out_of_sync_print(struct dr=
bd_peer_device *peer_device)
 	device->ov_last_oos_size =3D 0;
 }
=20
-
-extern void drbd_csum_bio(struct crypto_shash *, struct bio *, void *);
-extern void drbd_csum_ee(struct crypto_shash *, struct drbd_peer_request=
 *,
-			 void *);
+void drbd_csum_bio(struct crypto_shash *, struct bio *, void *);
+void drbd_csum_ee(struct crypto_shash *, struct drbd_peer_request *, voi=
d *);
 /* worker callbacks */
-extern int w_e_end_data_req(struct drbd_work *, int);
-extern int w_e_end_rsdata_req(struct drbd_work *, int);
-extern int w_e_end_csum_rs_req(struct drbd_work *, int);
-extern int w_e_end_ov_reply(struct drbd_work *, int);
-extern int w_e_end_ov_req(struct drbd_work *, int);
-extern int w_ov_finished(struct drbd_work *, int);
-extern int w_resync_timer(struct drbd_work *, int);
-extern int w_send_write_hint(struct drbd_work *, int);
-extern int w_send_dblock(struct drbd_work *, int);
-extern int w_send_read_req(struct drbd_work *, int);
-extern int w_restart_disk_io(struct drbd_work *, int);
-extern int w_send_out_of_sync(struct drbd_work *, int);
-
-extern void resync_timer_fn(struct timer_list *t);
-extern void start_resync_timer_fn(struct timer_list *t);
-
-extern void drbd_endio_write_sec_final(struct drbd_peer_request *peer_re=
q);
+int w_e_end_data_req(struct drbd_work *, int);
+int w_e_end_rsdata_req(struct drbd_work *, int);
+int w_e_end_csum_rs_req(struct drbd_work *, int);
+int w_e_end_ov_reply(struct drbd_work *, int);
+int w_e_end_ov_req(struct drbd_work *, int);
+int w_ov_finished(struct drbd_work *, int);
+int w_resync_timer(struct drbd_work *, int);
+int w_send_write_hint(struct drbd_work *, int);
+int w_send_dblock(struct drbd_work *, int);
+int w_send_read_req(struct drbd_work *, int);
+int w_restart_disk_io(struct drbd_work *, int);
+int w_send_out_of_sync(struct drbd_work *, int);
+
+void resync_timer_fn(struct timer_list *t);
+void start_resync_timer_fn(struct timer_list *t);
+
+void drbd_endio_write_sec_final(struct drbd_peer_request *peer_req);
=20
 /* drbd_receiver.c */
-extern int drbd_issue_discard_or_zero_out(struct drbd_device *device,
-		sector_t start, unsigned int nr_sectors, int flags);
-extern int drbd_receiver(struct drbd_thread *thi);
-extern int drbd_ack_receiver(struct drbd_thread *thi);
-extern void drbd_send_acks_wf(struct work_struct *ws);
-extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
-extern bool drbd_rs_should_slow_down(struct drbd_peer_device *peer_devic=
e, sector_t sector,
-		bool throttle_if_app_is_waiting);
-extern int drbd_submit_peer_request(struct drbd_peer_request *peer_req);
-extern int drbd_free_peer_reqs(struct drbd_device *, struct list_head *)=
;
-extern struct drbd_peer_request *drbd_alloc_peer_req(struct drbd_peer_de=
vice *, u64,
-						     sector_t, unsigned int,
-						     unsigned int,
-						     gfp_t) __must_hold(local);
-extern void drbd_free_peer_req(struct drbd_device *device, struct drbd_p=
eer_request *req);
-extern struct page *drbd_alloc_pages(struct drbd_peer_device *, unsigned=
 int, bool);
-extern void _drbd_clear_done_ee(struct drbd_device *device, struct list_=
head *to_be_freed);
-extern int drbd_connected(struct drbd_peer_device *);
+int drbd_issue_discard_or_zero_out(struct drbd_device *device, sector_t =
start,
+				   unsigned int nr_sectors, int flags);
+int drbd_receiver(struct drbd_thread *thi);
+int drbd_ack_receiver(struct drbd_thread *thi);
+void drbd_send_acks_wf(struct work_struct *ws);
+bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
+bool drbd_rs_should_slow_down(struct drbd_peer_device *peer_device,
+			      sector_t sector, bool throttle_if_app_is_waiting);
+int drbd_submit_peer_request(struct drbd_peer_request *peer_req);
+int drbd_free_peer_reqs(struct drbd_device *, struct list_head *);
+struct drbd_peer_request *drbd_alloc_peer_req(struct drbd_peer_device *,=
 u64,
+					      sector_t, unsigned int,
+					      unsigned int, gfp_t)
+	__must_hold(local);
+void drbd_free_peer_req(struct drbd_device *device,
+			struct drbd_peer_request *req);
+struct page *drbd_alloc_pages(struct drbd_peer_device *, unsigned int, b=
ool);
+void _drbd_clear_done_ee(struct drbd_device *device,
+			 struct list_head *to_be_freed);
+int drbd_connected(struct drbd_peer_device *);
=20
 /* sets the number of 512 byte sectors of our virtual device */
 void drbd_set_my_capacity(struct drbd_device *device, sector_t size);
@@ -1512,32 +1542,36 @@ extern struct proc_dir_entry *drbd_proc;
 int drbd_seq_show(struct seq_file *seq, void *v);
=20
 /* drbd_actlog.c */
-extern bool drbd_al_begin_io_prepare(struct drbd_device *device, struct =
drbd_interval *i);
-extern int drbd_al_begin_io_nonblock(struct drbd_device *device, struct =
drbd_interval *i);
-extern void drbd_al_begin_io_commit(struct drbd_device *device);
-extern bool drbd_al_begin_io_fastpath(struct drbd_device *device, struct=
 drbd_interval *i);
-extern void drbd_al_begin_io(struct drbd_device *device, struct drbd_int=
erval *i);
-extern void drbd_al_complete_io(struct drbd_device *device, struct drbd_=
interval *i);
-extern void drbd_rs_complete_io(struct drbd_device *device, sector_t sec=
tor);
-extern int drbd_rs_begin_io(struct drbd_device *device, sector_t sector)=
;
-extern int drbd_try_rs_begin_io(struct drbd_peer_device *peer_device, se=
ctor_t sector);
-extern void drbd_rs_cancel_all(struct drbd_device *device);
-extern int drbd_rs_del_all(struct drbd_device *device);
-extern void drbd_rs_failed_io(struct drbd_peer_device *peer_device,
-		sector_t sector, int size);
-extern void drbd_advance_rs_marks(struct drbd_peer_device *peer_device, =
unsigned long still_to_go);
+bool drbd_al_begin_io_prepare(struct drbd_device *device,
+			      struct drbd_interval *i);
+int drbd_al_begin_io_nonblock(struct drbd_device *device,
+			      struct drbd_interval *i);
+void drbd_al_begin_io_commit(struct drbd_device *device);
+bool drbd_al_begin_io_fastpath(struct drbd_device *device,
+			       struct drbd_interval *i);
+void drbd_al_begin_io(struct drbd_device *device, struct drbd_interval *=
i);
+void drbd_al_complete_io(struct drbd_device *device, struct drbd_interva=
l *i);
+void drbd_rs_complete_io(struct drbd_device *device, sector_t sector);
+int drbd_rs_begin_io(struct drbd_device *device, sector_t sector);
+int drbd_try_rs_begin_io(struct drbd_peer_device *peer_device, sector_t =
sector);
+void drbd_rs_cancel_all(struct drbd_device *device);
+int drbd_rs_del_all(struct drbd_device *device);
+void drbd_rs_failed_io(struct drbd_peer_device *peer_device, sector_t se=
ctor,
+		       int size);
+void drbd_advance_rs_marks(struct drbd_peer_device *peer_device,
+			   unsigned long still_to_go);
=20
 enum update_sync_bits_mode { RECORD_RS_FAILED, SET_OUT_OF_SYNC, SET_IN_S=
YNC };
-extern int __drbd_change_sync(struct drbd_peer_device *peer_device, sect=
or_t sector, int size,
-		enum update_sync_bits_mode mode);
+int __drbd_change_sync(struct drbd_peer_device *peer_device, sector_t se=
ctor,
+		       int size, enum update_sync_bits_mode mode);
 #define drbd_set_in_sync(peer_device, sector, size) \
 	__drbd_change_sync(peer_device, sector, size, SET_IN_SYNC)
 #define drbd_set_out_of_sync(peer_device, sector, size) \
 	__drbd_change_sync(peer_device, sector, size, SET_OUT_OF_SYNC)
 #define drbd_rs_failed_io(peer_device, sector, size) \
 	__drbd_change_sync(peer_device, sector, size, RECORD_RS_FAILED)
-extern void drbd_al_shrink(struct drbd_device *device);
-extern int drbd_al_initialize(struct drbd_device *, void *);
+void drbd_al_shrink(struct drbd_device *device);
+int drbd_al_initialize(struct drbd_device *, void *);
=20
 /* drbd_nl.c */
 /* state info broadcast */
@@ -1556,28 +1590,20 @@ struct sib_info {
 };
 void drbd_bcast_event(struct drbd_device *device, const struct sib_info =
*sib);
=20
-extern int notify_resource_state(struct sk_buff *,
-				  unsigned int,
-				  struct drbd_resource *,
-				  struct resource_info *,
-				  enum drbd_notification_type);
-extern int notify_device_state(struct sk_buff *,
-				unsigned int,
-				struct drbd_device *,
-				struct device_info *,
-				enum drbd_notification_type);
-extern int notify_connection_state(struct sk_buff *,
-				    unsigned int,
-				    struct drbd_connection *,
-				    struct connection_info *,
-				    enum drbd_notification_type);
-extern int notify_peer_device_state(struct sk_buff *,
-				     unsigned int,
-				     struct drbd_peer_device *,
-				     struct peer_device_info *,
-				     enum drbd_notification_type);
-extern void notify_helper(enum drbd_notification_type, struct drbd_devic=
e *,
-			  struct drbd_connection *, const char *, int);
+int notify_resource_state(struct sk_buff *, unsigned int,
+			  struct drbd_resource *, struct resource_info *,
+			  enum drbd_notification_type);
+int notify_device_state(struct sk_buff *, unsigned int, struct drbd_devi=
ce *,
+			struct device_info *, enum drbd_notification_type);
+int notify_connection_state(struct sk_buff *, unsigned int,
+			    struct drbd_connection *, struct connection_info *,
+			    enum drbd_notification_type);
+int notify_peer_device_state(struct sk_buff *, unsigned int,
+			     struct drbd_peer_device *,
+			     struct peer_device_info *,
+			     enum drbd_notification_type);
+void notify_helper(enum drbd_notification_type, struct drbd_device *,
+		   struct drbd_connection *, const char *, int);
=20
 /*
  * inline helper functions
@@ -1822,7 +1848,7 @@ drbd_device_post_work(struct drbd_device *device, i=
nt work_bit)
 	}
 }
=20
-extern void drbd_flush_workqueue(struct drbd_work_queue *work_queue);
+void drbd_flush_workqueue(struct drbd_work_queue *work_queue);
=20
 /* To get the ack_receiver out of the blocking network stack,
  * so it can change its sk_rcvtimeo from idle- to ping-timeout,
@@ -1841,19 +1867,19 @@ static inline void request_ping(struct drbd_conne=
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
-			     enum drbd_packet, unsigned int, void *,
-			     unsigned int);
-extern int drbd_send_command(struct drbd_peer_device *, struct drbd_sock=
et *,
-			     enum drbd_packet, unsigned int, void *,
-			     unsigned int);
+void *conn_prepare_command(struct drbd_connection *, struct drbd_socket =
*);
+void *drbd_prepare_command(struct drbd_peer_device *, struct drbd_socket=
 *);
+int conn_send_command(struct drbd_connection *, struct drbd_socket *,
+		      enum drbd_packet, unsigned int, void *, unsigned int);
+int drbd_send_command(struct drbd_peer_device *, struct drbd_socket *,
+		      enum drbd_packet, unsigned int, void *, unsigned int);
=20
-extern int drbd_send_ping(struct drbd_connection *connection);
-extern int drbd_send_ping_ack(struct drbd_connection *connection);
-extern int drbd_send_state_req(struct drbd_peer_device *, union drbd_sta=
te, union drbd_state);
-extern int conn_send_state_req(struct drbd_connection *, union drbd_stat=
e, union drbd_state);
+int drbd_send_ping(struct drbd_connection *connection);
+int drbd_send_ping_ack(struct drbd_connection *connection);
+int drbd_send_state_req(struct drbd_peer_device *, union drbd_state,
+			union drbd_state);
+int conn_send_state_req(struct drbd_connection *, union drbd_state,
+			union drbd_state);
=20
 static inline void drbd_thread_stop(struct drbd_thread *thi)
 {
@@ -2023,7 +2049,7 @@ static inline int _get_ldev_if_state(struct drbd_de=
vice *device, enum drbd_disk_
 	return io_allowed;
 }
 #else
-extern int _get_ldev_if_state(struct drbd_device *device, enum drbd_disk=
_state mins);
+int _get_ldev_if_state(struct drbd_device *device, enum drbd_disk_state =
mins);
 #endif
=20
 /* this throttles on-the-fly application requests
diff --git a/drivers/block/drbd/drbd_interval.h b/drivers/block/drbd/drbd=
_interval.h
index 5d3213b81eed..255e9d071ae1 100644
--- a/drivers/block/drbd/drbd_interval.h
+++ b/drivers/block/drbd/drbd_interval.h
@@ -29,13 +29,12 @@ static inline bool drbd_interval_empty(struct drbd_in=
terval *i)
 	return RB_EMPTY_NODE(&i->rb);
 }
=20
-extern bool drbd_insert_interval(struct rb_root *, struct drbd_interval =
*);
-extern bool drbd_contains_interval(struct rb_root *, sector_t,
-				   struct drbd_interval *);
-extern void drbd_remove_interval(struct rb_root *, struct drbd_interval =
*);
-extern struct drbd_interval *drbd_find_overlap(struct rb_root *, sector_=
t,
+bool drbd_insert_interval(struct rb_root *, struct drbd_interval *);
+bool drbd_contains_interval(struct rb_root *, sector_t, struct drbd_inte=
rval *);
+void drbd_remove_interval(struct rb_root *, struct drbd_interval *);
+struct drbd_interval *drbd_find_overlap(struct rb_root *, sector_t,
 					unsigned int);
-extern struct drbd_interval *drbd_next_overlap(struct drbd_interval *, s=
ector_t,
+struct drbd_interval *drbd_next_overlap(struct drbd_interval *, sector_t=
,
 					unsigned int);
=20
 #define drbd_for_each_overlap(i, root, sector, size)		\
diff --git a/drivers/block/drbd/drbd_req.h b/drivers/block/drbd/drbd_req.=
h
index 9ae860e7591b..7f24cb8e5429 100644
--- a/drivers/block/drbd/drbd_req.h
+++ b/drivers/block/drbd/drbd_req.h
@@ -264,20 +264,18 @@ struct bio_and_error {
 	int error;
 };
=20
-extern void start_new_tl_epoch(struct drbd_connection *connection);
-extern void drbd_req_destroy(struct kref *kref);
-extern int __req_mod(struct drbd_request *req, enum drbd_req_event what,
-		struct drbd_peer_device *peer_device,
-		struct bio_and_error *m);
-extern void complete_master_bio(struct drbd_device *device,
-		struct bio_and_error *m);
-extern void request_timer_fn(struct timer_list *t);
-extern void tl_restart(struct drbd_connection *connection, enum drbd_req=
_event what);
-extern void _tl_restart(struct drbd_connection *connection, enum drbd_re=
q_event what);
-extern void tl_abort_disk_io(struct drbd_device *device);
+void start_new_tl_epoch(struct drbd_connection *connection);
+void drbd_req_destroy(struct kref *kref);
+int __req_mod(struct drbd_request *req, enum drbd_req_event what,
+	      struct drbd_peer_device *peer_device, struct bio_and_error *m);
+void complete_master_bio(struct drbd_device *device, struct bio_and_erro=
r *m);
+void request_timer_fn(struct timer_list *t);
+void tl_restart(struct drbd_connection *connection, enum drbd_req_event =
what);
+void _tl_restart(struct drbd_connection *connection, enum drbd_req_event=
 what);
+void tl_abort_disk_io(struct drbd_device *device);
=20
 /* this is in drbd_main.c */
-extern void drbd_restart_request(struct drbd_request *req);
+void drbd_restart_request(struct drbd_request *req);
=20
 /* use this if you don't want to deal with calling complete_master_bio()
  * outside the spinlock, e.g. when walking some list on cleanup. */
@@ -319,6 +317,6 @@ static inline int req_mod(struct drbd_request *req,
 	return rv;
 }
=20
-extern bool drbd_should_do_remote(union drbd_dev_state);
+bool drbd_should_do_remote(union drbd_dev_state);
=20
 #endif
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_st=
ate.h
index cbaeb8018dbf..a7e31d092039 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -112,26 +112,23 @@ union drbd_dev_state {
 	unsigned int i;
 };
=20
-extern enum drbd_state_rv drbd_change_state(struct drbd_device *device,
-					    enum chg_state_flags f,
-					    union drbd_state mask,
-					    union drbd_state val);
-extern void drbd_force_state(struct drbd_device *, union drbd_state,
-			union drbd_state);
-extern enum drbd_state_rv _drbd_request_state(struct drbd_device *,
-					      union drbd_state,
-					      union drbd_state,
-					      enum chg_state_flags);
-
-extern enum drbd_state_rv
+enum drbd_state_rv drbd_change_state(struct drbd_device *device,
+				     enum chg_state_flags f,
+				     union drbd_state mask,
+				     union drbd_state val);
+void drbd_force_state(struct drbd_device *, union drbd_state, union drbd=
_state);
+enum drbd_state_rv _drbd_request_state(struct drbd_device *, union drbd_=
state,
+				       union drbd_state, enum chg_state_flags);
+
+enum drbd_state_rv
 _drbd_request_state_holding_state_mutex(struct drbd_device *, union drbd=
_state,
 					union drbd_state, enum chg_state_flags);
=20
-extern enum drbd_state_rv _drbd_set_state(struct drbd_device *, union dr=
bd_state,
-					  enum chg_state_flags,
-					  struct completion *done);
-extern void print_st_err(struct drbd_device *, union drbd_state,
-			union drbd_state, enum drbd_state_rv);
+enum drbd_state_rv _drbd_set_state(struct drbd_device *, union drbd_stat=
e,
+				   enum chg_state_flags,
+				   struct completion *done);
+void print_st_err(struct drbd_device *, union drbd_state, union drbd_sta=
te,
+		  enum drbd_state_rv);
=20
 enum drbd_state_rv
 _conn_request_state(struct drbd_connection *connection, union drbd_state=
 mask, union drbd_state val,
@@ -141,8 +138,8 @@ enum drbd_state_rv
 conn_request_state(struct drbd_connection *connection, union drbd_state =
mask, union drbd_state val,
 		   enum chg_state_flags flags);
=20
-extern void drbd_resume_al(struct drbd_device *device);
-extern bool conn_all_vols_unconf(struct drbd_connection *connection);
+void drbd_resume_al(struct drbd_device *device);
+bool conn_all_vols_unconf(struct drbd_connection *connection);
=20
 /**
  * drbd_request_state() - Request a state change
diff --git a/drivers/block/drbd/drbd_state_change.h b/drivers/block/drbd/=
drbd_state_change.h
index a56a57d67686..f58a55014177 100644
--- a/drivers/block/drbd/drbd_state_change.h
+++ b/drivers/block/drbd/drbd_state_change.h
@@ -40,25 +40,17 @@ struct drbd_state_change {
 	struct drbd_peer_device_state_change *peer_devices;
 };
=20
-extern struct drbd_state_change *remember_old_state(struct drbd_resource=
 *, gfp_t);
-extern void copy_old_to_new_state_change(struct drbd_state_change *);
-extern void forget_state_change(struct drbd_state_change *);
-
-extern int notify_resource_state_change(struct sk_buff *,
-					 unsigned int,
-					 void *,
-					 enum drbd_notification_type type);
-extern int notify_connection_state_change(struct sk_buff *,
-					   unsigned int,
-					   void *,
-					   enum drbd_notification_type type);
-extern int notify_device_state_change(struct sk_buff *,
-				       unsigned int,
-				       void *,
-				       enum drbd_notification_type type);
-extern int notify_peer_device_state_change(struct sk_buff *,
-					    unsigned int,
-					    void *,
-					    enum drbd_notification_type type);
+struct drbd_state_change *remember_old_state(struct drbd_resource *, gfp=
_t);
+void copy_old_to_new_state_change(struct drbd_state_change *);
+void forget_state_change(struct drbd_state_change *);
+
+int notify_resource_state_change(struct sk_buff *, unsigned int, void *,
+				 enum drbd_notification_type type);
+int notify_connection_state_change(struct sk_buff *, unsigned int, void =
*,
+				   enum drbd_notification_type type);
+int notify_device_state_change(struct sk_buff *, unsigned int, void *,
+			       enum drbd_notification_type type);
+int notify_peer_device_state_change(struct sk_buff *, unsigned int, void=
 *,
+				    enum drbd_notification_type type);
=20
 #endif  /* DRBD_STATE_CHANGE_H */
