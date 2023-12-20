Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A716ECC
	for <linux-block@vger.kernel.org>; Wed, 20 Dec 2023 00:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/FahpO9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C37CC433C7;
	Wed, 20 Dec 2023 00:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703030741;
	bh=k+5XEeCRQz+hiMNIqkEHTYoHINFgxK5vBpUN0X8cXOs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J/FahpO9rk2pSoRyDiAEczOPCbA0wrcIgawvmdahx0MvVT4JC4uG2Lrfw1857psIe
	 465g9SNnD2r8WiFyvs9tT5vd774tpYl0kHVuveL4aC8mB/cntzRvRUShm1vcNPKbvq
	 SS8tX8Q5tDFVy78BB5xG9dGOojQxyk3uyWUA6AtyE5X2ojrjxlr+hmM+FGDTkUNRlg
	 nOF8wOJQmL4CqNEkkBYvxlPZcdUwIFkZ9DsiatgIUMy/bfqqVO+V0QmHvBRJwrdbYX
	 wtLlH80EDqXVt/duPWJEariUb42oLVae2uOPd5joef/RW44PzkGZgaSG1ui9Zsuw9E
	 sp58g72lSK/ag==
Message-ID: <6d2e8aaa-3e0e-4f8e-8295-0f74b65f23ae@kernel.org>
Date: Wed, 20 Dec 2023 09:05:38 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] block/mq-deadline: Prevent zoned write reordering
 due to I/O prioritization
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20231218211342.2179689-1-bvanassche@acm.org>
 <20231218211342.2179689-5-bvanassche@acm.org> <20231219121010.GA21240@lst.de>
 <54a920d3-08e3-4810-806d-2961110d876d@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <54a920d3-08e3-4810-806d-2961110d876d@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/23 02:42, Bart Van Assche wrote:
> On 12/19/23 04:10, Christoph Hellwig wrote:
>> On Mon, Dec 18, 2023 at 01:13:42PM -0800, Bart Van Assche wrote:
>>> Assigning I/O priorities with the ioprio cgroup policy may cause
>>> different I/O priorities to be assigned to write requests for the same
>>> zone. Prevent that this causes unaligned write errors by adding zoned
>>> writes for the same zone in the same priority queue as prior zoned
>>> writes.
>>
>> I still think this is fundamentally the wrong thing to do.  If you set
>> different priorities, you want I/O to be reordered, so ignoring that
>> is a bad thing.
> 
> Hi Christoph,
> 
> How about not setting the I/O priority of sequential zoned writes as in
> the (untested) patch below?
> 
> Thanks,
> 
> Bart.
> 
> 
> [PATCH] block: Do not set the I/O priority for sequential zoned writes
> 
> ---
>   block/blk-mq.c         |  7 +++++++
>   include/linux/blk-mq.h | 17 +++++++++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c11c97afa0bc..668888103a47 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2922,6 +2922,13 @@ static bool blk_mq_can_use_cached_rq(struct request *rq, struct blk_plug *plug,
> 
>   static void bio_set_ioprio(struct bio *bio)
>   {
> +	/*
> +	 * Do not set the I/O priority of sequential zoned write bios because
> +	 * this could lead to reordering and hence to unaligned write errors.
> +	 */
> +	if (blk_bio_is_seq_zoned_write(bio))
> +		return;

That is not acceptable as that will ignore priorities passed for async direct
IOs through aio->aio_reqprio. That one is a perfectly acceptable use case and we
should not ignore it.

> +
>   	/* Nobody set ioprio so far? Initialize it based on task's nice value */
>   	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
>   		bio->bi_ioprio = get_current_ioprio();
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 1ab3081c82ed..e7fa81170b7c 100644
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
> +	return disk_zone_is_seq(bio->bi_bdev->bd_disk, bio->bi_iter.bi_sector) &&
> +		op_needs_zoned_write_locking(bio_op(bio));
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

