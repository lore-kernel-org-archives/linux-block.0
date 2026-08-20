Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835403C1984
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255890; cv=none; b=ueCcIF1u10OueH7jaZU5zK9tTHq6O2LTdXjhcowOUih6UZBvhNTCqedW1CPiWrupFGAlt85miwjqzkKGc+5cRLZbX/X9l0bJHiNHdowzI0x2wCc4AZxmoWy6t2ShVcEChC6LrRheBzeutEIO1LQwIMe0dRjoMpZJK/QuBi5qk8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255890; c=relaxed/simple;
	bh=yDeihUVE2mKEkrwNKbxWUGLwGJcud/J8Xefr5Eiev2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKndDyOpwIuEfUvcwWjSWkaTyUcb/cdaHVeoKpzeOSAcwXRuID6y+9W7bmv0Q3D5WuIt+CN0mDt13ji2zpftJ//3qr8dc3iVbYEEtbCU/aJXPXMESlPzyF/4ORzMgzRn6ZH+AO7oZEff/j5rBpmMUkgRd6cxbOD9I4DzSCIdlfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RAbGiu1o; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RAbGiu1o"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hQvPY15rGzlfsVF;
	Thu, 20 Aug 2026 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1787255885; x=1789847886; bh=tUrY9
	/zW1hmjp0y28aomK3XNOE8Dtge/T+b3BupEmnE=; b=RAbGiu1oFI3ntoRC7JyME
	2TX8N/uSQUQZEeA0j6sVMT7X2f7SMtGyxpWwaSke8wAdbMEbFvtbjKHhofQY4FVZ
	djOknXqQN5HlPsjilvM8ziIcMXVzuQlTO5HR1ziNrtPKziGgPCbnJXbCW0/7JnqS
	/lWQrjPsCH7moXFnFky5Xagv9p6NUMxFfQReA6Of/fJnHWDIHlhDLGv5tWDTQZ7g
	TGUWIILqeJPLkrRGalE9qV/dR0hI7AgdYfrDnvLLGMeGIb5bQFQJoerzvnzki63y
	oNRwNf99AxlUMdOelM0YP2tS+FLBwqVzaVCOqwLSGgQEYMAoo/bgxYUAhrJ+dHzX
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2nufVFmeISOm; Thu, 20 Aug 2026 19:58:05 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hQvPS28ttzlfvpW;
	Thu, 20 Aug 2026 19:58:03 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 13/13] loop: Add __guarded_by() annotations
Date: Thu, 20 Aug 2026 12:57:21 -0700
Message-ID: <f81e920eed63d33d232948ecbc1b29c099e72016.1787255652.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
In-Reply-To: <cover.1787255652.git.bvanassche@acm.org>
References: <cover.1787255652.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Document which synchronization object protects which variable. Suppress
complaints about accesses without locking in initialization and cleanup
functions with context_unsafe() and __assume_ctx_lock().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 637212af70d2..8a6082d887eb 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -60,13 +60,13 @@ struct loop_device {
=20
 	gfp_t		old_gfp_mask;
=20
-	int			lo_state;
+	int			lo_state __guarded_by(&lo_mutex);
 	spinlock_t              lo_work_lock;
 	struct workqueue_struct *workqueue;
 	struct work_struct      rootcg_work;
-	struct list_head        rootcg_cmd_list;
-	struct list_head        idle_worker_list;
-	struct rb_root          worker_tree;
+	struct list_head        rootcg_cmd_list __guarded_by(&lo_work_lock);
+	struct list_head        idle_worker_list __guarded_by(&lo_work_lock);
+	struct rb_root          worker_tree __guarded_by(&lo_work_lock);
 	struct timer_list       timer;
 	bool			sysfs_inited;
=20
@@ -92,8 +92,8 @@ struct loop_cmd {
 #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
 #define LOOP_DEFAULT_HW_Q_DEPTH 128
=20
-static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
+static __guarded_by(&loop_ctl_mutex) DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_validate_mutex);
=20
 /**
@@ -2107,10 +2107,10 @@ static int loop_add(int i)
 	lo =3D kzalloc_obj(*lo);
 	if (!lo)
 		goto out;
-	lo->worker_tree =3D RB_ROOT;
-	INIT_LIST_HEAD(&lo->idle_worker_list);
+	context_unsafe(lo->worker_tree =3D RB_ROOT);
+	context_unsafe(INIT_LIST_HEAD(&lo->idle_worker_list));
 	timer_setup(&lo->timer, loop_free_idle_workers_timer, TIMER_DEFERRABLE)=
;
-	WRITE_ONCE(lo->lo_state, Lo_unbound);
+	context_unsafe(WRITE_ONCE(lo->lo_state, Lo_unbound));
=20
 	err =3D mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
@@ -2173,7 +2173,7 @@ static int loop_add(int i)
 	lo->lo_number		=3D i;
 	spin_lock_init(&lo->lo_work_lock);
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
-	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
+	context_unsafe(INIT_LIST_HEAD(&lo->rootcg_cmd_list));
 	disk->major		=3D LOOP_MAJOR;
 	disk->first_minor	=3D i << part_shift;
 	disk->minors		=3D 1 << part_shift;
@@ -2405,6 +2405,7 @@ static void __exit loop_exit(void)
 	 * module unloading is requested). If this is not a clean unloading,
 	 * we have no means to avoid kernel crash.
 	 */
+	__assume_ctx_lock(&loop_ctl_mutex);
 	idr_for_each_entry(&loop_index_idr, lo, id)
 		loop_remove(lo);
=20
