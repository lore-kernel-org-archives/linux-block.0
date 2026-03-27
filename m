Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B16D393DD4
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774651140; cv=none; b=aNy+40sOwAPDWpJ10TRTo1QTUNwnM/XXdWl7gOVOOYR/SloJwDMSIuA0tSZAusiPn+HvNqVVKCQ+uNFArsKcR4J0lJntRWAH/kM/jbGIfsXeeL8C4W6oWO9vNk55/Lo1MFxQt+3WWbGbRdPj572Siz1oDNkjJvnL1u5zIhci+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774651140; c=relaxed/simple;
	bh=oR7UiXpfSNBZsumghDirPzuEB0psymF57gF39gQ1irA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jo6XqgINzJUnQO5SaXaC+6js/6A6zNeC9o3ba5VrDQgp/+/cn5ptpXgAmStHa9ro9E3GHMTh4oCN+4fM4ZsJ6PUnjCg0P9iJ6T/BwdSt58umjQ46HAuDk17cCA2rxylkCF5yGg3MA8L8jS1eWanigfGMtTm2sA7GZXzhEmIuUHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=uu0eLifm; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="uu0eLifm"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b9144790dso1451266f8f.1
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 15:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1774651135; x=1775255935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmcB5h5XUKfZNULB9IhTN+JX3V7GOii4GY+gk3EO3+8=;
        b=uu0eLifm/Cq2OwC9yZHm98XP/NgBWRkelT4ERxc2xBVviEbU1TY2J2SYwNR5j8D1ee
         TQ29UbDV+bhU8f2HFtDgzKRb1Efkjo/hh1qb6em2gT/7OY8Af9/shZhAoT8m/wm5g7wz
         cI1jDbJQnSaCjmf1AvVMR3MQ1MN5I4ESuRyQbpN48K9xhly6xBLq2oIJbM2iCyf1OtiZ
         pisa8PrDDRQPSJId7lTy1+NNaKHMkD6Cs6Al8FcrWmwMbity5Ifwz4gLjMM2PDWAdMaq
         rsSOxvHSXvUDC70oCECURypbUMxXTLxKhW4FuTHH4TbssO9mYF+GbqBQ8OIj2tkFCqKf
         uPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774651135; x=1775255935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QmcB5h5XUKfZNULB9IhTN+JX3V7GOii4GY+gk3EO3+8=;
        b=ey3kBgrPeDceFkLevEZyLC91IrDWgzyH+1ya4rjBD/TmdnfE5MPXANMKt7s/w4KBo+
         n5ET2UKFQHVUq9fiaqpdPhymXb1bCFblxuVMrsTEUL69M83xIAvHZi10qhEt0FKmtG3W
         YO6BqqvvugCl5BEUCIDOFAPMlGl8yVDMh6fxWrPhOa/QbProapHgqIiSZOCP2gIJ5fdW
         bQycz5Oa32dxnrLSy5IY+tn9+POEtGAfNDS5osfWBRp4Hy6upTbR8tXA/tlA0uuiYQre
         84CRnPlk+y2lWUbby804TxFW978hPQ36GE4DCGD5YtZDq50pz5XDHAXFaXsq2W3dpe/M
         T3vw==
X-Forwarded-Encrypted: i=1; AJvYcCU5ukTLyMUMk6yyxcFTBcfyOEK1+Ho4Jzm9+6Hcrcl9Unzsrs1oGBsdEdaetZxo97cjgzdPmxMzMU8dIA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2M9xlFgHUBiMUrQfBtxpAYrQBxW1QKN04Wf2Fo0oRLQLuU6tD
	GUPolKK+Evrjw7BFDTdKdNE7dwaZdA6nuvSSTqr5BeutzzHRvPujybIQjLfgEkS0yfs=
X-Gm-Gg: ATEYQzy6shkwHqCFCgUfAUBp6lqzTa1FKJdL3b5s6z5PLzkvVXd8TuX2YkHr1bmYR4q
	kWQqleT6d2U9jHTQx/4ANq6UQzI6x1aiKi/mNglCYHLcoIkvMiWO3gOIFdBs948u6Ufm7/qvfDN
	LlBYL2y53Sxl57Tp5p2Zgg043J5QA8Jvg1NTFV76MqurM+S+biELQ+Zm/+0clTkGuclZTvPmEFP
	AwhyOWlfpr0ltgPepwvMGViIgmW7Qy4HO4fn8QfWhOCVV1KpqQAaj8seZqEtCRk/qr8w7fhP/DQ
	sxc2/D5giPVHTak/iGGXxz8E9wXU9jPcHgzMvhfL7F3d6gDdM9j8aKPc7n7hgqHlCz3pRpqaxRD
	fPDR+RjSHm9F2rW2EyraIBEYzs6z21qjKgQaXT4LPwf1IqXWuqmKuiEBNzULBzeIiCFXOYRvaPC
	4TEzO+PxBCOUssx5xNc07zAWvy5KuM3oa2ewBLztJ4cYoabEZS1TnQF5T8cwqOuweBU8hnMJJ7O
	paigyUaaZ7GUe+6P+paNQ==
X-Received: by 2002:a05:6000:2005:b0:43b:3c06:c30a with SMTP id ffacd0b85a97d-43b9e9900c0mr7190730f8f.18.1774651135385;
        Fri, 27 Mar 2026 15:38:55 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247079esm998990f8f.25.2026.03.27.15.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:38:54 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 04/20] drbd: add transport layer abstraction
Date: Fri, 27 Mar 2026 23:38:04 +0100
Message-ID: <20260327223820.2244227-5-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DRBD 9 decouples all network I/O from the core driver by introducing a
transport abstraction layer. The core driver interacts with the network
only through a well-defined ops table, and concrete implementations
live in separate kernel modules that register themselves at load time.

The abstraction models connections as a set of paths, each representing
a local/remote address pair. A shared listener mechanism allows multiple
paths on the same resource to reuse a single listening socket.
The core exports a callbacks which the transports can call back into,
keeping protocol logic in the core and handling wire details in the
transport.

This commit adds the header defining the interface and some
infrastructure. actual transport implementations follow later in the
series.

Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Co-developed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Co-developed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
Co-developed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Makefile                  |   1 +
 drivers/block/drbd/drbd_transport.c          | 379 ++++++++++++++++
 drivers/block/drbd/drbd_transport.h          | 443 +++++++++++++++++++
 drivers/block/drbd/drbd_transport_template.c | 160 +++++++
 4 files changed, 983 insertions(+)
 create mode 100644 drivers/block/drbd/drbd_transport.c
 create mode 100644 drivers/block/drbd/drbd_transport.h
 create mode 100644 drivers/block/drbd/drbd_transport_template.c

diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 67a8b352a1d5..4929bd423472 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -4,6 +4,7 @@ drbd-y += drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o
 drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
 drbd-y += drbd_interval.o drbd_state.o
 drbd-y += drbd_nla.o
+drbd-y += drbd_transport.o
 drbd-$(CONFIG_DEBUG_FS) += drbd_debugfs.o
 
 obj-$(CONFIG_BLK_DEV_DRBD)     += drbd.o
diff --git a/drivers/block/drbd/drbd_transport.c b/drivers/block/drbd/drbd_transport.c
new file mode 100644
index 000000000000..7c6128cbb8bc
--- /dev/null
+++ b/drivers/block/drbd/drbd_transport.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <net/ipv6.h>
+#include "drbd_transport.h"
+#include "drbd_int.h"
+
+static LIST_HEAD(transport_classes);
+static DECLARE_RWSEM(transport_classes_lock);
+
+static struct drbd_transport_class *__find_transport_class(const char *transport_name)
+{
+	struct drbd_transport_class *transport_class;
+
+	list_for_each_entry(transport_class, &transport_classes, list)
+		if (!strcmp(transport_class->name, transport_name))
+			return transport_class;
+
+	return NULL;
+}
+
+int drbd_register_transport_class(struct drbd_transport_class *transport_class, int version,
+				  int drbd_transport_size)
+{
+	int rv = 0;
+	if (version != DRBD_TRANSPORT_API_VERSION) {
+		pr_err("DRBD_TRANSPORT_API_VERSION not compatible\n");
+		return -EINVAL;
+	}
+
+	if (drbd_transport_size != sizeof(struct drbd_transport)) {
+		pr_err("sizeof(drbd_transport) not compatible\n");
+		return -EINVAL;
+	}
+
+	down_write(&transport_classes_lock);
+	if (__find_transport_class(transport_class->name)) {
+		pr_err("transport class '%s' already registered\n", transport_class->name);
+		rv = -EEXIST;
+	} else {
+		list_add_tail(&transport_class->list, &transport_classes);
+		pr_info("registered transport class '%s' (version:%s)\n",
+			transport_class->name,
+			transport_class->module->version ?: "N/A");
+	}
+	up_write(&transport_classes_lock);
+	return rv;
+}
+
+void drbd_unregister_transport_class(struct drbd_transport_class *transport_class)
+{
+	down_write(&transport_classes_lock);
+	if (!__find_transport_class(transport_class->name)) {
+		pr_crit("unregistering unknown transport class '%s'\n",
+			transport_class->name);
+		BUG();
+	}
+	list_del_init(&transport_class->list);
+	pr_info("unregistered transport class '%s'\n", transport_class->name);
+	up_write(&transport_classes_lock);
+}
+
+static struct drbd_transport_class *get_transport_class(const char *name)
+{
+	struct drbd_transport_class *tc;
+
+	down_read(&transport_classes_lock);
+	tc = __find_transport_class(name);
+	if (tc && !try_module_get(tc->module))
+		tc = NULL;
+	up_read(&transport_classes_lock);
+	return tc;
+}
+
+struct drbd_transport_class *drbd_get_transport_class(const char *name)
+{
+	struct drbd_transport_class *tc = get_transport_class(name);
+
+	if (!tc) {
+		request_module("drbd_transport_%s", name);
+		tc = get_transport_class(name);
+	}
+
+	return tc;
+}
+
+void drbd_put_transport_class(struct drbd_transport_class *tc)
+{
+	/* convenient in the error cleanup path */
+	if (!tc)
+		return;
+	down_read(&transport_classes_lock);
+	module_put(tc->module);
+	up_read(&transport_classes_lock);
+}
+
+void drbd_print_transports_loaded(struct seq_file *seq)
+{
+	struct drbd_transport_class *tc;
+
+	down_read(&transport_classes_lock);
+
+	seq_puts(seq, "Transports (api:" __stringify(DRBD_TRANSPORT_API_VERSION) "):");
+	list_for_each_entry(tc, &transport_classes, list) {
+		seq_printf(seq, " %s (%s)", tc->name,
+				tc->module->version ? tc->module->version : "NONE");
+	}
+	seq_putc(seq, '\n');
+
+	up_read(&transport_classes_lock);
+}
+
+static bool addr_equal(const struct sockaddr_storage *addr1, const struct sockaddr_storage *addr2)
+{
+	if (addr1->ss_family != addr2->ss_family)
+		return false;
+
+	if (addr1->ss_family == AF_INET6) {
+		const struct sockaddr_in6 *v6a1 = (const struct sockaddr_in6 *)addr1;
+		const struct sockaddr_in6 *v6a2 = (const struct sockaddr_in6 *)addr2;
+
+		if (!ipv6_addr_equal(&v6a1->sin6_addr, &v6a2->sin6_addr))
+			return false;
+		else if (ipv6_addr_type(&v6a1->sin6_addr) & IPV6_ADDR_LINKLOCAL)
+			return v6a1->sin6_scope_id == v6a2->sin6_scope_id;
+		return true;
+	} else /* AF_INET, AF_SSOCKS, AF_SDP */ {
+		const struct sockaddr_in *v4a1 = (const struct sockaddr_in *)addr1;
+		const struct sockaddr_in *v4a2 = (const struct sockaddr_in *)addr2;
+
+		return v4a1->sin_addr.s_addr == v4a2->sin_addr.s_addr;
+	}
+}
+
+static bool addr_and_port_equal(const struct sockaddr_storage *addr1, const struct sockaddr_storage *addr2)
+{
+	if (!addr_equal(addr1, addr2))
+		return false;
+
+	if (addr1->ss_family == AF_INET6) {
+		const struct sockaddr_in6 *v6a1 = (const struct sockaddr_in6 *)addr1;
+		const struct sockaddr_in6 *v6a2 = (const struct sockaddr_in6 *)addr2;
+
+		return v6a1->sin6_port == v6a2->sin6_port;
+	} else /* AF_INET, AF_SSOCKS, AF_SDP */ {
+		const struct sockaddr_in *v4a1 = (const struct sockaddr_in *)addr1;
+		const struct sockaddr_in *v4a2 = (const struct sockaddr_in *)addr2;
+
+		return v4a1->sin_port == v4a2->sin_port;
+	}
+
+	return false;
+}
+
+static struct drbd_listener *find_listener(struct drbd_connection *connection,
+					   const struct sockaddr_storage *addr)
+{
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_listener *listener;
+
+	list_for_each_entry(listener, &resource->listeners, list) {
+		if (addr_and_port_equal(&listener->listen_addr, addr)) {
+			if (kref_get_unless_zero(&listener->kref))
+				return listener;
+		}
+	}
+	return NULL;
+}
+
+int drbd_get_listener(struct drbd_path *path)
+{
+	struct drbd_transport *transport = path->transport;
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
+	struct sockaddr *addr = (struct sockaddr *)&path->my_addr;
+	struct drbd_resource *resource = connection->resource;
+	struct drbd_transport_class *tc = transport->class;
+	struct drbd_listener *listener;
+	bool needs_init = false;
+	int err;
+
+	spin_lock_bh(&resource->listeners_lock);
+	listener = find_listener(connection, (struct sockaddr_storage *)addr);
+	if (!listener) {
+		listener = kzalloc(tc->listener_instance_size, GFP_ATOMIC);
+		if (!listener) {
+			spin_unlock_bh(&resource->listeners_lock);
+			return -ENOMEM;
+		}
+		kref_init(&listener->kref);
+		INIT_LIST_HEAD(&listener->waiters);
+		listener->resource = resource;
+		listener->pending_accepts = 0;
+		spin_lock_init(&listener->waiters_lock);
+		init_completion(&listener->ready);
+		listener->listen_addr = *(struct sockaddr_storage *)addr;
+		listener->transport_class = NULL;
+
+		list_add(&listener->list, &resource->listeners);
+		needs_init = true;
+	}
+	spin_unlock_bh(&resource->listeners_lock);
+
+	if (needs_init) {
+		if (try_module_get(tc->module)) {
+			listener->transport_class = tc;
+			err = tc->ops.init_listener(transport, addr, path->net, listener);
+		} else {
+			err = -ENODEV;
+		}
+		listener->err = err;
+		complete_all(&listener->ready);
+	} else {
+		wait_for_completion(&listener->ready);
+		err = listener->err;
+	}
+
+	if (err) {
+		kref_put(&listener->kref, drbd_listener_destroy);
+		return err;
+	}
+
+	spin_lock_bh(&listener->waiters_lock);
+	kref_get(&path->kref);
+	list_add(&path->listener_link, &listener->waiters);
+	path->listener = listener;
+	spin_unlock_bh(&listener->waiters_lock);
+	/* After exposing the listener on a path, drbd_put_listenr() can destroy it. */
+
+	return 0;
+}
+
+void drbd_listener_destroy(struct kref *kref)
+{
+	struct drbd_listener *listener = container_of(kref, struct drbd_listener, kref);
+	struct drbd_transport_class *tc = listener->transport_class;
+	struct drbd_resource *resource = listener->resource;
+
+	spin_lock_bh(&resource->listeners_lock);
+	list_del(&listener->list);
+	spin_unlock_bh(&resource->listeners_lock);
+
+	if (tc) {
+		tc->ops.release_listener(listener);
+		module_put(tc->module);
+	}
+	kfree(listener);
+}
+
+void drbd_put_listener(struct drbd_path *path)
+{
+	struct drbd_listener *listener;
+
+	listener = xchg(&path->listener, NULL);
+	if (!listener)
+		return;
+
+	spin_lock_bh(&listener->waiters_lock);
+	list_del(&path->listener_link);
+	kref_put(&path->kref, drbd_destroy_path);
+	spin_unlock_bh(&listener->waiters_lock);
+	kref_put(&listener->kref, drbd_listener_destroy);
+}
+
+struct drbd_path *drbd_find_path_by_addr(struct drbd_listener *listener, struct sockaddr_storage *addr)
+{
+	struct drbd_path *path;
+
+	list_for_each_entry(path, &listener->waiters, listener_link) {
+		if (addr_equal(&path->peer_addr, addr))
+			return path;
+	}
+
+	return NULL;
+}
+
+/**
+ * drbd_stream_send_timed_out() - Tells transport if the connection should stay alive
+ * @transport:	DRBD transport to operate on.
+ * @stream:     DATA_STREAM or CONTROL_STREAM
+ *
+ * When it returns true, the transport should return -EAGAIN to its caller of the
+ * send function. When it returns false the transport should keep on trying to
+ * get the packet through.
+ */
+bool drbd_stream_send_timed_out(struct drbd_transport *transport, enum drbd_stream stream)
+{
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
+	bool drop_it;
+
+	drop_it = stream == CONTROL_STREAM || connection->cstate[NOW] < C_CONNECTED;
+
+	if (drop_it)
+		return true;
+
+	drop_it = !--connection->transport.ko_count;
+	if (!drop_it) {
+		drbd_err(connection, "[%s/%d] sending time expired, ko = %u\n",
+			 current->comm, current->pid, connection->transport.ko_count);
+		schedule_work(&connection->send_ping_work);
+	}
+
+	return drop_it;
+}
+
+bool drbd_should_abort_listening(struct drbd_transport *transport)
+{
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
+	bool abort = false;
+
+	if (connection->cstate[NOW] <= C_DISCONNECTING)
+		abort = true;
+	if (signal_pending(current)) {
+		flush_signals(current);
+		smp_rmb();
+		if (get_t_state(&connection->receiver) == EXITING)
+			abort = true;
+	}
+
+	return abort;
+}
+
+/* Called by a transport if a path was established / disconnected */
+void drbd_path_event(struct drbd_transport *transport, struct drbd_path *path)
+{
+	struct drbd_connection *connection =
+		container_of(transport, struct drbd_connection, transport);
+
+	notify_path(connection, path, NOTIFY_CHANGE);
+}
+
+struct drbd_path *__drbd_next_path_ref(struct drbd_path *drbd_path,
+					      struct drbd_transport *transport)
+{
+	rcu_read_lock();
+	if (!drbd_path) {
+		drbd_path = list_first_or_null_rcu(&transport->paths, struct drbd_path, list);
+	} else {
+		struct list_head *pos;
+		bool in_list;
+
+		pos = list_next_rcu(&drbd_path->list);
+		/* Ensure list head is read before flag. */
+		smp_rmb();
+		in_list = !test_bit(TR_UNREGISTERED, &drbd_path->flags);
+		kref_put(&drbd_path->kref, drbd_destroy_path);
+
+		if (pos == &transport->paths) {
+			drbd_path = NULL;
+		} else if (in_list) {
+			drbd_path = list_entry_rcu(pos, struct drbd_path, list);
+		} else {
+			/* No longer on the list, element might be freed, restart from the start */
+			drbd_path = list_first_or_null_rcu(&transport->paths,
+					struct drbd_path, list);
+		}
+	}
+	if (drbd_path)
+		kref_get(&drbd_path->kref);
+	rcu_read_unlock();
+
+	return drbd_path;
+}
+
+/* Network transport abstractions */
+EXPORT_SYMBOL_GPL(drbd_register_transport_class);
+EXPORT_SYMBOL_GPL(drbd_unregister_transport_class);
+EXPORT_SYMBOL_GPL(drbd_get_listener);
+EXPORT_SYMBOL_GPL(drbd_put_listener);
+EXPORT_SYMBOL_GPL(drbd_find_path_by_addr);
+EXPORT_SYMBOL_GPL(drbd_stream_send_timed_out);
+EXPORT_SYMBOL_GPL(drbd_should_abort_listening);
+EXPORT_SYMBOL_GPL(drbd_path_event);
+EXPORT_SYMBOL_GPL(drbd_listener_destroy);
+EXPORT_SYMBOL_GPL(__drbd_next_path_ref);
diff --git a/drivers/block/drbd/drbd_transport.h b/drivers/block/drbd/drbd_transport.h
new file mode 100644
index 000000000000..ff393e8d12dc
--- /dev/null
+++ b/drivers/block/drbd/drbd_transport.h
@@ -0,0 +1,443 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef DRBD_TRANSPORT_H
+#define DRBD_TRANSPORT_H
+
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/wait.h>
+#include <linux/socket.h>
+
+/* Whenever touch this file in a non-trivial way, increase the
+   DRBD_TRANSPORT_API_VERSION
+   So that transport compiled against an older version of this
+   header will no longer load in a module that assumes a newer
+   version. */
+#define DRBD_TRANSPORT_API_VERSION 21
+
+/* MSG_MSG_DONTROUTE and MSG_PROBE are not used by DRBD. I.e.
+   we can reuse these flags for our purposes */
+#define CALLER_BUFFER  MSG_DONTROUTE
+#define GROW_BUFFER    MSG_PROBE
+
+/*
+ * gfp_mask for allocating memory with no write-out.
+ *
+ * When drbd allocates memory on behalf of the peer, we prevent it from causing
+ * write-out because in a criss-cross setup, the write-out could lead to memory
+ * pressure on the peer, eventually leading to deadlock.
+ */
+#define GFP_TRY	(__GFP_HIGHMEM | __GFP_NOWARN | __GFP_RECLAIM)
+
+#define tr_printk(level, transport, fmt, args...)  ({		\
+	rcu_read_lock();					\
+	printk(level "drbd %s %s:%s: " fmt,			\
+	       (transport)->log_prefix,				\
+	       (transport)->class->name,			\
+	       rcu_dereference((transport)->net_conf)->name,	\
+	       ## args);					\
+	rcu_read_unlock();					\
+	})
+
+#define tr_err(transport, fmt, args...) \
+	tr_printk(KERN_ERR, transport, fmt, ## args)
+#define tr_warn(transport, fmt, args...) \
+	tr_printk(KERN_WARNING, transport, fmt, ## args)
+#define tr_notice(transport, fmt, args...) \
+	tr_printk(KERN_NOTICE, transport, fmt, ## args)
+#define tr_info(transport, fmt, args...) \
+	tr_printk(KERN_INFO, transport, fmt, ## args)
+
+#define TR_ASSERT(x, exp)							\
+	do {									\
+		if (!(exp))							\
+			tr_err(x, "ASSERTION %s FAILED in %s\n",	\
+				 #exp, __func__);				\
+	} while (0)
+
+struct drbd_resource;
+struct drbd_listener;
+struct drbd_transport;
+
+enum drbd_stream {
+	DATA_STREAM,
+	CONTROL_STREAM
+};
+
+enum drbd_tr_hints {
+	CORK,
+	UNCORK,
+	NODELAY,
+	NOSPACE,
+	QUICKACK
+};
+
+enum { /* bits in the flags word */
+	NET_CONGESTED,		/* The data socket is congested */
+	RESOLVE_CONFLICTS,	/* Set on one node, cleared on the peer! */
+};
+
+enum drbd_tr_free_op {
+	CLOSE_CONNECTION,
+	DESTROY_TRANSPORT
+};
+
+enum drbd_tr_event {
+	CLOSED_BY_PEER,
+	TIMEOUT,
+};
+
+enum drbd_tr_path_flag {
+	TR_ESTABLISHED, /* updated by the transport */
+	TR_UNREGISTERED,
+	TR_TRANSPORT_PRIVATE = 32, /* flags starting here are used exclusively by the transport */
+};
+
+/* A transport might wrap its own data structure around this. Having
+   this base class as its first member. */
+struct drbd_path {
+	struct sockaddr_storage my_addr;
+	struct sockaddr_storage peer_addr;
+
+	struct kref kref;
+
+	struct net *net;
+	int my_addr_len;
+	int peer_addr_len;
+	unsigned long flags;
+
+	struct drbd_transport *transport;
+	struct list_head list; /* paths of a connection */
+	struct list_head listener_link; /* paths waiting for an incoming connection,
+					   head is in a drbd_listener */
+	struct drbd_listener *listener;
+
+	struct rcu_head rcu;
+};
+
+/* Each transport implementation should embed a struct drbd_transport
+   into it's instance data structure. */
+struct drbd_transport {
+	struct drbd_transport_class *class;
+
+	struct list_head paths;
+
+	const char *log_prefix;		/* resource name */
+	struct net_conf __rcu *net_conf;	/* content protected by rcu */
+
+	/* These members are intended to be updated by the transport: */
+	unsigned int ko_count;
+	unsigned long flags;
+};
+
+struct drbd_transport_stats {
+	int unread_received;
+	int unacked_send;
+	int send_buffer_size;
+	int send_buffer_used;
+};
+
+/* argument to ->recv_pages() */
+struct drbd_page_chain_head {
+	struct page *head;
+	unsigned int nr_pages;
+};
+
+struct drbd_const_buffer {
+	const u8 *buffer;
+	unsigned int avail;
+};
+
+/**
+ * struct drbd_transport_ops - Operations implemented by the transport.
+ *
+ * The user of this API guarantees that all of the following will be exclusive
+ * with respect to each other for a given transport instance:
+ * * init()
+ * * free()
+ * * prepare_connect()
+ * * finish_connect()
+ * * add_path() and the subsequent list_add_tail_rcu() for the paths list
+ * * may_remove_path() and the subsequent list_del_rcu() for the paths list
+ *
+ * The connection sequence is as follows:
+ * 1. prepare_connect(), with the above exclusivity guarantee
+ * 2. connect(), this may take a long time
+ * 3. finish_connect(), with the above exclusivity guarantee
+ */
+struct drbd_transport_ops {
+	int (*init)(struct drbd_transport *);
+	void (*free)(struct drbd_transport *, enum drbd_tr_free_op free_op);
+	int (*init_listener)(struct drbd_transport *, const struct sockaddr *, struct net *net,
+			     struct drbd_listener *);
+	void (*release_listener)(struct drbd_listener *);
+	int (*prepare_connect)(struct drbd_transport *);
+	int (*connect)(struct drbd_transport *);
+	void (*finish_connect)(struct drbd_transport *);
+
+/**
+ * recv() - Receive data via the transport
+ * @transport:	The transport to use
+ * @stream:	The stream within the transport to use. Ether DATA_STREAM or CONTROL_STREAM
+ * @buf:	The function will place here the pointer to the data area
+ * @size:	Number of byte to receive
+ * @msg_flags:	Bitmask of CALLER_BUFFER, GROW_BUFFER and MSG_DONTWAIT
+ *
+ * recv() returns the requests data in a buffer (owned by the transport).
+ * You may pass MSG_DONTWAIT as flags.  Usually with the next call to recv()
+ * or recv_pages() on the same stream, the buffer may no longer be accessed
+ * by the caller. I.e. it is reclaimed by the transport.
+ *
+ * If the transport was not capable of fulfilling the complete "wish" of the
+ * caller (that means it returned a smaller size that size), the caller may
+ * call recv() again with the flag GROW_BUFFER, and *buf as returned by the
+ * previous call.
+ * Note1: This can happen if MSG_DONTWAIT was used, or if a receive timeout
+ *	was we with set_rcvtimeo().
+ * Note2: recv() is free to re-locate the buffer in such a call. I.e. to
+ *	modify *buf. Then it copies the content received so far to the new
+ *	memory location.
+ *
+ * Last not least the caller may also pass an arbitrary pointer in *buf with
+ * the CALLER_BUFFER flag. This is expected to be used for small amounts
+ * of data only
+ *
+ * Upon success the function returns the bytes read. Upon error the return
+ * code is negative. A 0 indicates that the socket was closed by the remote
+ * side.
+ */
+	int (*recv)(struct drbd_transport *, enum drbd_stream, void **buf, size_t size, int flags);
+
+/**
+ * recv_pages() - Receive bulk data via the transport's DATA_STREAM
+ * @peer_device: Identify the transport and the device
+ * @page_chain:	Here recv_pages() will place the page chain head and length
+ * @size:	Number of bytes to receive
+ *
+ * recv_pages() will return the requested amount of data from DATA_STREAM,
+ * and place it into pages allocated with drbd_alloc_pages().
+ *
+ * Upon success the function returns 0. Upon error the function returns a
+ * negative value
+ */
+	int (*recv_pages)(struct drbd_transport *, struct drbd_page_chain_head *, size_t size);
+
+	void (*stats)(struct drbd_transport *, struct drbd_transport_stats *stats);
+/**
+ * net_conf_change() - Notify about changed network configuration on the transport.
+ * @new_net_conf: The new network configuration that should be applied.
+ *
+ * net_conf_change() is called in the context of either the initial creation of the connection,
+ * or when the net_conf is changed via netlink. Note that assignment of the net_conf to the
+ * transport object happens after this function is called.
+ *
+ * On a negative (error) return value, it is expected that any changes are reverted and
+ * the old net_conf (if any) is still in effect.
+ *
+ * Upon success the function return 0. Upon error the function returns a negative value.
+ */
+	int (*net_conf_change)(struct drbd_transport *, struct net_conf *new_net_conf);
+	void (*set_rcvtimeo)(struct drbd_transport *, enum drbd_stream, long timeout);
+	long (*get_rcvtimeo)(struct drbd_transport *, enum drbd_stream);
+	int (*send_page)(struct drbd_transport *, enum drbd_stream, struct page *,
+			 int offset, size_t size, unsigned msg_flags);
+	int (*send_zc_bio)(struct drbd_transport *, struct bio *bio);
+	bool (*stream_ok)(struct drbd_transport *, enum drbd_stream);
+	bool (*hint)(struct drbd_transport *, enum drbd_stream, enum drbd_tr_hints hint);
+	void (*debugfs_show)(struct drbd_transport *, struct seq_file *m);
+
+/**
+ * add_path() - Prepare path to be added
+ * @path: The path that is being added
+ *
+ * Called before the path is added to the paths list.
+ *
+ * Return: 0 if path may be added, error code otherwise.
+ */
+	int (*add_path)(struct drbd_path *path);
+
+/**
+ * may_remove_path() - Query whether path may currently be removed
+ * @path: The path to be removed
+ *
+ * Return: true is path may be removed, false otherwise.
+ */
+	bool (*may_remove_path)(struct drbd_path *path);
+
+/**
+ * remove_path() - Clear up after path removal
+ * @path: The path that is being removed
+ *
+ * Clear up a path that is being removed. Called after the path has been
+ * removed from the list and all kref references have been put.
+ */
+	void (*remove_path)(struct drbd_path *path);
+};
+
+struct drbd_transport_class {
+	const char *name;
+	const int instance_size;
+	const int path_instance_size;
+	const int listener_instance_size;
+	struct drbd_transport_ops ops;
+
+	struct module *module;
+
+	struct list_head list;
+};
+
+
+/* An "abstract base class" for transport implementations. I.e. it
+   should be embedded into a transport specific representation of a
+   listening "socket" */
+struct drbd_listener {
+	struct kref kref;
+	struct drbd_resource *resource;
+	struct drbd_transport_class *transport_class;
+	struct list_head list; /* link for resource->listeners */
+	struct list_head waiters; /* list head for paths */
+	spinlock_t waiters_lock;
+	int pending_accepts;
+	struct sockaddr_storage listen_addr;
+	struct completion ready;
+	int err;
+};
+
+/* drbd_main.c */
+void drbd_destroy_path(struct kref *kref);
+
+/* drbd_transport.c */
+int drbd_register_transport_class(struct drbd_transport_class *transport_class,
+				  int version, int drbd_transport_size);
+void drbd_unregister_transport_class(struct drbd_transport_class *transport_class);
+struct drbd_transport_class *drbd_get_transport_class(const char *name);
+void drbd_put_transport_class(struct drbd_transport_class *tc);
+void drbd_print_transports_loaded(struct seq_file *seq);
+
+int drbd_get_listener(struct drbd_path *path);
+void drbd_put_listener(struct drbd_path *path);
+struct drbd_path *drbd_find_path_by_addr(struct drbd_listener *listener,
+					 struct sockaddr_storage *addr);
+bool drbd_stream_send_timed_out(struct drbd_transport *transport,
+				enum drbd_stream stream);
+bool drbd_should_abort_listening(struct drbd_transport *transport);
+void drbd_path_event(struct drbd_transport *transport, struct drbd_path *path);
+void drbd_listener_destroy(struct kref *kref);
+struct drbd_path *__drbd_next_path_ref(struct drbd_path *drbd_path,
+				       struct drbd_transport *transport);
+
+/* Might restart iteration, if current element is removed from list!! */
+#define for_each_path_ref(path, transport)			\
+	for (path = __drbd_next_path_ref(NULL, transport);	\
+	     path;						\
+	     path = __drbd_next_path_ref(path, transport))
+
+/* drbd_receiver.c*/
+struct page *drbd_alloc_pages(struct drbd_transport *transport,
+			      unsigned int number, gfp_t gfp_mask);
+void drbd_free_pages(struct drbd_transport *transport, struct page *page);
+void drbd_control_data_ready(struct drbd_transport *transport,
+			     struct drbd_const_buffer *pool);
+void drbd_control_event(struct drbd_transport *transport,
+			enum drbd_tr_event event);
+
+static inline void drbd_alloc_page_chain(struct drbd_transport *t,
+	struct drbd_page_chain_head *chain, unsigned int nr, gfp_t gfp_flags)
+{
+	chain->head = drbd_alloc_pages(t, nr, gfp_flags);
+	chain->nr_pages = chain->head ? nr : 0;
+}
+
+static inline void drbd_free_page_chain(struct drbd_transport *transport,
+					struct drbd_page_chain_head *chain)
+{
+	drbd_free_pages(transport, chain->head);
+	chain->head = NULL;
+	chain->nr_pages = 0;
+}
+
+/*
+ * Some helper functions to deal with our page chains.
+ */
+/* Our transports may sometimes need to only partially use a page.
+ * We need to express that somehow.  Use this struct, and "graft" it into
+ * struct page at page->lru.
+ *
+ * According to include/linux/mm.h:
+ *  | A page may be used by anyone else who does a __get_free_page().
+ *  | In this case, page_count still tracks the references, and should only
+ *  | be used through the normal accessor functions. The top bits of page->flags
+ *  | and page->virtual store page management information, but all other fields
+ *  | are unused and could be used privately, carefully. The management of this
+ *  | page is the responsibility of the one who allocated it, and those who have
+ *  | subsequently been given references to it.
+ * (we do alloc_page(), that is equivalent).
+ *
+ * Red Hat struct page is different from upstream (layout and members) :(
+ * So I am not too sure about the "all other fields", and it is not as easy to
+ * find a place where sizeof(struct drbd_page_chain) would fit on all archs and
+ * distribution-changed layouts.
+ *
+ * But (upstream) struct page also says:
+ *  | struct list_head lru;   * ...
+ *  |       * Can be used as a generic list
+ *  |       * by the page owner.
+ *
+ * On 32bit, use unsigned short for offset and size,
+ * to still fit in sizeof(page->lru).
+ */
+
+/* grafted over struct page.lru */
+struct drbd_page_chain {
+	struct page *next;	/* next page in chain, if any */
+#ifdef CONFIG_64BIT
+	unsigned int offset;	/* start offset of data within this page */
+	unsigned int size;	/* number of data bytes within this page */
+#else
+#if PAGE_SIZE > (1U<<16)
+#error "won't work."
+#endif
+	unsigned short offset;	/* start offset of data within this page */
+	unsigned short size;	/* number of data bytes within this page */
+#endif
+};
+
+static inline void dummy_for_buildbug(void)
+{
+	struct page *dummy;
+	BUILD_BUG_ON(sizeof(struct drbd_page_chain) > sizeof(dummy->lru));
+}
+
+#define page_chain_next(page) \
+	(((struct drbd_page_chain *)&(page)->lru)->next)
+#define page_chain_size(page) \
+	(((struct drbd_page_chain *)&(page)->lru)->size)
+#define page_chain_offset(page) \
+	(((struct drbd_page_chain *)&(page)->lru)->offset)
+#define set_page_chain_next(page, v) \
+	(((struct drbd_page_chain *)&(page)->lru)->next = (v))
+#define set_page_chain_size(page, v) \
+	(((struct drbd_page_chain *)&(page)->lru)->size = (v))
+#define set_page_chain_offset(page, v) \
+	(((struct drbd_page_chain *)&(page)->lru)->offset = (v))
+#define set_page_chain_next_offset_size(page, n, o, s)		\
+	(*((struct drbd_page_chain *)&(page)->lru) =		\
+	((struct drbd_page_chain) {				\
+		.next = (n),					\
+		.offset = (o),					\
+		.size = (s),					\
+	 }))
+
+#define page_chain_for_each(page) \
+	for (; page && ({ prefetch(page_chain_next(page)); 1; }); \
+			page = page_chain_next(page))
+#define page_chain_for_each_safe(page, n) \
+	for (; page && ({ n = page_chain_next(page); 1; }); page = n)
+
+#ifndef SK_CAN_REUSE
+/* This constant was introduced by Pavel Emelyanov <xemul@parallels.com> on
+   Thu Apr 19 03:39:36 2012 +0000. Before the release of linux-3.5
+   commit 4a17fd52 sock: Introduce named constants for sk_reuse */
+#define SK_CAN_REUSE   1
+#endif
+
+#endif
diff --git a/drivers/block/drbd/drbd_transport_template.c b/drivers/block/drbd/drbd_transport_template.c
new file mode 100644
index 000000000000..7a07dff0b5e8
--- /dev/null
+++ b/drivers/block/drbd/drbd_transport_template.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include "drbd_transport.h"
+#include "drbd_int.h"
+
+
+MODULE_AUTHOR("xxx");
+MODULE_DESCRIPTION("xxx transport layer for DRBD");
+MODULE_LICENSE("GPL");
+
+
+struct drbd_xxx_transport {
+	struct drbd_transport transport;
+	/* xxx */
+};
+
+struct xxx_listener {
+	struct drbd_listener listener;
+	/* xxx */
+};
+
+struct xxx_waiter {
+	struct drbd_waiter waiter;
+	/* xxx */
+};
+
+static struct drbd_transport *xxx_create(struct drbd_connection *connection);
+static void xxx_free(struct drbd_transport *transport, enum drbd_tr_free_op free_op);
+static int xxx_connect(struct drbd_transport *transport);
+static int xxx_recv(struct drbd_transport *transport, enum drbd_stream stream, void *buf, size_t size, int flags);
+static void xxx_stats(struct drbd_transport *transport, struct drbd_transport_stats *stats);
+static void xxx_set_rcvtimeo(struct drbd_transport *transport, enum drbd_stream stream, long timeout);
+static long xxx_get_rcvtimeo(struct drbd_transport *transport, enum drbd_stream stream);
+static int xxx_send_page(struct drbd_transport *transport, enum drbd_stream stream, struct page *page,
+		    int offset, size_t size, unsigned msg_flags);
+static bool xxx_stream_ok(struct drbd_transport *transport, enum drbd_stream stream);
+static bool xxx_hint(struct drbd_transport *transport, enum drbd_stream stream, enum drbd_tr_hints hint);
+
+
+static struct drbd_transport_class xxx_transport_class = {
+	.name = "xxx",
+	.create = xxx_create,
+	.list = LIST_HEAD_INIT(xxx_transport_class.list),
+};
+
+static struct drbd_transport_ops xxx_ops = {
+	.free = xxx_free,
+	.connect = xxx_connect,
+	.recv = xxx_recv,
+	.stats = xxx_stats,
+	.set_rcvtimeo = xxx_set_rcvtimeo,
+	.get_rcvtimeo = xxx_get_rcvtimeo,
+	.send_page = xxx_send_page,
+	.stream_ok = xxx_stream_ok,
+	.hint = xxx_hint,
+};
+
+
+static struct drbd_transport *xxx_create(struct drbd_connection *connection)
+{
+	struct drbd_xxx_transport *xxx_transport;
+
+	if (!try_module_get(THIS_MODULE))
+		return NULL;
+
+	xxx_transport = kzalloc_obj(struct drbd_xxx_transport);
+	if (!xxx_transport) {
+		module_put(THIS_MODULE);
+		return NULL;
+	}
+
+	xxx_transport->transport.ops = &xxx_ops;
+	xxx_transport->transport.connection = connection;
+
+	return &xxx_transport->transport;
+}
+
+static void xxx_free(struct drbd_transport *transport, enum drbd_tr_free_op free_op)
+{
+	struct drbd_xxx_transport *xxx_transport =
+		container_of(transport, struct drbd_xxx_transport, transport);
+
+	/* disconnect here */
+
+	if (free_op == DESTROY_TRANSPORT) {
+		kfree(xxx_transport);
+		module_put(THIS_MODULE);
+	}
+}
+
+static int xxx_send(struct drbd_transport *transport, enum drbd_stream stream, void *buf, size_t size, unsigned msg_flags)
+{
+	struct drbd_xxx_transport *xxx_transport =
+		container_of(transport, struct drbd_xxx_transport, transport);
+
+	return 0;
+}
+
+static int xxx_recv(struct drbd_transport *transport, enum drbd_stream stream, void *buf, size_t size, int flags)
+{
+	struct drbd_xxx_transport *xxx_transport =
+		container_of(transport, struct drbd_xxx_transport, transport);
+
+	return 0;
+}
+
+static void xxx_stats(struct drbd_transport *transport, struct drbd_transport_stats *stats)
+{
+}
+
+static int xxx_connect(struct drbd_transport *transport)
+{
+	struct drbd_xxx_transport *xxx_transport =
+		container_of(transport, struct drbd_xxx_transport, transport);
+
+	return true;
+}
+
+static void xxx_set_rcvtimeo(struct drbd_transport *transport, enum drbd_stream stream, long timeout)
+{
+}
+
+static long xxx_get_rcvtimeo(struct drbd_transport *transport, enum drbd_stream stream)
+{
+	return 0;
+}
+
+static bool xxx_stream_ok(struct drbd_transport *transport, enum drbd_stream stream)
+{
+	return true;
+}
+
+static int xxx_send_page(struct drbd_transport *transport, enum drbd_stream stream, struct page *page,
+		    int offset, size_t size, unsigned msg_flags)
+{
+	return 0;
+}
+
+static bool xxx_hint(struct drbd_transport *transport, enum drbd_stream stream,
+		enum drbd_tr_hints hint)
+{
+	switch (hint) {
+	default: /* not implemented, but should not trigger error handling */
+		return true;
+	}
+	return true;
+}
+
+static int __init xxx_init(void)
+{
+	return drbd_register_transport_class(&xxx_transport_class);
+}
+
+static void __exit xxx_cleanup(void)
+{
+	drbd_unregister_transport_class(&xxx_transport_class);
+}
+
+module_init(xxx_init)
+module_exit(xxx_cleanup)
-- 
2.53.0

