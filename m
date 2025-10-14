Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6130DEAC
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431088; cv=none; b=M/X3+q9lZROP6E2rFRgVAVTKRUTrR0+dHbuv0QFdln9W8InVhXNeH21xghclRWDWuJZqAneultD9ru4ZLDwjAgwq0za/x1sidMt+Tg9Kks3ENb6TcEOC2F+enQoIRlj78WQIZ4nzR3ablF5uwftMYlb9ekJ7t4biRUXn1CyqPIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431088; c=relaxed/simple;
	bh=1G7OOfkP5kUBWLy/7TfGa93v2eu4W2JMg3qsQ/ROOz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYdgLLGfc2Aqza36FJnZDDJcWNb9fEszqrpKTQhpQTjWvM7KKRr+jvDBBWcoZ3Z3w0j7442RtdSuJt2C+PdaL12LgXcuyTRKNrCrnXHP6cUKnTah3fLs33Td92nJOS/p6Ho0R6lBlLwZcMJb6QGPUa+2hP6tMcB9E9cawghaGDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIIAWSy6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIIAWSy6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760431085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qYSSk+gzoQaZka0378DcrQyNgfnCqmIWdSOnXNg/zIY=;
	b=eIIAWSy63gS0Xcae6cBBrX0V1cwHZuE4chDzen/5L7qkGTG3G0jLb7JR2+uE0JhdiWBq1L
	hnC6wckJq7rFL8A0DPj5Xp1vPlrLa42cPOYgX1Tgiefezih7ugK5VzoJW2nxoCLK+hyUZn
	nZIA+pJmp1ivq20F7CNWDQHxAd18HMU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-H-WxLVG6OMiv34yDrG8UVQ-1; Tue,
 14 Oct 2025 04:38:00 -0400
X-MC-Unique: H-WxLVG6OMiv34yDrG8UVQ-1
X-Mimecast-MFC-AGG-ID: H-WxLVG6OMiv34yDrG8UVQ_1760431079
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFA9D1956095;
	Tue, 14 Oct 2025 08:37:58 +0000 (UTC)
Received: from fedora (unknown [10.72.120.30])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C0D6180035E;
	Tue, 14 Oct 2025 08:37:51 +0000 (UTC)
Date: Tue, 14 Oct 2025 16:37:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com,
	axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 3/4] blk-rq-qos: fix possible deadlock
Message-ID: <aO4L2THnLFM-_Fb8@fedora>
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <20251014022149.947800-4-yukuai3@huawei.com>
 <aO4GPKKpLbj7kMoz@fedora>
 <f0ab9c95-990b-a41d-477e-c1b20b392985@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0ab9c95-990b-a41d-477e-c1b20b392985@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Oct 14, 2025 at 04:24:23PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/10/14 16:13, Ming Lei 写道:
> > On Tue, Oct 14, 2025 at 10:21:48AM +0800, Yu Kuai wrote:
> > > Currently rq-qos debugfs entries is created from rq_qos_add(), while
> > > rq_qos_add() requires queue to be freezed. This can deadlock because
> > > creating new entries can trigger fs reclaim.
> > > 
> > > Fix this problem by delaying creating rq-qos debugfs entries until
> > > it's initialization is complete.
> > > 
> > > - For wbt, it can be initialized by default of by blk-sysfs, fix it by
> > >    calling blk_mq_debugfs_register_rq_qos() after wbt_init;
> > > - For other policies, they can only be initialized by blkg configuration,
> > >    fix it by calling blk_mq_debugfs_register_rq_qos() from
> > >    blkg_conf_end();
> > > 
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > ---
> > >   block/blk-cgroup.c | 6 ++++++
> > >   block/blk-rq-qos.c | 7 -------
> > >   block/blk-sysfs.c  | 4 ++++
> > >   block/blk-wbt.c    | 7 ++++++-
> > >   4 files changed, 16 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > > index d93654334854..e4ccabf132c0 100644
> > > --- a/block/blk-cgroup.c
> > > +++ b/block/blk-cgroup.c
> > > @@ -33,6 +33,7 @@
> > >   #include "blk-cgroup.h"
> > >   #include "blk-ioprio.h"
> > >   #include "blk-throttle.h"
> > > +#include "blk-mq-debugfs.h"
> > >   static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
> > > @@ -746,6 +747,11 @@ void blkg_conf_end(struct blkg_conf_ctx *ctx)
> > >   	mutex_unlock(&q->elevator_lock);
> > >   	blk_mq_unfreeze_queue(q, ctx->memflags);
> > >   	blkdev_put_no_open(ctx->bdev);
> > > +
> > > +	mutex_lock(&q->debugfs_mutex);
> > > +	blk_mq_debugfs_register_rq_qos(q);
> > > +	mutex_unlock(&q->debugfs_mutex);
> > > +
> > >   }
> > >   EXPORT_SYMBOL_GPL(blkg_conf_end);
> > > diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> > > index 654478dfbc20..d7ce99ce2e80 100644
> > > --- a/block/blk-rq-qos.c
> > > +++ b/block/blk-rq-qos.c
> > > @@ -347,13 +347,6 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
> > >   	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
> > >   	blk_mq_unfreeze_queue(q, memflags);
> > > -
> > > -	if (rqos->ops->debugfs_attrs) {
> > > -		mutex_lock(&q->debugfs_mutex);
> > > -		blk_mq_debugfs_register_rqos(rqos);
> > > -		mutex_unlock(&q->debugfs_mutex);
> > > -	}
> > > -
> > >   	return 0;
> > >   ebusy:
> > >   	blk_mq_unfreeze_queue(q, memflags);
> > > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > > index 76c47fe9b8d6..52bb4db25cf5 100644
> > > --- a/block/blk-sysfs.c
> > > +++ b/block/blk-sysfs.c
> > > @@ -688,6 +688,10 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
> > >   	mutex_unlock(&disk->rqos_state_mutex);
> > >   	blk_mq_unquiesce_queue(q);
> > > +
> > > +	mutex_lock(&q->debugfs_mutex);
> > > +	blk_mq_debugfs_register_rq_qos(q);
> > > +	mutex_unlock(&q->debugfs_mutex);
> > >   out:
> > >   	blk_mq_unfreeze_queue(q, memflags);
> > > diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> > > index eb8037bae0bd..a120b5ba54db 100644
> > > --- a/block/blk-wbt.c
> > > +++ b/block/blk-wbt.c
> > > @@ -724,8 +724,13 @@ void wbt_enable_default(struct gendisk *disk)
> > >   	if (!blk_queue_registered(q))
> > >   		return;
> > > -	if (queue_is_mq(q) && enable)
> > > +	if (queue_is_mq(q) && enable) {
> > >   		wbt_init(disk);
> > > +
> > > +		mutex_lock(&q->debugfs_mutex);
> > > +		blk_mq_debugfs_register_rq_qos(q);
> > > +		mutex_unlock(&q->debugfs_mutex);
> > > +	}
> > 
> > ->debugfs_mutex only may be not enough, because blk_mq_debugfs_register_rq_qos()
> > has to traverse rq_qos single list list, you may have to grab q->rq_qos_mutex
> > for protect the list.
> > 
> 
> I think we can't grab rq_qos_mutex to create debugfs entries, right?

It depends on the finalized order between rq_qos_mutex and freezing queue.

> With the respect of this, perhaps we can grab debugfs_mutex to protect
> insering rq_qos list instead?

No, debugfs_mutex shouldn't protect rq_qos list, and rq_qos_mutex is
supposed to do the job at least from naming viewpoint.


Thanks,
Ming

