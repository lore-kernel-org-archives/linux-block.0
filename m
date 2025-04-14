Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7F254670
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744594954; cv=none; b=AMURoizKFczk6AwcxzRkoNaSxhSFjVZ3mF8ET+W7StQTxyFwh+SNhE9EcSYj41ehtFWKvAiJWQMaJN08fGYg0MWSIqAjKgMkF6pGgw/ZhtGdcjhaBzSUSBCaHufWpdLxro/5krao6mzaHMYHh2Fk3LnKi0Pf5raxImhCWCk6Uv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744594954; c=relaxed/simple;
	bh=tTzLH01omU9vHNiWsUw8fdB7L8dSVasqeEkzTJme8V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJFD4kXrtl7UVRIOzRoS3ZFMjcKCAooG/g7Ar2qOr9l352+BT7TBkzYwKJrFgl2lIgzKS1rzhXKbNF2qxHzyiOVvGqC/fTOQWstzRr2ZfOgrFjiD5z6vqTR8kJGQq9bnR4zG5aYsT6naMorbywnwGOckyT499VCjd7ptntAayN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/e0ZaY9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/e0ZaY9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744594951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eVoD+uDQMYsapWUiieCR1tEJiuOZJ3frkSJB/4rSdzE=;
	b=W/e0ZaY9NNDy1AhOsdCG+OoNcDqtHB5/zDs7GQ6qxLScW7bvp+d8VCDRCnpRSk+Frwxopc
	6031mkbB67CcQT5Qbk3/PRiSkZ6n4LKis4l4O1MJ9/aej0HaBThE2CQUhFr9A4LgY3s2Un
	98W3MN0raG1sjW3zCyveKYRqo7VIm9s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-FOYlsNFCN0eA9Xw6fgsqVA-1; Sun,
 13 Apr 2025 21:42:28 -0400
X-MC-Unique: FOYlsNFCN0eA9Xw6fgsqVA-1
X-Mimecast-MFC-AGG-ID: FOYlsNFCN0eA9Xw6fgsqVA_1744594947
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE166180049D;
	Mon, 14 Apr 2025 01:42:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.68])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93A793001D13;
	Mon, 14 Apr 2025 01:42:22 +0000 (UTC)
Date: Mon, 14 Apr 2025 09:42:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/15] block: move debugfs/sysfs register out of freezing
 queue
Message-ID: <Z_xn-Zl5FDGdZ_Bk@fedora>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-13-ming.lei@redhat.com>
 <b28d98a6-b406-45b0-a5db-11bc600be75f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b28d98a6-b406-45b0-a5db-11bc600be75f@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Apr 11, 2025 at 12:27:17AM +0530, Nilay Shroff wrote:
> 
> 
> On 4/10/25 7:00 PM, Ming Lei wrote:
> > Move debugfs/sysfs register out of freezing queue in
> > __blk_mq_update_nr_hw_queues(), so that the following lockdep dependency
> > can be killed:
> > 
> > 	#2 (&q->q_usage_counter(io)#16){++++}-{0:0}:
> > 	#1 (fs_reclaim){+.+.}-{0:0}:
> > 	#0 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}: //debugfs
> > 
> > And registering/un-registering debugfs/sysfs does not require queue to be
> > frozen.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 7219b01764da..0fb72a698d77 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -4947,15 +4947,15 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> >  	if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
> >  		return;
> >  
> > -	memflags = memalloc_noio_save();
> > -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> > -		blk_mq_freeze_queue_nomemsave(q);
> > -
> >  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> >  		blk_mq_debugfs_unregister_hctxs(q);
> >  		blk_mq_sysfs_unregister_hctxs(q);
> >  	}
> As we removed hctx sysfs protection while un-registering it, this might
> cause crash or other side-effect if simultaneously these sysfs attributes
> are accessed. The read access of these attributes are still protected 
> using ->elevator_lock. 

The ->elevator_lock in ->show() is useless except for reading the elevator
internal data(sched tags, requests, ...), even for reading elevator data,
it should have been relying on elevator reference, instead of lock, but
that is another topic & improvement in future.

Also this patch does _not_ change ->elevator_lock for above debugfs/sysfs
unregistering, does it? It is always done without holding ->elevator_lock.
Also ->show() does not require ->q_usage_counter too.

As I mentioned, kobject/sysfs provides protection between ->show()/->store()
and kobject_del(), isn't it the reason why you want to remove ->sys_lock?

https://lore.kernel.org/linux-block/20250226124006.1593985-1-nilay@linux.ibm.com/


Thanks,
Ming

