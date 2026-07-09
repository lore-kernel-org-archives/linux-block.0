Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F502DCF41
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632997; cv=none; b=tfDAKBPeSt7tUDTXALjMBNBdUBcp1G8zIpi4+qjiRvmMC7tkLXUEVDWTrnxAFA5gSLstryrxiCU8ei7SMkDglNE6GVPhixMYCvXnW3+V5+a2jQI4GIPwKEFfM95Fm4lHD9nIEHfgWKEEvrtoRVj7ZvCEOH+n7BwcLWKYfYjfBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632997; c=relaxed/simple;
	bh=BS8sIisUmufiy5rMbyi2AZWAyez+Pyfr19euPeVvvOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mITTWMUf10xOhdazkgqY0CpV4zW1H0J2vj/yPWwlFd1sJpEdi+Y2uNI1JYQox9kL0XLzJWlFOmUlrExFRX7oifChLiP5seIA2W85aHfD625ufeKTHxqYE1p8UXASM3cp8JnqFG90+OstRerYUaQQQv91Uf9ANbFc2ELSgBQpKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SHmjhRiH; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SHmjhRiH"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gx7ZW4TyczlffvQ;
	Thu,  9 Jul 2026 21:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received; s=mr01; t=1783632985; x=
	1786224986; bh=x5xtvbk8C2nyGsuhgY0OERzwN7eAbuqT0dP15E3cF2o=; b=S
	HmjhRiHG8MIWePr+7efEa6i3L/LQy8hnKSYn9AiBrpUnOXSXO+VYcTgM41YjfqCd
	pDo25hsYpagc3NCbbDjcnloeBS5+bjz1wMFCZ+6EAl+zI3uvPd5B9MKFrnyXVGnN
	66+9JjiljSWAp9cPGjUzZzkVVx1yX6YCBZ1x+4IMtTkJCYxxfKF0Vjxq8qPW+3Mp
	twfaz+YICaB6sss1HruzbcY5Ze9Wo6y9McRa+m2co0lpo/cHJEvGavgOZzjy3p0f
	IgiQZ0n8ha+o9sFEI67c5NeVz2rzqusb7CwzWQX6KmuVaAQ0HfFn5eMrC0k0729W
	XETACMVardz4HDRwBNhnw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id B6SmTOTsDpk3; Thu,  9 Jul 2026 21:36:25 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gx7ZH4HXDzlhH04;
	Thu,  9 Jul 2026 21:36:23 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	=?UTF-8?q?Cc=20=3A=20Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 12/12] drbd: Enable lock context analysis
Date: Thu,  9 Jul 2026 14:35:33 -0700
Message-ID: <f0d908c60c68af345184b6b349edaaa6fa0faa96.1783632330.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <cover.1783632330.git.bvanassche@acm.org>
References: <cover.1783632330.git.bvanassche@acm.org>
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
 6 files changed, 32 insertions(+), 9 deletions(-)

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
index c60c071a666a..416a71d7a61c 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -714,6 +714,7 @@ int drbd_request_detach_interruptible(struct drbd_dev=
ice *device)
 enum drbd_state_rv
 _drbd_request_state_holding_state_mutex(struct drbd_device *device, unio=
n drbd_state mask,
 		    union drbd_state val, enum chg_state_flags f)
+	__must_hold(&device->state_mutex)
 {
 	enum drbd_state_rv rv;
=20
@@ -2307,6 +2308,7 @@ _conn_rq_cond(struct drbd_connection *connection, u=
nion drbd_state mask, union d
 enum drbd_state_rv
 _conn_request_state(struct drbd_connection *connection, union drbd_state=
 mask, union drbd_state val,
 		    enum chg_state_flags flags)
+	__context_unsafe(conditional locking)
 {
 	enum drbd_state_rv rv =3D SS_SUCCESS;
 	struct after_conn_state_chg_work *acscw;
