Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6044139CEF;
	Tue,  9 Jul 2024 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503563; cv=none; b=kAJqynR6Wurd6pOtVzMJmNF/TQHImaQ3p5XvLvYI8MfHhZ3v1dHU5QJGYKbfei1NrI0TCoXa0GPpcVFxw/FTx4+Ua2WmaXGGk3iYvbWXyAegZsirTO6tDePqdJvdM8tSHnI7/IqQ5Q1qy+UNgOpQYEcSNzFQ6lAz0k3WnpRCa5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503563; c=relaxed/simple;
	bh=jS9i7M/lCAvKduyEogFavlC2vGv3BHk0t6u08ojd/oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNvymiQVAxk/anSNS2GV8NkKI+A9YndpMMPeUhHYJ5/e3aA9UfWJtMtIPqtajjAcHeuPhlnlYGAdUJmyashkqdff0fsKgTFm3JVGUym4IxnxLDF+7sdTE3/9LdU+SqzrdHWAWdCOUnJGu12TEyH6n3F/UNzVx0i7uPn6+pNgq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwIN2la1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwIN2la1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC42C4AF07;
	Tue,  9 Jul 2024 05:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720503562;
	bh=jS9i7M/lCAvKduyEogFavlC2vGv3BHk0t6u08ojd/oI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hwIN2la12SALZ9mpuvjSgZhoOR1UqJEpoHH+6rCgvjMzsjYOREnPG8TEYwLJn1i/J
	 sRU3bec0TT+BUrRc5VhdEaO/t/wyHqZJu3FswJQ/yvvYRhIrPp9D82k+wdfNglIpSb
	 WvMCnEg5iGzYI3vB/+eS1cMrqpW2ipVLkr0mQVddJEyaiqc2ww5KWbk0qPehIM4mfe
	 e4Rk/IFdY+mkbsX96KWwNBdMVleA8ARpLGBAc3pRIW0S+XqW0lsD/txjmHo7hTPDfI
	 p3LQxGzQhRy6XvVhka7gguAq4Efduv89t0bUdx8PlONH7Lls2oO17qOCfsaAaRNEZv
	 s++ry3AqBlfKQ==
Message-ID: <3a2314b7-ab94-4cf4-80c1-9b3a971c3adb@kernel.org>
Date: Tue, 9 Jul 2024 14:39:20 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] virtio_blk: Don't bother validating blocksize
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com, hare@suse.de, kbusch@kernel.org,
 hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240708091651.177447-1-john.g.garry@oracle.com>
 <20240708091651.177447-5-john.g.garry@oracle.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240708091651.177447-5-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/24 18:16, John Garry wrote:
> The block queue limits validation does this for us now.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/block/virtio_blk.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index f11b0c3b2625..e3147a611151 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1289,18 +1289,9 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
>  	lim->max_segment_size = max_size;
>  
>  	/* Host can optionally specify the block size of the device */
> -	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
> +	virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
>  				   struct virtio_blk_config, blk_size,
>  				   &lim->logical_block_size);

I really wonder why this does not check that the VIRTIO_BLK_F_BLK_SIZE feature
exists... But that is not the fault of this patch :)

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> -	if (!err) {
> -		err = blk_validate_block_size(lim->logical_block_size);
> -		if (err) {
> -			dev_err(&vdev->dev,
> -				"virtio_blk: invalid block size: 0x%x\n",
> -				lim->logical_block_size);
> -			return err;
> -		}
> -	}
>  
>  	/* Use topology information if available */
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,

-- 
Damien Le Moal
Western Digital Research

