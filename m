Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248751;
	b=EaDv8qYD0+g8GUEHzKIO4F0eiu050lEm0JwA3CXsM62y++dleToPzrPY36aegxuMwqCr
	 d9WetA9sLk1lCKJw1aZaE9ZoBrdkD1DS/siU8jo33lL7SXAIRApKrBxavWdoRkKqMoE8P
	 eHlX4HIGzy7gI0wXyWYVmohn6Vim/aYIW3UGtBSy/giy6ndL9jfY09Uo0Y9sovf7YNALY
	 xih2T2PncEPiDKu14ioLg3XvFowm30uHFCcJcmf60XwWnmDv+65jHZwpZnSHR+EVLNhWr
	 dwC2CHdnGvHyqnqzR5p4rSp7+KIRiv/SkcI3vfDyXOhL9v0yHOxb4I3YErXwR0Ee4PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=6cydJtB07kzkqbqAwuyYeLXmBk6fsv/YqKMHTHat3gU=;
	b=cPSZ74Uwq08Hsp9dSC/qjd2QdNJeY3J3MofUIM6rJkPfkTBFzkr6ZkJPpatMVTrQFdd2
	 oRUUNlS6qF0UJsmoAspm8fhAqvB/RWU/H/m9JWWt3JjHV1Kvii3urp9dQclHT8t9A0Tyc
	 JlSoBiSlceVeknq2iq044YZKv4GwJlKFucqwh0p2OjvovsT9hqKi2NPAx5kra4fNOpzSG
	 4/WgPZ10dw/ykvand2cVgOb8fs+yU3RgRUgut8XoaBgvUDsWLJb6OP61cQqoxDDp1DKZY
	 +avQgOr0wBbJfvxN429Q6K3L7CNIggBW1BECIBI0D/aWUPZ30tbGdMl0a/GMznCaSLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kBnf4hYt;
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C8606B5A7
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 18:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF9C8606B5A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kBnf4hYt
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b65682a122so1751894a12.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 10:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248749; x=1794853549; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cydJtB07kzkqbqAwuyYeLXmBk6fsv/YqKMHTHat3gU=;
        b=kBnf4hYtoAi6E7BgFDqnei3MfKoNd3l287mBPH3iw4u/4JNe3dReP5bgxnWNJ+7TyV
         yVCsZmLa3t2BF/UE/8XDPnqK0hNDug4mIJmXHjKPJ2IHcOY1QwiPHTwJNqIjpJWaBlZa
         t9GfihExQfkI6bziWq5T/ahUAh8mLVaSpwl/Xj811t1+OGvnSB6wLxP05QgIwwFLwKlE
         zjwhqxpuVx/tsA3p2zpVE+XB762kGkg8aNDeIFSGfojLCdDI629N/CzXv932R+cNcRO/
         8YbTP9x+5ZtNx6izUOzxN91TZpLlgSY0YwcFSHuGOaXWGkXbD4rkAYt2xDeSwLaiIiYg
         Q9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248749; x=1794853549;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6cydJtB07kzkqbqAwuyYeLXmBk6fsv/YqKMHTHat3gU=;
        b=Ahfa0SFi5R66rpbwhfHVrcO23jMd0E0Yvzju45g371rAa+NZqcPfPCGFpT6GbTKgNY
         w+zb+rY3k0ggJhyz+oT5/j3Bd+MNZ0Z9cvQQyIZxjo3vOiA7tElRFRrAWDpcksFGyHtn
         J0X79nTiNKFjhlZ3SUsVSfC/c2dQO5rr/x5Q6MtZBDK6ub6q4FtTA0ou3owIyEDVeQXR
         4C2/L9+/+xvei+8Alm4SFVSqJJ9MDbNZk4wRLkG482bJzuiCv6r6eMqQ+QIPrk1f8phV
         p6MGf1LFz73DEUyWtuVZ2+ManPTz4p/+SY1DPsBt/lzIS8YJk83+wx7DtMVtAHYCZxM1
         RTnA==
X-Forwarded-Encrypted: i=1; AL+hErFIUNe5Y3OWOuKS97oJdqZPKoVXGeOJoLM8f4f55g3QVt3m40poTLDiabGUgHOQxIn0ZNEwuGE0XxetyQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z97kIXb9d5OyFBZb3DnjOwrF/tmHSoA3eUejgdthzQscoPIaBJH
	eCPddn5Stc95UGpUvosBLQzhEAls2IupRvq+f8riaJP45v1lwU4pjikDS7RiD9efX8kd9pimAZa
	agOlB0Q==
X-Received: from ejbo13.prod.google.com ([2002:a17:906:358d:b0:c31:7cee:94dd])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:c11:b0:c49:d1c5:431a
 with SMTP id a640c23a62f3a-c50495ecedbmr18940166b.38.1794248749031; Mon, 09
 Nov 2026 10:25:49 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:20 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109182533.3594984-13-lrizzo@google.com>
Subject: [RFC PATCH v2 12/25] net/core: Use per-node PISA allocators for skb_page_frag_refill()
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Transmit socket buffers use memory coming from skb_page_frag_refill().
Sockets whose leaf device has enabled pisa_tx_bufs should use PISA
memory.

Add a dedicated per-task page_frag, current->task_frag_pisa, populated
with read-only PISA blocks via __GFP_PISA_RO, and select it on TX when
the socket's (or cork's) route goes out in the clear through a PISA-enabled
device.

Because walking lower devices can be expensive (e.g. bonded devices),
cache the leaf device check on the net_device and refresh it at most once
every ~250ms. Special paths that hold plaintext before encryption (IPsec,
kTLS) or do not use a DMA device keep using regular pages;
ESP output uses skb_page_frag_refill_dev() to opt in when the
egress device has pisa_tx_bufs enabled.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/base/core.c        | 24 +++++++---
 drivers/iommu/pisa-alloc.c | 57 ++++++++++++++++++++++++
 drivers/iommu/pisa-kunit.c |  3 +-
 include/linux/device.h     |  9 ++++
 include/linux/netdevice.h  |  4 ++
 include/linux/pisa.h       | 20 +++++++++
 include/linux/sched.h      |  4 ++
 include/linux/skbuff.h     |  2 +
 include/net/sock.h         | 89 ++++++++++++++++++++++++++++++++++++++
 kernel/exit.c              |  2 +
 kernel/fork.c              |  2 +
 net/core/sock.c            | 41 ++++++++++++++++++
 net/ipv4/esp4.c            |  4 +-
 net/ipv4/ip_output.c       | 11 +++--
 net/ipv4/tcp.c             |  3 +-
 net/ipv6/esp6.c            |  4 +-
 net/ipv6/ip6_output.c      | 11 +++--
 17 files changed, 270 insertions(+), 20 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 97cd2d03ff77c..ade0c94b02ae7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2909,7 +2909,8 @@ static ssize_t removable_show(struct device *dev, const struct device_attribute
 static const DEVICE_ATTR_RO(removable);
 
 /* Per-device configuration to selectively enable PISA */
-static ssize_t pisa_attr_store(const char *buf, size_t count, bool *field)
+static ssize_t pisa_attr_store(struct device *dev, const char *buf, size_t count,
+			       bool *field, int (*setter)(struct device *, bool))
 {
 	bool val;
 	int ret = kstrtobool(buf, &val);
@@ -2921,11 +2922,17 @@ static ssize_t pisa_attr_store(const char *buf, size_t count, bool *field)
 		if (ret < 0)
 			return ret;
 	}
-	WRITE_ONCE(*field, val);
+	if (setter) {
+		ret = setter(dev, val);
+		if (ret < 0)
+			return ret;
+	} else {
+		WRITE_ONCE(*field, val);
+	}
 	return count;
 }
 
-#define PISA_BOOL_ATTR(name)						\
+#define PISA_SET_ATTR(name, setter)					\
 static ssize_t name##_show(struct device *dev,				\
 			   struct device_attribute *attr, char *buf)	\
 {									\
@@ -2935,13 +2942,15 @@ static ssize_t name##_store(struct device *dev,				\
 			    struct device_attribute *attr,		\
 			    const char *buf, size_t count)		\
 {									\
-	return pisa_attr_store(buf, count, &dev->name);			\
+	return pisa_attr_store(dev, buf, count, &dev->name, setter);	\
 }									\
 static DEVICE_ATTR_RW(name)
 
+#define PISA_BOOL_ATTR(name)	PISA_SET_ATTR(name, NULL)
+
 PISA_BOOL_ATTR(pisa_coherent);
 PISA_BOOL_ATTR(pisa_rx_bufs);
-PISA_BOOL_ATTR(pisa_tx_bufs);
+PISA_SET_ATTR(pisa_tx_bufs, net_pisa_tx_bufs_set);
 PISA_BOOL_ATTR(pisa_tx_skb_heads);
 
 static struct attribute *dev_attr_pisa[] = {
@@ -3100,8 +3109,11 @@ static void device_remove_attrs(struct device *dev)
 	const struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 
-	if (IS_ENABLED(CONFIG_PISA) && dev->dma_mask)
+	if (IS_ENABLED(CONFIG_PISA) && dev->dma_mask) {
 		device_remove_group(dev, &dev_attr_pisa_group);
+		if (dev->pisa_tx_bufs)
+			net_pisa_tx_bufs_set(dev, false);
+	}
 
 	if (dev->physical_location) {
 		device_remove_group(dev, &dev_attr_physical_location_group);
diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index 913706a503341..7b9d0a7acc101 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -644,6 +644,63 @@ bool pisa_has_free_blocks_rx(const struct device *dev, unsigned int order, int n
 }
 EXPORT_SYMBOL(pisa_has_free_blocks_rx);
 
+#ifdef CONFIG_NET
+/* Enabled while at least one device has pisa_tx_bufs set. */
+DEFINE_STATIC_KEY_FALSE(net_pisa_tx_bufs_key);
+EXPORT_SYMBOL(net_pisa_tx_bufs_key);
+
+int net_pisa_tx_bufs_set(struct device *dev, bool val)
+{
+	static DEFINE_MUTEX(lock);
+
+	mutex_lock(&lock);
+	if (dev->pisa_tx_bufs != val) {
+		WRITE_ONCE(dev->pisa_tx_bufs, val);
+		if (val)
+			static_branch_inc(&net_pisa_tx_bufs_key);
+		else
+			static_branch_dec(&net_pisa_tx_bufs_key);
+	}
+	mutex_unlock(&lock);
+	return 0;
+}
+
+/*
+ * The sysfs attribute pisa_tx_bufs lives on the physical DMA parent
+ * (dev->dev.parent), whereas a socket route (dst->dev) may point to an upper
+ * virtual net_device (bond, VLAN, ipvlan, etc.). Walking lower devices via
+ * netdev_walk_all_lower_dev_rcu() on every TX allocation would be too
+ * expensive, so dev->pisa_tx_stamp caches the walk result on the net_device
+ * and refreshes it at most once every 256 jiffies:
+ *   bit 0 (PISA_TX_STAMP_OK):         pisa_tx_bufs enabled on lower device(s)
+ *   bits 31..8 (PISA_TX_STAMP_MASK):  upper 24 bits of (u32)jiffies
+ */
+static int netdev_pisa_tx_bufs_walk(struct net_device *dev, struct netdev_nested_priv *priv)
+{
+	return dev->dev.parent && READ_ONCE(dev->dev.parent->pisa_tx_bufs);
+}
+
+/* Slow path of __netdev_tx_pisa_ok(): refresh dev->pisa_tx_stamp. */
+bool netdev_tx_pisa_refresh(struct net_device *dev, u32 now)
+{
+	bool ok;
+
+	if (dev->dev.parent) {
+		ok = READ_ONCE(dev->dev.parent->pisa_tx_bufs);
+	} else {
+		rcu_read_lock();
+		ok = netdev_walk_all_lower_dev_rcu(dev,
+						   netdev_pisa_tx_bufs_walk,
+						   NULL) != 0;
+		rcu_read_unlock();
+	}
+	now |= ok ? PISA_TX_STAMP_OK : 0;
+	WRITE_ONCE(dev->pisa_tx_stamp, now);
+	return now & PISA_TX_STAMP_OK;
+}
+EXPORT_SYMBOL(netdev_tx_pisa_refresh);
+#endif /* CONFIG_NET */
+
 /*
  * Split a non-compound page of @old_order into 1 << (@old_order - @new_order)
  * pages of @new_order (compound if @new_order > 0), all frozen at refcount 0.
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index 5bbb540eb505e..5f6b2ebcab1d9 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -477,7 +477,8 @@ static void test_dev_pisa_attrs(struct kunit *test)
 	}
 	kunit_check_pisa_attr(test, dev, "pisa_coherent", &dev->pisa_coherent);
 	kunit_check_pisa_attr(test, dev, "pisa_rx_bufs", &dev->pisa_rx_bufs);
-	kunit_check_pisa_attr(test, dev, "pisa_tx_bufs", &dev->pisa_tx_bufs);
+	if (IS_ENABLED(CONFIG_NET))
+		kunit_check_pisa_attr(test, dev, "pisa_tx_bufs", &dev->pisa_tx_bufs);
 	kunit_check_pisa_attr(test, dev, "pisa_tx_skb_heads", &dev->pisa_tx_skb_heads);
 	device_unregister(dev);
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index b3c11e32116ca..08f511b978ded 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -814,6 +814,15 @@ struct device {
 	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
 };
 
+#if defined(CONFIG_NET) && defined(CONFIG_PISA)
+int net_pisa_tx_bufs_set(struct device *dev, bool val);
+#else
+static inline int net_pisa_tx_bufs_set(struct device *dev, bool val)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #define __create_dev_flag_accessors(accessor_name, flag_name) \
 static inline bool dev_##accessor_name(const struct device *dev) \
 { \
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 435be7880d7e5..41c999223a15e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2161,6 +2161,7 @@ enum netdev_reg_state {
  *	@neighbours:	List heads pointing to this device's neighbours'
  *			dev_list, one per address-family.
  *	@hwprov: Tracks which PTP performs hardware packet time stamping.
+ *	@pisa_tx_stamp:	Cached leaf pisa flags and timestamp.
  *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
@@ -2276,6 +2277,9 @@ struct net_device {
 	} adj_list;
 
 	/* Read-mostly cache-line for fast-path access */
+#ifdef CONFIG_PISA
+	u32			pisa_tx_stamp;
+#endif
 	xdp_features_t		xdp_features;
 	const struct xdp_metadata_ops *xdp_metadata_ops;
 	const struct xsk_tx_metadata_ops *xsk_tx_metadata_ops;
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index cdf176464d74a..822e1556d78ef 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -107,6 +107,18 @@ static inline gfp_t pisa_rx_gfp(const struct device *dev)
 	return dev && READ_ONCE(dev->pisa_rx_bufs) ? __GFP_PISA_RW : 0;
 }
 
+/* current->task_frag_pisa lifetime, see task_page_frag(). */
+static inline void pisa_task_frag_init(struct task_struct *tsk)
+{
+	tsk->task_frag_pisa.page = NULL;
+}
+
+static inline void pisa_task_frag_release(struct task_struct *tsk)
+{
+	if (tsk->task_frag_pisa.page)
+		put_page(tsk->task_frag_pisa.page);
+}
+
 #else /* !CONFIG_PISA */
 
 static inline int pisa_meta_init(void)
@@ -164,6 +176,14 @@ static inline bool pisa_has_free_blocks_rx(const struct device *dev,
 	return false;
 }
 
+static inline void pisa_task_frag_init(struct task_struct *tsk)
+{
+}
+
+static inline void pisa_task_frag_release(struct task_struct *tsk)
+{
+}
+
 #endif /* CONFIG_PISA */
 
 static inline struct page *
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c93da75226e3..1c7ef0d90dc35 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1453,6 +1453,10 @@ struct task_struct {
 	struct pipe_inode_info		*splice_pipe;
 
 	struct page_frag		task_frag;
+#ifdef CONFIG_PISA
+	/* TX frag that may hold PISA pages, see sk_page_frag_dst(). */
+	struct page_frag		task_frag_pisa;
+#endif
 
 #ifdef CONFIG_ARCH_HAS_LAZY_MMU_MODE
 	struct lazy_mmu_state		lazy_mmu_state;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 6787fcf6ac3e4..2fce6eafa1cb3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3808,6 +3808,8 @@ static inline void skb_frag_page_copy(skb_frag_t *fragto,
 }
 
 bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio);
+bool skb_page_frag_refill_dev(unsigned int sz, struct page_frag *pfrag,
+			      const struct sk_buff *skb);
 
 /**
  * __skb_frag_dma_map - maps a paged fragment via the DMA API
diff --git a/include/net/sock.h b/include/net/sock.h
index 173b37b2b8bb0..73906351d11db 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2670,6 +2670,95 @@ static inline struct page_frag *sk_page_frag(struct sock *sk)
 	return &sk->sk_frag;
 }
 
+/* 256-jiffy cache in dev->pisa_tx_stamp; see netdev_tx_pisa_refresh(). */
+#define PISA_TX_STAMP_OK	BIT(0)
+#define PISA_TX_STAMP_MASK	(~0xffU)
+
+#ifdef CONFIG_PISA
+DECLARE_STATIC_KEY_FALSE(net_pisa_tx_bufs_key);
+
+static inline bool net_pisa_tx_bufs_enabled(void)
+{
+	return static_branch_unlikely(&net_pisa_tx_bufs_key);
+}
+
+bool netdev_tx_pisa_refresh(struct net_device *dev, u32 now);
+
+static inline bool __netdev_tx_pisa_ok(const struct net_device *dev)
+{
+	u32 stamp, now;
+
+	if (!dev)
+		return false;
+	stamp = READ_ONCE(dev->pisa_tx_stamp);
+	now = (u32)jiffies & PISA_TX_STAMP_MASK;
+	if (likely((stamp & PISA_TX_STAMP_MASK) == now))
+		return stamp & PISA_TX_STAMP_OK;
+	return netdev_tx_pisa_refresh((struct net_device *)dev, now);
+}
+#else
+static inline bool net_pisa_tx_bufs_enabled(void)
+{
+	return false;
+}
+
+static inline bool __netdev_tx_pisa_ok(const struct net_device *dev)
+{
+	return false;
+}
+#endif
+
+/*
+ * May TX payload routed through @dst be copied into PISA pages? Those pages
+ * stay readable by every device that mapped them for as long as they are
+ * active, so only data that leaves the host in clear qualifies: IPsec payload
+ * is still plaintext here.
+ */
+static inline bool dst_tx_pisa_ok(const struct dst_entry *dst)
+{
+	bool ok = false;
+
+	if (!net_pisa_tx_bufs_enabled() || !dst)
+		return false;
+
+	rcu_read_lock();
+	if (!dst_xfrm(dst))
+		ok = __netdev_tx_pisa_ok(dst_dev_rcu(dst));
+	rcu_read_unlock();
+	return ok;
+}
+
+/* Is @pfrag the task's frag reserved for PISA-eligible data? */
+static inline bool is_pisa_pfrag(const struct page_frag *pfrag)
+{
+#ifdef CONFIG_PISA
+	return pfrag == &current->task_frag_pisa;
+#else
+	return false;
+#endif
+}
+
+/* current->task_frag, or its PISA twin if @dst qualifies. */
+static inline struct page_frag *task_page_frag(const struct dst_entry *dst)
+{
+#ifdef CONFIG_PISA
+	if (dst_tx_pisa_ok(dst))
+		return &current->task_frag_pisa;
+#endif
+	return &current->task_frag;
+}
+
+/*
+ * sk_page_frag() for data routed through @dst. PISA pages only ever enter
+ * current->task_frag_pisa, so data of sockets that do not qualify (or that use
+ * sk_page_frag() directly: kTLS, sockmap, KCM, MPTCP) never lands in them.
+ */
+static inline struct page_frag *sk_page_frag_dst(struct sock *sk,
+						 const struct dst_entry *dst)
+{
+	return sk->sk_use_task_frag ? task_page_frag(dst) : &sk->sk_frag;
+}
+
 bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag);
 
 static inline bool __sock_writeable(const struct sock *sk, int wmem_alloc)
diff --git a/kernel/exit.c b/kernel/exit.c
index d5e7bc2af804a..ac7ca1fb180c3 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/pisa.h>
 #include <linux/slab.h>
 #include <linux/sched/autogroup.h>
 #include <linux/sched/mm.h>
@@ -1009,6 +1010,7 @@ void __noreturn do_exit(long code)
 
 	if (tsk->task_frag.page)
 		put_page(tsk->task_frag.page);
+	pisa_task_frag_release(tsk);
 
 	exit_task_stack_account(tsk);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 5efceb8d58a78..d235d7ab04687 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -44,6 +44,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/pisa.h>
 #include <linux/mm_inline.h>
 #include <linux/memblock.h>
 #include <linux/nsproxy.h>
@@ -982,6 +983,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #endif
 	tsk->splice_pipe = NULL;
 	tsk->task_frag.page = NULL;
+	pisa_task_frag_init(tsk);
 	tsk->wake_q.next = NULL;
 	tsk->worker_private = NULL;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index e2401d735c5a7..695fefe316925 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -115,6 +115,7 @@
 #include <linux/memcontrol.h>
 #include <linux/prefetch.h>
 #include <linux/compat.h>
+#include <linux/pisa.h>
 #include <linux/mroute.h>
 #include <linux/mroute6.h>
 #include <linux/icmpv6.h>
@@ -3257,13 +3258,20 @@ DEFINE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
  */
 bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
 {
+	/* PISA pages only go into current->task_frag_pisa, see sk_page_frag_dst(). */
+	if (is_pisa_pfrag(pfrag))
+		gfp |= __GFP_PISA_RO;
+
 	if (pfrag->page) {
+		if ((gfp & __GFP_PISA_RO) && !pisa_page_can_recycle(pfrag->page))
+			goto drop_page;
 		if (page_ref_count(pfrag->page) == 1) {
 			pfrag->offset = 0;
 			return true;
 		}
 		if (pfrag->offset + sz <= pfrag->size)
 			return true;
+drop_page:
 		put_page(pfrag->page);
 	}
 
@@ -3289,6 +3297,39 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
 }
 EXPORT_SYMBOL(skb_page_frag_refill);
 
+/**
+ * skb_page_frag_refill_dev - GFP_ATOMIC skb_page_frag_refill() for @skb TX
+ * @sz: minimum size of the fragment we want to get
+ * @pfrag: pointer to page_frag, private to the caller
+ * @skb: packet being transmitted
+ *
+ * Pages come from the per-node DMA_TO_DEVICE PISA allocators when they are
+ * useful for @skb's egress device (__netdev_tx_pisa_ok()), otherwise from the
+ * buddy allocator. PISA pages are readable by every device that maps them
+ * while they stay active, so @pfrag must only ever hold data meant for devices,
+ * e.g. ciphertext; it may mix PISA and ordinary pages.
+ */
+bool skb_page_frag_refill_dev(unsigned int sz, struct page_frag *pfrag,
+			      const struct sk_buff *skb)
+{
+	gfp_t gfp = GFP_ATOMIC;
+
+	/*
+	 * Before ip_finish_output2() populates skb->dev (e.g. esp_output),
+	 * the egress device is carried by skb_dst(skb).
+	 */
+	if (net_pisa_tx_bufs_enabled()) {
+		const struct dst_entry *dst = skb_dst(skb);
+
+		rcu_read_lock();
+		if (__netdev_tx_pisa_ok(skb->dev ?: (dst ? dst_dev_rcu(dst) : NULL)))
+			gfp |= __GFP_PISA_RO;
+		rcu_read_unlock();
+	}
+	return skb_page_frag_refill(sz, pfrag, gfp);
+}
+EXPORT_SYMBOL(skb_page_frag_refill_dev);
+
 bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
 {
 	if (likely(skb_page_frag_refill(32U, pfrag, sk->sk_allocation)))
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index ae701561d9f12..feecf094f582c 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -451,7 +451,7 @@ int esp_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 
 			spin_lock_bh(&x->lock);
 
-			if (unlikely(!skb_page_frag_refill(allocsize, pfrag, GFP_ATOMIC))) {
+			if (unlikely(!skb_page_frag_refill_dev(allocsize, pfrag, skb))) {
 				spin_unlock_bh(&x->lock);
 				goto cow;
 			}
@@ -560,7 +560,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 		allocsize = ALIGN(skb->data_len, L1_CACHE_BYTES);
 
 		spin_lock_bh(&x->lock);
-		if (unlikely(!skb_page_frag_refill(allocsize, pfrag, GFP_ATOMIC))) {
+		if (unlikely(!skb_page_frag_refill_dev(allocsize, pfrag, skb))) {
 			spin_unlock_bh(&x->lock);
 			goto error_free;
 		}
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 3396f177a18d0..a5ea530bc8b5b 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -986,7 +986,10 @@ static int __ip_append_data(struct sock *sk,
 
 	exthdrlen = !skb ? rt->dst.header_len : 0;
 	mtu = cork->gso_size ? IP_MAX_MTU : cork->fragsize;
-	paged = !!cork->gso_size;
+	paged = !!cork->gso_size ||
+		(sk->sk_type != SOCK_RAW &&
+		 (rt->dst.dev->features & NETIF_F_SG) &&
+		 is_pisa_pfrag(pfrag));
 
 	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
 
@@ -1383,8 +1386,8 @@ int ip_append_data(struct sock *sk, struct flowi4 *fl4,
 	}
 
 	return __ip_append_data(sk, fl4, &sk->sk_write_queue, &inet->cork.base,
-				sk_page_frag(sk), getfrag,
-				from, length, transhdrlen, flags);
+				sk_page_frag_dst(sk, inet->cork.base.dst),
+				getfrag, from, length, transhdrlen, flags);
 }
 
 static void ip_cork_release(struct inet_cork *cork)
@@ -1592,7 +1595,7 @@ struct sk_buff *ip_make_skb(struct sock *sk,
 		return ERR_PTR(err);
 
 	err = __ip_append_data(sk, fl4, &queue, cork,
-			       &current->task_frag, getfrag,
+			       task_page_frag(cork->dst), getfrag,
 			       from, length, transhdrlen, flags);
 	if (err) {
 		__ip_flush_pending_frames(sk, &queue, cork);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b9de7c302ba83..b8d44a0638914 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1290,9 +1290,10 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			copy = msg_data_left(msg);
 
 		if (zc == 0) {
+			const struct dst_entry *dst = __sk_dst_get(sk);
 			bool merge = true;
 			int i = skb_shinfo(skb)->nr_frags;
-			struct page_frag *pfrag = sk_page_frag(sk);
+			struct page_frag *pfrag = sk_page_frag_dst(sk, dst);
 
 			if (!sk_page_frag_refill(sk, pfrag))
 				goto wait_for_space;
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index d654f0f442388..cdedda548749a 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -481,7 +481,7 @@ int esp6_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 
 			spin_lock_bh(&x->lock);
 
-			if (unlikely(!skb_page_frag_refill(allocsize, pfrag, GFP_ATOMIC))) {
+			if (unlikely(!skb_page_frag_refill_dev(allocsize, pfrag, skb))) {
 				spin_unlock_bh(&x->lock);
 				goto cow;
 			}
@@ -592,7 +592,7 @@ int esp6_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 		allocsize = ALIGN(skb->data_len, L1_CACHE_BYTES);
 
 		spin_lock_bh(&x->lock);
-		if (unlikely(!skb_page_frag_refill(allocsize, pfrag, GFP_ATOMIC))) {
+		if (unlikely(!skb_page_frag_refill_dev(allocsize, pfrag, skb))) {
 			spin_unlock_bh(&x->lock);
 			goto error_free;
 		}
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 25fe0ba98b1a6..957c38a08680c 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1486,7 +1486,10 @@ static int __ip6_append_data(struct sock *sk,
 		dst_exthdrlen = rt->dst.header_len - rt->rt6i_nfheader_len;
 	}
 
-	paged = !!cork->gso_size;
+	paged = !!cork->gso_size ||
+		(sk->sk_type != SOCK_RAW &&
+		 (rt->dst.dev->features & NETIF_F_SG) &&
+		 is_pisa_pfrag(pfrag));
 	mtu = cork->gso_size ? IP6_MAX_MTU : cork->fragsize;
 	orig_mtu = mtu;
 
@@ -1889,8 +1892,8 @@ int ip6_append_data(struct sock *sk,
 	}
 
 	return __ip6_append_data(sk, &sk->sk_write_queue, &inet->cork,
-				 sk_page_frag(sk), getfrag,
-				 from, length, transhdrlen, flags);
+				 sk_page_frag_dst(sk, inet->cork.base.dst),
+				 getfrag, from, length, transhdrlen, flags);
 }
 EXPORT_SYMBOL_GPL(ip6_append_data);
 
@@ -2092,7 +2095,7 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 	}
 
 	err = __ip6_append_data(sk, &queue, cork,
-				&current->task_frag, getfrag, from,
+				task_page_frag(cork->base.dst), getfrag, from,
 				length + exthdrlen, transhdrlen + exthdrlen,
 				flags);
 	if (err) {
-- 
2.56.0.542.g3ef89b7020-goog

