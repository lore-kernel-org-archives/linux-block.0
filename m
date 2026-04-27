Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568A332623
	for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302803; cv=none; b=Tn9bX/9POB4iUL65EN7j5pfIhuQ84OdHa/144RPD/z3g5voVA1m9z/BBYmsiSi4Dr6Uy/vnphmYoO9xATfYyZIKXQJMimiurzBA4kOVPgt5NB4Qh1oH1CjvXpUjVg+SpQwCmb7Bqscv036AtPKLyiFNPwUtAhogfDg9FoKZ9kw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302803; c=relaxed/simple;
	bh=VW0HJ/ArqhJPIEBkF3ug4gbvzRTCNF70jBlEt1qiVE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB5A65xwtKtOFcDdNLNlhsKeT3QkAqyuHbCHO9RBkdIzNgd0edoxgQoCoRXWGbGPpNH4vf72/lHG7sUpibPZvJrkmXS0QorGFebUxJMVrI041LhNLgK8o1UxTA8biaL2xiqIJAQjEXQ0ijQxzwSwbl8aCE1kaHTWWXehDQxOs6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bLJbU8p7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bLJbU8p7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAA9C19425;
	Mon, 27 Apr 2026 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777302803;
	bh=VW0HJ/ArqhJPIEBkF3ug4gbvzRTCNF70jBlEt1qiVE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLJbU8p7hOGCZJCy7LcbGG6IUftWXUiCN1DVj/Z4EewTBQN1EkQY3qjKyBI/L8vKf
	 +LYFmD+eDxHdfDK6kOek7nNk52P1+1/g4mjE0UOTmTZ4VzBHoyeBvImWs4ssMcLJnt
	 BE2XPZ6bXPNCho12sbmlQhfdaST51sKWf4MVCHmU=
Date: Mon, 27 Apr 2026 09:12:47 -0600
From: Greg KH <gregkh@linuxfoundation.org>
To: Ramesh Adhikari <adhikari.resume@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] badblocks: fix infinite loop due to incorrect rounding
 and overflow
Message-ID: <2026042730-ranting-underfeed-7758@gregkh>
References: <20260427151048.756072-1-adhikari.resume@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427151048.756072-1-adhikari.resume@gmail.com>

On Mon, Apr 27, 2026 at 08:40:48PM +0530, Ramesh Adhikari wrote:
> The roundup() and rounddown() macros return the rounded value but
> do not modify the input in place. In _badblocks_set(), _badblocks_clear(),
> and badblocks_check(), the return values were being discarded, causing
> s and target/next to remain unrounded. This resulted in sectors
> being calculated from unrounded values, which could lead to sectors
> being way too large (or zero), causing infinite loops in the
> re_insert/re_clear/re_check loops.
> 
> Additionally, add integer overflow checks (s > ULLONG_MAX - sectors)
> before the s + sectors calculation in all three functions to prevent
> overflow-related issues. Also add early return when sectors becomes
> zero after rounding in badblocks_check().
> 
> Root cause: When s and sectors have specific values (e.g., from
> syzkaller fuzzing via nvdimm ioctl), the unrounded values cause
> sectors to be incorrectly calculated. In _badblocks_clear(), this
> could result in needing 2^46 iterations to process 2^55 sectors,
> triggering RCU stall warnings and effectively hanging the kernel.
> 
> Fix by properly capturing the return values from roundup() and
> rounddown(), adding overflow checks before sector arithmetic, and
> handling the zero-sectors case in badblocks_check().
> 
> Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
> ---
>  block/badblocks.c | 43 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/block/badblocks.c b/block/badblocks.c
> index ece64e76fe8..a5ffae65a05 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -855,13 +855,21 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
>  
>  	if (bb->shift) {
>  		/* round the start down, and the end up */
> +		if (s > ULLONG_MAX - sectors)
> +			return false;
>  		sector_t next = s + sectors;
>  
> -		rounddown(s, 1 << bb->shift);
> -		roundup(next, 1 << bb->shift);
> -		sectors = next - s;
> +		s = rounddown(s, 1 << bb->shift);
> +		next = roundup(next, 1 << bb->shift);
> +		if (next < s)
> +			sectors = 0;
> +		else
> +			sectors = next - s;
>  	}
>  
> +	if (sectors == 0)
> +		return false;
> +
>  	write_seqlock_irqsave(&bb->lock, flags);
>  
>  	bad.ack = acknowledged;
> @@ -1070,12 +1078,20 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
>  		 * However it is better the think a block is bad when it
>  		 * isn't than to think a block is not bad when it is.
>  		 */
> +		if (s > ULLONG_MAX - sectors)
> +			return false;
>  		target = s + sectors;
> -		roundup(s, 1 << bb->shift);
> -		rounddown(target, 1 << bb->shift);
> -		sectors = target - s;
> +		s = roundup(s, 1 << bb->shift);
> +		target = rounddown(target, 1 << bb->shift);
> +		if (target < s)
> +			sectors = 0;
> +		else
> +			sectors = target - s;
>  	}
>  
> +	if (sectors == 0)
> +		return false;
> +
>  	write_seqlock_irq(&bb->lock);
>  
>  	bad.ack = true;
> @@ -1305,11 +1321,20 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
>  
>  	if (bb->shift > 0) {
>  		/* round the start down, and the end up */
> +		if (s > ULLONG_MAX - sectors) {
> +			return -EINVAL;
> +		}
>  		sector_t target = s + sectors;
>  
> -		rounddown(s, 1 << bb->shift);
> -		roundup(target, 1 << bb->shift);
> -		sectors = target - s;
> +		s = rounddown(s, 1 << bb->shift);
> +		target = roundup(target, 1 << bb->shift);
> +		if (target < s)
> +			sectors = 0;
> +		else
> +			sectors = target - s;
> +
> +		if (sectors == 0)
> +			return 0;
>  	}
>  
>  retry:
> -- 
> 2.43.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
