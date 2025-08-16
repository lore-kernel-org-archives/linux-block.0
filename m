Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831DA1A8401
	for <linux-block@vger.kernel.org>; Sat, 16 Aug 2025 04:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755317141; cv=none; b=exxOiCqaVXrbHJAmCQDVRfYEEpbsMOqhOjic6GZLdLq077ywgxqtYO4BCMCFvh12BUhYg/FEZgDg4kusAxvtQ/6BV9OXb3QYW9Si0PSQ+MXU+6i2gwQG2N9JTVLnZiBoGXpdPhYP7UQU3voKKI97Um+dbvpv3S5MaijBQbi8sDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755317141; c=relaxed/simple;
	bh=9MraKFbbVF3ZG1giR43/4Qfnj03Tvr0GDhYuIA6QRrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqpiNH+LJZ4mjDavE1tLioJD8xOAYU0EaKLVLNdl8VOwuA+8zO2MfO8nTapBk0RXFC15sy0k0yBbLe+DgZL7P7k9hGVyE60y3jPhm5qhNLoMKjM7+uyrBws++VjYsVP7cMRdMR4hunAQN1cg4S0Ex+GhfnyeMp8eC72pKHIwm0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWJHd4ur; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWJHd4ur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755317137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Be/x7kdTxHZOOjJPiYl+QftUIbBdfgZWPH7ZWtutGaM=;
	b=JWJHd4urcho0YgYpv7WdHt1rHF9MbPFvx8B3bVgx+H904+hQ1CXy3pSf2Tn4jCBHhqA6cp
	v8P483geTYvwizHTI2j07mhq18eq/dn7jqjJ20xoQm/vX19BDKwBujKN6fGENbVKF1Ce+y
	3jFJSzT/1efJbO552qdcBAOrwP9kPR8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-Rt3GOwvDMkCOA0BzFAluyw-1; Sat,
 16 Aug 2025 00:05:30 -0400
X-MC-Unique: Rt3GOwvDMkCOA0BzFAluyw-1
X-Mimecast-MFC-AGG-ID: Rt3GOwvDMkCOA0BzFAluyw_1755317129
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55B4A180047F;
	Sat, 16 Aug 2025 04:05:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A481180029C;
	Sat, 16 Aug 2025 04:05:20 +0000 (UTC)
Date: Sat, 16 Aug 2025 12:05:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
	axboe@kernel.dk, hare@suse.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 08/10] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
Message-ID: <aKADe9hNz99dQTfy@fedora>
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
 <20250815080216.410665-9-yukuai1@huaweicloud.com>
 <c5e63966-e7f6-4d82-9d66-3a0abccc9d17@linux.ibm.com>
 <af40ef99-9b61-4725-ba77-c5d3741add99@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af40ef99-9b61-4725-ba77-c5d3741add99@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sat, Aug 16, 2025 at 10:57:23AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/8/16 3:30, Nilay Shroff 写道:
> > 
> > On 8/15/25 1:32 PM, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > In the case user trigger tags grow by queue sysfs attribute nr_requests,
> > > hctx->sched_tags will be freed directly and replaced with a new
> > > allocated tags, see blk_mq_tag_update_depth().
> > > 
> > > The problem is that hctx->sched_tags is from elevator->et->tags, while
> > > et->tags is still the freed tags, hence later elevator exist will try to
> > > free the tags again, causing kernel panic.
> > > 
> > > Fix this problem by using new allocated elevator_tags, also convert
> > > blk_mq_update_nr_requests to void since this helper will never fail now.
> > > 
> > > Meanwhile, there is a longterm problem can be fixed as well:
> > > 
> > > If blk_mq_tag_update_depth() succeed for previous hctx, then bitmap depth
> > > is updated, however, if following hctx failed, q->nr_requests is not
> > > updated and the previous hctx->sched_tags endup bigger than q->nr_requests.
> > > 
> > > Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")
> > > Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through sysfs")
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > ---
> > >   block/blk-mq.c    | 19 ++++++-------------
> > >   block/blk-mq.h    |  4 +++-
> > >   block/blk-sysfs.c | 21 ++++++++++++++-------
> > >   3 files changed, 23 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index 11c8baebb9a0..e9f037a25fe3 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -4917,12 +4917,12 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
> > >   }
> > >   EXPORT_SYMBOL(blk_mq_free_tag_set);
> > > -int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
> > > +void blk_mq_update_nr_requests(struct request_queue *q,
> > > +			       struct elevator_tags *et, unsigned int nr)
> > >   {
> > >   	struct blk_mq_tag_set *set = q->tag_set;
> > >   	struct blk_mq_hw_ctx *hctx;
> > >   	unsigned long i;
> > > -	int ret = 0;
> > >   	blk_mq_quiesce_queue(q);
> > > @@ -4946,24 +4946,17 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
> > >   				nr - hctx->sched_tags->nr_reserved_tags);
> > >   		}
> > >   	} else {
> > > -		queue_for_each_hw_ctx(q, hctx, i) {
> > > -			if (!hctx->tags)
> > > -				continue;
> > > -			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
> > > -						      nr);
> > > -			if (ret)
> > > -				goto out;
> > > -		}
> > > +		blk_mq_free_sched_tags(q->elevator->et, set);
> > I think you also need to ensure that elevator tags are freed after we unfreeze
> > queue and release ->elevator_lock otherwise we may get into the lockdep splat
> > for pcpu_lock dependency on ->freeze_lock and/or ->elevator_lock. Please note
> > that blk_mq_free_sched_tags internally invokes sbitmap_free which invokes
> > free_percpu which acquires pcpu_lock.
> 
> Ok, thanks for the notice. However, as Ming suggested, we might fix this
> problem
> 
> in the next merge window.

There are two issues involved:

- blk_mq_tags double free, introduced recently

- long-term lock issue in queue_requests_store()

IMO, the former is a bit serious, because kernel panic can be triggered,
so suggest to make it to v6.17. The latter looks less serious and has
existed for long time, but may need code refactor to get clean fix.

> I'll send one patch to fix this regression by
> replace
> 
> st->tags with reallocated new sched_tags as well.

Patch 7 in this patchset and patch 8 in your 1st post looks enough to
fix this double free issue.


Thanks,
Ming

