Received: from mta0.migadu.com (out-34.mta0.migadu.com [91.218.175.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF863B6C06
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586416; cv=none; b=dgBHdy/IkR6ZMEaQSrBHTfzoiNyh5TXZVJ4+o35jxf65d2rzpurYIUq0tHi+a7ZDCw6beYPbUWlJjbsl1JWiAzCLzmXNfvsBxxoeaWkC3TDKf+caGYWn3h9C1vEo6wtrKJbwtb1+yfFzK0HvxzQZ9PuLvQ5XmsBP/m8UW0sKvO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586416; c=relaxed/simple;
	bh=m15aHFZctFALytF5O1vtiK/owJ/shsf42TavoFDg7P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5l7cr3FZPVFa81VZhvyJUVtEXPLu0bnA8k2Qn7X+lu9X6xuWIeC0F1N7elBu0nJJTBru/wCs//6ksgMA0KnlhE277vT68a5/5xixrqTjrfzEqRVSFR2/oyikXrPkGHyAws1OhYGC3zMEMIcPkVlHL8E6iNJgtt+a0NmzY0T8YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BIAvOZP6; arc=none smtp.client-ip=91.218.175.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BIAvOZP6"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=m15aHFZctFALytF5O1vtiK/owJ/shsf42TavoFDg7P8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789586401; v=1; x=1790191201;
 b=BIAvOZP6tPxCH91brQY8P+Rc5SiOvOaI+KsgoEur2qQzNmvFdXuK/sFzGqD1zcCd2/bHngBb
 vi7RL6lj0WAwvK0JSt3Wl3ZOu+CYsyFuW3kQTBLUxcUvvDU0H+EZyawHZGkAXqzZpd77uZwmtJ9
 +BkINbxo/C1yGt9uq2OKoiNI=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 16ce70b1551d4654;
	Wed, 16 Sep 2026 19:20:00 +0000
X-Mizu-Trace-ID: 16ce70b1551d4654
X-Migadu-Flow: FLOW_OUT
Message-ID: <18a634dd-35fc-4f33-a7c2-4c72d210b0bb@linux.dev>
Date: Wed, 16 Sep 2026 20:19:58 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: check passthrough state before reusing cached
 requests
To: huhai <15815827059@163.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, Henry Hu <huhai@kylinos.cn>
References: <20260916151655.2588-1-15815827059@163.com>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260916151655.2588-1-15815827059@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 16:16, huhai wrote:
> From: Henry Hu <huhai@kylinos.cn>
> 
> blk_mq_alloc_request() and blk_mq_submit_bio() share plug->cached_rqs,
> but neither lookup checks the passthrough state. This allows an io_uring
> batch to reuse a cached NVMe passthrough request for an ordinary bio.
> 
> When an I/O scheduler is enabled, passthrough requests have RQF_SCHED_TAGS
> set but RQF_USE_SCHED clear, and skip ->prepare_request(). Reuse updates
> rq->cmd_flags without reinitializing the scheduler state, so the request
> is inserted into the scheduler on plug flush, while completion skips
> ->finish_request(). With kyber, this leaks the domain token acquired at
> dispatch and can stall further I/O in that domain.
> 
> This was reproduced with kyber and request merging disabled on a QEMU
> NVMe device by submitting a passthrough read followed by O_DIRECT writes
> in one io_uring batch. Tokens leak until the kyber write-domain token pool
> is exhausted, blocking ext4 journal I/O and fsync():
> 
>    INFO: task jbd2/nvme0n1-8:97 blocked in I/O wait for more than 241 seconds.
>      Call Trace:
>        schedule+0xe9/0x300
>        io_schedule+0xca/0x150
>        bit_wait_io+0x1b/0x140
>        __wait_on_bit+0x63/0x170
>        jbd2_write_superblock+0x3d7/0x600
>        jbd2_journal_update_sb_log_tail+0x1e3/0x2d0
>        jbd2_journal_commit_transaction+0x11d1/0x5b50
> 
>    INFO: task fsynctest:107 blocked in I/O wait for more than 241 seconds.
>      Call Trace:
>        schedule+0xe9/0x300
>        io_schedule+0xca/0x150
>        folio_wait_bit_common+0x2ed/0x780
>        folio_wait_bit+0x18/0x30
>        folio_wait_writeback+0x4b/0x1e0
>        __filemap_fdatawait_range+0x120/0x1e0
>        file_write_and_wait_range+0xeb/0x130
>        ext4_sync_file+0x368/0xa80
>        do_fsync+0xa2/0x200
> 
> Require the passthrough state to match before reusing a cached request.
> With the fix, the workload completes normally.
> 
> Assisted-by: LLM
> Signed-off-by: Henry Hu <huhai@kylinos.cn>
> ---
>   block/blk-mq.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a26a11c73ee3..3a9d57f6a569 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -648,6 +648,8 @@ static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
>   			return NULL;
>   		if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
>   			return NULL;
> +		if (blk_rq_is_passthrough(rq) != blk_op_is_passthrough(opf))
> +			return NULL;
>   
>   		rq_list_pop(&plug->cached_rqs);
>   		blk_mq_rq_time_init(rq, blk_time_get_ns());
> @@ -3062,6 +3064,8 @@ static struct request *blk_mq_get_cached_request(struct blk_plug *plug,
>   		return NULL;
>   	if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
>   		return NULL;
> +	if (blk_rq_is_passthrough(rq) != blk_op_is_passthrough(opf))
> +		return NULL;

It seems like some code which code be factored out (between 
blk_mq_alloc_cached_request() and blk_mq_get_cached_request()).

And maybe 7746564793978fe2f43b18a302b22dca0ad3a0e8 could to be repeated 
for blk_mq_alloc_cached_request(), which could mean even more factoring out.

>   	rq_list_pop(&plug->cached_rqs);
>   	return rq;
>   }

