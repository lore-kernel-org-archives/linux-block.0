Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5880DC10F0D
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1506220989
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kz/4MMdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfCRTsa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:48:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfCRTsa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=syPNaKyPeHJalobdeO/7vC2pGxao4lfo8CHz8FE1ntg=; b=Kz/4MMdQi2cV16gyCmldt7Kdb
        enkKBVqb0EupDQQ9M57xlLpf/3NhkZSPiOpeyRft3BqFb1kRmV11D6kBmetN+W3RKiw1zkl0Ubg0M
        Fn+7vXEJUD0f0fMBHiyd5w+gzhuI3rtNGTQMRnm+hJMsZ5HUKN4JrgAUnoc2arKfdFguCHsw/ktqc
        tadp0Ztd0ETVVUbgzGOUnj/VJuaOdfhP1dNp/g2iMS9m+VzFvea6lURdVguBVHkXQ/cYPxfQfdWJz
        +BedaMQrvf8kVKaesXYrvMvYgI/SxOamn+bGk+DDhByCKkbF3BuV9ji8DX7WA7f2KpTZH8N66SYqx
        GHaFmxOaA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5yFJ-0000wQ-S3; Mon, 18 Mar 2019 19:48:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 14/14] drbd: Convert peer devices to XArray
Date:   Mon, 18 Mar 2019 12:48:21 -0700
Message-Id: <20190318194821.3470-15-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190318194821.3470-1-willy@infradead.org>
References: <20190318194821.3470-1-willy@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/block/drbd/drbd_int.h      |  4 +-
 drivers/block/drbd/drbd_main.c     | 25 +++++++------
 drivers/block/drbd/drbd_nl.c       | 35 +++++++++---------
 drivers/block/drbd/drbd_receiver.c | 29 ++++++++-------
 drivers/block/drbd/drbd_state.c    | 59 +++++++++++++++---------------
 drivers/block/drbd/drbd_worker.c   | 12 +++---
 6 files changed, 84 insertions(+), 80 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 4e68b5f8265b..375418164a2c 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -705,7 +705,7 @@ struct drbd_connection {
 	struct dentry *debugfs_conn_oldest_requests;
 #endif
 	struct kref kref;
-	struct idr peer_devices;	/* volume number to peer device mapping */
+	struct xarray peer_devices;	/* volume number to peer device mapping */
 	enum drbd_conns cstate;		/* Only C_STANDALONE to C_WF_REPORT_PARAMS */
 	struct mutex cstate_mutex;	/* Protects graceful disconnects */
 	unsigned int connect_cnt;	/* Inc each time a connection is established */
@@ -1033,7 +1033,7 @@ static inline struct drbd_peer_device *first_peer_device(struct drbd_device *dev
 static inline struct drbd_peer_device *
 conn_peer_device(struct drbd_connection *connection, int volume_number)
 {
-	return idr_find(&connection->peer_devices, volume_number);
+	return xa_load(&connection->peer_devices, volume_number);
 }
 
 #define for_each_resource(resource, _resources) \
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 2f3b18e0223b..c292fbdddfec 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -489,10 +489,12 @@ void _drbd_thread_stop(struct drbd_thread *thi, int restart, int wait)
 int conn_lowest_minor(struct drbd_connection *connection)
 {
 	struct drbd_peer_device *peer_device;
-	int vnr = 0, minor = -1;
+	unsigned long vnr = 0;
+	int minor = -1;
 
 	rcu_read_lock();
-	peer_device = idr_get_next(&connection->peer_devices, &vnr);
+	peer_device = xa_find(&connection->peer_devices, &vnr,
+			ULONG_MAX, XA_PRESENT);
 	if (peer_device)
 		minor = device_to_minor(peer_device->device);
 	rcu_read_unlock();
@@ -2712,7 +2714,7 @@ struct drbd_connection *conn_create(const char *name, struct res_opts *res_opts)
 	connection->cstate = C_STANDALONE;
 	mutex_init(&connection->cstate_mutex);
 	init_waitqueue_head(&connection->ping_wait);
-	idr_init(&connection->peer_devices);
+	xa_init(&connection->peer_devices);
 
 	drbd_init_workqueue(&connection->sender_work);
 	mutex_init(&connection->data.mutex);
@@ -2757,7 +2759,7 @@ void drbd_destroy_connection(struct kref *kref)
 		drbd_err(connection, "epoch_size:%d\n", atomic_read(&connection->current_epoch->epoch_size));
 	kfree(connection->current_epoch);
 
-	idr_destroy(&connection->peer_devices);
+	xa_destroy(&connection->peer_devices);
 
 	drbd_free_socket(&connection->meta);
 	drbd_free_socket(&connection->data);
@@ -2881,9 +2883,10 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 		list_add(&peer_device->peer_devices, &device->peer_devices);
 		kref_get(&device->kref);
 
-		ret = idr_alloc(&connection->peer_devices, peer_device, vnr, vnr + 1, GFP_KERNEL);
+		ret = xa_insert(&connection->peer_devices, vnr, peer_device,
+				GFP_KERNEL);
 		if (ret < 0) {
-			if (ret == -ENOSPC)
+			if (ret == -EBUSY)
 				err = ERR_INVALID_REQUEST;
 			goto out_remove_from_resource;
 		}
@@ -2911,10 +2914,10 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	return NO_ERROR;
 
 out_idr_remove_vol:
-	idr_remove(&connection->peer_devices, vnr);
+	xa_erase(&connection->peer_devices, vnr);
 out_remove_from_resource:
 	for_each_connection(connection, resource) {
-		peer_device = idr_remove(&connection->peer_devices, vnr);
+		peer_device = xa_erase(&connection->peer_devices, vnr);
 		if (peer_device)
 			kref_put(&connection->kref, drbd_destroy_connection);
 	}
@@ -2951,7 +2954,7 @@ void drbd_delete_device(struct drbd_device *device)
 		drbd_debugfs_peer_device_cleanup(peer_device);
 	drbd_debugfs_device_cleanup(device);
 	for_each_connection(connection, resource) {
-		idr_remove(&connection->peer_devices, device->vnr);
+		xa_erase(&connection->peer_devices, device->vnr);
 		kref_put(&device->kref, drbd_destroy_device);
 	}
 	xa_erase(&resource->devices, device->vnr);
@@ -3066,10 +3069,10 @@ void drbd_free_sock(struct drbd_connection *connection)
 void conn_md_sync(struct drbd_connection *connection)
 {
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 
 		kref_get(&device->kref);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 67c1a343a595..9f599c85b3d2 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -457,10 +457,10 @@ static enum drbd_fencing_p highest_fencing_policy(struct drbd_connection *connec
 {
 	enum drbd_fencing_p fp = FP_NOT_AVAIL;
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		if (get_ldev_if_state(device, D_CONSISTENT)) {
 			struct disk_conf *disk_conf =
@@ -2271,10 +2271,10 @@ static bool conn_resync_running(struct drbd_connection *connection)
 {
 	struct drbd_peer_device *peer_device;
 	bool rv = false;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		if (device->state.conn == C_SYNC_SOURCE ||
 		    device->state.conn == C_SYNC_TARGET ||
@@ -2293,10 +2293,10 @@ static bool conn_ov_running(struct drbd_connection *connection)
 {
 	struct drbd_peer_device *peer_device;
 	bool rv = false;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		if (device->state.conn == C_VERIFY_S ||
 		    device->state.conn == C_VERIFY_T) {
@@ -2313,7 +2313,7 @@ static enum drbd_ret_code
 _check_net_options(struct drbd_connection *connection, struct net_conf *old_net_conf, struct net_conf *new_net_conf)
 {
 	struct drbd_peer_device *peer_device;
-	int i;
+	unsigned long i;
 
 	if (old_net_conf && connection->cstate == C_WF_REPORT_PARAMS && connection->agreed_pro_version < 100) {
 		if (new_net_conf->wire_protocol != old_net_conf->wire_protocol)
@@ -2335,7 +2335,7 @@ _check_net_options(struct drbd_connection *connection, struct net_conf *old_net_
 	    (new_net_conf->wire_protocol != DRBD_PROT_C))
 		return ERR_NOT_PROTO_C;
 
-	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
+	xa_for_each(&connection->peer_devices, i, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		if (get_ldev(device)) {
 			enum drbd_fencing_p fp = rcu_dereference(device->ldev->disk_conf)->fencing;
@@ -2358,14 +2358,14 @@ check_net_options(struct drbd_connection *connection, struct net_conf *new_net_c
 {
 	enum drbd_ret_code rv;
 	struct drbd_peer_device *peer_device;
-	int i;
+	unsigned long i;
 
 	rcu_read_lock();
 	rv = _check_net_options(connection, rcu_dereference(connection->net_conf), new_net_conf);
 	rcu_read_unlock();
 
 	/* connection->peer_devices protected by genl_lock() here */
-	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
+	xa_for_each(&connection->peer_devices, i, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		if (!device->bitmap) {
 			if (drbd_bm_init(device))
@@ -2535,9 +2535,9 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 
 	if (connection->cstate >= C_WF_REPORT_PARAMS) {
 		struct drbd_peer_device *peer_device;
-		int vnr;
+		unsigned long vnr;
 
-		idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+		xa_for_each(&connection->peer_devices, vnr, peer_device)
 			drbd_send_sync_param(peer_device);
 	}
 
@@ -2589,7 +2589,7 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	struct drbd_resource *resource;
 	struct drbd_connection *connection;
 	enum drbd_ret_code retcode;
-	int i;
+	unsigned long i;
 	int err;
 
 	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_RESOURCE);
@@ -2682,7 +2682,7 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	connection->peer_addr_len = nla_len(adm_ctx.peer_addr);
 	memcpy(&connection->peer_addr, nla_data(adm_ctx.peer_addr), connection->peer_addr_len);
 
-	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
+	xa_for_each(&connection->peer_devices, i, peer_device) {
 		peer_devices++;
 	}
 
@@ -2690,7 +2690,7 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	flags = (peer_devices--) ? NOTIFY_CONTINUES : 0;
 	mutex_lock(&notification_mutex);
 	notify_connection_state(NULL, 0, connection, &connection_info, NOTIFY_CREATE | flags);
-	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
+	xa_for_each(&connection->peer_devices, i, peer_device) {
 		struct peer_device_info peer_device_info;
 
 		peer_device_to_info(&peer_device_info, peer_device);
@@ -2701,7 +2701,7 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	mutex_unlock(&adm_ctx.resource->conf_update);
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, i) {
+	xa_for_each(&connection->peer_devices, i, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		device->send_cnt = 0;
 		device->recv_cnt = 0;
@@ -4515,7 +4515,6 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 	struct drbd_connection *connection;
 	struct drbd_device *device;
 	int retcode; /* enum drbd_ret_code rsp. enum drbd_state_rv */
-	unsigned i;
 	unsigned long index;
 
 	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_RESOURCE);
@@ -4530,7 +4529,7 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 	for_each_connection(connection, resource) {
 		struct drbd_peer_device *peer_device;
 
-		idr_for_each_entry(&connection->peer_devices, peer_device, i) {
+		xa_for_each(&connection->peer_devices, index, peer_device) {
 			retcode = drbd_set_role(peer_device->device, R_SECONDARY, 0);
 			if (retcode < SS_SUCCESS) {
 				drbd_msg_put_info(adm_ctx.reply_skb, "failed to demote");
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index f87bd8a034b2..88b9de71833e 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -232,10 +232,10 @@ static void drbd_reclaim_net_peer_reqs(struct drbd_device *device)
 static void conn_reclaim_net_peer_reqs(struct drbd_connection *connection)
 {
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		if (!atomic_read(&device->pp_in_use_by_net))
 			continue;
@@ -935,7 +935,8 @@ static int conn_connect(struct drbd_connection *connection)
 	struct drbd_socket sock, msock;
 	struct drbd_peer_device *peer_device;
 	struct net_conf *nc;
-	int vnr, timeout, h;
+	int timeout, h;
+	unsigned long vnr;
 	bool discard_my_data, ok;
 	enum drbd_state_rv rv;
 	struct accept_wait_data ad = {
@@ -1098,7 +1099,7 @@ static int conn_connect(struct drbd_connection *connection)
 	 * drbd_set_role() is finished, and any incoming drbd_set_role
 	 * will see the STATE_SENT flag, and wait for it to be cleared.
 	 */
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+	xa_for_each(&connection->peer_devices, vnr, peer_device)
 		mutex_lock(peer_device->device->state_mutex);
 
 	/* avoid a race with conn_request_state( C_DISCONNECTING ) */
@@ -1106,11 +1107,11 @@ static int conn_connect(struct drbd_connection *connection)
 	set_bit(STATE_SENT, &connection->flags);
 	spin_unlock_irq(&connection->resource->req_lock);
 
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+	xa_for_each(&connection->peer_devices, vnr, peer_device)
 		mutex_unlock(peer_device->device->state_mutex);
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		kref_get(&device->kref);
 		rcu_read_unlock();
@@ -1323,14 +1324,14 @@ static void drbd_flush(struct drbd_connection *connection)
 	if (connection->resource->write_ordering >= WO_BDEV_FLUSH) {
 		struct drbd_peer_device *peer_device;
 		struct issue_flush_context ctx;
-		int vnr;
+		unsigned long vnr;
 
 		atomic_set(&ctx.pending, 1);
 		ctx.error = 0;
 		init_completion(&ctx.done);
 
 		rcu_read_lock();
-		idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+		xa_for_each(&connection->peer_devices, vnr, peer_device) {
 			struct drbd_device *device = peer_device->device;
 
 			if (!get_ldev(device))
@@ -1763,10 +1764,10 @@ static void drbd_remove_epoch_entry_interval(struct drbd_device *device,
 static void conn_wait_active_ee_empty(struct drbd_connection *connection)
 {
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 
 		kref_get(&device->kref);
@@ -5166,7 +5167,7 @@ static void conn_disconnect(struct drbd_connection *connection)
 {
 	struct drbd_peer_device *peer_device;
 	enum drbd_conns oc;
-	int vnr;
+	unsigned long vnr;
 
 	if (connection->cstate == C_STANDALONE)
 		return;
@@ -5187,7 +5188,7 @@ static void conn_disconnect(struct drbd_connection *connection)
 	drbd_free_sock(connection);
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		kref_get(&device->kref);
 		rcu_read_unlock();
@@ -5881,12 +5882,12 @@ static int got_BarrierAck(struct drbd_connection *connection, struct packet_info
 {
 	struct p_barrier_ack *p = pi->data;
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 
 	tl_release(connection, p->barrier, be32_to_cpu(p->set_size));
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 
 		if (device->state.conn == C_AHEAD &&
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index c3587054fa1e..f6a93cda2028 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -307,10 +307,10 @@ bool conn_all_vols_unconf(struct drbd_connection *connection)
 {
 	struct drbd_peer_device *peer_device;
 	bool rv = true;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		if (device->state.disk != D_DISKLESS ||
 		    device->state.conn != C_STANDALONE ||
@@ -348,10 +348,10 @@ enum drbd_role conn_highest_role(struct drbd_connection *connection)
 {
 	enum drbd_role role = R_SECONDARY;
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		role = max_role(role, device->state.role);
 	}
@@ -364,10 +364,10 @@ enum drbd_role conn_highest_peer(struct drbd_connection *connection)
 {
 	enum drbd_role peer = R_UNKNOWN;
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		peer = max_role(peer, device->state.peer);
 	}
@@ -380,10 +380,10 @@ enum drbd_disk_state conn_highest_disk(struct drbd_connection *connection)
 {
 	enum drbd_disk_state disk_state = D_DISKLESS;
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		disk_state = max_t(enum drbd_disk_state, disk_state, device->state.disk);
 	}
@@ -396,10 +396,10 @@ enum drbd_disk_state conn_lowest_disk(struct drbd_connection *connection)
 {
 	enum drbd_disk_state disk_state = D_MASK;
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		disk_state = min_t(enum drbd_disk_state, disk_state, device->state.disk);
 	}
@@ -412,10 +412,10 @@ enum drbd_disk_state conn_highest_pdsk(struct drbd_connection *connection)
 {
 	enum drbd_disk_state disk_state = D_DISKLESS;
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		disk_state = max_t(enum drbd_disk_state, disk_state, device->state.pdsk);
 	}
@@ -428,10 +428,10 @@ enum drbd_conns conn_lowest_conn(struct drbd_connection *connection)
 {
 	enum drbd_conns conn = C_MASK;
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		conn = min_t(enum drbd_conns, conn, device->state.conn);
 	}
@@ -443,11 +443,11 @@ enum drbd_conns conn_lowest_conn(struct drbd_connection *connection)
 static bool no_peer_wf_report_params(struct drbd_connection *connection)
 {
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 	bool rv = true;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+	xa_for_each(&connection->peer_devices, vnr, peer_device)
 		if (peer_device->device->state.conn == C_WF_REPORT_PARAMS) {
 			rv = false;
 			break;
@@ -460,10 +460,10 @@ static bool no_peer_wf_report_params(struct drbd_connection *connection)
 static void wake_up_all_devices(struct drbd_connection *connection)
 {
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+	xa_for_each(&connection->peer_devices, vnr, peer_device)
 		wake_up(&peer_device->device->state_wait);
 	rcu_read_unlock();
 
@@ -1767,10 +1767,10 @@ static void after_state_ch(struct drbd_device *device, union drbd_state os,
 		if (resource->susp_fen && conn_lowest_conn(connection) >= C_CONNECTED) {
 			/* case2: The connection was established again: */
 			struct drbd_peer_device *peer_device;
-			int vnr;
+			unsigned long vnr;
 
 			rcu_read_lock();
-			idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+			xa_for_each(&connection->peer_devices, vnr, peer_device)
 				clear_bit(NEW_CUR_UUID, &peer_device->device->flags);
 			rcu_read_unlock();
 
@@ -2054,7 +2054,7 @@ static int w_after_conn_state_ch(struct drbd_work *w, int unused)
 	enum drbd_conns oc = acscw->oc;
 	union drbd_state ns_max = acscw->ns_max;
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 
 	broadcast_state_change(acscw->state_change);
 	forget_state_change(acscw->state_change);
@@ -2068,7 +2068,7 @@ static int w_after_conn_state_ch(struct drbd_work *w, int unused)
 		struct net_conf *old_conf;
 
 		mutex_lock(&notification_mutex);
-		idr_for_each_entry(&connection->peer_devices, peer_device, vnr)
+		xa_for_each(&connection->peer_devices, vnr, peer_device)
 			notify_peer_device_state(NULL, 0, peer_device, NULL,
 						 NOTIFY_DESTROY | NOTIFY_CONTINUES);
 		notify_connection_state(NULL, 0, connection, NULL, NOTIFY_DESTROY);
@@ -2090,7 +2090,7 @@ static int w_after_conn_state_ch(struct drbd_work *w, int unused)
 		/* case1: The outdate peer handler is successful: */
 		if (ns_max.pdsk <= D_OUTDATED) {
 			rcu_read_lock();
-			idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+			xa_for_each(&connection->peer_devices, vnr, peer_device) {
 				struct drbd_device *device = peer_device->device;
 				if (test_bit(NEW_CUR_UUID, &device->flags)) {
 					drbd_uuid_new_current(device);
@@ -2117,7 +2117,8 @@ static void conn_old_common_state(struct drbd_connection *connection, union drbd
 {
 	enum chg_state_flags flags = ~0;
 	struct drbd_peer_device *peer_device;
-	int vnr, first_vol = 1;
+	unsigned long vnr;
+	bool first_vol = true;
 	union drbd_dev_state os, cs = {
 		{ .role = R_SECONDARY,
 		  .peer = R_UNKNOWN,
@@ -2127,7 +2128,7 @@ static void conn_old_common_state(struct drbd_connection *connection, union drbd
 		} };
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		os = device->state;
 
@@ -2166,10 +2167,10 @@ conn_is_valid_transition(struct drbd_connection *connection, union drbd_state ma
 	enum drbd_state_rv rv = SS_SUCCESS;
 	union drbd_state ns, os;
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		os = drbd_read_state(device);
 		ns = sanitize_state(device, os, apply_mask_val(os, mask, val), NULL);
@@ -2216,7 +2217,7 @@ conn_set_state(struct drbd_connection *connection, union drbd_state mask, union
 		} };
 	struct drbd_peer_device *peer_device;
 	enum drbd_state_rv rv;
-	int vnr, number_of_volumes = 0;
+	unsigned long vnr, number_of_volumes = 0;
 
 	if (mask.conn == C_MASK) {
 		/* remember last connect time so request_timer_fn() won't
@@ -2229,7 +2230,7 @@ conn_set_state(struct drbd_connection *connection, union drbd_state mask, union
 	}
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		number_of_volumes++;
 		os = drbd_read_state(device);
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 614aa963700c..ece947ba341d 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1013,8 +1013,8 @@ int drbd_resync_finished(struct drbd_device *device)
 		fp = rcu_dereference(device->ldev->disk_conf)->fencing;
 		if (fp != FP_DONT_CARE) {
 			struct drbd_peer_device *peer_device;
-			int vnr;
-			idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+			unsigned long vnr;
+			xa_for_each(&connection->peer_devices, vnr, peer_device) {
 				struct drbd_device *device = peer_device->device;
 				disk_state = min_t(enum drbd_disk_state, disk_state, device->state.disk);
 				pdsk_state = min_t(enum drbd_disk_state, pdsk_state, device->state.pdsk);
@@ -2062,10 +2062,10 @@ static unsigned long get_work_bits(unsigned long *flags)
 static void do_unqueued_work(struct drbd_connection *connection)
 {
 	struct drbd_peer_device *peer_device;
-	int vnr;
+	unsigned long vnr;
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		unsigned long todo = get_work_bits(&device->flags);
 		if (!todo)
@@ -2179,7 +2179,7 @@ int drbd_worker(struct drbd_thread *thi)
 	struct drbd_work *w = NULL;
 	struct drbd_peer_device *peer_device;
 	LIST_HEAD(work_list);
-	int vnr;
+	unsigned long vnr;
 
 	while (get_t_state(thi) == RUNNING) {
 		drbd_thread_current_set_cpu(thi);
@@ -2232,7 +2232,7 @@ int drbd_worker(struct drbd_thread *thi)
 	} while (!list_empty(&work_list) || test_bit(DEVICE_WORK_PENDING, &connection->flags));
 
 	rcu_read_lock();
-	idr_for_each_entry(&connection->peer_devices, peer_device, vnr) {
+	xa_for_each(&connection->peer_devices, vnr, peer_device) {
 		struct drbd_device *device = peer_device->device;
 		D_ASSERT(device, device->state.disk == D_DISKLESS && device->state.conn == C_STANDALONE);
 		kref_get(&device->kref);
-- 
2.20.1

