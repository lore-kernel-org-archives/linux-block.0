Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207C93B0598
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424490; cv=none; b=fLxr2ToGt5cbjmqoZA95yp3+XPO9ZlOC7PtgqJroHhBr1/mBaTTaxj5dtUgB76vrRNXzFXf6CPtYMz8e4ji8IrlWyk5p5hewzd9Y0tPGIvDRWuVxHZge6AfOG8SWopowrV30Bt8iyl7O/5lypUOif4K44BZzga0Va9fTk1tk9uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424490; c=relaxed/simple;
	bh=LefEe9I6FGK4kIF5fVLq2fdAdHftVnsLlMJfAYcLId0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfpXeupcNxaIJmtGwXag9vSRrjfC1rZF/B1UIkJt2qEtU+m3yPFDG+ZN6ayD4k3p7+dzRLV7lkDyMdxhG60uM4PDunF/gmV4VYtKFpVPp0YKa+hpYIt/TP1mCIfgFx4h+jDC999J/eeGiE3XAey4idgOA9ekOKS/tBuCbjXrco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir+MDwOM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir+MDwOM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4955158f26aso15064075e9.3
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785424487; x=1786029287; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ov+anrItHwMaEMVWagqnRxOBMkmXUb72K6ECwRf5/g=;
        b=Ir+MDwOMJPZLOxvcgT0liNxa9+9nLiYUh9RURGZCw/uiiOiYaSgUQd1e3W5H1kjGio
         z0/y6Tw+jBubvq5QZN7ml6vZzbuhu+iYDjaC3vhyh1YJLS6ijXnDMA07Lcc6KZ2h6pd4
         mb9MjyyiIn+DYkpb9BmH8XdEaCz/hmdin0XyHb6pM81nIGYtNJgsEfelAvxATPW/KVyY
         7dLcofYfAf69Kw4pAJWuWhwwKu7HsoW6oB/c1mc8n7t7J0hgEcz2PE1GkVzeCRDzecLB
         ztOx7YCG/yimFg5sPleM7Dcucp2BWp7q2Hyvw6kChIsjywVaBYyPJoGPVBZTohvGtHEa
         SO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785424487; x=1786029287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7ov+anrItHwMaEMVWagqnRxOBMkmXUb72K6ECwRf5/g=;
        b=ienkRmWdtYdKqqgwn5yvEAvO2BIMg8zT3Y+JE7gfF4YjVc3gJyaX7to913oPBpl5QC
         33hjdaQlG21vG+tjVRN8tmsUx0uUCGUnLYm4PCYRvAqJvoK9BnjmlGWQ48IReW/P12UN
         Rm3pEpF6nB6xn1BPpxLuU/vQTFSUViZfWxYK97m90r6uPpEWbfFl8+rStsLEsy3f1KPf
         5rqE7gwGdEEK2xYLTcNXLbHA/WTVSoWTNl6cxYFnmfOHoIV2Cb1lTReKWwyzAZ4lRAGJ
         lypxArVy5Yi0TzeaSIMJpYauATJ2LM6RgwTw4GL/wYo8dMHMpa46/zW8YbMzaghhYhB2
         Hqog==
X-Forwarded-Encrypted: i=1; AHgh+RqsB/Ky58FZShUNnsQ7DiKtz7GWJcs7iVUblwds4KxTuwaGW3npeV7e7DOl0UUOp5KpJWDj8kN/JLnRJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzce7lub9xIrEkrDHQoFDZd4KMK8cPbmNRh/h1AZnn8mMfUg96f
	lfzo2XMOaJifOxEOZWnyz0uJzBDUiTkjhXQFF+u2QRhinUg2UgeA70aA
X-Gm-Gg: AR+sD12MFR+EF8KQOcCS8f+nxkzjrLW231wKl/WNwJ/6h6mR0x4zItNnKRLhqloyaMZ
	Q+P6OqQ9rO1JcUCoR5QK9SzSTVVnnhX516/tBLBmKk9XbWG8ABjzXPRnu8Mm3lcScZSb0bIpUag
	d1Un+Zrh0RG+OamU5fxZY0cWJlq07/8xvekkwU6aaqTaBXzdmMc8qbBaMxAKxMZ/mguGks1MXzq
	hI8am51f2j0bcwUoEDtDA1GaCa/+eJQKZTNqHlcHoaBtwMrIROuX4CdojzXgS/mYDRJzIWaGZUG
	I5qOk5uG2z3GGE5QZlPf6RwI3FOm1k41Lp9qp2XKS9IuA9BnhGlnRM6GY8HkTIFfBpPb/xVHs2i
	jl11chZtIJeoTAcmTfFkrCMhsbRpqs6uksQOTvautvRWZGgsOMWaCCeL+mhWKkFD1ie+svsDdfV
	g4ZLutdzcpDMAUfpzneXHsNxxizev0c9pwd1lEVMtfnXOeHLS+OawpTlz/LGN9B5bHNbYbq5CzA
	xM2zyzs0rgZDlerWh4GoWMG9VhPTtlLnPFB1UZcA2pVt1OKio0lWgLea77OkvvPzvhk
X-Received: by 2002:a05:600c:46cf:b0:495:63f5:7a4f with SMTP id 5b1f17b1804b1-49800ebb9bamr42997065e9.33.1785424487240;
        Thu, 30 Jul 2026 08:14:47 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49800f1a7f7sm81489485e9.5.2026.07.30.08.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:14:46 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:14:20 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] ublk: add UBLK_F_IO_DESC_SIZE
Message-ID: <amtqTIZiUgOrSJmg@fedora-laptop>
References: <20260729012951.3744582-1-csander@purestorage.com>
 <20260729012951.3744582-6-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260729012951.3744582-6-csander@purestorage.com>

On Tue, Jul 28, 2026 at 07:29:50PM -0600, Caleb Sander Mateos wrote:
> ublk passes the parameters of incoming I/O in memory shared between the
> kernel ublk driver and userspace ublk server in struct ublksrv_io_desc.
> The size of this struct is currently fixed to 24 bytes, which has been
> an obstacle to extending it with additional fields [1]. Additionally,
> with multiple ublk server threads handling I/Os from the same ublk queue
> (possible with UBLK_F_PER_IO_DAEMON or UBLK_F_BATCH_IO), false sharing
> results from adjacent io_descs sharing the same cache line.
> 
> Add a ublk feature UBLK_F_IO_DESC_SIZE to allow a ublk server to
> override the size of each io_desc. The size must be at least 24 and a
> multiple of 8 to store a properly-aligned struct ublksrv_io_desc. The
> struct ublksrv_io_desc is located at the beginning of each io_desc and
> the remainder is padding. The mmap() performed for each queue must have
> a length of queue_depth * io_desc_size, rounded up to the page size. The
> mmap() offset must be q_id * UBLK_MAX_QUEUE_DEPTH * io_desc_size, also
> rounded up to the page size.
> 
> [1]: https://lore.kernel.org/linux-block/aV8QfvaNO5P6vOs6@fedora/
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c      | 35 ++++++++++++++++++++++++-----------
>  include/uapi/linux/ublk_cmd.h |  5 ++++-
>  2 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 46f5ab13f87e..1da45e382253 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -87,11 +87,12 @@
>  		| UBLK_F_BUF_REG_OFF_DAEMON \
>  		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
>  		| UBLK_F_SAFE_STOP_DEV \
>  		| UBLK_F_BATCH_IO \
>  		| UBLK_F_NO_AUTO_PART_SCAN \
> -		| UBLK_F_SHMEM_ZC)
> +		| UBLK_F_SHMEM_ZC \
> +		| UBLK_F_IO_DESC_SIZE)
>  
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>  		| UBLK_F_USER_RECOVERY_REISSUE \
>  		| UBLK_F_USER_RECOVERY_FAIL_IO)
>  
> @@ -237,10 +238,11 @@ struct ublk_io {
>  } ____cacheline_aligned_in_smp;
>  
>  struct ublk_queue {
>  	u16 q_id;
>  	u16 q_depth;
> +	u16 io_desc_size;
>  
>  	unsigned long flags;
>  	struct ublksrv_io_desc *io_cmd_buf;
>  
>  	bool force_abort;
> @@ -403,11 +405,11 @@ static inline void ublk_io_evts_deinit(struct ublk_queue *q)
>  }
>  
>  static inline struct ublksrv_io_desc *
>  ublk_get_iod(const struct ublk_queue *ubq, u16 tag)
>  {
> -	return &ubq->io_cmd_buf[tag];
> +	return (void *)ubq->io_cmd_buf + tag * (size_t)ubq->io_desc_size;
>  }
>  
>  static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
>  {
>  	return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
> @@ -1246,23 +1248,24 @@ static inline struct ublksrv_io_desc *
>  ublk_queue_cmd_buf(struct ublk_device *ub, u16 q_id)
>  {
>  	return ublk_get_queue(ub, q_id)->io_cmd_buf;
>  }
>  
> -static inline int __ublk_queue_cmd_buf_size(u16 depth)
> +static inline size_t __ublk_queue_cmd_buf_size(const struct ublk_device *ub,
> +					       u16 depth)
>  {
> -	return round_up(depth * sizeof(struct ublksrv_io_desc), PAGE_SIZE);
> +	return round_up(depth * (size_t)ub->dev_info.io_desc_size, PAGE_SIZE);
>  }
>  
> -static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub)
> +static inline size_t ublk_queue_cmd_buf_size(const struct ublk_device *ub)
>  {
> -	return __ublk_queue_cmd_buf_size(ub->dev_info.queue_depth);
> +	return __ublk_queue_cmd_buf_size(ub, ub->dev_info.queue_depth);
>  }
>  
> -static int ublk_max_cmd_buf_size(void)
> +static size_t ublk_max_cmd_buf_size(const struct ublk_device *ub)
>  {
> -	return __ublk_queue_cmd_buf_size(UBLK_MAX_QUEUE_DEPTH);
> +	return __ublk_queue_cmd_buf_size(ub, UBLK_MAX_QUEUE_DEPTH);
>  }
>  
>  /*
>   * Should I/O outstanding to the ublk server when it exits be reissued?
>   * If not, outstanding I/O will get errors.
> @@ -2648,11 +2651,11 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
>  /* map pre-allocated per-queue cmd buffer to ublksrv daemon */
>  static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
>  	struct ublk_device *ub = filp->private_data;
>  	size_t sz = vma->vm_end - vma->vm_start;
> -	unsigned max_sz = ublk_max_cmd_buf_size();
> +	size_t max_sz = ublk_max_cmd_buf_size(ub);
>  	unsigned long pfn, end, phys_off = vma->vm_pgoff << PAGE_SHIFT;
>  	int ret = 0;
>  	u16 q_id;
>  
>  	spin_lock(&ub->lock);
> @@ -4174,11 +4177,11 @@ static const struct file_operations ublk_ch_batch_io_fops = {
>  	.mmap = ublk_ch_mmap,
>  };
>  
>  static void __ublk_deinit_queue(struct ublk_device *ub, struct ublk_queue *ubq)
>  {
> -	int size;
> +	size_t size;
>  	u16 i;
>  
>  	size = ublk_queue_cmd_buf_size(ub);
>  
>  	for (i = 0; i < ubq->q_depth; i++) {
> @@ -4227,11 +4230,12 @@ static int ublk_init_queue(struct ublk_device *ub, u16 q_id)
>  	u16 depth = ub->dev_info.queue_depth;
>  	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO;
>  	struct ublk_queue *ubq;
>  	struct page *page;
>  	int numa_node;
> -	int size, ret;
> +	size_t size;
> +	int ret;
>  	u16 i;
>  
>  	/* Determine NUMA node based on queue's CPU affinity */
>  	numa_node = ublk_get_queue_numa_node(ub, q_id);
>  
> @@ -4252,10 +4256,11 @@ static int ublk_init_queue(struct ublk_device *ub, u16 q_id)
>  	if (!page) {
>  		kvfree(ubq);
>  		return -ENOMEM;
>  	}
>  	ubq->io_cmd_buf = page_address(page);
> +	ubq->io_desc_size = ub->dev_info.io_desc_size;
>  
>  	for (i = 0; i < ubq->q_depth; i++)
>  		spin_lock_init(&ubq->ios[i].lock);
>  
>  	if (ublk_dev_support_batch_io(ub)) {
> @@ -4736,10 +4741,18 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
>  
>  	/* User copy is required to access integrity buffer */
>  	if (info.flags & UBLK_F_INTEGRITY && !(info.flags & UBLK_F_USER_COPY))
>  		return -EINVAL;
>  
> +	if (info.flags & UBLK_F_IO_DESC_SIZE) {
> +		if (info.io_desc_size < sizeof(struct ublksrv_io_desc) ||
> +		    info.io_desc_size % _Alignof(struct ublksrv_io_desc))
> +			return -EINVAL;
> +	} else {
> +		info.io_desc_size = sizeof(struct ublksrv_io_desc);
> +	}
> +

No upper bound on io_desc_size.

Also Missing selftest update — this causes generic_13 failure.

New feature needs sanity test to show it working at least.

Thanks,
Ming
