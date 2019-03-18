Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFA5C10F10
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20662133F
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AxMidq+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfCRTsa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:48:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbfCRTsa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fbn0hOZXTaH//51hQ9uMk96e0SP6ig2f7P3BksZdLtU=; b=AxMidq+p2ljaornnhjbhjRlnF
        i4XLRflV1/ICRFlBQVd12FwRIN99M111rpCtmCfJPSEhOYmorG8oWWNFi/HGkzs3rfdQ0ytQR6c6H
        eoKMjnAc5VzvylJOGFHq/cJSk+eOXNLPy1EQHdUVcFfBU0l4fR985noJVVB79/eJvyb885B0ZIgPH
        3/AaL3lcY43w0cgTxG0MkJsJB3PE7qqjta1Ln11uzCytGHqmVuUZ9QnzBH7A4h8toJhzUtBnYwZzf
        AadsmDhwT9AWxKlQkwhI/inErB0xwCPT7eaoASpptUAfR5vqYo159fORVv/3gw4mivbVyC+0EQT1W
        /1xisUrTQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5yFJ-0000wL-Mw; Mon, 18 Mar 2019 19:48:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 13/14] drbd: Convert drbd devices to XArray
Date:   Mon, 18 Mar 2019 12:48:20 -0700
Message-Id: <20190318194821.3470-14-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190318194821.3470-1-willy@infradead.org>
References: <20190318194821.3470-1-willy@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/block/drbd/drbd_debugfs.c  | 16 ++++-----
 drivers/block/drbd/drbd_int.h      |  6 ++--
 drivers/block/drbd/drbd_main.c     | 56 ++++++++++++++----------------
 drivers/block/drbd/drbd_nl.c       | 42 +++++++++++-----------
 drivers/block/drbd/drbd_proc.c     |  8 ++---
 drivers/block/drbd/drbd_receiver.c |  4 +--
 drivers/block/drbd/drbd_state.c    |  8 ++---
 drivers/block/drbd/drbd_worker.c   |  8 ++---
 8 files changed, 72 insertions(+), 76 deletions(-)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index f13b48ff5f43..a1336bbf5083 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -128,11 +128,11 @@ static void seq_print_minor_vnr_req(struct seq_file *m, struct drbd_request *req
 static void seq_print_resource_pending_meta_io(struct seq_file *m, struct drbd_resource *resource, unsigned long now)
 {
 	struct drbd_device *device;
-	unsigned int i;
+	unsigned long i;
 
 	seq_puts(m, "minor\tvnr\tstart\tsubmit\tintent\n");
 	rcu_read_lock();
-	idr_for_each_entry(&resource->devices, device, i) {
+	xa_for_each(&resource->devices, i, device) {
 		struct drbd_md_io tmp;
 		/* In theory this is racy,
 		 * in the sense that there could have been a
@@ -156,11 +156,11 @@ static void seq_print_resource_pending_meta_io(struct seq_file *m, struct drbd_r
 static void seq_print_waiting_for_AL(struct seq_file *m, struct drbd_resource *resource, unsigned long now)
 {
 	struct drbd_device *device;
-	unsigned int i;
+	unsigned long i;
 
 	seq_puts(m, "minor\tvnr\tage\t#waiting\n");
 	rcu_read_lock();
-	idr_for_each_entry(&resource->devices, device, i) {
+	xa_for_each(&resource->devices, i, device) {
 		unsigned long jif;
 		struct drbd_request *req;
 		int n = atomic_read(&device->ap_actlog_cnt);
@@ -216,11 +216,11 @@ static void seq_print_device_bitmap_io(struct seq_file *m, struct drbd_device *d
 static void seq_print_resource_pending_bitmap_io(struct seq_file *m, struct drbd_resource *resource, unsigned long now)
 {
 	struct drbd_device *device;
-	unsigned int i;
+	unsigned long i;
 
 	seq_puts(m, "minor\tvnr\trw\tage\t#in-flight\n");
 	rcu_read_lock();
-	idr_for_each_entry(&resource->devices, device, i) {
+	xa_for_each(&resource->devices, i, device) {
 		seq_print_device_bitmap_io(m, device, now);
 	}
 	rcu_read_unlock();
@@ -288,10 +288,10 @@ static void seq_print_resource_pending_peer_requests(struct seq_file *m,
 	struct drbd_resource *resource, unsigned long now)
 {
 	struct drbd_device *device;
-	unsigned int i;
+	unsigned long i;
 
 	rcu_read_lock();
-	idr_for_each_entry(&resource->devices, device, i) {
+	xa_for_each(&resource->devices, i, device) {
 		seq_print_device_peer_requests(m, device, now);
 	}
 	rcu_read_unlock();
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 000a2f4c0e92..4e68b5f8265b 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -189,7 +189,7 @@ drbd_insert_fault(struct drbd_device *device, unsigned int type) {
 #define div_floor(A, B) ((A)/(B))
 
 extern struct ratelimit_state drbd_ratelimit_state;
-extern struct idr drbd_devices; /* RCU, updates: genl_lock() */
+extern struct xarray drbd_devices; /* RCU, updates: genl_lock() */
 extern struct list_head drbd_resources; /* RCU, updates: genl_lock() */
 
 extern const char *cmdname(enum drbd_packet cmd);
@@ -670,7 +670,7 @@ struct drbd_resource {
 	struct dentry *debugfs_res_in_flight_summary;
 #endif
 	struct kref kref;
-	struct idr devices;		/* volume number to device mapping */
+	struct xarray devices;		/* volume number to device mapping */
 	struct list_head connections;
 	struct list_head resources;
 	struct res_opts res_opts;
@@ -1022,7 +1022,7 @@ struct drbd_config_context {
 
 static inline struct drbd_device *minor_to_device(unsigned int minor)
 {
-	return (struct drbd_device *)idr_find(&drbd_devices, minor);
+	return xa_load(&drbd_devices, minor);
 }
 
 static inline struct drbd_peer_device *first_peer_device(struct drbd_device *device)
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 714eb64fabfd..2f3b18e0223b 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -116,7 +116,7 @@ module_param_string(usermode_helper, drbd_usermode_helper, sizeof(drbd_usermode_
 /* in 2.6.x, our device mapping and config info contains our virtual gendisks
  * as member "struct gendisk *vdisk;"
  */
-struct idr drbd_devices;
+DEFINE_XARRAY(drbd_devices);
 struct list_head drbd_resources;
 struct mutex resources_mutex;
 
@@ -2364,7 +2364,7 @@ void drbd_destroy_resource(struct kref *kref)
 	struct drbd_resource *resource =
 		container_of(kref, struct drbd_resource, kref);
 
-	idr_destroy(&resource->devices);
+	xa_destroy(&resource->devices);
 	free_cpumask_var(resource->cpu_mask);
 	kfree(resource->name);
 	memset(resource, 0xf2, sizeof(*resource));
@@ -2386,7 +2386,7 @@ void drbd_free_resource(struct drbd_resource *resource)
 
 static void drbd_cleanup(void)
 {
-	unsigned int i;
+	unsigned long i;
 	struct drbd_device *device;
 	struct drbd_resource *resource, *tmp;
 
@@ -2406,8 +2406,9 @@ static void drbd_cleanup(void)
 
 	drbd_genl_unregister();
 
-	idr_for_each_entry(&drbd_devices, device, i)
+	xa_for_each(&drbd_devices, i, device)
 		drbd_delete_device(device);
+	xa_destroy(&drbd_devices);
 
 	/* not _rcu since, no other updater anymore. Genl already unregistered */
 	for_each_resource_safe(resource, tmp, &drbd_resources) {
@@ -2420,8 +2421,6 @@ static void drbd_cleanup(void)
 	drbd_destroy_mempools();
 	unregister_blkdev(DRBD_MAJOR, "drbd");
 
-	idr_destroy(&drbd_devices);
-
 	pr_info("module cleanup done.\n");
 }
 
@@ -2659,7 +2658,7 @@ struct drbd_resource *drbd_create_resource(const char *name)
 	if (!zalloc_cpumask_var(&resource->cpu_mask, GFP_KERNEL))
 		goto fail_free_name;
 	kref_init(&resource->kref);
-	idr_init(&resource->devices);
+	xa_init(&resource->devices);
 	INIT_LIST_HEAD(&resource->connections);
 	resource->write_ordering = WO_BDEV_FLUSH;
 	list_add_tail_rcu(&resource->resources, &drbd_resources);
@@ -2791,7 +2790,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	struct drbd_peer_device *peer_device, *tmp_peer_device;
 	struct gendisk *disk;
 	struct request_queue *q;
-	int id;
+	int ret;
 	int vnr = adm_ctx->volume;
 	enum drbd_ret_code err = ERR_NOMEM;
 
@@ -2854,19 +2853,19 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	device->read_requests = RB_ROOT;
 	device->write_requests = RB_ROOT;
 
-	id = idr_alloc(&drbd_devices, device, minor, minor + 1, GFP_KERNEL);
-	if (id < 0) {
-		if (id == -ENOSPC)
+	ret = xa_insert(&drbd_devices, minor, device, GFP_KERNEL);
+	if (ret < 0) {
+		if (ret == -EBUSY)
 			err = ERR_MINOR_OR_VOLUME_EXISTS;
-		goto out_no_minor_idr;
+		goto out_no_minor;
 	}
 	kref_get(&device->kref);
 
-	id = idr_alloc(&resource->devices, device, vnr, vnr + 1, GFP_KERNEL);
-	if (id < 0) {
-		if (id == -ENOSPC)
+	ret = xa_insert(&resource->devices, vnr, device, GFP_KERNEL);
+	if (ret < 0) {
+		if (ret == -EBUSY)
 			err = ERR_MINOR_OR_VOLUME_EXISTS;
-		goto out_idr_remove_minor;
+		goto out_remove_minor;
 	}
 	kref_get(&device->kref);
 
@@ -2875,18 +2874,18 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	for_each_connection(connection, resource) {
 		peer_device = kzalloc(sizeof(struct drbd_peer_device), GFP_KERNEL);
 		if (!peer_device)
-			goto out_idr_remove_from_resource;
+			goto out_remove_from_resource;
 		peer_device->connection = connection;
 		peer_device->device = device;
 
 		list_add(&peer_device->peer_devices, &device->peer_devices);
 		kref_get(&device->kref);
 
-		id = idr_alloc(&connection->peer_devices, peer_device, vnr, vnr + 1, GFP_KERNEL);
-		if (id < 0) {
-			if (id == -ENOSPC)
+		ret = idr_alloc(&connection->peer_devices, peer_device, vnr, vnr + 1, GFP_KERNEL);
+		if (ret < 0) {
+			if (ret == -ENOSPC)
 				err = ERR_INVALID_REQUEST;
-			goto out_idr_remove_from_resource;
+			goto out_remove_from_resource;
 		}
 		kref_get(&connection->kref);
 		INIT_WORK(&peer_device->send_acks_work, drbd_send_acks_wf);
@@ -2913,7 +2912,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 out_idr_remove_vol:
 	idr_remove(&connection->peer_devices, vnr);
-out_idr_remove_from_resource:
+out_remove_from_resource:
 	for_each_connection(connection, resource) {
 		peer_device = idr_remove(&connection->peer_devices, vnr);
 		if (peer_device)
@@ -2923,11 +2922,11 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 		list_del(&peer_device->peer_devices);
 		kfree(peer_device);
 	}
-	idr_remove(&resource->devices, vnr);
-out_idr_remove_minor:
-	idr_remove(&drbd_devices, minor);
+	xa_erase(&resource->devices, vnr);
+out_remove_minor:
+	xa_erase(&drbd_devices, minor);
 	synchronize_rcu();
-out_no_minor_idr:
+out_no_minor:
 	drbd_bm_cleanup(device);
 out_no_bitmap:
 	__free_page(device->md_io.page);
@@ -2955,9 +2954,9 @@ void drbd_delete_device(struct drbd_device *device)
 		idr_remove(&connection->peer_devices, device->vnr);
 		kref_put(&device->kref, drbd_destroy_device);
 	}
-	idr_remove(&resource->devices, device->vnr);
+	xa_erase(&resource->devices, device->vnr);
 	kref_put(&device->kref, drbd_destroy_device);
-	idr_remove(&drbd_devices, device_to_minor(device));
+	xa_erase(&drbd_devices, device_to_minor(device));
 	kref_put(&device->kref, drbd_destroy_device);
 	del_gendisk(device->vdisk);
 	synchronize_rcu();
@@ -2990,7 +2989,6 @@ static int __init drbd_init(void)
 	init_waitqueue_head(&drbd_pp_wait);
 
 	drbd_proc = NULL; /* play safe for drbd_cleanup */
-	idr_init(&drbd_devices);
 
 	mutex_init(&resources_mutex);
 	INIT_LIST_HEAD(&drbd_resources);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index f2471172a961..67c1a343a595 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3436,11 +3436,12 @@ int drbd_adm_dump_devices(struct sk_buff *skb, struct netlink_callback *cb)
 	struct nlattr *resource_filter;
 	struct drbd_resource *resource;
 	struct drbd_device *uninitialized_var(device);
-	int minor, err, retcode;
+	int err, retcode;
+	unsigned long minor;
 	struct drbd_genlmsghdr *dh;
 	struct device_info device_info;
 	struct device_statistics device_statistics;
-	struct idr *idr_to_search;
+	struct xarray *devices;
 
 	resource = (struct drbd_resource *)cb->args[0];
 	if (!cb->args[0] && !cb->args[1]) {
@@ -3456,18 +3457,13 @@ int drbd_adm_dump_devices(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	minor = cb->args[1];
-	idr_to_search = resource ? &resource->devices : &drbd_devices;
-	device = idr_get_next(idr_to_search, &minor);
+	devices = resource ? &resource->devices : &drbd_devices;
+	device = xa_find_after(devices, &minor, ULONG_MAX, XA_PRESENT);
 	if (!device) {
 		err = 0;
 		goto out;
 	}
-	idr_for_each_entry_continue(idr_to_search, device, minor) {
-		retcode = NO_ERROR;
-		goto put_result;  /* only one iteration */
-	}
-	err = 0;
-	goto out;  /* no more devices */
+	retcode = NO_ERROR;
 
 put_result:
 	dh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
@@ -3688,9 +3684,10 @@ int drbd_adm_dump_peer_devices(struct sk_buff *skb, struct netlink_callback *cb)
 	struct drbd_resource *resource;
 	struct drbd_device *uninitialized_var(device);
 	struct drbd_peer_device *peer_device = NULL;
-	int minor, err, retcode;
+	int err, retcode;
+	unsigned long minor;
 	struct drbd_genlmsghdr *dh;
-	struct idr *idr_to_search;
+	struct xarray *devices;
 
 	resource = (struct drbd_resource *)cb->args[0];
 	if (!cb->args[0] && !cb->args[1]) {
@@ -3706,13 +3703,12 @@ int drbd_adm_dump_peer_devices(struct sk_buff *skb, struct netlink_callback *cb)
 
 	rcu_read_lock();
 	minor = cb->args[1];
-	idr_to_search = resource ? &resource->devices : &drbd_devices;
-	device = idr_find(idr_to_search, minor);
+	devices = resource ? &resource->devices : &drbd_devices;
+	device = xa_load(devices, minor);
 	if (!device) {
 next_device:
-		minor++;
 		cb->args[2] = 0;
-		device = idr_get_next(idr_to_search, &minor);
+		device = xa_find_after(devices, &minor, ULONG_MAX, XA_PRESENT);
 		if (!device) {
 			err = 0;
 			goto out;
@@ -3941,12 +3937,12 @@ static int get_one_status(struct sk_buff *skb, struct netlink_callback *cb)
 	struct drbd_resource *pos = (struct drbd_resource *)cb->args[0];
 	struct drbd_resource *resource = NULL;
 	struct drbd_resource *tmp;
-	unsigned volume = cb->args[1];
+	unsigned long volume = cb->args[1];
 
 	/* Open coded, deferred, iteration:
 	 * for_each_resource_safe(resource, tmp, &drbd_resources) {
 	 *      connection = "first connection of resource or undefined";
-	 *	idr_for_each_entry(&resource->devices, device, i) {
+	 *	xa_for_each(&resource->devices, i, device) {
 	 *	  ...
 	 *	}
 	 * }
@@ -3981,7 +3977,8 @@ static int get_one_status(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 	if (resource) {
 next_resource:
-		device = idr_get_next(&resource->devices, &volume);
+		device = xa_find(&resource->devices, &volume,
+				ULONG_MAX, XA_PRESENT);
 		if (!device) {
 			/* No more volumes to dump on this resource.
 			 * Advance resource iterator. */
@@ -4489,7 +4486,7 @@ static int adm_del_resource(struct drbd_resource *resource)
 		if (connection->cstate > C_STANDALONE)
 			return ERR_NET_CONFIGURED;
 	}
-	if (!idr_is_empty(&resource->devices))
+	if (!xa_empty(&resource->devices))
 		return ERR_RES_IN_USE;
 
 	/* The state engine has stopped the sender thread, so we don't
@@ -4519,6 +4516,7 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 	struct drbd_device *device;
 	int retcode; /* enum drbd_ret_code rsp. enum drbd_state_rv */
 	unsigned i;
+	unsigned long index;
 
 	retcode = drbd_adm_prepare(&adm_ctx, skb, info, DRBD_ADM_NEED_RESOURCE);
 	if (!adm_ctx.reply_skb)
@@ -4548,7 +4546,7 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	/* detach */
-	idr_for_each_entry(&resource->devices, device, i) {
+	xa_for_each(&resource->devices, index, device) {
 		retcode = adm_detach(device, 0);
 		if (retcode < SS_SUCCESS || retcode > NO_ERROR) {
 			drbd_msg_put_info(adm_ctx.reply_skb, "failed to detach");
@@ -4557,7 +4555,7 @@ int drbd_adm_down(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	/* delete volumes */
-	idr_for_each_entry(&resource->devices, device, i) {
+	xa_for_each(&resource->devices, index, device) {
 		retcode = adm_del_minor(device);
 		if (retcode != NO_ERROR) {
 			/* "can not happen" */
diff --git a/drivers/block/drbd/drbd_proc.c b/drivers/block/drbd/drbd_proc.c
index 74ef29247bb5..77a0ad118e51 100644
--- a/drivers/block/drbd/drbd_proc.c
+++ b/drivers/block/drbd/drbd_proc.c
@@ -226,7 +226,7 @@ static void drbd_syncer_progress(struct drbd_device *device, struct seq_file *se
 
 int drbd_seq_show(struct seq_file *seq, void *v)
 {
-	int i, prev_i = -1;
+	unsigned long i, prev_i = -1;
 	const char *sn;
 	struct drbd_device *device;
 	struct net_conf *nc;
@@ -263,7 +263,7 @@ int drbd_seq_show(struct seq_file *seq, void *v)
 	*/
 
 	rcu_read_lock();
-	idr_for_each_entry(&drbd_devices, device, i) {
+	xa_for_each(&drbd_devices, i, device) {
 		if (prev_i != i - 1)
 			seq_putc(seq, '\n');
 		prev_i = i;
@@ -274,7 +274,7 @@ int drbd_seq_show(struct seq_file *seq, void *v)
 		if (state.conn == C_STANDALONE &&
 		    state.disk == D_DISKLESS &&
 		    state.role == R_SECONDARY) {
-			seq_printf(seq, "%2d: cs:Unconfigured\n", i);
+			seq_printf(seq, "%2ld: cs:Unconfigured\n", i);
 		} else {
 			/* reset device->congestion_reason */
 			bdi_rw_congested(device->rq_queue->backing_dev_info);
@@ -282,7 +282,7 @@ int drbd_seq_show(struct seq_file *seq, void *v)
 			nc = rcu_dereference(first_peer_device(device)->connection->net_conf);
 			wp = nc ? nc->wire_protocol - DRBD_PROT_A + 'A' : ' ';
 			seq_printf(seq,
-			   "%2d: cs:%s ro:%s/%s ds:%s/%s %c %c%c%c%c%c%c\n"
+			   "%2ld: cs:%s ro:%s/%s ds:%s/%s %c %c%c%c%c%c%c\n"
 			   "    ns:%u nr:%u dw:%u dr:%u al:%u bm:%u "
 			   "lo:%d pe:%d ua:%d ap:%d ep:%d wo:%c",
 			   i, sn,
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c7ad88d91a09..f87bd8a034b2 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1460,7 +1460,7 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
 {
 	struct drbd_device *device;
 	enum write_ordering_e pwo;
-	int vnr;
+	unsigned long vnr;
 	static char *write_ordering_str[] = {
 		[WO_NONE] = "none",
 		[WO_DRAIN_IO] = "drain",
@@ -1471,7 +1471,7 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
 	if (wo != WO_BDEV_FLUSH)
 		wo = min(pwo, wo);
 	rcu_read_lock();
-	idr_for_each_entry(&resource->devices, device, vnr) {
+	xa_for_each(&resource->devices, vnr, device) {
 		if (get_ldev(device)) {
 			wo = max_allowed_wo(device->ldev, wo);
 			if (device->ldev == bdev)
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 2b4c0db5d867..c3587054fa1e 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -56,12 +56,12 @@ static void count_objects(struct drbd_resource *resource,
 {
 	struct drbd_device *device;
 	struct drbd_connection *connection;
-	int vnr;
+	unsigned long vnr;
 
 	*n_devices = 0;
 	*n_connections = 0;
 
-	idr_for_each_entry(&resource->devices, device, vnr)
+	xa_for_each(&resource->devices, vnr, device)
 		(*n_devices)++;
 	for_each_connection(connection, resource)
 		(*n_connections)++;
@@ -99,7 +99,7 @@ struct drbd_state_change *remember_old_state(struct drbd_resource *resource, gfp
 	unsigned int n_devices;
 	struct drbd_connection *connection;
 	unsigned int n_connections;
-	int vnr;
+	unsigned long vnr;
 
 	struct drbd_device_state_change *device_state_change;
 	struct drbd_peer_device_state_change *peer_device_state_change;
@@ -133,7 +133,7 @@ struct drbd_state_change *remember_old_state(struct drbd_resource *resource, gfp
 
 	device_state_change = state_change->devices;
 	peer_device_state_change = state_change->peer_devices;
-	idr_for_each_entry(&resource->devices, device, vnr) {
+	xa_for_each(&resource->devices, vnr, device) {
 		kref_get(&device->kref);
 		device_state_change->device = device;
 		device_state_change->disk_state[OLD] = device->state.disk;
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 268ef0c5d4ab..614aa963700c 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1577,10 +1577,10 @@ static bool drbd_pause_after(struct drbd_device *device)
 {
 	bool changed = false;
 	struct drbd_device *odev;
-	int i;
+	unsigned long i;
 
 	rcu_read_lock();
-	idr_for_each_entry(&drbd_devices, odev, i) {
+	xa_for_each(&drbd_devices, i, odev) {
 		if (odev->state.conn == C_STANDALONE && odev->state.disk == D_DISKLESS)
 			continue;
 		if (!_drbd_may_sync_now(odev) &&
@@ -1603,10 +1603,10 @@ static bool drbd_resume_next(struct drbd_device *device)
 {
 	bool changed = false;
 	struct drbd_device *odev;
-	int i;
+	unsigned long i;
 
 	rcu_read_lock();
-	idr_for_each_entry(&drbd_devices, odev, i) {
+	xa_for_each(&drbd_devices, i, odev) {
 		if (odev->state.conn == C_STANDALONE && odev->state.disk == D_DISKLESS)
 			continue;
 		if (odev->state.aftr_isp) {
-- 
2.20.1

