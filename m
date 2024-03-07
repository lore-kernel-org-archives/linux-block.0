Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534EE20B38
	for <linux-block@vger.kernel.org>; Thu,  7 Mar 2024 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847196; cv=none; b=bVmFuAmPrCtLZ+aP2N/kzktS3qtkkov2kanhsxizOpaCeoQAPH37Uap/4rtVqmgKYYyJheM+PQ2mO72jS5eFFeQ5nRUz79UsXCAhVBRlzNR1+O4tgnadsfH0lDOWhPpQf5nirTPsA5yGsu6KYvxzvzZR3vKGQhI5lepuXBelW2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847196; c=relaxed/simple;
	bh=OrH49QyuJiSLD8wpZ+NEcJdciRsA7upByfcAV0KkM/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ld6DYBrkUblsHHi+DCBJ/U89v6nVFviryL2mdrQ6vFB6KI8oJ1TtXKbuEqQpq6R574weLX0DFFOlAc9I/J3WfqtDveAEOZaVQnfs5cgpUhLdvnLqBNJLh9gEQL4Gfq4dmh66dKXCSi8psAq7jmWNpCOFXkTZ1AF3/FndHLnyJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=nFcLEjSX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="nFcLEjSX"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e66a3d492fso133737b3a.2
        for <linux-block@vger.kernel.org>; Thu, 07 Mar 2024 13:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709847192; x=1710451992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6KcRdxUsnfY4lrURoaAoZmnUMAtid4aFLe7flA5XXZs=;
        b=nFcLEjSXyx+UieSDDc5PWCamyqPOXRYORs/6SbIuZHbMXcOc8H591ZF0Fy6YCejLSy
         JICxWjM3MuvAjJjZS+8gexMGMj/tJBqBl7XHp0STJ9h/qa+sFtV9ytYxa/84nzHndkzQ
         tzFdqf43gvxeR6BjIbuXuHKVXfaxMc3QUEzmVuZ3Od42xmGc1PMXjTfK2ofukk5QsFpU
         T2E/42CfufcVI2Nn3aXlbSqqJAihC9Nc1W9z+A+2E1bAJ999EfDFqwRJAqzoX164pSeR
         ulYWwNWFWmG8haoH7qz6LXzTA0Sq2R35EbkkzFJ7QmUMlKd6Zzbsjtr8l9BEyGaUAZsI
         Y2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709847192; x=1710451992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KcRdxUsnfY4lrURoaAoZmnUMAtid4aFLe7flA5XXZs=;
        b=VxkOQw6N5OwSUKlmcYG8i8HSXNNF7DhvdbOZPQYwL2mdQLowtw1I5UEBaVYEL9wjUt
         qJ3nPPT2+yNxOCvQjgxwgErCGkvbISialr27WOIpWLsmwkODlBKyVdg9TVEoDP0njHYl
         aX94LPNuVF1686eBaMhDoFBOMOqgEm1LNzuYN+7Pxzz0L8WbTn306qJnXyOzk+EKiALN
         Gsk35A2Hk6/75EYJFktrv1+/OMOlgEvz8MHgUJlVRqiPNJ0vcUC4x3gc6suir5p6u6aD
         IIwqy0faivZfJ1nqP9wlXvupMbSezb+n0ShYQSIlHZcJmjyafm8RRuLMfUgmS8OcypbX
         kfQw==
X-Forwarded-Encrypted: i=1; AJvYcCUalGkjEG7/bMnkStYjgMaqgBPYqBjGkI5OD6BlIfuwnwEmtTZOOuItgWxTlC0mJ/yuUVgkdG9EWtTZJJYE+YsmXNX74HPCCdu9iaA=
X-Gm-Message-State: AOJu0YwCeBk4RwpEza1XJOZfvYwlKTzjx0P+vzzwhoUeYhk+lGWApoDO
	S8ajLRh/IRDwP43B6csiqqlV7JfABWbh3h5ndFlwuKVymfgBGU//EWFDtVge3nJwBOLnpm0/UrQ
	H
X-Google-Smtp-Source: AGHT+IEIZ5Bq0gUkg8eGb8dSnjmcn/yxs210qHWqUuXnY0jZp8AuB4DTJR7s1nyb0ByOyBua3WrKtA==
X-Received: by 2002:a05:6a21:32aa:b0:1a1:77ed:5abc with SMTP id yt42-20020a056a2132aa00b001a177ed5abcmr2708513pzb.34.1709847192375;
        Thu, 07 Mar 2024 13:33:12 -0800 (PST)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id y9-20020a62f249000000b006e535bf8da4sm12845551pfl.57.2024.03.07.13.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 13:33:11 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1riLMS-00GQUj-1Z;
	Fri, 08 Mar 2024 08:33:08 +1100
Date: Fri, 8 Mar 2024 08:33:08 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/10] block: move discard checks into the ioctl handler
Message-ID: <ZeoylEeVMt2fXT2R@dread.disaster.area>
References: <20240307151157.466013-1-hch@lst.de>
 <20240307151157.466013-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307151157.466013-3-hch@lst.de>

On Thu, Mar 07, 2024 at 08:11:49AM -0700, Christoph Hellwig wrote:
> Most bio operations get basic sanity checking in submit_bio and anything
> more complicated than that is done in the callers.  Discards are a bit
> different from that in that a lot of checking is done in
> __blkdev_issue_discard, and the specific errnos for that are returned
> to userspace.  Move the checks that require specific errnos to the ioctl
> handler instead, and just leave the basic sanity checking in submit_bio
> for the other handlers.  This introduces two changes in behavior:
> 
>  1) the logical block size alignment check of the start and len is lost
>     for non-ioctl callers.
>     This matches what is done for other operations including reads and
>     writes.  We should probably verify this for all bios, but for now
>     make discards match the normal flow.
>  2) for non-ioctl callers all errors are reported on I/O completion now
>     instead of synchronously.  Callers in general mostly ignore or log
>     errors so this will actually simplify the code once cleaned up
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

OK.

> ---
>  block/blk-lib.c | 13 -------------
>  block/ioctl.c   | 13 +++++++++----
>  2 files changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index f873eb9a886f63..50923508a32466 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -59,19 +59,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
>  {
>  	struct bio *bio = *biop;
> -	sector_t bs_mask;
> -
> -	if (bdev_read_only(bdev))
> -		return -EPERM;
> -	if (!bdev_max_discard_sectors(bdev))
> -		return -EOPNOTSUPP;
> -
> -	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
> -	if ((sector | nr_sects) & bs_mask)
> -		return -EINVAL;
> -
> -	if (!nr_sects)
> -		return -EINVAL;
>  
>  	while (nr_sects) {
>  		sector_t req_sects =
> diff --git a/block/ioctl.c b/block/ioctl.c
> index de0cc0d215c633..1d5de0a890c5e8 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -95,6 +95,8 @@ static int compat_blkpg_ioctl(struct block_device *bdev,
>  static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
>  		unsigned long arg)
>  {
> +	sector_t bs_mask = (bdev_logical_block_size(bdev) >> SECTOR_SHIFT) - 1;
> +	sector_t sector, nr_sects;

This changes the alignment checks from a hard coded 512 byte sector
to the logical block size of the device. I don't see a problem with
this (it fixes a bug) but it should at least be mentioned in the
commit message.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
