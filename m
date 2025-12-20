Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05F2135D7
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766234883; cv=none; b=hFDITvrynovWtSoRKgkycOjhTCWGMqc4t4+tAMqvTaQ05iJ+vqYbVZl8+f9DZVOdPvaq5RXwxATGMWmbUli89Syio7Ki6XE/niFw1CaTCD7XXI+8vfIC91ZDN9qLOMfyXktacnecK9nN7k8d7KCeKiC5cvxg5t+s/dcqCtvu/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766234883; c=relaxed/simple;
	bh=sHrRBUBY+sKxok2pkVu6baFFcdcL8/IRhHGbMABylzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR/ndsn/N2QbslPGWWS5kOn57shNDJznpP0EUKER1vX6NexM3JwXy4WlCyWN5It2vPhxVOduazwDSeZNRtJMrD5z85DEryDqc6TV6CoFIyjHASKCudAVLhuzSgAXQ8ng/70830zQLXwi20jVngtgwopf/awTuAOOifD4a+hmd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYpRaCl4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYpRaCl4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766234880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WMsR2PvCaWPlJouF9K8Py4oPXG0GhjqBTKXmoX5GMQ=;
	b=MYpRaCl4Up0NcBdNyPRiQnLmx0WEe8nqb8qGnENOR+BeieDAIxRBJoZGN6GQDxOJLiDQO4
	6CYo8wHOkI1djQHRuYz+5mmcmBcHr9ox8Cs9EQTnDjO5Kde10jAFAjhGmKi5LUiCrLfqdC
	fRz5PiUXdGJGH/vqaNQr5sQjxlsDpEs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-I9kGSS00PoKzIMgkmobnKw-1; Sat,
 20 Dec 2025 07:47:56 -0500
X-MC-Unique: I9kGSS00PoKzIMgkmobnKw-1
X-Mimecast-MFC-AGG-ID: I9kGSS00PoKzIMgkmobnKw_1766234875
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD209195DE61;
	Sat, 20 Dec 2025 12:47:54 +0000 (UTC)
Received: from fedora (unknown [10.72.116.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7382930001A2;
	Sat, 20 Dec 2025 12:47:45 +0000 (UTC)
Date: Sat, 20 Dec 2025 20:47:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
Cc: axboe@kernel.dk, gregkh@linuxfoundation.org, muchun.song@linux.dev,
	sashal@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ionut Nechita <ionut.nechita@windriver.com>
Subject: Re: [PATCH 2/2] block/blk-mq: convert blk_mq_cpuhp_lock to
 raw_spinlock for RT
Message-ID: <aUaa7IbGko82Dn8Z@fedora>
References: <20251220110241.8435-1-ionut.nechita@windriver.com>
 <20251220110241.8435-3-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220110241.8435-3-ionut.nechita@windriver.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Dec 20, 2025 at 01:02:41PM +0200, Ionut Nechita (WindRiver) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> Commit 58bf93580fec ("blk-mq: move cpuhp callback registering out of
> q->sysfs_lock") introduced a global mutex blk_mq_cpuhp_lock to avoid
> lockdep warnings between sysfs_lock and CPU hotplug lock.
> 
> On RT kernels (CONFIG_PREEMPT_RT), regular mutexes are converted to
> rt_mutex (sleeping locks). When block layer operations need to acquire
> blk_mq_cpuhp_lock, IRQ threads processing I/O completions may sleep,
> causing additional contention on top of the queue_lock issue from
> commit 679b1874eba7 ("block: fix ordering between checking
> QUEUE_FLAG_QUIESCED request adding").
> 
> Test case (MegaRAID 12GSAS with 8 MSI-X vectors on RT kernel):
> - v6.6.68-rt with queue_lock fix: 640 MB/s (queue_lock fixed)
> - v6.6.69-rt: still exhibits contention due to cpuhp_lock mutex
> 
> The functions protected by blk_mq_cpuhp_lock only perform fast,
> non-sleeping operations:
> - hlist_unhashed() checks
> - cpuhp_state_add_instance_nocalls() - just hlist manipulation
> - cpuhp_state_remove_instance_nocalls() - just hlist manipulation
> - INIT_HLIST_NODE() initialization
> 
> The _nocalls variants do not invoke state callbacks and only manipulate
> data structures, making them safe to call under raw_spinlock.
> 
> Convert blk_mq_cpuhp_lock from mutex to raw_spinlock to prevent it from
> becoming a sleeping lock in RT kernel. This eliminates the contention
> bottleneck while maintaining the lockdep fix's original intent.

What is the contention bottleneck? blk_mq_cpuhp_lock is only acquired in
slow code path, and it isn't required in fast io path.

> 
> Fixes: 58bf93580fec ("blk-mq: move cpuhp callback registering out of q->sysfs_lock")

With the 1st patch, the perf becomes 640MB/s, same with before regression.

So can you share what you try to fix with this patch?

> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>  block/blk-mq.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5fb8da4958d0..3982e24b1081 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -43,7 +43,7 @@
>  
>  static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
>  static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
> -static DEFINE_MUTEX(blk_mq_cpuhp_lock);
> +static DEFINE_RAW_SPINLOCK(blk_mq_cpuhp_lock);
>  
>  static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
>  static void blk_mq_request_bypass_insert(struct request *rq,
> @@ -3641,9 +3641,9 @@ static void __blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
>  
>  static void blk_mq_remove_cpuhp(struct blk_mq_hw_ctx *hctx)
>  {
> -	mutex_lock(&blk_mq_cpuhp_lock);
> +	raw_spin_lock(&blk_mq_cpuhp_lock);
>  	__blk_mq_remove_cpuhp(hctx);
> -	mutex_unlock(&blk_mq_cpuhp_lock);
> +	raw_spin_unlock(&blk_mq_cpuhp_lock);

__blk_mq_remove_cpuhp()
	->cpuhp_state_remove_instance_nocalls()
		->__cpuhp_state_remove_instance
			->cpus_read_lock
				->percpu_down_read
					->percpu_down_read_internal
						->might_sleep()


Thanks,
Ming

