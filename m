Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39263EBF1B;
	Thu, 12 Feb 2026 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939466; cv=none; b=P99Pnk8GJERNS503tfX1L4yO04RAbhJMDVbjVjbY8g+hjxK6fuLEQe4/2xQ6Sfta6LkPrFisuHzcPqo58szjnC61JZFrxdEiodrd6QIUNRBHY6X0RfOXKWIOUnAdr57fFaPNoYNR5NR8bFPayJFa2fpufMkK49/lfgn/94qTtIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939466; c=relaxed/simple;
	bh=5FR7zvKaQGSCNel317XRj279LDz3pxa1RLC1Q1Z2tTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIh+QC99OZQ38E5veBNFOXD97hZNKEQ19c836RX1hCYXn8pZPZKtNAhQPyO4fc4eZep5+K3BJ+TYdOXGpvcHPUgs3YcIGUNgqMN+wqUUT/1stq26wGbfQtx9/OCGHoE5c8I46J47PzDrjLghtb3rWp2UuGuZnAJl98paxcZ8M+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ys8gxeoK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys8gxeoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5FBC4CEF7;
	Thu, 12 Feb 2026 23:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770939466;
	bh=5FR7zvKaQGSCNel317XRj279LDz3pxa1RLC1Q1Z2tTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ys8gxeoK+qJ6p8wiu6RMIRgIs7yh+OF3q16wXRPcCrTbxn7eFo0GxgF4zKCKZj35n
	 j/kb8I3/Hiy2KAH7+LSuiagbJ60yummJ6xYuEnNT2X+v1MWx1JRj4LM0rrOBPw/0c7
	 d3BO6L+c8SC2BJsTvPOiJd2k56UQre4P8mTpf1laR2g1UrzPui01qm1ctvnekPYhZz
	 XGdfaGVZP3COMhAaHmBqNoRlTuS6RIXueca1c4ndakjCZrM/UbgjResYq4gNldMdwd
	 Atdo1ywl0ji07hgkbW8HxkTLOoCR0s+N4RTG7l8qyXJ4fE28+1mrtiLObk//ULo3B+
	 k+ly/YiXiEsXQ==
Message-ID: <790ac7f1-c971-4607-bf44-3a77d2600179@kernel.org>
Date: Fri, 13 Feb 2026 08:37:43 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
To: Chaitanya Kulkarni <kch@nvidia.com>, axboe@kernel.dk
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-block@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260211204752.23061-1-kch@nvidia.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260211204752.23061-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/26 05:47, Chaitanya Kulkarni wrote:
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
> * With old blktrace tool and this patch :-
> 
> blktests (master) # ./check blktrace/
> blktrace/001 (blktrace zone management command tracing)      [passed]
>     runtime  3.706s  ...  3.735s
> blktrace/002 (blktrace ftrace corruption with sysfs trace)   [passed]
>     runtime  0.479s  ...  0.456s
> blktests (master) # dmesg  -c
> [ 9455.610899] null_blk: disk nullb0 created
> [ 9455.610916] null_blk: module loaded
> [ 9455.634103] run blktests blktrace/001 at 2026-02-02 15:02:23
> [ 9455.651710] null_blk: nullb1: using native zone append
> [ 9455.662852] null_blk: disk nullb1 created
> *[ 9455.714998] blktrace: nullb1: blktrace events for zone operations will be dropped*
> *[ 9455.715065] blktrace: use blktrace tools version >= 2 to track zone operations*
> [ 9459.480181] null_blk: disk nullb0 created
> [ 9459.480199] null_blk: module loaded
> [ 9459.514464] run blktests blktrace/002 at 2026-02-02 15:02:27
> [ 9459.541772] null_blk: disk nullb1 created
> blktests (master) #
> 
> * With new blktrace tools and this patch :-
> 
> blktests (master) # ./check blktrace/
> blktrace/001 (blktrace zone management command tracing)      [passed]
>     runtime  3.735s  ...  3.734s
> blktrace/002 (blktrace ftrace corruption with sysfs trace)   [passed]
>     runtime  0.456s  ...  0.496s
> blktests (master) # dmesg  -c
> [ 9490.395572] null_blk: disk nullb0 created
> [ 9490.395591] null_blk: module loaded
> [ 9490.419467] run blktests blktrace/001 at 2026-02-02 15:02:58
> [ 9490.436416] null_blk: nullb1: using native zone append
> [ 9490.447806] null_blk: disk nullb1 created
> [ 9494.262176] null_blk: disk nullb0 created
> [ 9494.262195] null_blk: module loaded
> [ 9494.296653] run blktests blktrace/002 at 2026-02-02 15:03:02
> [ 9494.322261] null_blk: disk nullb1 created
> blktests (master) #
> 
> This helps users understand why zone operation traces may be missing
> when using older blktrace tool versions with modern kernels that
> support REQ_OP_ZONE_XXX in blktrace.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> 
> V3->V4:-
> 
> Replace REQ_OP_ZONE_XXX with "zone operations". (Damien, Jens)
> 
> ---
>  kernel/trace/blktrace.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index d031c8d80be4..04b41c698127 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -741,6 +741,12 @@ static void blk_trace_setup_finalize(struct request_queue *q,
>  	 * to underscores for this to work as expected
>  	 */
>  	strreplace(buts->name, '/', '_');
> +	if (version == 1 && IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +		pr_info("%s: blktrace events for zone operations will be dropped\n",
> +			name);
> +		pr_info("use blktrace tools version >= 2 to track zone operations\n");

Since this message is split, please keep the same format for the second line. I.e.:

pr_info("%s: use blktrace tools version >= 2 to track zone operations\n",
	name);

That will avoid incomprehensible interleaved output of if multiple traces are
started together.

> +
> +	}
>  
>  	bt->version = version;
>  	bt->act_mask = buts->act_mask;


-- 
Damien Le Moal
Western Digital Research
