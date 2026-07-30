Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80A519A2A3
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391636; cv=none; b=tmb1UnVNY+onoeQfg1xJhLbkWOqbMYmnIchntYT6DFFKSNVK539teOw8LnavlCNhyd19B/srfxp4t4dgnMPzdxSZvz0PIopAv2VoK9EHPv0dikYUZRceyc5BAmY59QTlksSdNeNOcYY3e9Vct1xPDs2KFLegfN5HvDaKS0QkB/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391636; c=relaxed/simple;
	bh=7u1tI2m7lcLDnGBpfQgEhdYDLbyqI8J4Vsm/cOlYw0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUSnCxHx4c2IhwGhi57XOqyRtiQCQ4aPvjhzCTeAl9wY1F6205uQgo0tCLAhs+N2JBw2S1cj8ZNgrGCnvr3SGsujBKbGhMr3S5xTTWxOBLoC3MGIrMuOhV8m5pWf165dkELTxQcV4xtVMTkyXe+QhZUKXKkFA9ZnGHQ7iLsKnVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBkhEWJy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBkhEWJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76581F000E9;
	Thu, 30 Jul 2026 06:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785391635;
	bh=QjssBAKLMfGB+qa0WNecWgiCGDl+JvQdlPRIS6jwGk0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QBkhEWJyxvLa/fPnhgcsVc3rJuzwHtZYC29C+tw3yAa4SEVwfmlfrZ5Zjc2HPRW8N
	 AqFSfDVeZnvLxHyIomCbC2CvPX/jidpedrsLH3xVljopybxymt7XFI9k22alWlUeda
	 uD5S+AdIwLvUMMVjI18Y1s/muYrJk9WNcs8ViHWPnlJcbNGorcSyELTyR140fH17qI
	 WdU7QVh7aYDnRjbbIsDsl2/GGLZn0A5mUWs2oNT04cxVq4ST2lSyzsV6gxFtKOOlD+
	 ZSNjlxHn26zAqNwsYzYjK1HHot758RBmln/JFTtPvkx7n/TBICNa10SGihTq3FR3Dk
	 KrJbr4cabS7BQ==
Message-ID: <4f18395a-7ff1-4a9a-8aef-4790d0cd8944@kernel.org>
Date: Thu, 30 Jul 2026 15:07:13 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zloop: zero out only the unread tail of short reads
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>
References: <20260730055832.1826093-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260730055832.1826093-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/07/30 14:58, Shin'ichiro Kawasaki wrote:
> zloop_complete_rq() handles a short read from a zone's backing file by
> zero-filling every bio in the request. This is correct when the entire
> request is beyond the written part of the zone. When a read request
> straddles the boundary between written and unwritten data, read_iter()
> returns a partial byte count and zloop then zeroes the whole request
> even for the partially read area with valid data.
> 
> Such an unexpected zero data read was observed with fio test script
> t/zbd/test-zbd-support and its test case 69, failing with "bad magic
> header 0".
> 
> Avoid the unexpected zero data read by zeroing out only the unread tail
> part. When read data size cmd->ret is smaller than the request size,
> call the new helper function zloop_fill_zero_rq() that walks through
> each bio_vec and fills zeros from the specified start offset.
> 
> Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> The fio test case 69 of t/zbd/test-zbd-support started failing since the
> recent kernel commit 9cbbac29d752 ("block: Remove redundant plug in
> __submit_bio()"). My understanding is that this commit in block layer
> changed request merge behavior, and unveiled the bug in zloop.
> 
>  drivers/block/zloop.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
> index 55eeb6aac0ea..42967e7aea58 100644
> --- a/drivers/block/zloop.c
> +++ b/drivers/block/zloop.c
> @@ -798,6 +798,26 @@ static void zloop_cmd_workfn(struct work_struct *work)
>  	current->flags = orig_flags;
>  }
>  
> +static void zloop_fill_zero_rq(struct request *rq, unsigned int zero_from)
> +{
> +	struct req_iterator iter;
> +	struct bio_vec bv;
> +	unsigned int pos = 0;
> +	unsigned int end, off;
> +
> +	rq_for_each_segment(bv, rq, iter) {
> +		end = pos + bv.bv_len;
> +		if (end > zero_from) {
> +			off = 0;
> +			if (pos < zero_from)
> +				off = zero_from - pos;

Maybe write this as:

			if (pos < zero_from)
				off = zero_from - pos;
			else
				off = 0;

> +			memzero_page(bv.bv_page, bv.bv_offset + off,
> +				     bv.bv_len - off);
> +		}
> +		pos = end;
> +	}
> +}
> +
>  static void zloop_complete_rq(struct request *rq)
>  {
>  	struct zloop_cmd *cmd = blk_mq_rq_to_pdu(rq);
> @@ -812,13 +832,9 @@ static void zloop_complete_rq(struct request *rq)
>  			pr_err("Zone %u: failed read sector %llu, %llu sectors\n",
>  			       zone_no, cmd->sector, cmd->nr_sectors);
>  
> -		if (cmd->ret >= 0 && cmd->ret != blk_rq_bytes(rq)) {
> -			/* short read */
> -			struct bio *bio;
> -
> -			__rq_for_each_bio(bio, rq)
> -				zero_fill_bio(bio);
> -		}
> +		/* Short read. Zero out the unread tail beyond cmd->ret. */
> +		if (cmd->ret >= 0 && cmd->ret != blk_rq_bytes(rq))
> +			zloop_fill_zero_rq(rq, cmd->ret);
>  		break;
>  	case REQ_OP_WRITE:
>  	case REQ_OP_ZONE_APPEND:


-- 
Damien Le Moal
Western Digital Research
