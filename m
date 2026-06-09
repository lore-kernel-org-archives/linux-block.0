Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEF3408018
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042797; cv=none; b=SS1QVSjDHFut0GTaGSaZHbuEhEpcTx4iq6jXU5RNsbbe3gRgTArXVuTp/F5oMKHWJkCogyZfsJE/QWmh1sD25OJ9iqf1fEGqfc+ozkb9RmV2NHy/Db3lM6oIjlgvthesF3R2W3C6Zg72gxGKteZdtsMJJcwPZgANuDu0GUjRLzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042797; c=relaxed/simple;
	bh=RRB+BM5UEDh0OJf4BuTdQYXjNnXor6VgIu0U+urRd9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYvx8nU2d08oDDwiZ/dZo1KoCM6pxJ78TreJc8boznHwK0RBfQgzBhlECYdD6sw4XLI+lAV6O6W7WQxTpS4eRTXfBy1p1dvbByz4anZMdsL0Ay2XAR5Gl/WhQJ+Keg2yx3AHe2QmwLdvEvMGnbj0/knvpv42Ydaq6vGVhP00xBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=oI46+ESs; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="oI46+ESs"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjfy39vbzlgwMq;
	Tue,  9 Jun 2026 22:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received; s=mr01; t=1781042784; x=
	1783634785; bh=f0aTtfSiqvS48XKKaHu42O/oBfpwDxuLwVhUoPCdLiw=; b=o
	I46+ESsMjJQaTfsRMprQ47cF1DE/B2Ig1fESPgnCPUJ/6u0n2fet5PljwFRgk9Cz
	a3iiM2ukpZhV3+ctq/KTfQ2AAEC1j+KjRyhdgkplldD0S0QqQ2aTjSDn/1YRnzs4
	kvBa51GzxJ+nFoCA0UEOOJ3DAps1ESx5cQ9yrHaOs6s8q/rh4I9HW3uPQvKslnUl
	sb/apphRFtG1MQHIMb1v5ythAWquBxYKLYRnSO85R+PN2psY6AtVp6OoIdN1Duxz
	MyNe3JWD37eTlC1dQ3ArxOAqwfIpnPCCxZx5YGPYoYH1yvxm1iI5a3eaoe2xE1oi
	NNZ76am4Jr+BHgwCj7l3g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BPM0gFwjG9BT; Tue,  9 Jun 2026 22:06:24 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjfj5cCCzlh1Mn;
	Tue,  9 Jun 2026 22:06:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 14/27] drbd: Enable lock context analysis
Date: Tue,  9 Jun 2026 15:05:01 -0700
Message-ID: <f5d9fb036fe6dbe3df338c04ff74d6de89953f31.1781042470.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <cover.1781042470.git.bvanassche@acm.org>
References: <cover.1781042470.git.bvanassche@acm.org>
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

Cc: Christoph B=C3=B6hmwalder <christoph.boehmwalder@linbit.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/Makefile        |  3 +++
 drivers/block/drbd/drbd_int.h      | 27 ++++++++++++++++++---------
 drivers/block/drbd/drbd_main.c     |  2 ++
 drivers/block/drbd/drbd_receiver.c |  6 ++++++
 drivers/block/drbd/drbd_req.c      |  1 +
 drivers/block/drbd/drbd_state.c    |  2 ++
 drivers/block/drbd/drbd_state.h    |  4 ++--
 7 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 5faaa8a8e7f0..cae65578001b 100644
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
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.=
h
index 7e0e0a0f27ae..73ceaab3842d 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -197,8 +197,8 @@ struct drbd_device_work {
=20
 extern struct mutex resources_mutex;
=20
-void lock_all_resources(void);
-void unlock_all_resources(void);
+void lock_all_resources(void) __acquires(&resources_mutex);
+void unlock_all_resources(void) __releases(&resources_mutex);
=20
 struct drbd_request {
 	struct drbd_work w;
@@ -1094,7 +1094,8 @@ int drbd_bmio_set_n_write(struct drbd_device *devic=
e,
 			  struct drbd_peer_device *peer_device);
 int drbd_bmio_clear_n_write(struct drbd_device *device,
 			    struct drbd_peer_device *peer_device);
-int drbd_wait_misc(struct drbd_device *device, struct drbd_interval *i);
+int drbd_wait_misc(struct drbd_device *device, struct drbd_interval *i)
+	__must_hold(&device->resource->req_lock);
=20
 /* Meta data layout
  *
@@ -1859,12 +1860,20 @@ static inline void request_ping(struct drbd_conne=
ction *connection)
 	wake_ack_receiver(connection);
 }
=20
-void *conn_prepare_command(struct drbd_connection *, struct drbd_socket =
*);
-void *drbd_prepare_command(struct drbd_peer_device *, struct drbd_socket=
 *);
-int conn_send_command(struct drbd_connection *, struct drbd_socket *,
-		      enum drbd_packet, unsigned int, void *, unsigned int);
-int drbd_send_command(struct drbd_peer_device *, struct drbd_socket *,
-		      enum drbd_packet, unsigned int, void *, unsigned int);
+void *conn_prepare_command(struct drbd_connection *connection,
+			   struct drbd_socket *sock)
+	__cond_acquires(true, &sock->mutex);
+void *drbd_prepare_command(struct drbd_peer_device *peer_device, struct =
drbd_socket *sock)
+	__cond_acquires(true, &sock->mutex);
+int conn_send_command(struct drbd_connection *connection,
+		      struct drbd_socket *sock,
+		      enum drbd_packet cmd, unsigned int header_size,
+		      void *data, unsigned int size)
+	__releases(&sock->mutex);
+int drbd_send_command(struct drbd_peer_device *peer_device, struct drbd_=
socket *sock,
+		      enum drbd_packet cmd, unsigned int header_size,
+		      void *data, unsigned int size)
+	__releases(&sock->mutex);
=20
 int drbd_send_ping(struct drbd_connection *connection);
 int drbd_send_ping_ack(struct drbd_connection *connection);
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_mai=
n.c
index d9eb95aa5c44..6f3c04252b5d 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3659,6 +3659,7 @@ int drbd_wait_misc(struct drbd_device *device, stru=
ct drbd_interval *i)
 }
=20
 void lock_all_resources(void)
+	__context_unsafe(locking loop)
 {
 	struct drbd_resource *resource;
 	int __maybe_unused i =3D 0;
@@ -3670,6 +3671,7 @@ void lock_all_resources(void)
 }
=20
 void unlock_all_resources(void)
+	__context_unsafe(locking loop)
 {
 	struct drbd_resource *resource;
=20
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd=
_receiver.c
index 4e04ff2dc65d..b4a350cd03b0 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -288,6 +288,7 @@ static int drbd_finish_peer_reqs(struct drbd_device *=
device)
=20
 static void _drbd_wait_ee_list_empty(struct drbd_device *device,
 				     struct list_head *head)
+	__must_hold(&device->resource->req_lock)
 {
 	DEFINE_WAIT(wait);
=20
@@ -897,6 +898,8 @@ static int conn_connect(struct drbd_connection *conne=
ction)
 	if (drbd_send_protocol(connection) =3D=3D -EOPNOTSUPP)
 		return -1;
=20
+	/* context_unsafe() because of two locking loops */
+	context_unsafe(
 	/* Prevent a race between resync-handshake and
 	 * being promoted to Primary.
 	 *
@@ -914,6 +917,7 @@ static int conn_connect(struct drbd_connection *conne=
ction)
=20
 	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
 		mutex_unlock(peer_device->device->state_mutex);
+	);
=20
 	rcu_read_lock();
 	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
@@ -2231,6 +2235,7 @@ static blk_opf_t wire_flags_to_bio(struct drbd_conn=
ection *connection, u32 dpf)
=20
 static void fail_postponed_requests(struct drbd_device *device, sector_t=
 sector,
 				    unsigned int size)
+	__must_hold(&device->resource->req_lock)
 {
 	struct drbd_peer_device *peer_device =3D first_peer_device(device);
 	struct drbd_interval *i;
@@ -2257,6 +2262,7 @@ static void fail_postponed_requests(struct drbd_dev=
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
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.=
c
index a851e43c94a8..1cc455846f92 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -953,6 +953,7 @@ static bool remote_due_to_read_balancing(struct drbd_=
device *device, sector_t se
  */
 static void complete_conflicting_writes(struct drbd_resource *resource,
 					struct drbd_request *req)
+	__must_hold(&resource->req_lock)
 {
 	DEFINE_WAIT(wait);
 	struct drbd_device *device =3D req->device;
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_st=
ate.c
index 171c6488283d..a48b2c1b5f15 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -713,6 +713,7 @@ int drbd_request_detach_interruptible(struct drbd_dev=
ice *device)
 enum drbd_state_rv
 _drbd_request_state_holding_state_mutex(struct drbd_device *device, unio=
n drbd_state mask,
 		    union drbd_state val, enum chg_state_flags f)
+	__must_hold(&device->state_mutex)
 {
 	enum drbd_state_rv rv;
=20
@@ -2306,6 +2307,7 @@ _conn_rq_cond(struct drbd_connection *connection, u=
nion drbd_state mask, union d
 enum drbd_state_rv
 _conn_request_state(struct drbd_connection *connection, union drbd_state=
 mask, union drbd_state val,
 		    enum chg_state_flags flags)
+	__context_unsafe(conditional locking)
 {
 	enum drbd_state_rv rv =3D SS_SUCCESS;
 	struct after_conn_state_chg_work *acscw;
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_st=
ate.h
index a7e31d092039..a22ee1916051 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -121,8 +121,8 @@ enum drbd_state_rv _drbd_request_state(struct drbd_de=
vice *, union drbd_state,
 				       union drbd_state, enum chg_state_flags);
=20
 enum drbd_state_rv
-_drbd_request_state_holding_state_mutex(struct drbd_device *, union drbd=
_state,
-					union drbd_state, enum chg_state_flags);
+_drbd_request_state_holding_state_mutex(struct drbd_device *device, unio=
n drbd_state mask,
+		    union drbd_state val, enum chg_state_flags f);
=20
 enum drbd_state_rv _drbd_set_state(struct drbd_device *, union drbd_stat=
e,
 				   enum chg_state_flags,
