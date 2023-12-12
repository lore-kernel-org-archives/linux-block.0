Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B457A59B69
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jto1gchC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77882C433C7;
	Tue, 12 Dec 2023 10:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702375722;
	bh=sSQJLQCrL/cuj7UGaYU0dq6iYmOj2WOrtIa01kn3TYM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jto1gchCVyzS8tupIiFgg1Zf7DllL0prl/wSqsdkDQ0aHaTeNYS3Z3a9VdMbhe/bm
	 Lm9eMNNUOfQeNJxlenPsYrGbpeGfIuwUM5ddT3V2Yoh35T0Xs6CcUtsNlAlZNPWSTO
	 kZsfoA2+Q/TmTYn1HeoIaGTvuXWSsR4RNhUr+9QL1P5HA+oh7MqfsmQOiw3v8cqsT0
	 GIHZsKSywMjkLfVxuyBlDDVNMhLAT7wFXnqUjawip6gN0RL3hcpI1d3driiyg8/1/b
	 W7IJIy9ttzM8Jg1BJ9DTmHvJxVOFMxhcDqfDhYVHGvBfpHUtN0Kh1tRhCjtLIjlLuH
	 shLgv07et0jnQ==
Message-ID: <eeed963d-2002-43b4-b07d-12cbca3ea149@kernel.org>
Date: Tue, 12 Dec 2023 19:08:39 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/blk-ioprio: Skip zoned writes that are not append
 operations
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20231211231451.1452979-1-bvanassche@acm.org>
 <19eaaa5b-e4b7-41aa-b5a2-7d5a89927a91@kernel.org>
 <d660cc31-a5be-47f2-9fdf-ba4bf5106226@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <d660cc31-a5be-47f2-9fdf-ba4bf5106226@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/23 09:11, Bart Van Assche wrote:
> On 12/11/23 15:31, Damien Le Moal wrote:
>> On 12/12/23 08:14, Bart Van Assche wrote:
>>> +	/*
>>> +	 * If REQ_OP_WRITE or REQ_OP_WRITE_ZEROES operations for the same zone
>>> +	 * originate from different cgroups that could result in different
>>> +	 * priorities being assigned to these operations. Do not modify the I/O
>>> +	 * priority of these write operations to prevent that these would be
>>> +	 * executed in the wrong order when using the mq-deadline I/O
>>> +	 * scheduler.
>>> +	 */
>>> +	if (bdev_op_is_zoned_write(bio->bi_bdev, bio_op(bio)))
>>
>> Ideally, we want the bio equivalent of blk_rq_is_seq_zoned_write() here so that
>> writes to conventional zones are not affected (these can be reordered).
>   How about the patch below?
> 
> Thanks,
> 
> Bart.
> 
> 
> [PATCH] block/blk-ioprio: Skip zoned writes that are not append operations
> 
> If REQ_OP_WRITE or REQ_OP_WRITE_ZEROES operations for the same zone
> originate from different cgroups that could result in different priorities
> being assigned to these operations. Do not modify the I/O priority of
> these write operations to prevent them from being executed in the wrong
> order when using the mq-deadline I/O scheduler.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-ioprio.c     | 11 +++++++++++
>   include/linux/blk-mq.h | 17 +++++++++++++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
> index 4051fada01f1..96b46d34e3d6 100644
> --- a/block/blk-ioprio.c
> +++ b/block/blk-ioprio.c
> @@ -192,6 +192,17 @@ void blkcg_set_ioprio(struct bio *bio)
>   	if (!blkcg || blkcg->prio_policy == POLICY_NO_CHANGE)
>   		return;
> 
> +	/*
> +	 * If REQ_OP_WRITE or REQ_OP_WRITE_ZEROES operations for the same zone
> +	 * originate from different cgroups that could result in different
> +	 * priorities being assigned to these operations. Do not modify the I/O
> +	 * priority of these write operations to prevent that these would be
> +	 * executed in the wrong order when using the mq-deadline I/O
> +	 * scheduler.
> +	 */
> +	if (blk_bio_is_seq_zoned_write(bio))
> +		return;
> +
>   	if (blkcg->prio_policy == POLICY_PROMOTE_TO_RT ||
>   	    blkcg->prio_policy == POLICY_NONE_TO_RT) {
>   		/*
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 1ab3081c82ed..90907d9001c0 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -1149,6 +1149,18 @@ static inline unsigned int blk_rq_zone_no(struct request *rq)
>   	return disk_zone_no(rq->q->disk, blk_rq_pos(rq));
>   }
> 
> +/**
> + * blk_bio_is_seq_zoned_write() - Check if @bio requires write serialization.
> + * @bio: Bio to examine.
> + *
> + * Note: REQ_OP_ZONE_APPEND bios do not require serialization.
> + */
> +static inline bool blk_bio_is_seq_zoned_write(struct bio *bio)
> +{
> +	return op_needs_zoned_write_locking(bio_op(bio)) &&
> +		disk_zone_is_seq(bio->bi_disk, bio.bi_iter.bi_sector);

Given that disk_zone_is_seq() always return false for regular devices, I think
reversing the test order is better:

	return disk_zone_is_seq(bio->bi_disk, bio.bi_iter.bi_sector) &&
	       op_needs_zoned_write_locking(bio_op(bio));

> +}
> +
>   static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
>   {
>   	return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
> @@ -1196,6 +1208,11 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
>   	return !blk_req_zone_is_write_locked(rq);
>   }
>   #else /* CONFIG_BLK_DEV_ZONED */
> +static inline bool blk_bio_is_seq_zoned_write(struct bio *bio)
> +{
> +	return false;
> +}
> +
>   static inline bool blk_rq_is_seq_zoned_write(struct request *rq)
>   {
>   	return false;
> 

-- 
Damien Le Moal
Western Digital Research

