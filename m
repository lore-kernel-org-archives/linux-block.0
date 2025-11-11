Received: from sg-1-17.ptr.blmpb.com (sg-1-17.ptr.blmpb.com [118.26.132.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056A934D38B
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845638; cv=none; b=fqnkwRZRTS7i6fwDbtMmrU+YrJttGJCQYot8qWKOprm2e43NyJ690ZEt8QbtZ/GzX/lTNuNKAfjUEb82HQuM9txjJwCa74jVwwQLiZEUk6RS97dKZBph8K7/ufFjE6FGqDta3EwxEtyE8F9q3VEt9xJhBjT+MdLwzs9aaKAZ1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845638; c=relaxed/simple;
	bh=zvaqK7WCVZd1YynrgFL9oHlZgwSMyNzySFEpVhx4vsc=;
	h=From:Content-Type:In-Reply-To:References:To:Cc:Date:Message-Id:
	 Mime-Version:Subject; b=YlQEPVz7AaoGczsULXEqrXaM6kC1O1m9Hj1SR9PaONyxq84LJv3fhw2zXsAdhLf+TY/U/odXNka5kpcIDuWt7hGZNk/oWrHdHVXHNGd0aMGG8xjxAzz9fHDYkT9I7pGN1eCEP4x6eJNgIEnDQAlSwMq27rcrs9/Q1aoBd0a/9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=zEBfn6uk; arc=none smtp.client-ip=118.26.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="zEBfn6uk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762845629;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=QdPg4pkTIpdjdIcJpqvhbpSLm6J76eXEpsERAqgHkjo=;
 b=zEBfn6uk+TH9Q6Fv/+II7U3AswIltUPdoL+E9IOIldzJiLojhvdiVDypmQpdn42wnK1iNf
 RSmrFesTCRTEuMV2JRgpLx0x4VPjbWWdEJlUVQS500/dx0cNlXcUEAH1QGMGLsyRbrIU/l
 rLWZxV7aNoeLuMobcRB/eDCyEpWwnALvvxTzRP1eHpPw+nHbZNxxuC8zeAaYqYIzGUY1TI
 C0dJ2R4JOswQ7/gZKlA8K/JqyHY6zcjuLTZAa6wjwfaVUUOTrekcvzXDaLXq34r0mY+rS4
 0DMx9Y3Z6xmlgBQD9FdXUHTbsIVPXw5QWYg1hZeeMtiVdN6W/6sboZU2fZpTeQ==
From: "Yu Kuai" <yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>
In-Reply-To: <20251110081457.1006206-4-nilay@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
References: <20251110081457.1006206-1-nilay@linux.ibm.com> <20251110081457.1006206-4-nilay@linux.ibm.com>
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Tue, 11 Nov 2025 15:20:26 +0800
X-Lms-Return-Path: <lba+26912e3bb+25e379+vger.kernel.org+yukuai@fnnas.com>
To: "Nilay Shroff" <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>
Cc: <ming.lei@redhat.com>, <hch@lst.de>, <axboe@kernel.dk>, 
	<yi.zhang@redhat.com>, <czhong@redhat.com>, <gjoyce@ibm.com>, 
	<yukuai@fnnas.com>
Date: Tue, 11 Nov 2025 15:20:24 +0800
Message-Id: <e8506adf-a90c-493d-a060-129aa5d417b7@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Reply-To: yukuai@fnnas.com
Subject: Re: [PATCHv4 3/5] block: introduce alloc_sched_data and free_sched_data elevator methods
User-Agent: Mozilla Thunderbird

Hi,

=E5=9C=A8 2025/11/10 16:14, Nilay Shroff =E5=86=99=E9=81=93:
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
>   block/blk-mq-sched.h | 17 +++++++++++++++++
>   block/elevator.h     |  2 ++
>   2 files changed, 19 insertions(+)
>
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 97204df76def..d38911d0d9eb 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -39,6 +39,23 @@ void blk_mq_free_sched_res(struct elevator_resources *=
res,
>   void blk_mq_free_sched_res_batch(struct xarray *et_table,
>   		struct blk_mq_tag_set *set);
>  =20
> +static inline int blk_mq_alloc_sched_data(struct request_queue *q,
> +		struct elevator_type *e, void **data)
> +{
> +	if (e && e->ops.alloc_sched_data) {
> +		*data =3D e->ops.alloc_sched_data(q);
> +		if (!*data)
> +			return -ENOMEM;
> +	}
> +	return 0;
> +}

I'm not strongly against this, but instead of the input parameter
as the output, why not return data directly? I feel this is more readable.

Perhaps you're considering different cases that alloc_sched_data() method
is defined or not, when NULL is returned. And this can be solved by fold ab=
ove
helper into caller directly, there is only one caller anyway. In patch 4:

if (types && types->ops.alloc_sched_data) {
	res->data =3D types->ops.alloc_sched_data(q);
	if (!res->data) {
		blk_mq_free_sched_tags();
		return -ENOMEM;
	}
}

It's up to you :)

Thanks,
Kuai

> +
> +static inline void blk_mq_free_sched_data(struct elevator_type *e, void =
*data)
> +{
> +	if (e && e->ops.free_sched_data)
> +		e->ops.free_sched_data(data);
> +}
> +
>   static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
>   {
>   	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
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
