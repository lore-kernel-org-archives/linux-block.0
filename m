Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D504E288514
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653786; cv=none; b=F4qo7PRNTfkb4sNy1pbz/dQ1kqq2Dmwf5NVTjztT+lUvaq0jGFiDpbWbE9n3h+pv1p3LYmZfgI1fsF/i51nNkttXQnOUE09yFLXAgtkZfK8wkwHOFOFS5xuwlUgeIJBAhitqoV1x5P5OdF+SJ3hsv1Pf9SytVxe/u6wpMFJMvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653786; c=relaxed/simple;
	bh=c+qKugedM5akhtBw/w63JQQVIxsL23zlMAYnO2oJYcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W64hI8fLM2XiHwCVgnKst8ZgzkBkpiRQcOqWazLqDS7I7Slri6fUzi0Fiw36i3zTL0Y1wkRJMazb2YiU6EmeBXqNsUsC5TEpi4kdhMhjrKjs2BdvXuY5tiogp9srihu9EUpTYnParhSI+XojKSSwErI+5eChLZdTaitaJ5uC2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=CJWqt6mR; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="CJWqt6mR"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR3Cr4ddRz1XMFZh;
	Wed,  4 Mar 2026 19:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1772653749; x=1775245750; bh=DKuRU
	9mwEhI6LYkRYQ/jR4cEA4jNlhISnuQ7wnH/G48=; b=CJWqt6mRWe9EDI1w/eGTP
	fyyIHs2HQ8uH+kpBolCpj26wvQDYGdztE5kby2dpbpYqs2G6gtFoEMOu60gmeOUT
	fyjo7tuGP+1epDHrbx2ivwLQJ84ApIKNWh1MziIk8xMeuAECr3crAqr4cdYexHc+
	USHi3QvDaEB2r7sQeX6IgX/Gah2Zs1wqWigsPHKMiPhDqTcxSHZktmzcuimoWDDQ
	ZXimMY1rnP7VutIheJUOO7HEN/ywMzyI1++jKbHyD4nznfYC46t01MKxAVuqiY0J
	2nKhVm1MSP1zhFRJAg2vFKI4Nd38narUronEqV7+wZCOKMYRucHA73QN2+KB79hw
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Vbl0ubRtax8r; Wed,  4 Mar 2026 19:49:09 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR3C52BXTz1XM5kt;
	Wed,  4 Mar 2026 19:49:05 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 03/14] block: Make the lock context annotations compatible with Clang
Date: Wed,  4 Mar 2026 11:48:22 -0800
Message-ID: <20260304194843.760669-4-bvanassche@acm.org>
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

Clang is more strict than sparse with regard to lock context annotation
checking. Hence this patch that makes the lock context annotations
compatible with Clang. __release() annotations have been added below
invocations of indirect calls that unlock a mutex because Clang does not
support annotating function pointers with __releases().

Enable context analysis in the block layer Makefile.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/Makefile              |  2 ++
 block/bdev.c                |  7 +++++--
 block/blk-cgroup.c          |  7 ++++---
 block/blk-crypto-profile.c  |  2 ++
 block/blk-iocost.c          |  2 ++
 block/blk-mq-debugfs.c      | 12 ++++++------
 block/blk-zoned.c           |  1 +
 block/blk.h                 |  4 ++++
 block/ioctl.c               |  1 +
 block/kyber-iosched.c       |  4 ++--
 block/mq-deadline.c         |  8 ++++----
 include/linux/backing-dev.h |  2 ++
 include/linux/blkdev.h      | 11 ++++++++---
 include/linux/bpf.h         |  1 +
 14 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/block/Makefile b/block/Makefile
index c65f4da93702..407ea53e39b2 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the kernel block layer
 #
=20
+CONTEXT_ANALYSIS :=3D y
+
 obj-y		:=3D bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
 			blk-merge.o blk-timeout.o blk-lib.o blk-mq.o \
diff --git a/block/bdev.c b/block/bdev.c
index ed022f8c48c7..367f0f09a2e4 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -313,6 +313,7 @@ int bdev_freeze(struct block_device *bdev)
 	if (bdev->bd_holder_ops && bdev->bd_holder_ops->freeze) {
 		error =3D bdev->bd_holder_ops->freeze(bdev);
 		lockdep_assert_not_held(&bdev->bd_holder_lock);
+		__release(&bdev->bd_holder_lock);
 	} else {
 		mutex_unlock(&bdev->bd_holder_lock);
 		error =3D sync_blockdev(bdev);
@@ -356,6 +357,7 @@ int bdev_thaw(struct block_device *bdev)
 	if (bdev->bd_holder_ops && bdev->bd_holder_ops->thaw) {
 		error =3D bdev->bd_holder_ops->thaw(bdev);
 		lockdep_assert_not_held(&bdev->bd_holder_lock);
+		__release(&bdev->bd_holder_lock);
 	} else {
 		mutex_unlock(&bdev->bd_holder_lock);
 	}
@@ -1254,9 +1256,10 @@ EXPORT_SYMBOL(lookup_bdev);
 void bdev_mark_dead(struct block_device *bdev, bool surprise)
 {
 	mutex_lock(&bdev->bd_holder_lock);
-	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
+	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead) {
 		bdev->bd_holder_ops->mark_dead(bdev, surprise);
-	else {
+		__release(&bdev->bd_holder_lock);
+	} else {
 		mutex_unlock(&bdev->bd_holder_lock);
 		sync_blockdev(bdev);
 	}
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b70096497d38..5aec000d3da6 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -774,6 +774,7 @@ EXPORT_SYMBOL_GPL(blkg_conf_init);
  * of @ctx->input. Returns -errno on error.
  */
 int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
+	__no_context_analysis /* conditional locking */
 {
 	char *input =3D ctx->input;
 	unsigned int major, minor;
@@ -819,6 +820,7 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
  * for restoring the memalloc scope.
  */
 unsigned long __must_check blkg_conf_open_bdev_frozen(struct blkg_conf_c=
tx *ctx)
+	__must_hold(&ctx->bdev->bd_queue->rq_qos_mutex)
 {
 	int ret;
 	unsigned long memflags;
@@ -860,7 +862,7 @@ unsigned long __must_check blkg_conf_open_bdev_frozen=
(struct blkg_conf_ctx *ctx)
  */
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   struct blkg_conf_ctx *ctx)
-	__acquires(&bdev->bd_queue->queue_lock)
+	__cond_acquires(0, &ctx->bdev->bd_disk->queue->queue_lock)
 {
 	struct gendisk *disk;
 	struct request_queue *q;
@@ -974,8 +976,7 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
  * blkg_conf_ctx's initialized with blkg_conf_init().
  */
 void blkg_conf_exit(struct blkg_conf_ctx *ctx)
-	__releases(&ctx->bdev->bd_queue->queue_lock)
-	__releases(&ctx->bdev->bd_queue->rq_qos_mutex)
+	__no_context_analysis /* conditional unlocking */
 {
 	if (ctx->blkg) {
 		spin_unlock_irq(&bdev_get_queue(ctx->bdev)->queue_lock);
diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 4ac74443687a..cf447ba4a66e 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -43,6 +43,7 @@ struct blk_crypto_keyslot {
 };
=20
 static inline void blk_crypto_hw_enter(struct blk_crypto_profile *profil=
e)
+	__acquires(&profile->lock)
 {
 	/*
 	 * Calling into the driver requires profile->lock held and the device
@@ -55,6 +56,7 @@ static inline void blk_crypto_hw_enter(struct blk_crypt=
o_profile *profile)
 }
=20
 static inline void blk_crypto_hw_exit(struct blk_crypto_profile *profile=
)
+	__releases(&profile->lock)
 {
 	up_write(&profile->lock);
 	if (profile->dev)
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index d145db61e5c3..081054ca8111 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -728,6 +728,7 @@ static void iocg_commit_bio(struct ioc_gq *iocg, stru=
ct bio *bio,
 }
=20
 static void iocg_lock(struct ioc_gq *iocg, bool lock_ioc, unsigned long =
*flags)
+	__no_context_analysis /* conditional locking */
 {
 	if (lock_ioc) {
 		spin_lock_irqsave(&iocg->ioc->lock, *flags);
@@ -738,6 +739,7 @@ static void iocg_lock(struct ioc_gq *iocg, bool lock_=
ioc, unsigned long *flags)
 }
=20
 static void iocg_unlock(struct ioc_gq *iocg, bool unlock_ioc, unsigned l=
ong *flags)
+	__no_context_analysis /* conditional locking */
 {
 	if (unlock_ioc) {
 		spin_unlock(&iocg->waitq.lock);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 047ec887456b..5c168e82273e 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -20,7 +20,7 @@ static int queue_poll_stat_show(void *data, struct seq_=
file *m)
 }
=20
 static void *queue_requeue_list_start(struct seq_file *m, loff_t *pos)
-	__acquires(&q->requeue_lock)
+	__acquires(&((struct request_queue *)m->private)->requeue_lock)
 {
 	struct request_queue *q =3D m->private;
=20
@@ -36,7 +36,7 @@ static void *queue_requeue_list_next(struct seq_file *m=
, void *v, loff_t *pos)
 }
=20
 static void queue_requeue_list_stop(struct seq_file *m, void *v)
-	__releases(&q->requeue_lock)
+	__releases(&((struct request_queue *)m->private)->requeue_lock)
 {
 	struct request_queue *q =3D m->private;
=20
@@ -298,7 +298,7 @@ int blk_mq_debugfs_rq_show(struct seq_file *m, void *=
v)
 EXPORT_SYMBOL_GPL(blk_mq_debugfs_rq_show);
=20
 static void *hctx_dispatch_start(struct seq_file *m, loff_t *pos)
-	__acquires(&hctx->lock)
+	__acquires(&((struct blk_mq_hw_ctx *)m->private)->lock)
 {
 	struct blk_mq_hw_ctx *hctx =3D m->private;
=20
@@ -314,7 +314,7 @@ static void *hctx_dispatch_next(struct seq_file *m, v=
oid *v, loff_t *pos)
 }
=20
 static void hctx_dispatch_stop(struct seq_file *m, void *v)
-	__releases(&hctx->lock)
+	__releases(&((struct blk_mq_hw_ctx *)m->private)->lock)
 {
 	struct blk_mq_hw_ctx *hctx =3D m->private;
=20
@@ -486,7 +486,7 @@ static int hctx_dispatch_busy_show(void *data, struct=
 seq_file *m)
=20
 #define CTX_RQ_SEQ_OPS(name, type)					\
 static void *ctx_##name##_rq_list_start(struct seq_file *m, loff_t *pos)=
 \
-	__acquires(&ctx->lock)						\
+	__acquires(&((struct blk_mq_ctx *)m->private)->lock)		\
 {									\
 	struct blk_mq_ctx *ctx =3D m->private;				\
 									\
@@ -503,7 +503,7 @@ static void *ctx_##name##_rq_list_next(struct seq_fil=
e *m, void *v,	\
 }									\
 									\
 static void ctx_##name##_rq_list_stop(struct seq_file *m, void *v)	\
-	__releases(&ctx->lock)						\
+	__releases(&((struct blk_mq_ctx *)m->private)->lock)		\
 {									\
 	struct blk_mq_ctx *ctx =3D m->private;				\
 									\
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index e1a23c8b676d..df0800e69ad7 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -439,6 +439,7 @@ static int blkdev_truncate_zone_range(struct block_de=
vice *bdev,
  */
 int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 			   unsigned int cmd, unsigned long arg)
+	__cond_acquires(0, bdev->bd_mapping->host->i_rwsem)
 {
 	void __user *argp =3D (void __user *)arg;
 	struct blk_zone_range zrange;
diff --git a/block/blk.h b/block/blk.h
index f6053e9dd2aa..59321957f54b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -736,16 +736,19 @@ static inline void blk_unfreeze_release_lock(struct=
 request_queue *q)
  * reclaim from triggering block I/O.
  */
 static inline void blk_debugfs_lock_nomemsave(struct request_queue *q)
+	__acquires(&q->debugfs_mutex)
 {
 	mutex_lock(&q->debugfs_mutex);
 }
=20
 static inline void blk_debugfs_unlock_nomemrestore(struct request_queue =
*q)
+	__releases(&q->debugfs_mutex)
 {
 	mutex_unlock(&q->debugfs_mutex);
 }
=20
 static inline unsigned int __must_check blk_debugfs_lock(struct request_=
queue *q)
+	__acquires(&q->debugfs_mutex)
 {
 	unsigned int memflags =3D memalloc_noio_save();
=20
@@ -755,6 +758,7 @@ static inline unsigned int __must_check blk_debugfs_l=
ock(struct request_queue *q
=20
 static inline void blk_debugfs_unlock(struct request_queue *q,
 				      unsigned int memflags)
+	__releases(&q->debugfs_mutex)
 {
 	blk_debugfs_unlock_nomemrestore(q);
 	memalloc_noio_restore(memflags);
diff --git a/block/ioctl.c b/block/ioctl.c
index 0b04661ac809..784f2965f8bd 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -518,6 +518,7 @@ static int blkdev_pr_read_reservation(struct block_de=
vice *bdev,
=20
 static int blkdev_flushbuf(struct block_device *bdev, unsigned cmd,
 		unsigned long arg)
+	__cond_acquires(0, bdev->bd_holder_lock)
 {
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index b84163d1f851..874791838cbc 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -894,7 +894,7 @@ static int kyber_##name##_tokens_show(void *data, str=
uct seq_file *m)	\
 }									\
 									\
 static void *kyber_##name##_rqs_start(struct seq_file *m, loff_t *pos)	\
-	__acquires(&khd->lock)						\
+	__acquires(((struct kyber_hctx_data *)((struct blk_mq_hw_ctx *)m->priva=
te)->sched_data)->lock) \
 {									\
 	struct blk_mq_hw_ctx *hctx =3D m->private;			\
 	struct kyber_hctx_data *khd =3D hctx->sched_data;			\
@@ -913,7 +913,7 @@ static void *kyber_##name##_rqs_next(struct seq_file =
*m, void *v,	\
 }									\
 									\
 static void kyber_##name##_rqs_stop(struct seq_file *m, void *v)	\
-	__releases(&khd->lock)						\
+	__releases(((struct kyber_hctx_data *)((struct blk_mq_hw_ctx *)m->priva=
te)->sched_data)->lock)						\
 {									\
 	struct blk_mq_hw_ctx *hctx =3D m->private;			\
 	struct kyber_hctx_data *khd =3D hctx->sched_data;			\
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 95917a88976f..b812708a86ee 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -798,7 +798,7 @@ static const struct elv_fs_entry deadline_attrs[] =3D=
 {
 #define DEADLINE_DEBUGFS_DDIR_ATTRS(prio, data_dir, name)		\
 static void *deadline_##name##_fifo_start(struct seq_file *m,		\
 					  loff_t *pos)			\
-	__acquires(&dd->lock)						\
+	__acquires(&((struct deadline_data *)((struct request_queue *)m->privat=
e)->elevator->elevator_data)->lock)						\
 {									\
 	struct request_queue *q =3D m->private;				\
 	struct deadline_data *dd =3D q->elevator->elevator_data;		\
@@ -819,7 +819,7 @@ static void *deadline_##name##_fifo_next(struct seq_f=
ile *m, void *v,	\
 }									\
 									\
 static void deadline_##name##_fifo_stop(struct seq_file *m, void *v)	\
-	__releases(&dd->lock)						\
+	__releases(&((struct deadline_data *)((struct request_queue *)m->privat=
e)->elevator->elevator_data)->lock)						\
 {									\
 	struct request_queue *q =3D m->private;				\
 	struct deadline_data *dd =3D q->elevator->elevator_data;		\
@@ -921,7 +921,7 @@ static int dd_owned_by_driver_show(void *data, struct=
 seq_file *m)
 }
=20
 static void *deadline_dispatch_start(struct seq_file *m, loff_t *pos)
-	__acquires(&dd->lock)
+	__acquires(&((struct deadline_data *)((struct request_queue *)m->privat=
e)->elevator->elevator_data)->lock)
 {
 	struct request_queue *q =3D m->private;
 	struct deadline_data *dd =3D q->elevator->elevator_data;
@@ -939,7 +939,7 @@ static void *deadline_dispatch_next(struct seq_file *=
m, void *v, loff_t *pos)
 }
=20
 static void deadline_dispatch_stop(struct seq_file *m, void *v)
-	__releases(&dd->lock)
+	__releases(&((struct deadline_data *)((struct request_queue *)m->privat=
e)->elevator->elevator_data)->lock)
 {
 	struct request_queue *q =3D m->private;
 	struct deadline_data *dd =3D q->elevator->elevator_data;
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 0c8342747cab..34571d8b9dce 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -273,6 +273,7 @@ static inline struct bdi_writeback *inode_to_wb_wbc(
  */
 static inline struct bdi_writeback *
 unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *c=
ookie)
+	__no_context_analysis /* conditional locking */
 {
 	rcu_read_lock();
=20
@@ -300,6 +301,7 @@ unlocked_inode_to_wb_begin(struct inode *inode, struc=
t wb_lock_cookie *cookie)
  */
 static inline void unlocked_inode_to_wb_end(struct inode *inode,
 					    struct wb_lock_cookie *cookie)
+	__no_context_analysis /* conditional locking */
 {
 	if (unlikely(cookie->locked))
 		xa_unlock_irqrestore(&inode->i_mapping->i_pages, cookie->flags);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8d93d8e356d8..7b05ea282435 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1092,15 +1092,19 @@ static inline unsigned int blk_boundary_sectors_l=
eft(sector_t offset,
  */
 static inline struct queue_limits
 queue_limits_start_update(struct request_queue *q)
+	__acquires(&q->limits_lock)
 {
 	mutex_lock(&q->limits_lock);
 	return q->limits;
 }
 int queue_limits_commit_update_frozen(struct request_queue *q,
-		struct queue_limits *lim);
+		struct queue_limits *lim)
+	__releases(&q->limits_lock);
 int queue_limits_commit_update(struct request_queue *q,
-		struct queue_limits *lim);
-int queue_limits_set(struct request_queue *q, struct queue_limits *lim);
+		struct queue_limits *lim)
+	__releases(&q->limits_lock);
+int queue_limits_set(struct request_queue *q, struct queue_limits *lim)
+	__must_not_hold(&q->limits_lock);
 int blk_validate_limits(struct queue_limits *lim);
=20
 /**
@@ -1112,6 +1116,7 @@ int blk_validate_limits(struct queue_limits *lim);
  * starting update.
  */
 static inline void queue_limits_cancel_update(struct request_queue *q)
+	__releases(&q->limits_lock)
 {
 	mutex_unlock(&q->limits_lock);
 }
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05b34a6355b0..a3277bcf8d1d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2489,6 +2489,7 @@ bpf_prog_run_array(const struct bpf_prog_array *arr=
ay,
 static __always_inline u32
 bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
 			  const void *ctx, bpf_prog_run_fn run_prog)
+	__no_context_analysis /* conditional locking */
 {
 	const struct bpf_prog_array_item *item;
 	const struct bpf_prog *prog;
