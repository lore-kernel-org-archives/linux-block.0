Received: from sg-1-18.ptr.blmpb.com (sg-1-18.ptr.blmpb.com [118.26.132.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29D920B7ED
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765519827; cv=none; b=Mk2QJDvGD9xNvh4NJa1OyoHmxvTxmr2QC/+vQSqW8mr9wVwnZqGBW/DXGPiLvEUqiOIIljuK/mWutLAr0c+kkibHWdUc5f0Pbltv6Cer+dY3WwEZXdNCFdUjbv/MaFv5N8hBIx+oBu5P17mzuKYCcWAWGiLCw7Yn7byMbthwgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765519827; c=relaxed/simple;
	bh=72bzDQjfqc12jstpKItMVNqOUBuREtv9tVWA2JY/U2g=;
	h=In-Reply-To:To:Date:References:Cc:From:Subject:Mime-Version:
	 Content-Type:Message-Id; b=fuvAvp7sNeGM38W0+ZP4ewWFWdEFIWnG+8Enb3G/M28gwjYbyfKCizftzk1ZDtuGvOqoWaOY65Mba+tTKPHKvI6r5zJVy959JJXhFFP7J5gBvyaK74WtWBAFfOlyS3YQOqu8vjrrSpmVYOXlR4t7MguramhozXZctfywBIspX94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=B0KeFDLq; arc=none smtp.client-ip=118.26.132.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="B0KeFDLq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1765518985;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=xLtDjKcTeD1BZprojVYuRQfaId0/xJJzYCOl++nZKOg=;
 b=B0KeFDLq9kEC//QHs8frj+LBI2C5uKlURKTtzvh5GhfJsMoRLQWbgL3+4y7RAkQyxK6qLW
 WJEBp65Uf2r5xMfPCbKQo3Je9wBVFLmA6K15wUtl0y6yk2Npzy/QC2YVupOyib5BuTZrM9
 aG8F87EvuS8fK7qVADjaqsEeU7kwaaBHKwZCWSi7OVMXZsn1CVkor0WUOk8RKNhphGOCJG
 JdI61tzV5ZkKc8gpKJ9ZyW8S808ZW+uoeooO8fr7a8qU7GBabxMvi4mHjiQ5PsMMe3Ctgo
 ZCieTfHWNI7P1mPN9JEgxItplWttmesLTuXLylPse03ru2PIIx1S5jpFIUBOvQ==
In-Reply-To: <20251210091001.236296-1-ming.lei@redhat.com>
Content-Transfer-Encoding: quoted-printable
X-Original-From: Yu Kuai <yukuai@fnnas.com>
To: "Ming Lei" <ming.lei@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>
Date: Fri, 12 Dec 2025 13:56:20 +0800
References: <20251210091001.236296-1-ming.lei@redhat.com>
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@fnnas.com
Cc: "Nilay Shroff" <nilay@linux.ibm.com>, "Yu Kuai" <yukuai3@huawei.com>, 
	"Guangwu Zhang" <guazhang@redhat.com>, <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH] block: fix race between wbt_enable_default and IO submission
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.136]) by smtp.feishu.cn with ESMTPS; Fri, 12 Dec 2025 13:56:23 +0800
X-Lms-Return-Path: <lba+2693bae87+4c2ed8+vger.kernel.org+yukuai@fnnas.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Message-Id: <52b5f2a4-e5e1-4917-8620-490fde89cfe7@fnnas.com>

Hi,

=E5=9C=A8 2025/12/10 17:10, Ming Lei =E5=86=99=E9=81=93:
> When wbt_enable_default() is moved out of queue freezing in elevator_chan=
ge(),
> it can cause the wbt inflight counter to become negative (-1), leading to=
 hung
> tasks in the writeback path. Tasks get stuck in wbt_wait() because the co=
unter
> is in an inconsistent state.
>
> The issue occurs because wbt_enable_default() could race with IO submissi=
on,
> allowing the counter to be decremented before proper initialization. This=
 manifests
> as:
>
>    rq_wait[0]:
>      inflight:             -1
>      has_waiters:        True
>
> And results in hung task warnings like:
>    task:kworker/u24:39 state:D stack:0 pid:14767
>    Call Trace:
>      rq_qos_wait+0xb4/0x150
>      wbt_wait+0xa9/0x100
>      __rq_qos_throttle+0x24/0x40
>      blk_mq_submit_bio+0x672/0x7b0
>      ...
>
> Fix this by:
>
> 1. Splitting wbt_enable_default() into:
>     - __wbt_enable_default(): Returns true if wbt_init() should be called
>     - wbt_enable_default(): Wrapper for existing callers (no init)
>     - wbt_init_enable_default(): New function that checks and inits WBT
>
> 2. Using wbt_init_enable_default() in blk_register_queue() to ensure
>     proper initialization during queue registration
>
> 3. Move wbt_init() out of wbt_enable_default() which is only for enabling
>     disabled wbt from bfq and iocost, and wbt_init() isn't needed. Then t=
he
>     original lock warning can be avoided.
>
> 4. Removing the ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT flag and its handling
>     code since it's no longer needed
>
> This ensures WBT is properly initialized before any IO can be submitted,
> preventing the counter from going negative.
>
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Cc: Guangwu Zhang <guazhang@redhat.com>
> Fixes: 78c271344b6f ("block: move wbt_enable_default() out of queue freez=
ing from sched ->exit()")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/bfq-iosched.c |  2 +-
>   block/blk-sysfs.c   |  2 +-
>   block/blk-wbt.c     | 20 ++++++++++++++++----
>   block/blk-wbt.h     |  5 +++++
>   block/elevator.c    |  4 ----
>   block/elevator.h    |  1 -
>   6 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 4a8d3d96bfe4..6e54b1d3d8bc 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -7181,7 +7181,7 @@ static void bfq_exit_queue(struct elevator_queue *e=
)
>  =20
>   	blk_stat_disable_accounting(bfqd->queue);
>   	blk_queue_flag_clear(QUEUE_FLAG_DISABLE_WBT_DEF, bfqd->queue);
> -	set_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT, &e->flags);
> +	wbt_enable_default(bfqd->queue->disk);
>  =20
>   	kfree(bfqd);
>   }
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 8684c57498cc..e0a70d26972b 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -932,7 +932,7 @@ int blk_register_queue(struct gendisk *disk)
>   		elevator_set_default(q);
>  =20
>   	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
> -	wbt_enable_default(disk);
> +	wbt_init_enable_default(disk);
>  =20
>   	/* Now everything is ready and send out KOBJ_ADD uevent */
>   	kobject_uevent(&disk->queue_kobj, KOBJ_ADD);
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index eb8037bae0bd..0974875f77bd 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -699,7 +699,7 @@ static void wbt_requeue(struct rq_qos *rqos, struct r=
equest *rq)
>   /*
>    * Enable wbt if defaults are configured that way
>    */
> -void wbt_enable_default(struct gendisk *disk)
> +static bool __wbt_enable_default(struct gendisk *disk)
>   {
>   	struct request_queue *q =3D disk->queue;
>   	struct rq_qos *rqos;
> @@ -716,19 +716,31 @@ void wbt_enable_default(struct gendisk *disk)
>   		if (enable && RQWB(rqos)->enable_state =3D=3D WBT_STATE_OFF_DEFAULT)
>   			RQWB(rqos)->enable_state =3D WBT_STATE_ON_DEFAULT;

Is this problem due to above state? Changing the state is not under queue f=
rozen.
The commit message is not quite clear to me. If so, the changes looks good =
to me,
by setting the state with queue frozen.

Thanks,
Kuai

>   		mutex_unlock(&disk->rqos_state_mutex);
> -		return;
> +		return false;
>   	}
>   	mutex_unlock(&disk->rqos_state_mutex);
>  =20
>   	/* Queue not registered? Maybe shutting down... */
>   	if (!blk_queue_registered(q))
> -		return;
> +		return false;
>  =20
>   	if (queue_is_mq(q) && enable)
> -		wbt_init(disk);
> +		return true;
> +	return false;
> +}
> +
> +void wbt_enable_default(struct gendisk *disk)
> +{
> +	__wbt_enable_default(disk);
>   }
>   EXPORT_SYMBOL_GPL(wbt_enable_default);
>  =20
> +void wbt_init_enable_default(struct gendisk *disk)
> +{
> +	if (__wbt_enable_default(disk))
> +		WARN_ON_ONCE(wbt_init(disk));
> +}
> +
>   u64 wbt_default_latency_nsec(struct request_queue *q)
>   {
>   	/*
> diff --git a/block/blk-wbt.h b/block/blk-wbt.h
> index e5fc653b9b76..925f22475738 100644
> --- a/block/blk-wbt.h
> +++ b/block/blk-wbt.h
> @@ -5,6 +5,7 @@
>   #ifdef CONFIG_BLK_WBT
>  =20
>   int wbt_init(struct gendisk *disk);
> +void wbt_init_enable_default(struct gendisk *disk);
>   void wbt_disable_default(struct gendisk *disk);
>   void wbt_enable_default(struct gendisk *disk);
>  =20
> @@ -16,6 +17,10 @@ u64 wbt_default_latency_nsec(struct request_queue *);
>  =20
>   #else
>  =20
> +static inline void wbt_init_enable_default(struct gendisk *disk)
> +{
> +}
> +
>   static inline void wbt_disable_default(struct gendisk *disk)
>   {
>   }
> diff --git a/block/elevator.c b/block/elevator.c
> index 5b37ef44f52d..a2f8b2251dc6 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -633,14 +633,10 @@ static int elevator_change_done(struct request_queu=
e *q,
>   			.et =3D ctx->old->et,
>   			.data =3D ctx->old->elevator_data
>   		};
> -		bool enable_wbt =3D test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
> -				&ctx->old->flags);
>  =20
>   		elv_unregister_queue(q, ctx->old);
>   		blk_mq_free_sched_res(&res, ctx->old->type, q->tag_set);
>   		kobject_put(&ctx->old->kobj);
> -		if (enable_wbt)
> -			wbt_enable_default(q->disk);
>   	}
>   	if (ctx->new) {
>   		ret =3D elv_register_queue(q, ctx->new, !ctx->no_uevent);
> diff --git a/block/elevator.h b/block/elevator.h
> index a9d092c5a9e8..3eb32516be0b 100644
> --- a/block/elevator.h
> +++ b/block/elevator.h
> @@ -156,7 +156,6 @@ struct elevator_queue
>  =20
>   #define ELEVATOR_FLAG_REGISTERED	0
>   #define ELEVATOR_FLAG_DYING		1
> -#define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT	2
>  =20
>   /*
>    * block elevator interface
