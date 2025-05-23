Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D347DA8C;
	Fri, 23 May 2025 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747988441; cv=none; b=MNN06ZQbXT9CNs2k2kzlDs7QwAxX2Ew/Bbc9tpZox+nl9YqgS7HAD/0+J6F7N1OaJHLkePvc4z92v7ZT2wWIY9JRi2Q8L9rRdvP7/S1xxisH6cpXiUA0eVjRGF1z6o46uQtH261wKYWCEyz1h/lR+2Dn+O9WbcnY9mt2Gc6dBqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747988441; c=relaxed/simple;
	bh=2Z+oK0NC384/cMyU4kwwzxiYRTQjSPCa2Zj/TUCYLYA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ExYAbaepSEt5LFA3dRRuisff7ne//9UpjYRT8shRSBpFeSpjvhXaADTTpkNkkJ7r4WRAT5MSLpZGGTZs0ka//taLXJHcpvLhJP99hnzmeCUPARnwSGiKOUVeFVYDBgQAYvc54W+lHFyPTD3y12iWI7PjO4sxFZbBPF9uO2SG1Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sV6tJvKi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sV6tJvKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1D1C4CEE9;
	Fri, 23 May 2025 08:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747988441;
	bh=2Z+oK0NC384/cMyU4kwwzxiYRTQjSPCa2Zj/TUCYLYA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=sV6tJvKi3Dcqr13xLN/GB7vUCINFQVQT+r4nbbx/LcytLWcmLIj/9cfGrHqxaD5+D
	 OE8MO4GDBTaC0kYIcCN2uWekqSSZnDPtC9r9R14l9p7E01CmOljgcxi3dpXRNjF2vm
	 yC4h7QBfX55u9EiqQxKe8manPbneQzgqJ4kh6zqy3vsOpq2qdeQopQ39LPYJTqigF+
	 w5GDlAA6cZJFXyV06StkMp8e5XvIyQ7/dKURG23H3vlqmivRpOeEILoYoqBHaIHguY
	 Zs5yTvmCt0x7LYHby+WuivTEBtqzrciG/ymR+iU1UIcVxCg3BsGFGOe01D/LFcW1Se
	 t44xkUZDIotBg==
Message-ID: <7fd56f2c-a769-4e9e-8168-6896b647087a@kernel.org>
Date: Fri, 23 May 2025 10:20:35 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a deadlock related freezing zoned storage
 devices
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
 stable@vger.kernel.org
References: <20250522171405.3239141-1-bvanassche@acm.org>
 <b1ea4120-e16a-47c8-b10c-ff6c9d5feb69@kernel.dk>
 <3cd139d0-5fe0-4ce1-b7a7-36da4fad6eff@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <3cd139d0-5fe0-4ce1-b7a7-36da4fad6eff@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/25 10:10, Damien Le Moal wrote:
> What about this patch, completely untested...
> 
>  diff --git a/block/blk-core.c b/block/blk-core.c
> index e8cc270a453f..3d2dec088a54 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -621,6 +621,32 @@ static inline blk_status_t blk_check_zone_append(struct
> request_queue *q,
>         return BLK_STS_OK;
>  }
> 
> +static inline void disk_submit_bio(struct bio *bio)
> +{
> +       struct gendisk *disk = bio->bi_bdev->bd_disk;
> +       bool need_queue_enter = !bio_zone_write_plugging(bio);
> +
> +       /*
> +        * BIOs that are issued from a zone write plug already hold a reference
> +        * on the device queue usage counter.
> +        */
> +       if (need_queue_enter) {
> +               if (unlikely(bio_queue_enter(bio)))
> +                       return;
> +       }
> +
> +       if ((bio->bi_opf & REQ_POLLED) &&
> +           !(disk->queue->limits.features & BLK_FEAT_POLL)) {
> +               bio->bi_status = BLK_STS_NOTSUPP;
> +               bio_endio(bio);
> +       } else {
> +               disk->fops->submit_bio(bio);
> +       }
> +
> +       if (need_queue_enter)
> +               blk_queue_exit(disk->queue);
> +}
> +
>  static void __submit_bio(struct bio *bio)
>  {
>         /* If plug is not used, add new plug here to cache nsecs time. */
> @@ -631,20 +657,10 @@ static void __submit_bio(struct bio *bio)
> 
>         blk_start_plug(&plug);
> 
> -       if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
> +       if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO))
>                 blk_mq_submit_bio(bio);
> -       } else if (likely(bio_queue_enter(bio) == 0)) {
> -               struct gendisk *disk = bio->bi_bdev->bd_disk;
> -
> -               if ((bio->bi_opf & REQ_POLLED) &&
> -                   !(disk->queue->limits.features & BLK_FEAT_POLL)) {
> -                       bio->bi_status = BLK_STS_NOTSUPP;
> -                       bio_endio(bio);
> -               } else {
> -                       disk->fops->submit_bio(bio);
> -               }
> -               blk_queue_exit(disk->queue);
> -       }
> +       else
> +               disk_submit_bio(bio)

Missing ";" here.
> 
>         blk_finish_plug(&plug);
>  }

Looking into this deeper, the regular mq path actually likely has the same issue
since it will call blk_queue_enter() if we do not have a cached request. So this
solution is only partial and not good enough. We need something else.

-- 
Damien Le Moal
Western Digital Research
