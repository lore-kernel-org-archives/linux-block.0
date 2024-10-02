Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FAF18027;
	Wed,  2 Oct 2024 04:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841992; cv=none; b=DfMIwB5j29MgJwDkYjdwafK7S/XCm4QRBICzBkMmUKT/eYtPV+88woyn2TD+QDf3MGZ1Xvk27NwiHmBoUlvlsL7QY4ng9eQcQpv2iQaZ3mNaABHmv/pe8+Zr7Ld4ng/+TxfToZbDyUjeGdtYxEK88aUSv9X3/1eC4j33/f3F5wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841992; c=relaxed/simple;
	bh=zo5VwSEKCU/Lvb5+t+mW5K5kPk3hOVnEu83LPoCmyx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rF2bKG0ioGyHswlGOsMetbs9Ql6RxNM05tbEdAPEtyDT6k7pyYp8tafNrxncDkTOuVl44mKw3jSPL0qiKFgmCf7HPD4yWQJBaCckm2DzGQXgAyoC95OLHYKiUzHhJprSuYYi6BSDs7pGda7YQpdfRq2Ik8rb0zt2qsZR5capxO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsFKhDlE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsFKhDlE"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e109539aedso2807452a91.0;
        Tue, 01 Oct 2024 21:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727841991; x=1728446791; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jvO3ydRgY4tt/z1UVsF5Faqu4tn053ewwaTrZBvxX0Y=;
        b=NsFKhDlEd4Mq4zwXsMh4Xx+odOWVLqh7FemQXlHgMHncRPstKC23p8Sm32R9uxuunT
         0HN34msA18hf4FzLvAuog1zxze8PCQIi681ntL8a+SWN42O9Ot5VWGESzWZxjEKzo8nT
         mLNvgIj4hnm0IYqauAXbpK03IIehtcrqMrSekVOaxo2DQOauWXPVJgiN2CnEpq2arMx/
         XeJ7KLoqx2dIu6I6DCFUNPVf3+F/xF0jP2IvvxHG55ynrthhvpjalVQRxPYF7PQNbvSe
         kNnhvLk/rdFCyl8oDlvu3RHgTsn+vt9SsSuPx7mJdRzz7Evw86xNL1N5jkZ2ZdLnibxm
         89CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727841991; x=1728446791;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvO3ydRgY4tt/z1UVsF5Faqu4tn053ewwaTrZBvxX0Y=;
        b=UF59412Agn4bcfINQ8dGCrosCX6p/yXJbAwUQB3dur3fOfucQSL0dCv0gGhD5NWwZG
         FZKL6x3X+B+99ME+nUQg+DZZsMcEHHx3H40kjLI0EWNCNo8RDTfwbVuFDjm4Fwh4kD4t
         WLrXwbtdYVZkCuIE/Zd/f8kXxllsHWPUNXv3N1KA4PfY67dbQI5EjizUjhENvYMjFxdX
         am6dJ8ZEo502DqmMlrKMnyDX7URp7KanPLaoDMvPMM4WB/4XXUNkoTAxE3qgUsb5R3Fp
         8Q+KKDKI51neX5gY9E+iBPape5HhlUrWb17BunuUFlRy3m2kj4UdQeRC4Dz/vW8l0ewY
         7Uow==
X-Forwarded-Encrypted: i=1; AJvYcCWgx5gf1N6EHoU2uYAT0rjB1wh4dXqzprD5v0eOwR1HZ6IIZGLj8HucaxEXPo4DmuneX4fIUH4JbBLmesyN@vger.kernel.org, AJvYcCXyUoM3+34MQSL0EvvQ3heBpeipD8Y0oU8H9EV3vO3Vspi6rsi7qzjPzfI0tUiKoacUT6BC+9Jl5nWZZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Kolu9/wnWsW5o4+vxIQUCDjwEyIQpoqZpe1262p7SWlmA+yq
	2lQQ5JpfPsNF9/zaW6OaCmNwz502gOwjUVLpTdVPL+LoeBb0SmTB
X-Google-Smtp-Source: AGHT+IGsQIinJWLAlplnKYLC00klkkFs9EfuwGdQekBYkAMHfaf5zkwFBrxSPy7bCKwvYClbeLm8Mg==
X-Received: by 2002:a17:90b:4c47:b0:2d8:8ab3:2889 with SMTP id 98e67ed59e1d1-2e184684888mr2747611a91.11.1727841990566;
        Tue, 01 Oct 2024 21:06:30 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f8a1429sm511331a91.32.2024.10.01.21.06.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2024 21:06:30 -0700 (PDT)
From: Chun-Yi Lee <joeyli.kernel@gmail.com>
X-Google-Original-From: Chun-Yi Lee <jlee@suse.com>
To: Justin Sanders <justin@coraid.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chun-Yi Lee <jlee@suse.com>
Subject: [RFC PATCH 1/2] aoe: add reference count in aoeif for tracking the using of net_device
Date: Wed,  2 Oct 2024 12:06:15 +0800
Message-Id: <20241002040616.25193-2-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20241002040616.25193-1-jlee@suse.com>
References: <20241002040616.25193-1-jlee@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

This is a patch for debugging. For tracking the reference count of using
net_device in aoeif, this patch adds a nd_pcpu_refcnt field in aoeif
structure. Two wrappers, nd_dev_hold() and nd_dev_put() are used to
call dev_hold(nd)/dev_put(nd) and maintain ifp->nd_pcpu_refcnt at the
same time.

Defined DEBUG to the top of the aoe.h can enable the tracking function.
The nd_pcpu_refcnt will be printed to debugfs:

rttavg: 249029 rttdev: 1781043
nskbpool: 0
kicked: 0
maxbcnt: 1024
ref: 0
falloc: 36
ffree: 0000000013c0033f
52540054c48e:0:16:16
        ssthresh:8
        taint:0
        r:1270
        w:8
        enp1s0:1	<-- the aoeif->nd_pcpu_refcnt is behind nd->name

The value of aoeif->nd_pcpu_refcnt will also be printed when 'rmmod aoe':

[23412.255237][ T2857] aoe: enp1s0->refcnt: 32, aoeif->nd_refcnt: 0

Using kernel dynamic debug can print more detail log but it causes extra
overhead:

echo -n 'file drivers/block/aoe/* +p' > /sys/kernel/debug/dynamic_debug/control

[ 6961.938642] aoe: tx dev_put enp1s0->refcnt: 31, aoeif->nd_refcnt: 1
[ 7023.368814] aoe: aoecmd_cfg_pkts dev_hold lo->refcnt: 30
[ 7023.370530] aoe: aoecmd_cfg_pkts dev_hold enp1s0->refcnt: 32, aoeif->nd_refcnt: 2
[ 7023.372977] aoe: tx dev_put lo->refcnt: 29
[ 7023.375147] aoe: tx dev_put enp1s0->refcnt: 31, aoeif->nd_refcnt: 1

Normally, after one operation of aoe, the aoeif->nd_refcnt should be
shown as '1' which means that calls of dev_hold(nd)/dev_put(nd) are
balanced. The final '1' reference of net_device will be removed when
rmmod aoe.

Signed-off-by: Chun-Yi Lee <jlee@suse.com>
---
 drivers/block/aoe/aoe.h    | 84 ++++++++++++++++++++++++++++++++++++++
 drivers/block/aoe/aoeblk.c |  5 +++
 drivers/block/aoe/aoedev.c | 20 +++++++++
 3 files changed, 109 insertions(+)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 749ae1246f4c..a6d954562794 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -1,5 +1,6 @@
 /* Copyright (c) 2013 Coraid, Inc.  See COPYING for GPL terms. */
 #include <linux/blk-mq.h>
+#include <linux/netdevice.h>
 
 #define VERSION "85"
 #define AOE_MAJOR 152
@@ -133,6 +134,9 @@ struct aoeif {
 	struct net_device *nd;
 	ulong lost;
 	int bcnt;
+#ifdef DEBUG
+	int __percpu *nd_pcpu_refcnt;
+#endif
 };
 
 struct aoetgt {
@@ -238,6 +242,7 @@ void aoedev_downdev(struct aoedev *d);
 int aoedev_flush(const char __user *str, size_t size);
 void aoe_failbuf(struct aoedev *, struct buf *);
 void aoedev_put(struct aoedev *);
+struct aoeif *get_aoeif(struct net_device *nd);
 
 int aoenet_init(void);
 void aoenet_exit(void);
@@ -246,3 +251,82 @@ int is_aoe_netif(struct net_device *ifp);
 int set_aoe_iflist(const char __user *str, size_t size);
 
 extern struct workqueue_struct *aoe_wq;
+
+#ifdef DEBUG
+static inline int aoeif_nd_refcnt_read(const struct aoeif *ifp)
+{
+       int i, refcnt = 0;
+
+       for_each_possible_cpu(i)
+               refcnt += *per_cpu_ptr(ifp->nd_pcpu_refcnt, i);
+       return refcnt;
+}
+
+static inline void aoeif_nd_refcnt_free(struct aoeif *ifp)
+{
+	int i;
+
+	if(!ifp)
+		return;
+	if (ifp->nd)
+		pr_info("aoe: %s->refcnt: %d, aoeif->nd_refcnt: %d\n",
+			ifp->nd->name, netdev_refcnt_read(ifp->nd),
+			aoeif_nd_refcnt_read(ifp));
+	else
+		pr_info("aoe: aoeif->nd_refcnt: %d\n", aoeif_nd_refcnt_read(ifp));
+
+	for_each_possible_cpu(i)
+		*per_cpu_ptr(ifp->nd_pcpu_refcnt, i) = 0;
+	free_percpu(ifp->nd_pcpu_refcnt);
+	ifp->nd_pcpu_refcnt = NULL;
+}
+
+/* ifi aoeif input, nb be set to aoeif or in the future will be set */
+static inline void __nd_dev_hold(const char *str, struct net_device *nd, struct aoeif *ifi)
+{
+	struct aoeif *ifp;
+
+	if (!nd)
+		return;
+	dev_hold(nd);
+	ifp = ifi? ifi:get_aoeif(nd);
+	if (ifp) {
+		this_cpu_inc(*ifp->nd_pcpu_refcnt);
+		pr_debug("aoe: %s dev_hold %s->refcnt: %d, aoeif->nd_refcnt: %d\n",
+			 str, nd->name, netdev_refcnt_read(nd),
+			 aoeif_nd_refcnt_read(ifp));
+	} else
+		pr_debug("aoe: %s dev_hold %s->refcnt: %d\n",
+			 str, nd->name, netdev_refcnt_read(nd));
+}
+#define nd_dev_hold(msg, ifi) __nd_dev_hold(__FUNCTION__, (msg), (ifi))
+
+static inline void __nd_dev_put(const char *str, struct net_device *nd, struct aoeif *ifi)
+{
+	struct aoeif *ifp;
+
+	if (!nd)
+		return;
+	dev_put(nd);
+	ifp = ifi? ifi:get_aoeif(nd);
+	if (ifp) {
+		this_cpu_dec(*ifp->nd_pcpu_refcnt);
+		pr_debug("aoe: %s dev_put %s->refcnt: %d, aoeif->nd_refcnt: %d\n",
+			 str, nd->name, netdev_refcnt_read(nd),
+			 aoeif_nd_refcnt_read(ifp));
+	} else
+		pr_debug("aoe: %s dev_put %s->refcnt: %d\n",
+			 str, nd->name, netdev_refcnt_read(nd));
+}
+#define nd_dev_put(msg, ifi) __nd_dev_put(__FUNCTION__, (msg), (ifi))
+#else
+static inline void nd_dev_put(struct net_device *nd, struct aoeif *ifi)
+{
+	dev_hold(nd);
+}
+static inline void nd_dev_hold(struct net_device *nd, struct aoeif *ifi)
+{
+       dev_put(nd);
+}
+static inline void aoeif_nd_refcnt_free(const struct aoeif *ifp) {}
+#endif // DEBUG
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 2028795ec61c..19d62ccca1e9 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -142,7 +142,12 @@ static int aoe_debugfs_show(struct seq_file *s, void *ignored)
 		ifp = (*t)->ifs;
 		ife = ifp + ARRAY_SIZE((*t)->ifs);
 		for (; ifp->nd && ifp < ife; ifp++) {
+#ifdef DEBUG
+			seq_printf(s, "%c%s:%d", c, ifp->nd->name,
+					aoeif_nd_refcnt_read(ifp));
+#else
 			seq_printf(s, "%c%s", c, ifp->nd->name);
+#endif
 			c = ',';
 		}
 		seq_puts(s, "\n");
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 3523dd82d7a0..9781488b286b 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -529,3 +529,23 @@ aoedev_init(void)
 {
 	return 0;
 }
+
+struct aoeif *
+get_aoeif(struct net_device *nd)
+{
+	struct aoedev *d;
+	struct aoetgt *t, **tt, **te;
+	struct aoeif *ifp;
+
+	for (d=devlist; d; d=d->next) {
+		tt = d->targets;
+		te = tt + d->ntargets;
+		for (; tt < te && (t = *tt); tt++) {
+			for (ifp = t->ifs; ifp < &t->ifs[NAOEIFS]; ++ifp) {
+				if (ifp->nd && (ifp->nd == nd))
+					return ifp;
+			}
+		}
+	}
+	return NULL;
+}
-- 
2.35.3

