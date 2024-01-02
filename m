Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290D1DF5D
	for <linux-block@vger.kernel.org>; Tue,  2 Jan 2024 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VH+54gRH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704194858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vuEl5bzYPdLQYuJiYuL6XpRByqC5g17VVYTw6M5DGc=;
	b=VH+54gRH8XiWa/7uGUMDm9tl0nndOa9rgdlDoXSB+lqDck64uNfUrKXENDTvtcJwHv5fDN
	VUpa38Dxo2gM5/M9TCekR4UURZVy8B+FP8DKz9ipH9kORTBmTt4OUQGT+EYwoITG4MC4Rn
	mIEmynP0u5CG4//g3HhU8kXgcuTzkIQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-0bm9yJXqNR-C9CPMWquM2g-1; Tue, 02 Jan 2024 06:27:33 -0500
X-MC-Unique: 0bm9yJXqNR-C9CPMWquM2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 189F08057FC;
	Tue,  2 Jan 2024 11:27:33 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ACF9D2166B31;
	Tue,  2 Jan 2024 11:27:29 +0000 (UTC)
Date: Tue, 2 Jan 2024 19:27:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Changhui Zhong <czhong@redhat.com>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-cgroup: fix rcu lockdep warning in blkg_lookup()
Message-ID: <ZZPzHZsSa0g0PzDg@fedora>
References: <20231219012833.2129540-1-ming.lei@redhat.com>
 <d067baba-e718-76c1-807f-feb169bd0e71@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d067baba-e718-76c1-807f-feb169bd0e71@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Tue, Jan 02, 2024 at 06:32:13PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/12/19 9:28, Ming Lei 写道:
> > blkg_lookup() is called with either queue_lock or rcu read lock, so
> > use rcu_dereference_check(lockdep_is_held(&q->queue_lock)) for
> > retrieving 'blkg', which way models the check exactly for covering
> > queue lock or rcu read lock.
> > 
> > Fix lockdep warning of "block/blk-cgroup.h:254 suspicious rcu_dereference_check() usage!"
> > from blkg_lookup().
> > 
> > Tested-by: Changhui Zhong <czhong@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-cgroup.h | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
> > index fd482439afbc..b927a4a0ad03 100644
> > --- a/block/blk-cgroup.h
> > +++ b/block/blk-cgroup.h
> > @@ -252,7 +252,8 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
> >   	if (blkcg == &blkcg_root)
> >   		return q->root_blkg;
> > -	blkg = rcu_dereference(blkcg->blkg_hint);
> > +	blkg = rcu_dereference_check(blkcg->blkg_hint,
> > +			lockdep_is_held(&q->queue_lock));
> 
> This patch itself is correct, and in fact this is a false positive
> warning.

Yeah, it is, but we always teach lockdep to not trigger warning,

> 
> I noticed that commit 83462a6c971c ("blkcg: Drop unnecessary RCU read
> [un]locks from blkg_conf_prep/finish()") drop rcu_read_lock/unlock()
> because 'queue_lock' is held. This is correct, however you add this back
> for tg_conf_updated() later in commit 27b13e209ddc ("blk-throttle: fix
> lockdep warning of "cgroup_mutex or RCU read lock required!"") because
> rcu_read_lock_held() from blkg_lookup() is triggered. And this patch is
> again another use case cased by commit 83462a6c971c.

We should add:

Fixes: 83462a6c971c ("blkcg: Drop unnecessary RCU read [un]locks from blkg_conf_prep/finish()")

> 
> I just wonder, with the respect of rcu implementation, is it possible to
> add preemptible() check directly in rcu_read_lock_held() to bypass all
> this kind of false positive warning?

It isn't related with rcu_read_lock_held(), and the check is done in
RCU_LOCKDEP_WARN(). rcu_dereference_check() does cover this situation,
and no need to invent wheel for avoiding the warning.

Thanks,
Ming

