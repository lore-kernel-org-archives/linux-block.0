Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746868;
	b=WLNvc3HUClKvqxKxkQ4NuQUIt9U3+Y+INncoriRD01uvpDEWHupDgO7ooS+Y53Gp6DmZ
	 A1Jzoy8ccLEMy7sqVqG9eQneZoj1Jl/ee774NQaSKSJNR8+N7sblTdYLSydzUC0I5ufmE
	 vjq53OMpblqaBmmtSrzCaz9PM3HLaXr/SU+50dHcwjIM4mhA8u1iCl+0Zg6zvnajQ6If3
	 0PxC5A0Z2nSFCTsg/KRZvoU/MK0zZGmxdrbSpBC36caYKKEQZNc8jgIGzl9tIuOi1AQln
	 Kr/qXqYr3qZ7BMn77UF8blrHJ8aNfCdhvtCr+0oGhxaOf1kScAIUkRJcRhefeJCp4MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746868;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 In-Reply-To:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-Sendblock-Type:CMS-TYPE:cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:
	 References;
	bh=KxRBaCl6SIR11QatilRX983Sq8/llllRV78Ep6I15c8=;
	b=sBBYrCHjRx3uQq10fdIkrBF1GYo8dwj5Wsi5Avd5FvGuV5gp9xDso80dzUHY/Qp8Xo8d
	 EYinvWWe0uM6byvNy5HZ3OH2pcboHB6ChppwtHhOyYG6RLVkPHcFYnSpKQrXVL+/g7wt7
	 85R+NzDE+I3yNwH5FSUu/MPLJ+Gw2hTe/hO+sRUT/A/ws+0zzInywCSut71dOe9zBYMdM
	 ID+Cqg+L7gxFBq+8Bol2E1E0CxKTZaYWwJ/+CeIFul18jSeTdBfJLy+AJM4yup25LX8Y5
	 WD90V9ZBvVu77zVHAgsjf21aMgJiv1kZHMrk1NYvI3op+pkA+rcfYzzRNiOCsjbI6wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NTww7lbG;
	arc=none smtp.remote-ip=203.254.224.34
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D932606A31E
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 09:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D932606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NTww7lbG
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261023091419epoutp04427a3eee31c925121dcf4eacdd8256b7~hHcU5vIL62064520645epoutp04N
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 09:14:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261023091419epoutp04427a3eee31c925121dcf4eacdd8256b7~hHcU5vIL62064520645epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1792746859;
	bh=KxRBaCl6SIR11QatilRX983Sq8/llllRV78Ep6I15c8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NTww7lbG6DNGSbYdJpQKW/4oLc1S4ixnafP49IKas3mC9sCYy0mZ/RYQwM35xquxi
	 3LlVeX720+DIt31tVagsJuQG/9lDc4C5+1vj2esuEppM3IMFRsLKmttZaLZL4iCkU/
	 6CTfROQdjsSJVFnU33yGdRRmi+eM0haOrPov7MxI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20261023091419epcas5p471c3db4981fae6ad5fd9f843c319a218~hHcUhYtpu2146721467epcas5p4l;
	Fri, 23 Oct 2026 09:14:19 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4j9y561PQ1z2SSKX; Fri, 23 Oct
	2026 09:14:18 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20261022130134epcas5p23704ea4f10cd9d90762b89c3c9fdf254~g25c8K_br1950919509epcas5p2j;
	Thu, 22 Oct 2026 13:01:34 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261022130132epsmtip19a5b77749906115956858b506dddc7c3~g25bZmdxB1541915419epsmtip1I;
	Thu, 22 Oct 2026 13:01:32 +0000 (GMT)
Date: Thu, 22 Oct 2026 18:30:53 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Anuj Gupta <anuj1072538@gmail.com>, hch@lst.de, djwong@kernel.org,
	cem@kernel.org, brauner@kernel.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, anuj20.g@samsung.com
Subject: Re: [RFC 2/4] block: refuse a dma-buf bio for a disk the buffer was
 not registered on
Message-ID: <20261022130053.vhphcch4swb5xxih@green245.gost>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <5f542a8d-c6c1-4c5d-b0c6-f761af2e126a@gmail.com>
X-CMS-MailID: 20261022130134epcas5p23704ea4f10cd9d90762b89c3c9fdf254
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----VZDtnczHWjdXYXkjw.jkIJrU2UH2.1dU.Tnm2W3-fiUacbuL=_9f5cc_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261022130134epcas5p23704ea4f10cd9d90762b89c3c9fdf254
References: <20261016091919.971295-1-anuj1072538@gmail.com>
	<20261016091919.971295-3-anuj1072538@gmail.com>
	<5f542a8d-c6c1-4c5d-b0c6-f761af2e126a@gmail.com>
	<CGME20261022130134epcas5p23704ea4f10cd9d90762b89c3c9fdf254@epcas5p2.samsung.com>

------VZDtnczHWjdXYXkjw.jkIJrU2UH2.1dU.Tnm2W3-fiUacbuL=_9f5cc_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 21/10/26 04:12PM, Pavel Begunkov wrote:
>On 10/16/26 10:19, Anuj Gupta wrote:
>>From: Nitesh Shetty <nj.shetty@samsung.com>
>...> +static bool bio_dmabuf_map_valid(const struct bio *bio,
>>+				 const struct iov_iter *iter)
>>+{
>>+	return iter->dmabuf_map->ctx->registered_devt ==
>>+		disk_devt(bio->bi_bdev->bd_disk);
>>+}
>>+
>>  /**
>>   * bio_iov_iter_get_pages - add user or kernel pages to a bio
>>   * @bio: bio to add pages to
>>@@ -1300,6 +1312,9 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
>>  	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
>>  		return -EIO;
>>+	if (iov_iter_is_dmabuf_map(iter) && !bio_dmabuf_map_valid(bio, iter))
>>+		return -EXDEV;
>>+
>>  	if (bio_iov_iter_set(bio, iter)) {
>>  		if (iov_iter_is_bvec(iter) &&
>>  		    !bio_iov_bvec_aligned(bio, mem_align_mask))
>>diff --git a/block/fops.c b/block/fops.c
>>index 18a755f6e0b0..b36dde10a4ac 100644
>>--- a/block/fops.c
>>+++ b/block/fops.c
>>@@ -19,6 +19,7 @@
>>  #include <linux/iomap.h>
>>  #include <linux/module.h>
>>  #include <linux/io_uring/cmd.h>
>>+#include <linux/dma-buf-io.h>
>>  #include "blk.h"
>>  static inline struct inode *bdev_file_inode(struct file *file)
>>@@ -938,6 +939,7 @@ int bdev_init_dma_buf_io_ctx(struct file *file, struct block_device *bdev,
>>  			     struct dma_buf_io_ctx *ctx)
>>  {
>>  	struct gendisk *disk = bdev->bd_disk;
>>+	int ret;
>>  	if (!(file->f_flags & O_DIRECT))
>>  		return -EINVAL;
>>@@ -945,7 +947,10 @@ int bdev_init_dma_buf_io_ctx(struct file *file, struct block_device *bdev,
>>  		return -EOPNOTSUPP;
>>  	if (bdev_has_integrity_csum(bdev))
>>  		return -EOPNOTSUPP;
>>-	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
>>+	ret = disk->fops->init_dma_buf_io_ctx(bdev, ctx);
>>+	if (!ret)
>>+		ctx->registered_devt = disk_devt(disk);
>>+	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(bdev_init_dma_buf_io_ctx);
>>diff --git a/include/linux/dma-buf-io.h b/include/linux/dma-buf-io.h
>>index b9bbeca1744f..d42a79f2ac9b 100644
>>--- a/include/linux/dma-buf-io.h
>>+++ b/include/linux/dma-buf-io.h
>>@@ -50,6 +50,8 @@ struct dma_buf_io_ctx {
>>  	void					*dev_priv;
>>  	const struct dma_buf_io_ops		*dev_ops;
>>+
>>+	dev_t					registered_devt;
>
>That wouldn't work well with multiple devices. Maybe reject it in
>xfs / iomap for now?
>
>FWIW, a generic solution is for xfs to own the ctx passed on
>registration instead of forwarding it to block, allocate an array
>of new ctxs for each device and register them separately. This
>should even be able to support dynamic device registration.
>
Agree, that works, keeps block layer clean, will update in next version.

--Nitesh

------VZDtnczHWjdXYXkjw.jkIJrU2UH2.1dU.Tnm2W3-fiUacbuL=_9f5cc_
Content-Type: text/plain; charset="utf-8"


------VZDtnczHWjdXYXkjw.jkIJrU2UH2.1dU.Tnm2W3-fiUacbuL=_9f5cc_--
