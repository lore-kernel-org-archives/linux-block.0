Received: from sg-1-21.ptr.blmpb.com (sg-1-21.ptr.blmpb.com [118.26.132.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AF3248F78
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 06:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763015757; cv=none; b=H3ssw69joDWJ4MzFThvokTv5p1mu0g0aQ+/GMCFs34XIm+85P21IBePo/J7xo6snEd3scvr6HKYHCcllYcKGccJeeLTFBqpSr0Y4IDL3Kw9kVo4dZj3NAGchpGdk7S1/8G4R2bayMUTPwgKi7a23QxI1HB9oc9rwrbdTrmBe1U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763015757; c=relaxed/simple;
	bh=LhPg4wYjT9d1ogpfAxSHxxN8xi/JncAV2Y8wspcXtMc=;
	h=Message-Id:References:To:Content-Type:From:Subject:Date:
	 Mime-Version:In-Reply-To:Cc; b=F8w8vTrMMMRnnBYZ1XqCknk/TdNiJ7mTNPC2mmqA3BZQWUIog2/VSavscSZG9Wxzx86Eis51o01cxeJA2gCBIXmW0ZPHJXG1oEWg401C+jnVq/tA2z8+BAB1/9NqIZDE5Vs9+Iy84GbmCpY3dWdIb9Ne8trkwLFRMf9A+R9aheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=B+71xRqa; arc=none smtp.client-ip=118.26.132.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="B+71xRqa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763015742;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=TQqF+reyQpn48Y2Ik0cg26rlOSElqHJAZ2tOmZz+yT8=;
 b=B+71xRqagpJu+xFodbiiNYponH/e7VyHczpS2ahyTQmliYb+y+ie7XCAEbggp7vaniTPpc
 6+iVzM1Z7T6nvfr2cwMr52j8N6Rlt8aXueyon7vN7iiN99K9MAF2+09AC0z+KjAv70vw0d
 Srt3i8/hyNIxCsuaBiOOQDSrtNTwA6WwWZ0wKyhYUG4nRFqDjFocEP3odH81uqJiff3Dsm
 1f70g+9P2ZOzUITyOX+3kpmLnGoevDQYj7A+DRb6Usdyy5BlK1zi39YdTeldcvWKGD+tzP
 UCKa4iNUD2z2hbUj7m8VfNTPsbK0GQgvwRAOBZvuFqmi4/60wBGR/6wz9do/Fg==
Message-Id: <f4490af5-e198-4d30-84e2-f33c70935de7@fnnas.com>
References: <20251112132249.1791304-1-nilay@linux.ibm.com> <20251112132249.1791304-4-nilay@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Reply-To: yukuai@fnnas.com
To: "Nilay Shroff" <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.130]) by smtp.feishu.cn with ESMTPS; Thu, 13 Nov 2025 14:35:39 +0800
User-Agent: Mozilla Thunderbird
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+269157c3c+c6322e+vger.kernel.org+yukuai@fnnas.com>
Content-Language: en-US
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCHv6 3/5] block: introduce alloc_sched_data and free_sched_data elevator methods
Date: Thu, 13 Nov 2025 14:35:37 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20251112132249.1791304-4-nilay@linux.ibm.com>
Cc: <ming.lei@redhat.com>, <hch@lst.de>, <axboe@kernel.dk>, 
	<yi.zhang@redhat.com>, <czhong@redhat.com>, <gjoyce@ibm.com>, 
	"Yu Kuai" <yukuai@fnnas.com>

Hi,

=E5=9C=A8 2025/11/12 21:22, Nilay Shroff =E5=86=99=E9=81=93:
> The recent lockdep splat [1] highlights a potential deadlock risk
> involving ->elevator_lock and ->freeze_lock dependencies on -pcpu_alloc_
> mutex. The trace shows that the issue occurs when the Kyber scheduler
> allocates dynamic memory for its elevator data during initialization.
>
> To address this, introduce two new elevator operation callbacks:
> ->alloc_sched_data and ->free_sched_data. The subsequent patch would
> build upon these newly introduced methods to suppress lockdep splat[1].
>
> [1] https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnV=
yjO0=3D-D5+A@mail.gmail.com/
>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-mq-sched.h | 25 +++++++++++++++++++++++++
>   block/elevator.h     |  2 ++
>   2 files changed, 27 insertions(+)
>
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 1f8e58dd4b49..f9433a1cc7f8 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -38,6 +38,31 @@ void blk_mq_free_sched_res(struct elevator_resources *=
res,
>   		struct blk_mq_tag_set *set);
>   void blk_mq_free_sched_res_batch(struct xarray *et_table,
>   		struct blk_mq_tag_set *set);
> +/*
> + * blk_mq_alloc_sched_data() - Allocates scheduler specific data
> + * Returns:
> + *         - Pointer to allocated data on success
> + *         - &blk_mq_sched_data sentinel if no allocation needed
> + *         - ERR_PTR(-ENOMEM) in case of failure
> + */
> +static inline void *blk_mq_alloc_sched_data(struct request_queue *q,
> +		struct elevator_type *e)
> +{
> +	void *sched_data;
> +	static char blk_mq_sched_data;	/* act as a success sentinel */
> +
> +	if (!e || !e->ops.alloc_sched_data)
> +		return &blk_mq_sched_data;

Looks to me it's fine to return NULL here, if so, I don't like this
hacky value. Otherwise LGTM.

> +
> +	sched_data =3D e->ops.alloc_sched_data(q);
> +	return (sched_data) ?: ERR_PTR(-ENOMEM);
> +}
> +
> +static inline void blk_mq_free_sched_data(struct elevator_type *e, void =
*data)
> +{
> +	if (e && e->ops.free_sched_data)
> +		e->ops.free_sched_data(data);
> +}
>  =20
>   static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
>   {
> diff --git a/block/elevator.h b/block/elevator.h
> index 621a63597249..e34043f6da26 100644
> --- a/block/elevator.h
> +++ b/block/elevator.h
> @@ -58,6 +58,8 @@ struct elevator_mq_ops {
>   	int (*init_hctx)(struct blk_mq_hw_ctx *, unsigned int);
>   	void (*exit_hctx)(struct blk_mq_hw_ctx *, unsigned int);
>   	void (*depth_updated)(struct request_queue *);
> +	void *(*alloc_sched_data)(struct request_queue *);
> +	void (*free_sched_data)(void *);
>  =20
>   	bool (*allow_merge)(struct request_queue *, struct request *, struct b=
io *);
>   	bool (*bio_merge)(struct request_queue *, struct bio *, unsigned int);

--=20
Thanks
Kuai
