Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FC123B63C
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244770; cv=none; b=g8n3zPsaWFlGDZkkxuwQ/HHTQVdzh+INPoSvFFSZCi2gbvUHAj/DfEpYywxZMaqtVM9kPbsiXfA4PUuLWkocsrCodTpEQiUM9BwCEl/jPJrzEwa7wme9n1TUSReOFLY2NV215uUuVie7WdZ7PlnQ3UdahfNkRRDNFSJ9Z3BqGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244770; c=relaxed/simple;
	bh=WVqpOnCkh92d2oPxNjb7DzeGCMTApli6Y/7tBz7vHPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfX99/Zh4PN0eOt1MIm5rilzR21HkU502ULDTV59bK+nSqKjwL5sePyRRhiNUmXpDDocWsxBOKIckHr4Zy35g4dRpsc12+cYD9opQdDJUL9j3IzmYSbGnSm2XaJ9LDGj3hSlrf42ZtscNIDl3Neaj0PJIMIG7ElELD00X/INn20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZypEd9YU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZypEd9YU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755244766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FqpsUaIYgJArwEf41h24DLfcv5QgufeMEYrt2GoikAU=;
	b=ZypEd9YUoSk7WvIFKRMaZb6ANXdfhFrBompxqERziXzbE8pO+i1ZgelDLlXzed1oShOvVs
	3fn1Rn1ReM7yXum6gB3d3GmvOhvQP7HPvAjJpEN9x5SRGZGDjvcNK3MjUzGfPV4FykOySA
	05+N/bGaQ+UZDb/Hael3/5ZhnR5xt3w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-VltTbOMoOtuXsyeSEuL7wQ-1; Fri,
 15 Aug 2025 03:59:23 -0400
X-MC-Unique: VltTbOMoOtuXsyeSEuL7wQ-1
X-Mimecast-MFC-AGG-ID: VltTbOMoOtuXsyeSEuL7wQ_1755244762
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D5A619560A6;
	Fri, 15 Aug 2025 07:59:21 +0000 (UTC)
Received: from fedora (unknown [10.72.116.153])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6336E1800296;
	Fri, 15 Aug 2025 07:59:14 +0000 (UTC)
Date: Fri, 15 Aug 2025 15:59:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, shinichiro.kawasaki@wdc.com,
	kch@nvidia.com, gjoyce@ibm.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCHv3 3/3] block: avoid cpu_hotplug_lock depedency on
 freeze_lock
Message-ID: <aJ7ozolL_rKWkdS5@fedora>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
 <20250814082612.500845-4-nilay@linux.ibm.com>
 <aJ3aR2JodRrAqVcO@fedora>
 <e125025b-d576-4919-b00e-5d9b640bed77@linux.ibm.com>
 <aJ3myQW2A8HtteBC@fedora>
 <e33e97f7-0c12-4f70-81d0-4fea05557579@linux.ibm.com>
 <aJ57lZLhktXxaBoh@fedora>
 <6d5949db-0df9-93d3-4397-966be5c2fac9@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d5949db-0df9-93d3-4397-966be5c2fac9@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Aug 15, 2025 at 09:04:53AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/15 8:13, Ming Lei 写道:
> > On Thu, Aug 14, 2025 at 08:01:11PM +0530, Nilay Shroff wrote:
> > > 
> > > 
> > > On 8/14/25 7:08 PM, Ming Lei wrote:
> > > > On Thu, Aug 14, 2025 at 06:27:08PM +0530, Nilay Shroff wrote:
> > > > > 
> > > > > 
> > > > > On 8/14/25 6:14 PM, Ming Lei wrote:
> > > > > > On Thu, Aug 14, 2025 at 01:54:59PM +0530, Nilay Shroff wrote:
> > > > > > > A recent lockdep[1] splat observed while running blktest block/005
> > > > > > > reveals a potential deadlock caused by the cpu_hotplug_lock dependency
> > > > > > > on ->freeze_lock. This dependency was introduced by commit 033b667a823e
> > > > > > > ("block: blk-rq-qos: guard rq-qos helpers by static key").
> > > > > > > 
> > > > > > > That change added a static key to avoid fetching q->rq_qos when
> > > > > > > neither blk-wbt nor blk-iolatency is configured. The static key
> > > > > > > dynamically patches kernel text to a NOP when disabled, eliminating
> > > > > > > overhead of fetching q->rq_qos in the I/O hot path. However, enabling
> > > > > > > a static key at runtime requires acquiring both cpu_hotplug_lock and
> > > > > > > jump_label_mutex. When this happens after the queue has already been
> > > > > > > frozen (i.e., while holding ->freeze_lock), it creates a locking
> > > > > > > dependency from cpu_hotplug_lock to ->freeze_lock, which leads to a
> > > > > > > potential deadlock reported by lockdep [1].
> > > > > > > 
> > > > > > > To resolve this, replace the static key mechanism with q->queue_flags:
> > > > > > > QUEUE_FLAG_QOS_ENABLED. This flag is evaluated in the fast path before
> > > > > > > accessing q->rq_qos. If the flag is set, we proceed to fetch q->rq_qos;
> > > > > > > otherwise, the access is skipped.
> > > > > > > 
> > > > > > > Since q->queue_flags is commonly accessed in IO hotpath and resides in
> > > > > > > the first cacheline of struct request_queue, checking it imposes minimal
> > > > > > > overhead while eliminating the deadlock risk.
> > > > > > > 
> > > > > > > This change avoids the lockdep splat without introducing performance
> > > > > > > regressions.
> > > > > > > 
> > > > > > > [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> > > > > > > 
> > > > > > > Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > > > > Closes: https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> > > > > > > Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
> > > > > > > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > > > > Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> > > > > > > ---
> > > > > > >   block/blk-mq-debugfs.c |  1 +
> > > > > > >   block/blk-rq-qos.c     |  9 ++++---
> > > > > > >   block/blk-rq-qos.h     | 54 ++++++++++++++++++++++++------------------
> > > > > > >   include/linux/blkdev.h |  1 +
> > > > > > >   4 files changed, 37 insertions(+), 28 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > > > > > > index 7ed3e71f2fc0..32c65efdda46 100644
> > > > > > > --- a/block/blk-mq-debugfs.c
> > > > > > > +++ b/block/blk-mq-debugfs.c
> > > > > > > @@ -95,6 +95,7 @@ static const char *const blk_queue_flag_name[] = {
> > > > > > >   	QUEUE_FLAG_NAME(SQ_SCHED),
> > > > > > >   	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
> > > > > > >   	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
> > > > > > > +	QUEUE_FLAG_NAME(QOS_ENABLED),
> > > > > > >   };
> > > > > > >   #undef QUEUE_FLAG_NAME
> > > > > > > diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> > > > > > > index b1e24bb85ad2..654478dfbc20 100644
> > > > > > > --- a/block/blk-rq-qos.c
> > > > > > > +++ b/block/blk-rq-qos.c
> > > > > > > @@ -2,8 +2,6 @@
> > > > > > >   #include "blk-rq-qos.h"
> > > > > > > -__read_mostly DEFINE_STATIC_KEY_FALSE(block_rq_qos);
> > > > > > > -
> > > > > > >   /*
> > > > > > >    * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
> > > > > > >    * false if 'v' + 1 would be bigger than 'below'.
> > > > > > > @@ -319,8 +317,8 @@ void rq_qos_exit(struct request_queue *q)
> > > > > > >   		struct rq_qos *rqos = q->rq_qos;
> > > > > > >   		q->rq_qos = rqos->next;
> > > > > > >   		rqos->ops->exit(rqos);
> > > > > > > -		static_branch_dec(&block_rq_qos);
> > > > > > >   	}
> > > > > > > +	blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
> > > > > > >   	mutex_unlock(&q->rq_qos_mutex);
> > > > > > >   }
> > > > > > > @@ -346,7 +344,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
> > > > > > >   		goto ebusy;
> > > > > > >   	rqos->next = q->rq_qos;
> > > > > > >   	q->rq_qos = rqos;
> > > > > > > -	static_branch_inc(&block_rq_qos);
> > > > > > > +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
> > > > > > 
> > > > > > One stupid question: can we simply move static_branch_inc(&block_rq_qos)
> > > > > > out of queue freeze in rq_qos_add()?
> > > > > > 
> > > > > > What matters is just the 1st static_branch_inc() which switches the counter
> > > > > > from 0 to 1, when blk_mq_freeze_queue() guarantees that all in-progress code
> > > > > > paths observe q->rq_qos as NULL. That means static_branch_inc(&block_rq_qos)
> > > > > > needn't queue freeze protection.
> > > > > > 
> > > > > I thought about it earlier but that won't work because we have
> > > > > code paths freezing queue before it reaches upto rq_qos_add(),
> > > > > For instance:
> > > > > 
> > > > > We have following code paths from where we invoke
> > > > > rq_qos_add() APIs with queue already frozen:
> > > > > 
> > > > > ioc_qos_write()
> > > > >   -> blkg_conf_open_bdev_frozen() => freezes queue
> > > > >   -> blk_iocost_init()
> > > > >     -> rq_qos_add()
> > > > > 
> > > > > queue_wb_lat_store()  => freezes queue
> > > > >   -> wbt_init()
> > > > >    -> rq_qos_add()
> > > > 
> > > > The above two shouldn't be hard to solve, such as, add helper
> > > > rq_qos_prep_add() for increasing the static branch counter.
> > > > 
> I thought about this, we'll need some return value to know if rq_qos
> is really added and I feel code will be much complex. We'll need at
> least two different APIs for cgroup based policy iocost/iolatency and
> pure rq_qos policy wbt.

Yes, but not too bad, such as:


diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 5bfd70311359..05b13235ebb3 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3227,6 +3227,8 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 
 	blkg_conf_init(&ctx, input);
 
+	rq_qos_prep_add();
+
 	memflags = blkg_conf_open_bdev_frozen(&ctx);
 	if (IS_ERR_VALUE(memflags)) {
 		ret = memflags;
@@ -3344,7 +3346,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	if (enable)
 		wbt_disable_default(disk);
 	else
-		wbt_enable_default(disk);
+		wbt_enable_default(disk, false);
 
 	blk_mq_unquiesce_queue(disk->queue);
 
@@ -3356,6 +3358,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	ret = -EINVAL;
 err:
 	blkg_conf_exit_frozen(&ctx, memflags);
+	rq_qos_prep_del();
 	return ret;
 }
 
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 848591fb3c57..27047f661e3f 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -319,7 +319,7 @@ void rq_qos_exit(struct request_queue *q)
 		struct rq_qos *rqos = q->rq_qos;
 		q->rq_qos = rqos->next;
 		rqos->ops->exit(rqos);
-		static_branch_dec(&block_rq_qos);
+		rq_qos_prep_del();
 	}
 	mutex_unlock(&q->rq_qos_mutex);
 }
@@ -346,7 +346,6 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
 		goto ebusy;
 	rqos->next = q->rq_qos;
 	q->rq_qos = rqos;
-	static_branch_inc(&block_rq_qos);
 
 	blk_mq_unfreeze_queue(q, memflags);
 
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 39749f4066fb..38572a7eb2b7 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -179,4 +179,14 @@ static inline void rq_qos_queue_depth_changed(struct request_queue *q)
 
 void rq_qos_exit(struct request_queue *);
 
+static inline void rq_qos_prep_add(void)
+{
+	static_branch_inc(&block_rq_qos);
+}
+
+static inline void rq_qos_prep_del(void)
+{
+	static_branch_dec(&block_rq_qos);
+}
+
 #endif
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 396cded255ea..3801f35f206f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -613,6 +613,7 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 	ssize_t ret;
 	s64 val;
 	unsigned int memflags;
+	bool rqos_added = false;
 
 	ret = queue_var_store64(&val, page);
 	if (ret < 0)
@@ -620,6 +621,7 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 	if (val < -1)
 		return -EINVAL;
 
+	rq_qos_prep_add();
 	memflags = blk_mq_freeze_queue(q);
 
 	rqos = wbt_rq_qos(q);
@@ -627,6 +629,7 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 		ret = wbt_init(disk);
 		if (ret)
 			goto out;
+		rqos_added = true;
 	}
 
 	ret = count;
@@ -653,6 +656,9 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
 out:
 	blk_mq_unfreeze_queue(q, memflags);
 
+	if (!rqos_added)
+		rq_qos_prep_del();
+
 	return ret;
 }
 
@@ -903,7 +909,7 @@ int blk_register_queue(struct gendisk *disk)
 
 	if (queue_is_mq(q))
 		elevator_set_default(q);
-	wbt_enable_default(disk);
+	wbt_enable_default(disk, true);
 
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index a50d4cd55f41..9dc5926adfcc 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -698,7 +698,7 @@ static void wbt_requeue(struct rq_qos *rqos, struct request *rq)
 /*
  * Enable wbt if defaults are configured that way
  */
-void wbt_enable_default(struct gendisk *disk)
+void wbt_enable_default(struct gendisk *disk, bool track_rqos_add)
 {
 	struct request_queue *q = disk->queue;
 	struct rq_qos *rqos;
@@ -723,8 +723,18 @@ void wbt_enable_default(struct gendisk *disk)
 	if (!blk_queue_registered(q))
 		return;
 
-	if (queue_is_mq(q) && enable)
-		wbt_init(disk);
+	if (queue_is_mq(q) && enable) {
+		if (track_rqos_add) {
+			int ret;
+
+			rq_qos_prep_add();
+			ret = wbt_init(disk);
+			if (ret)
+				rq_qos_prep_del();
+		} else {
+			wbt_init(disk);
+		}
+	}
 }
 EXPORT_SYMBOL_GPL(wbt_enable_default);
 
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index e5fc653b9b76..fea0e54d7c1f 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -6,7 +6,7 @@
 
 int wbt_init(struct gendisk *disk);
 void wbt_disable_default(struct gendisk *disk);
-void wbt_enable_default(struct gendisk *disk);
+void wbt_enable_default(struct gendisk *disk, bool track_rqos_add);
 
 u64 wbt_get_min_lat(struct request_queue *q);
 void wbt_set_min_lat(struct request_queue *q, u64 val);
diff --git a/block/elevator.c b/block/elevator.c
index fe96c6f4753c..cc2ca78ecb2b 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -647,7 +647,7 @@ static int elevator_change_done(struct request_queue *q,
 		blk_mq_free_sched_tags(ctx->old->et, q->tag_set);
 		kobject_put(&ctx->old->kobj);
 		if (enable_wbt)
-			wbt_enable_default(q->disk);
+			wbt_enable_default(q->disk, true);
 	}
 	if (ctx->new) {
 		ret = elv_register_queue(q, ctx->new, !ctx->no_uevent);
diff --git a/block/genhd.c b/block/genhd.c
index c26733f6324b..2dd9d4ec66e4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -762,8 +762,6 @@ static void __del_gendisk(struct gendisk *disk)
 	if (queue_is_mq(q))
 		blk_mq_cancel_work_sync(q);
 
-	rq_qos_exit(q);
-
 	/*
 	 * If the disk does not own the queue, allow using passthrough requests
 	 * again.  Else leave the queue frozen to fail all I/O.
@@ -775,6 +773,7 @@ static void __del_gendisk(struct gendisk *disk)
 
 	if (start_drain)
 		blk_unfreeze_release_lock(q);
+	rq_qos_exit(q);
 }
 
 static void disable_elv_switch(struct request_queue *q)


Thanks,
Ming

