Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F913A3ED;
	Fri,  3 Oct 2025 04:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465195; cv=none; b=LDaDtxPj/slutzq4PetfgCGiO+QoUkXkTa5iiMpYfrdmgDOrensYF1pjNMu6Ubb67/JrHqF9RMCgY0bEs1969cLIKZb0NbLUBEDAl64bCI164+JV/n0/xOYO91p+uv3xZgxbk9Q8v9YqjSTK5Qi+ix9y5tG3rpcwx135hgm7gBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465195; c=relaxed/simple;
	bh=tJF1eZNNuOE1+lkH9NxBrXzi38f2k9l7zWGgnC6Wnis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUxqONKBdv91QRTfL5F+os0anbCqWaDpG0vU1paY6rOrVB69+0F1SlKupmJUVykr7zBx4f17cY3vurUFF6HrqfnlRQWTKzUvjV5LQ7nv7a9Gh+eo8xqTwjmbdJWr0yJCDhuVUsnyUxM1p/Y+cnoLM8zuhbxPmPqRyfQi7Py6U5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxIpnjre; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxIpnjre"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F3DC4CEF5;
	Fri,  3 Oct 2025 04:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759465194;
	bh=tJF1eZNNuOE1+lkH9NxBrXzi38f2k9l7zWGgnC6Wnis=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TxIpnjre3Uz7q7thqMtcpFWf/u9n2iigg5OhhnpNobyZ2XkVmjiwCwGu120GuwQo9
	 X5TCk4CjfvukJXz1iA3Yn2Wc6VDjeUBa8EgptJidMHicSnLXaDQXwlPIfJOUudTeRY
	 JMURnn5Wj/TQYNwfKyWnEZHg5IhgpW17C4hsGEFiUx+VRsWX8cjJpW0OErwhqgGlo/
	 BYtab3RB6NGmtCj70hKJ7ACNoadtPrfARicBBLmVZHfydodxOoyt9p9XSYypsUrzA2
	 nj7Ax5ViQn0kqaGdf6VI3PNK8FqFCX8fXxIOpU0MgqLu7NTigwLS9D1PnZ2+doLcxg
	 lrJIz2tUkwjtA==
Message-ID: <b3a1cf17-a739-477c-acee-ac61a0d8e2a9@kernel.org>
Date: Fri, 3 Oct 2025 13:19:31 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] block/mq-deadline: adjust the timeout period of
 the per_prio->dispatch
To: chengkaitao <pilgrimtao@gmail.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 chengkaitao <chengkaitao@kylinos.cn>
References: <20250926023818.16223-1-pilgrimtao@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250926023818.16223-1-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 11:38, chengkaitao wrote:
> From: chengkaitao <chengkaitao@kylinos.cn>
> 
> Reference function started_after()
> Before modification:
> 	Timeout for dispatch{read}: 9.5s
> 	started_after - 0.5s < latest_start - 10s
> 	9.5s < latest_start - started_after
> 
> 	Timeout for dispatch{write}: 5s
> 	started_after - 5s < latest_start - 10s
> 	5s < latest_start - started_after
> 
> At this point, write requests have higher priority than read requests.
> 
> After modification:
> 	Timeout for dispatch{read/write}: 5s
> 	prio_aging_expire / 2 < latest_start - started_after
> 
> Signed-off-by: chengkaitao <chengkaitao@kylinos.cn>

Also please write your name correctly here, separating first and last names with
a capital first letter for each (unless of course if this is your only
name/firstname, but still missing the capital letter).

> ---
>  block/mq-deadline.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index b9b7cdf1d3c9..f311168f8dfe 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -672,7 +672,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	if (flags & BLK_MQ_INSERT_AT_HEAD) {
>  		list_add(&rq->queuelist, &per_prio->dispatch);
> -		rq->fifo_time = jiffies;
> +		rq->fifo_time = jiffies + dd->fifo_expire[data_dir]
> +				- dd->prio_aging_expire / 2;
>  	} else {
>  		deadline_add_rq_rb(per_prio, rq);
>  


-- 
Damien Le Moal
Western Digital Research
