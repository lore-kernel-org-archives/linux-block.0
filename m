Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA12798EA
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390374; cv=pass; b=CAJ8KEwI3QnbVFTOeu/4JJc5LoWSK13+M7WevAck+8CEjbo41kFNxdCnzRsL6nivyobQb64n4C6cAOzY9gjSHy5m+JMWmAk6d7GR4v8GSohWFlP+JlXFxBftwlGmr5Nt7486khZVZjfvLNT+9blBOwpTmm39ZZvXTgHguylSHxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390374; c=relaxed/simple;
	bh=OufKA992AHTujMMKlyMPMaSNXhGWNlCrvEQi1Oda2p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEirPZvWYTNEmJBxvBZUMT39n6ePJEOTDZcslrJtVsmeCz1tPeU0+AuXy2szmB6xPV5YvS5s0JZzuPIJE3oeKGQ0EyOXRm+QCD0Kl5RR+DxHH69KMRnBwWipImd1xOcFl2XwfqKQZR8mHwORhV3820hAjMYeyTr48zZXFhrBzBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8ZJSo9v; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8ZJSo9v"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65814266b08so3477163a12.3
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 07:06:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770390372; cv=none;
        d=google.com; s=arc-20240605;
        b=EFbnymxvAsUCfvxB5Oz6SxgBUcL/JefP2LicjSGMLu5yM9PbFiUI8dgOUC3sZtdOXl
         /GweAEt8PeNVhzou0DlGzL6GRoumqpTbOXpREQ5EUCrJv08xcpx10IZN038AKmWLQrRM
         CxMmH5a/OpVgifcfU+gAebIQN3mbgengc8S7mBMqGhOSBeKpo71VTAhqxEJNFYQql1YV
         cIuOchhpRf12iRmj1BiOpAP7o71YY8UGIsKMSt1rmOPQuTLaZDQDUIiY+XaxfEcGs6+/
         TNWjM/uRg9j/B/IVBoHJZXOz+sMo0bX8gt4XlcxvNIaBtxxxn2Ti2SZIM5irWe6J4Tbu
         TG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hGQBxRDZvTlf47Wu9lDxdnyR2cqQuj+x+M/+cDeQX7w=;
        fh=fu5FjAX/FzPTUltNlDV3vYnq2lRKAa9FG27MeWuatHM=;
        b=Za0stzJX00ZpA5fNsrbIMWbMOlPRe8ftozEEcC5nzAZRP1vrXU5uaVR4uISnWJbU06
         FXoxbcun6mclaN52tyKJlh4qlCyxXpEuc3zgmvQN/rZ+msZDiKZAYWl1LQBDstGM+WQU
         31KeHvW6ekyjgMWuEWHytifs1Hu3PTmHAbbuWPqxakiDaxAgc+46pqVYPqKh1wAviUfK
         InX/fJZ2cXLQH2sTAuZAlUWTp0lZ93aszyS6QGY0wLrAh+eewzC6SXPkdUf8rvZo202i
         /pO4apA69frXRJ3K+1WRB+mIhsq9yTMEfJRJ1dI8YN5dxitx9cTjX7JFT/VVCaVaDeXS
         c+bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770390372; x=1770995172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hGQBxRDZvTlf47Wu9lDxdnyR2cqQuj+x+M/+cDeQX7w=;
        b=h8ZJSo9vlSS5hxQXXJL2q2luhnxCw60rmiHlGjAP+CKSS8DdsC2VK0+XVie7uqk+fH
         NUQ+0I13UPnygzD19MWKJM6ld6u2hnrDDLxr3HQn5EUl4xn6E2x2WuDUcCGakAouh2i4
         prDofeb8LjqBtqHIbJyq8XM6HlDKY1kCDh5HalVtOE3FvDv0c6G1+Q1ndPVrP1qaRaZ7
         bHvsjFftiFbNHfJYASqwwg6YD36l1yJXjXYp/UWYCHsg9RbsJNTMI9AGGxfL96ngTqkx
         hYgLF37th3uZaWfJD9Ios4F9Wocsg6I7ozYacy5Cl6ZkqhwwzkeZb/oywNGUDaGze76e
         8MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390372; x=1770995172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGQBxRDZvTlf47Wu9lDxdnyR2cqQuj+x+M/+cDeQX7w=;
        b=JK1bmJNQOy5xinSffaHn1/CgulXjreUJnpuo4R7gNG1yjf4A6aQZBubwyOCxKpQcug
         G4uzIiG9fDR/hD+ZQ8jCQcvA2zzBd0HydEUzO0YXtHKTZWQdqPzbKRDlBmDmUFB3QjUx
         6cZFZO1OeckwRNU0BveTq/GjbAR+kg6oZOoF340/1g0w7bPKaXliu+dFErzqpaSGLj7L
         8osgiyM/lopDZqT9tYbvcycfc2/UMZ4J8yR7uXquMdBX2CjQv1k/rdWUc926xh1FbJXe
         5UHHIp9eNj4AjJATL6kUR6z23MC2dgy7oeZH6Bm6WwlTeBGuxa2FjOI5UIGUYd+HdYlS
         E1cQ==
X-Gm-Message-State: AOJu0Yw6M9ZgT+/gr22nR/v0tiKvlHfHgg6JqbmhVw68iv/bDn5q7H5x
	O3ZdD+4d8cWIDoqxnus51xXov2EYlSX49rkLNPZR9RvSI0g7si5Zx1SMAlDIh0stZMlMKK3g8A9
	ojFfvicIEy7RylTvdYr+IRQzwkyBftw==
X-Gm-Gg: AZuq6aK+lbrBQAjp29ZUS0Q9G4SoDoYkmvzrMLkAhRLUQzYjMdvi42vhfZxbNru480W
	L/RQMKpm5JvAabN97xv1YgXepXZLJSQnckc5haOJqw1UuT0VtsF0sogPisL3GsY/5n92e06KekT
	azKPxW7BBvGTljlnYScHbGP1AKjzUbknVV+B+WEr1BdYjyGXDdKK7A2qYRUeNjTTBpUjkZQ18HC
	f4j4P394bIUwKBvIiaBqPv5xE+eoKvONV+qO+jTq62MnINZx1KV8rMaVjnwtHp2mJqwsVLYieUw
	C+abfwwyplm0oSa5CS6bm4YRrkY8dxUx40a7QHlJ8GE/ylm3SLlZ2501wsDiit3s2W3C
X-Received: by 2002:a05:6402:5113:b0:658:dbf:d1a0 with SMTP id
 4fb4d7f45d1cf-659841a2f31mr1582224a12.30.1770390372219; Fri, 06 Feb 2026
 07:06:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com> <12530de6d1907afb44be3e76e7668b935f1fd441.1763725387.git.asml.silence@gmail.com>
In-Reply-To: <12530de6d1907afb44be3e76e7668b935f1fd441.1763725387.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 6 Feb 2026 20:35:34 +0530
X-Gm-Features: AZwV_QhZUfBhtu2huNeoyo9GkYijd3hbyMiyHPwiXwArHA1o3azl0x64XYjc0yI
Message-ID: <CACzX3AuNL0g_VvxMSbUu185rvn97+NpZqOVj246-9q9hAVPa9g@mail.gmail.com>
Subject: Re: [RFC v2 04/11] block: introduce dma token backed bio type
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"

> @@ -328,6 +328,29 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>         unsigned nsegs = 0, bytes = 0, gaps = 0;
>         struct bvec_iter iter;
>
> +       if (bio_flagged(bio, BIO_DMA_TOKEN)) {
> +               int offset = offset_in_page(bio->bi_iter.bi_bvec_done);
> +
> +               nsegs = ALIGN(bio->bi_iter.bi_size + offset, PAGE_SIZE);
> +               nsegs >>= PAGE_SHIFT;
> +
> +               if (offset & lim->dma_alignment || bytes & len_align_mask)
> +                       return -EINVAL;

bytes == 0 is a dead check here. Probably you would like to check the
length of the first and last segment to match with what the normal path
below is doing.
