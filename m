Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF2F2E1EFC;
	Fri, 19 Dec 2025 23:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766188555; cv=none; b=u7KhLIO02bMPW7QGsA5LRcJ/wIi+YmlSxSUu0+hzb0WysEi9SnBURtx7PtBqXpILafofHW39rnWHjutHHx4EZybq/vVbOVBpz1MphtxggxBZssy5radzp/vaXthITGxXK35tRGCBkQ0+nLOlzZVZoXB9obaoYeE0O6ZfJdEQRYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766188555; c=relaxed/simple;
	bh=xRiqoNCloIt1NwNyf4ZZjL3RF9nFy3Tqh+i+aDyWG0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUEzkNCwLu2jgplczgSU7mn3AkXr8E5dfXGO86OEjTPPr/XrCEIlAErddWnyTTxcpIX07LofYPHlYrp7LMGNzkpjVlppzfhPeYMaM7JCjBS8xe/j+hEnRdunjagBsOnLiGNdEB1lnaqJp+cJvckDsMLpH3xCpaGpzH8LoGYj14s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RguTA1Tn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RguTA1Tn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4C1C4CEF1;
	Fri, 19 Dec 2025 23:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766188554;
	bh=xRiqoNCloIt1NwNyf4ZZjL3RF9nFy3Tqh+i+aDyWG0Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RguTA1TnrVnN7wgsUutmoSSYiILFFTwQ5BByjscsu3UCC1O35DgvDqt0vbPeM8BT2
	 BsFrRPg1AkuezUVpwfZvc70RNzH/T+RBecaWOAggr9lWvRswBNrj2v6o5JgDz28ubR
	 uynBPxGtViq1AyNSdnE9ZotnraXoT6EZMIwyv+dYEBnjOQlu18/g5zqyRGZ9LyIH9B
	 TT3UdJQ1kpn0tPyWwNPuyYOdm64X0kM46q+/fdR2NouSaxe51qx4r2ATILPhHFuQLg
	 Jl7xBkhKOaJTtz3JbOr/axLCTchwBGsfSt+4s0yC3eZPX5PrPTyZtKRAMJcfT0zf8s
	 wosoOTzA+kMgw==
Message-ID: <bd88af0b-be00-4f1b-b089-6fce986e3cfe@kernel.org>
Date: Sat, 20 Dec 2025 08:55:51 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, johannes.thumshirn@wdc.com
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, martin.petersen@oracle.com,
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20251028173209.2859-1-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251028173209.2859-1-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 02:32, Chaitanya Kulkarni wrote:
> Add informational messages during blktrace setup when version 1 tools
> are used on kernels with CONFIG_BLK_DEV_ZONED enabled. This alerts users
> that REQ_OP_ZONE_* events will be dropped and suggests upgrading to
> blktrace tools version 2 or later.
> 
> The warning is printed once during trace setup to inform users about
> the limitation without spamming the logs during tracing operations.
> Version 2 blktrace tools properly handle zone management operations
> (zone reset, zone open, zone close, zone finish, zone append) that
> were added for zoned block devices.
> 
> Example output:
> 
> blktests (master) # ./check blktrace
> blktrace/001 (blktrace zone management command tracing)      [passed]
>     runtime  0.110s  ...  3.917s
> blktrace/002 (blktrace ftrace corruption with sysfs trace)   [passed]
>     runtime  0.333s  ...  0.608s
> blktests (master) # dmesg -c
> [   57.610592] blktrace: nullb0: blktrace events for REQ_OP_ZONE_XXX will be dropped
> [   57.610603] blktrace: use blktrace tools version >= 2 to track REQ_OP_ZONE_XXX
> 
> This helps users understand why zone operation traces may be missing
> when using older blktrace tool versions with modern kernels that
> support REQ_OP_ZONE_XXX in blktrace.
> 
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
> v1->v2 :-
> 
> Remove the extra () around IS_ENABLED(CONFIG_BLK_DEV_ZONED). (Jens)
> Add a space after device name in first pr_info(). (Jens)
> 
> ---
>  kernel/trace/blktrace.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index e4f26ddb7ee2..4a37d9aa0481 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -739,6 +739,12 @@ static void blk_trace_setup_finalize(struct request_queue *q,
>  	 */
>  	strreplace(buts->name, '/', '_');
>  
> +	if (version == 1 && IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +		pr_info("%s: blktrace events for REQ_OP_ZONE_XXX will be dropped\n",
> +				name);
> +		pr_info("use blktrace tools version >= 2 to track REQ_OP_ZONE_XXX\n");

Please change REQ_OP_ZONE_XXX to "zone operations" in these messages. That is a
little more general, so better I think since we also trace zone write
plug/unplug events, which are not REQ_OP_ZONE_XXX.

With that done,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +	}
> +
>  	bt->version = version;
>  	bt->act_mask = buts->act_mask;
>  	if (!bt->act_mask)


-- 
Damien Le Moal
Western Digital Research
