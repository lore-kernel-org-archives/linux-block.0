Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA002FA0C0
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250710; cv=none; b=cCxkR+Qbb7br7yqCB21d/hgfvbknbdhxHcXpf0GDbdbEWhGn2H9/Nh4x4wh5322i4JDaeraYk2fYwDjHHImWE1OM0pwfiNfyMKUZk2ZpHBp84pjRGyzzPh/imrEXPzO1W0sXDXsUnqXANZ4o2bsa79TZZlm+OESoPkg44GBAAVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250710; c=relaxed/simple;
	bh=qMv6K0eROuSEWByIWNr+XxhdMFkyTfWQWuuRMeh4ErM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8oL703Dlc7smQjRNB2HPPUwb5is5P7+KddRVfPQPlUTHfEwN0KIJr7KQuIPoYSmuJCuNJaWNXe8+Uyp8jhH23E1bBAyHkS5AuytgOR/Ghva0gdcoIMYMRAcpKWiMV+Naqfg2n65IpDijjPALD1YxNDFKoAM/Sqy18OgRKKpDdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Im5fNd4v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Im5fNd4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755250707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FBvZZBX8XnXoKCbdso7CoGJlj6/0vHThFzqdbKh6FA=;
	b=Im5fNd4vDbOwYFSldT3QKq09UA0Nf1gZ08hKUwziYQm5f+eVdFzp8c6suNMffiEpH7ENe8
	0uJxd1q3zK/7eCmpw+lcSoNvLon950deH07wt0xgakVPDs4R+8FOxjHgCTA+3rY/PeXDwC
	nX9Lj0TtAVW0mer/gqRBIOmrE2erWcI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-s63AxtT-N9Ckzd6ca4lfDg-1; Fri,
 15 Aug 2025 05:38:21 -0400
X-MC-Unique: s63AxtT-N9Ckzd6ca4lfDg-1
X-Mimecast-MFC-AGG-ID: s63AxtT-N9Ckzd6ca4lfDg_1755250700
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF5F419560B3;
	Fri, 15 Aug 2025 09:38:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.153])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1913C30001A2;
	Fri, 15 Aug 2025 09:38:15 +0000 (UTC)
Date: Fri, 15 Aug 2025 17:38:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-mq: fix lockdep warning in
 __blk_mq_update_nr_hw_queues
Message-ID: <aJ8AAiINKj-3c1Xw@fedora>
References: <20250815075636.304660-1-ming.lei@redhat.com>
 <ff5639d3-9a63-e26c-a062-cb8a23c0ed5d@huaweicloud.com>
 <b4183646-a5cf-1f29-5451-c63fdda7c490@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4183646-a5cf-1f29-5451-c63fdda7c490@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Aug 15, 2025 at 05:34:23PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/15 17:15, Yu Kuai 写道:
> > Will it be simpler if we move blk_mq_freeze_queue_nomemsave() into
> > blk_mq_elv_switch_none(), after elevator is succeed switching to none
> > then freeze the queue.
> > 
> > Later in blk_mq_elv_switch_back we'll know if xa_load() return valid
> > elevator_type, related queue is already freezed.
> 
> Like following:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e9f037a25fe3..3640fae5707b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -5010,7 +5010,13 @@ static int blk_mq_elv_switch_none(struct
> request_queue *q,
>                 __elevator_get(q->elevator->type);
> 
>                 elevator_set_none(q);
> +       } else {
> +               ret = xa_insert(elv_tbl, q->id, xa_mk_value(1), GFP_KERNEL);
> +               if (WARN_ON_ONCE(ret))
> +                       return ret;
>         }
> +
> +       blk_mq_freeze_queue_nomemsave(q);
>         return ret;
>  }
> 
> @@ -5045,9 +5051,6 @@ static void __blk_mq_update_nr_hw_queues(struct
> blk_mq_tag_set *set,
>                 blk_mq_sysfs_unregister_hctxs(q);
>         }
> 
> -       list_for_each_entry(q, &set->tag_list, tag_set_list)
> -               blk_mq_freeze_queue_nomemsave(q);
> -
>         /*
>          * Switch IO scheduler to 'none', cleaning up the data associated
>          * with the previous scheduler. We will switch back once we are done
> diff --git a/block/elevator.c b/block/elevator.c
> index e2ebfbf107b3..9400ea9ec024 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -715,16 +715,21 @@ void elv_update_nr_hw_queues(struct request_queue *q,
> struct elevator_type *e,
> 
>         WARN_ON_ONCE(q->mq_freeze_depth == 0);
> 
> -       if (e && !blk_queue_dying(q) && blk_queue_registered(q)) {
> -               ctx.name = e->elevator_name;
> -               ctx.et = t;
> -
> -               mutex_lock(&q->elevator_lock);
> -               /* force to reattach elevator after nr_hw_queue is updated
> */
> -               ret = elevator_switch(q, &ctx);
> -               mutex_unlock(&q->elevator_lock);
> +       if (e) {
> +               if (!xa_is_value(e) && !blk_queue_dying(q) &&
> +                   blk_queue_registered(q)) {
> +                       ctx.name = e->elevator_name;
> +                       ctx.et = t;
> +
> +                       mutex_lock(&q->elevator_lock);
> +                       /* force to reattach elevator after nr_hw_queue is
> updated */
> +                       ret = elevator_switch(q, &ctx);
> +                       mutex_unlock(&q->elevator_lock);
> +               }
> +
> +               blk_mq_unfreeze_queue_nomemrestore(q);
>         }
> -       blk_mq_unfreeze_queue_nomemrestore(q);
> +

I feel it doesn't become simpler, :-(

However we still can avoid the change in elv_update_nr_hw_queues() by moving
freeze/unfree queue to blk_mq_elv_switch_back(), which looks more readable.



Thanks, 
Ming

