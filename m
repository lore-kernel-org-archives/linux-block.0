Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B24D26A
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 04:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770949; cv=none; b=C1EzMyCUZUR+SARxb1M+ojwzJ2UYNWtkzM0ZrfcuKfuJB+b7KSeUdJbZfD0Xg3BA9yvu5xQ5Byj5mfurc60e3RQaQTy5FPkH+ZB01XgIMSi7j9aK6mLTYGVSBCndv1g9lwQvMFN1lTt/dUgui5umITA3iqqDbRfKFZfBhzQXBcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770949; c=relaxed/simple;
	bh=DhwKPoOSo163SnqnkqzJWhjtsajyjUEal/3Tk5wXDOI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o+dRi2v2ecdNQdBaJyQE5z0ngFLw1QjWLqNDrN8WOV6mDZBROgDWM97avHlHiMKTUah+hKAWd1Do933RlLraVngQjKX8vQsT2r2A+7SPrI+HoCz2L/uhoTUrYXxZAZRNYBl0hiZJcueN4YqTYxFfaeggZ1WuVI+3cLQFx4epT0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnBpzy99; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnBpzy99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD0FC2BBFC;
	Wed, 19 Jun 2024 04:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718770949;
	bh=DhwKPoOSo163SnqnkqzJWhjtsajyjUEal/3Tk5wXDOI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=SnBpzy99r/obHkX4boUncnYwy5hVMns6rc9cS+BOiAPhf3+6Ptid3JtDxr/+tGBbl
	 IxgaC8LBkN+Wki53Hf3eWfDVbFL0JFDphgguh1nO5o1XeT6OUJ6/Kauwco2cyBdtXZ
	 3ybw6cXE2Yi3qSeR62aPlq/gsYF1BKrS4QrUFhJWMHAfrgzUDPh7jgHXBni4sVWYyc
	 rnMYaNNsYhoimnSe/ISGIL32NrmBXH081o15uANbOBpIvs3tncB8jG6p5Sr4/uxWb4
	 koUa49BUikQ2L5FzKg2yv6OyTIW4l73no+dz4CPCSE6SwwUozWhYft9cgqCTi1MQym
	 SUxn6Tttp34BQ==
Message-ID: <355cc36f-e771-4f00-bfb0-0095674d5d49@kernel.org>
Date: Wed, 19 Jun 2024 13:22:27 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: check bio alignment in blk_mq_submit_bio
From: Damien Le Moal <dlemoal@kernel.org>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@infradead.org>,
 Ye Bin <yebin10@huawei.com>
References: <20240619033443.3017568-1-ming.lei@redhat.com>
 <7ed12f7e-f59a-4f6f-975b-ce7bb21652de@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <7ed12f7e-f59a-4f6f-975b-ce7bb21652de@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 13:14, Damien Le Moal wrote:
> On 6/19/24 12:34, Ming Lei wrote:
>> IO logical block size is one fundamental queue limit, and every IO has
>> to be aligned with logical block size because our bio split can't deal
>> with unaligned bio.
>>
>> The check has to be done with queue usage counter grabbed because device
>> reconfiguration may change logical block size, and we can prevent the
>> reconfiguration from happening by holding queue usage counter.
>>
>> logical_block_size stays in the 1st cache line of queue_limits, and this
>> cache line is always fetched in fast path via bio_may_exceed_limits(),
>> so IO perf won't be affected by this check.
>>
>> Cc: Yi Zhang <yi.zhang@redhat.com>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> Cc: Ye Bin <yebin10@huawei.com>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
>>  block/blk-mq.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 3b4df8e5ac9e..7bb50b6b9567 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2914,6 +2914,21 @@ static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
>>  	INIT_LIST_HEAD(&rq->queuelist);
>>  }
>>  
>> +static bool bio_unaligned(const struct bio *bio,
>> +		const struct request_queue *q)
>> +{
>> +	unsigned int bs = queue_logical_block_size(q);
>> +
>> +	if (bio->bi_iter.bi_size & (bs - 1))
>> +		return true;
>> +
>> +	if (bio->bi_iter.bi_size &&
>> +	    ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & (bs - 1)))
> 
> Hmmm... Some BIO operations have a 0 size but do specify a sector (e.g. zone
> management operations). So this seems incorrect to me...

I meant to say, why not checking the sector alignment for these BIOs as well ?
Something like:

static bool bio_unaligned(const struct bio *bio,
		          const struct request_queue *q)
{
	unsigned int bs_mask = queue_logical_block_size(q) - 1;

	return (bio->bi_iter.bi_size & bs_mask) ||
		((bio->bi_iter.bi_sector << SECTOR_SHIFT) & bs_mask);
}

> 
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>>  /**
>>   * blk_mq_submit_bio - Create and send a request to block device.
>>   * @bio: Bio pointer.
>> @@ -2966,6 +2981,15 @@ void blk_mq_submit_bio(struct bio *bio)
>>  			return;
>>  	}
>>  
>> +	/*
>> +	 * Device reconfiguration may change logical block size, so alignment
>> +	 * check has to be done with queue usage counter held
>> +	 */
>> +	if (unlikely(bio_unaligned(bio, q))) {
>> +		bio_io_error(bio);
>> +		goto queue_exit;
>> +	}
>> +
>>  	if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
>>  		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
>>  		if (!bio)
> 

-- 
Damien Le Moal
Western Digital Research

