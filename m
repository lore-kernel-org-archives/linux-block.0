Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39D92F5322
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669294; cv=none; b=owQlIwVNfYZ3wNGXYoQOuCBQEiqDXgYO51uy7dorlW3f1OkfJDN+sqNJ8sK06unQsNTP6ONTUwihUdSCMwK0Tb3jjKUmZZ5pm4R2QlFMxYSFA6EnPqAvNuJWSsl7LAz7LdXurkD2BQXjgnCHFrskAnuv+76z218ofHefxAy8K20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669294; c=relaxed/simple;
	bh=fPTJ4SsZh3OpT+9/wSZEo/B3FjzU/0X+obKUW00jtgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGpR4dmLevsb+o2CahuPcPmeb8KOG4eTnnX3pJ1U0meFxTJjsQaIS+C2l3bTzHb+5v+IT9prq0cEqyhZc/XiEnUoXwx8PfCo+sbqYKA6fmdktBBTVoVvdxqAAM0tXIAnl5CRubHlnlSgfWNhwNNb7P7wmem2TVw+zvtjuI1XI0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED3o/H8Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED3o/H8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CB4C4CEF0;
	Wed, 16 Jul 2025 12:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752669294;
	bh=fPTJ4SsZh3OpT+9/wSZEo/B3FjzU/0X+obKUW00jtgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ED3o/H8Y2GnuDpH2Sv9iFuIEAAqGezQi2b7DrgxJbAV53BicBeEl/NCEHfdjoO6j2
	 lyMurmVtP8gimPi1EFiY8ERCiC8JIrFIzprQLMnfdGC63X84uilFU1Gkm7/MhiVq6f
	 8jeHdbD9zoKImefA9uW/l7JSLHUBFlrhc+PXH4kIbbMZJe7wjZVtj2LlgCRAne3xml
	 bBwDCGoEIcD8Q3doplkP7nnnjXiG8YRlxKH/lMDhzCoLv28GgGYJE2hvthTu67MdUi
	 7UKoUwl/rBSlrKJXlcD1eL7qSR1SGF2Elp39UXHeEf8HLk9wR7Qc5FgcD0cwj4U3TG
	 JQdb0vSDKiMZw==
Date: Wed, 16 Jul 2025 20:34:49 +0800
From: Coly Li <colyli@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@lst.de, linux-block@vger.kernel.org, 
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: Improper io_opt setting for md raid5
Message-ID: <w56eyedneaptamuyl7gju6vl45egk4yza7lw5expwrqwe4f5ha@k25uqrq4f2mf>
References: <ywsfp3lqnijgig6yrlv2ztxram6ohf5z4yfeebswjkvp2dzisd@f5ikoyo3sfq5>
 <9b4027e8-6efa-7b28-8f00-3f4a5435b6c9@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b4027e8-6efa-7b28-8f00-3f4a5435b6c9@huaweicloud.com>

On Wed, Jul 16, 2025 at 03:26:02PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/07/15 23:56, Coly Li 写道:
> > Then when my raid5 array sets its queue limits, because its io_opt is 64KiB*7,
> > and the raid component sata hard drive has io_opt with 32767 sectors, by
> > calculation in block/blk-setting.c:blk_stack_limits() at line 753,
> > 753         t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
> > the calculated opt_io_size of my raid5 array is more than 1GiB. It is too large.
> 
> Perhaps we should at least provide a helper for raid5 that we prefer
> raid5 io_opt over underlying disk's io_opt. Because of raid5 internal
> implemation, chunk_size * data disks is the best choice, there will be
> significant differences in performance if not aligned with io_opt.
> 
> Something like following:
> 

Yeah, this one also solves my issue. Thanks.

Coly Li


> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index a000daafbfb4..04e7b4808e7a 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -700,6 +700,7 @@ int blk_stack_limits(struct queue_limits *t, struct
> queue_limits *b,
>                 t->features &= ~BLK_FEAT_POLL;
> 
>         t->flags |= (b->flags & BLK_FLAG_MISALIGNED);
> +       t->flags |= (b->flags & BLK_FLAG_STACK_IO_OPT);
> 
>         t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
>         t->max_user_sectors = min_not_zero(t->max_user_sectors,
> @@ -750,7 +751,10 @@ int blk_stack_limits(struct queue_limits *t, struct
> queue_limits *b,
>                                      b->physical_block_size);
> 
>         t->io_min = max(t->io_min, b->io_min);
> -       t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
> +       if (!t->io_opt || !(t->flags & BLK_FLAG_STACK_IO_OPT) ||
> +           (b->flags & BLK_FLAG_STACK_IO_OPT))
> +           t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
> +
>         t->dma_alignment = max(t->dma_alignment, b->dma_alignment);
> 
>         /* Set non-power-of-2 compatible chunk_sectors boundary */
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 5b270d4ee99c..bb482ec40506 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7733,6 +7733,7 @@ static int raid5_set_limits(struct mddev *mddev)
>         lim.io_min = mddev->chunk_sectors << 9;
>         lim.io_opt = lim.io_min * (conf->raid_disks - conf->max_degraded);
>         lim.features |= BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE;
> +       lim.flags |= BLK_FLAG_STACK_IO_OPT;
>         lim.discard_granularity = stripe;
>         lim.max_write_zeroes_sectors = 0;
>         mddev_stack_rdev_limits(mddev, &lim, 0);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 332b56f323d9..65317e93790e 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -360,6 +360,9 @@ typedef unsigned int __bitwise blk_flags_t;
>  /* passthrough command IO accounting */
>  #define BLK_FLAG_IOSTATS_PASSTHROUGH   ((__force blk_flags_t)(1u << 2))
> 
> +/* ignore underlying disks io_opt */
> +#define BLK_FLAG_STACK_IO_OPT          ((__force blk_flags_t)(1u << 3))
> +
>  struct queue_limits {
>         blk_features_t          features;
>         blk_flags_t             flags;
> 
