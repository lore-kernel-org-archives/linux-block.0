Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43230332638
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619399; cv=none; b=MOWq2WazDrQMiJQ+8PPxiU1oQwZ1zH73zLMUtSps2Hcsw18qmgQU9dn6mb29mIitaMiWKjAdZ/1UzTGXwlxvozZStRgHq/XmmLhos/GPYJha1bjVAo5uicajLvAMnsi4qVlhNXMd9mOxCWbohF+hgNrSY2i27LZlT5iPS15J9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619399; c=relaxed/simple;
	bh=4jCF1LngWbZ6Wa1eVU/+mphf348lpwr0ipuWQb6Vv3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY5kJec8ngLItJtQmJn7bmAuRaV16DLz6TpiOQJcCljtDqbGG/3w3hMM3l5lbIVIrKMpiqix+OJOyGNXvORpRTzi+hNKbDrKt9SpVgyzWqVV2ywxQ6beuTJbRSXhv+I4/1aIcu6p7kaZQL1ALaJVazhUGNOvArebm/gPUIOn+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGxOou4r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGxOou4r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772619397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmgHGHfWo6IDzrSlGCBMMqrj82oeE0gNAQ7XURHyn04=;
	b=MGxOou4repeKWNdqDnqMSmxrOqqeKcEjcP50LJE6QYQgy731tl/pGNuXETaVWE+pOjT63j
	BxUAcVQgA7K24yLhojATwN9jL7oYM9aj+xdpfzPeo2CY41omP0Ir2rUCPceAq+1RDrPHqR
	fFRNc6abhK3oz6IeKMu/l2Qy5siPJSs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-7TIiIZg8NzKKuz6wx_xGGw-1; Wed,
 04 Mar 2026 05:16:36 -0500
X-MC-Unique: 7TIiIZg8NzKKuz6wx_xGGw-1
X-Mimecast-MFC-AGG-ID: 7TIiIZg8NzKKuz6wx_xGGw_1772619395
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7BDC19560B2;
	Wed,  4 Mar 2026 10:16:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 306421958DC2;
	Wed,  4 Mar 2026 10:16:30 +0000 (UTC)
Date: Wed, 4 Mar 2026 18:16:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [bug report] blktests block/022 failed with possible circular
 locking dependency detected at: __kernfs_remove+0x275/0x710 and
 del_gendisk+0xfd/0x190
Message-ID: <aagGeXqeHnCugRyr@fedora>
References: <CAHj4cs-em-4acsHabMdT=jJhXkCzjnprD-aQH1OgrZo4nTnmMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs-em-4acsHabMdT=jJhXkCzjnprD-aQH1OgrZo4nTnmMw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Mar 04, 2026 at 03:10:06PM +0800, Yi Zhang wrote:
> Hi
> 
> I found blktests block/022 failed on the latest
> linux-block/for-next[1], please help check it and let me know if you
> need any info/testing for it, thanks.
> 
> [1]
> commit b82c5e4f1bcb3fa78ba3c95a0d198f55553c0fc1
> Merge: 187d9a5a18b4 d47f7c173262
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Mar 2 14:04:16 2026 -0700
> 
>     Merge branch 'for-7.1/block' into for-next
> 
> dmesg:
> [ 1329.227229] run blktests block/022 at 2026-03-03 13:51:07
> [ 1329.838331] null_blk: module loaded
> --snip--

...

> [ 1349.822314]  Possible unsafe locking scenario:
> 
> [ 1349.828232]        CPU0                    CPU1
> [ 1349.832766]        ----                    ----
> [ 1349.837296]   rlock(&set->update_nr_hwq_lock);
> [ 1349.841752]                                lock(kn->active#104);
> [ 1349.847767]                                lock(&set->update_nr_hwq_lock);
> [ 1349.854647]   lock(kn->active#104);
> [ 1349.858148]
>                 *** DEADLOCK ***

Looks one real deadlock risk, can you try the following patch?


diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f3b1968c80ce..55a1bbfef7d4 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -78,8 +78,14 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	/*
 	 * Serialize updating nr_requests with concurrent queue_requests_store()
 	 * and switching elevator.
+	 *
+	 * Use trylock to avoid circular lock dependency with kernfs active
+	 * reference during concurrent disk deletion:
+	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
+	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
 	 */
-	down_write(&set->update_nr_hwq_lock);
+	if (!down_write_trylock(&set->update_nr_hwq_lock))
+		return -EBUSY;
 
 	if (nr == q->nr_requests)
 		goto unlock;
diff --git a/block/elevator.c b/block/elevator.c
index ebe2a1fcf011..3bcd37c2aa34 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -807,7 +807,16 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	elv_iosched_load_module(ctx.name);
 	ctx.type = elevator_find_get(ctx.name);
 
-	down_read(&set->update_nr_hwq_lock);
+	/*
+	 * Use trylock to avoid circular lock dependency with kernfs active
+	 * reference during concurrent disk deletion:
+	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
+	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
+	 */
+	if (!down_read_trylock(&set->update_nr_hwq_lock)) {
+		ret = -EBUSY;
+		goto out;
+	}
 	if (!blk_queue_no_elv_switch(q)) {
 		ret = elevator_change(q, &ctx);
 		if (!ret)
@@ -817,6 +826,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	}
 	up_read(&set->update_nr_hwq_lock);
 
+out:
 	if (ctx.type)
 		elevator_put(ctx.type);
 	return ret;


Thanks,
Ming

