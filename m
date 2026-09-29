Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C733EB01;
	Tue, 29 Sep 2026 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682652; cv=none; b=Z7mAMz/8s6/QA+zYaNzgeKBSfE8auVMyRiQJWSRautNsJ6Mp+LIDF7LzfylBpt/Fse0xM+GqkoqMo8JsM/+EoPzKfLCeIBZIkrfqK4dY7NMRuRFvWaheBMIyvBK/JUpdwL7OYCQvD/8K9GTyY8zCkweFhRm0hNvhbjIU0lg0rLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682652; c=relaxed/simple;
	bh=HaNsiVNKubstmF8CH9ZhGViUbpvtMFcHdIt3mzeyAjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhWTu7P8aDlH9lixB/DScnD0awSmBjAaPDbKrvHIm4JiWSPrr11glKHUeJDLdD6/9XiuhpFJdS/gCGoyfhnxyNZaOl1GioXhqEbmKLP6sEqdLqUmxgeRjQz0/lsjVxJrrO8J8Mk6kGUaKNu9tz1YTfefmcYfQrJnZEvM+rzU+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGWo0Fum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGWo0Fum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0211F00893;
	Tue, 29 Sep 2026 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790682650;
	bh=bZ6CS82RsS8l09lcevntPYrLvDhywmDPJLM6pMJwFLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YGWo0FumpUS2dSk/kcS89s5J9yEC5/fnL/wsIx+OELgatbSpn6aZJSEOt0UtJxFET
	 O+s4aSpDadSpP1ixfCkmViXggiCVXU3DDBmaGFEGmicL8gThwoOw9SO00oy5QHUxMG
	 vR3UOTqanwp+/d1tnRHZ2SN3eRjAeVy9rz63ECWsLQJuvSunaIxYRy1KfcJ+YWOaQx
	 QHJsJ6SjADYnbcrZeoRgkDLQNCygbEtY8a9ENkdpV5zSbe3IkFyA+yIGlJTJp4fmBJ
	 oITLgHZNuSAZ/Q5fYYIdUsa/LSwXsBkacRwCPIYA1nDE+Oj3J8xGHKZfwCkyEbk1Ul
	 A3/FW1R/TUDUg==
Date: Tue, 29 Sep 2026 13:50:45 +0200
From: Niklas Cassel <cassel@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: set the zone write granularity
Message-ID: <arumFSTmHt3J0XRJ@ryzen>
References: <20260918140641.2031075-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918140641.2031075-2-cassel@kernel.org>

On Fri, Sep 18, 2026 at 04:06:42PM +0200, Niklas Cassel wrote:
> virtblk_read_zoned_limits() reads the write granularity that the device
> reports in virtio_blk_zoned_characteristics and assigns it to the
> physical block size and to io_min, but never to the limit that is named
> after it. queue_limits.zone_write_granularity is left at zero, so
> blk_validate_zoned_limits() raises it to the logical block size:
> 
> 	if (lim->zone_write_granularity < lim->logical_block_size)
> 		lim->zone_write_granularity = lim->logical_block_size;
> 
> A device that reports a granularity coarser than its logical block size,
> which is what the field exists to express, therefore has it silently
> reduced. A 512e host managed disk passed through to a guest reports a
> logical block size of 512 and a write granularity of 4096, and the guest
> ends up with a zone write granularity of 512.
> 
> bio_split_alignment() returns lim->zone_write_granularity if it is non-zero
> and bio_split_io_at() may split a bio with as per bio_split_alignment().
> This can real to the write getting rejected by the host drive, as the write
> is not aligned to the physical block size.
> 
> zonefs also takes its block size from bdev_zone_write_granularity(), so it
> would incorrectly use 512 on a disk that requires 4096.
> 
> sd_zbc_read_zones() sets the limit from the physical block size for the
> same reason. NVMe ZNS and null_blk leave it unset, but the fallback
> gives the right answer for them, as their write granularity is the
> logical block size. virtio carries a separate value that may exceed it.
> 
> Set the zone write granularity from the value that the device reports.
> 
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/block/virtio_blk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..c8bfbf8435ac 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -743,6 +743,7 @@ static int virtblk_read_zoned_limits(struct virtio_blk *vblk,
>  		dev_warn(&vdev->dev, "zero write granularity reported\n");
>  		return -ENODEV;
>  	}
> +	lim->zone_write_granularity = wg;
>  	lim->physical_block_size = wg;
>  	lim->io_min = wg;
>  
> 
> base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
> -- 
> 2.55.0
> 

Gentle ping
