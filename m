Received: from va-2-59.ptr.blmpb.com (va-2-59.ptr.blmpb.com [209.127.231.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E37403B13
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592754; cv=none; b=KIAaE6ZGxqlz/ZFjsLXtkkJNqRkdoSdHLAANoHXHUiLX83V4Uw3YXRg22DivhNQQ163XJATK4mkVRr6nrcAf4eT5jdCUwvhshvXwryLG5jPaxDvyTdQqv5GS32xzep3wUC3OcIoRAZF49hWACiuC3Y1Ix24qNqu+jwx1Z5S5Mx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592754; c=relaxed/simple;
	bh=WImoGB9zC9w6TvVurSpIB5F653VxUb6NNdO/ZNGlUEI=;
	h=Mime-Version:In-Reply-To:Content-Disposition:Cc:Message-Id:
	 Content-Type:References:From:Subject:Date:To; b=uCVz+kwQnXkj7zGuPjlsu8v8VMd5R52b8CluHtva6WN6k35vCTf/lWlTf60ufNA6dUjYNFRQNP//t+ZRFqJzOsL8ELDXYgGEFavaJ7WFJOu/TeVfzY+fxTPuQActC8eCGiWW29BksJAuIoqEDU7ZDmWtVmVE4cP3PpLjzX56uyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=QLrsF00P; arc=none smtp.client-ip=209.127.231.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="QLrsF00P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1783592744;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=o4cv9qmulrZqNwihxMf3chKHoYajvX6/9Gcz5F75/Mg=;
 b=QLrsF00PkPiGs1wYp+Zqf0mAw9NAID8dkkeefK/v3/WLS6pxF/XafrXe+eSViAmv3icU+P
 nnlUo0BQ6gf59uvxNKRXBEDjd854YE2N6ixVH9vbe/VA6Fbwx0enV0Wzb+06kT/8+3YSSl
 sF5jr/pc4t2CVs0BXQ7RN/OvRcxd9NqEYTSGsG+ENu5/nzUKSw9gWwq+q3sl081RMNfuuU
 jdbWbNSI2q8Mfc/x3FY8FGq3pKvieEdLp6lhWu6GnLoo4WksZGco6MqW7JQJ++xbKNKsc4
 TOHp6HdO3ToXHM1vlya6mKwraYVBSaYyaB9aTAnhAO0m5lW6VGe+77lI9u5pWw==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Coly Li <colyli@fygo.io>
In-Reply-To: <20260704171321.1956937-1-adhikari.resume@gmail.com>
Content-Disposition: inline
Cc: <axboe@kernel.dk>, <gregkh@linuxfoundation.org>, 
	<linux-block@vger.kernel.org>, <lkp@intel.com>
Message-Id: <ak9CC591ivuQ4BP1@studio.local>
Content-Type: text/plain; charset=UTF-8
References: <20260427151048.756072-1-adhikari.resume@gmail.com> <20260704171321.1956937-1-adhikari.resume@gmail.com>
Content-Transfer-Encoding: 7bit
From: "Coly Li" <colyli@fygo.io>
Subject: Re: [PATCH v5] badblocks: fix infinite loop due to incorrect rounding and overflow
Date: Thu, 9 Jul 2026 18:25:40 +0800
To: "Ramesh Adhikari" <adhikari.resume@gmail.com>
Received: from studio.local ([120.245.64.95]) by smtp.larksuite.com with ESMTPS; Thu, 09 Jul 2026 10:25:42 +0000
X-Lms-Return-Path: <lba+26a4f7727+ea038d+vger.kernel.org+colyli@fygo.io>

On Sat, Jul 04, 2026 at 10:43:21PM +0800, Ramesh Adhikari wrote:
> The roundup() and rounddown() macros return the rounded value but
> do not modify their input in place. In _badblocks_set(),
> _badblocks_clear(), and badblocks_check(), the return values were
> being discarded, so s and target/next remained unrounded. Sectors
> were then calculated from these unrounded values, which could make
> sectors way too large (or zero), causing infinite loops in the
> re_insert/re_clear/re_check loops.
> 
> This was confirmed with local syzkaller fuzzing against the nvdimm
> ioctl path (ND_IOCTL_CLEAR_ERROR -> nvdimm_clear_badblocks_region()
> -> badblocks_clear()), which reliably produces RCU stalls with the
> looping task caught mid-loop:
> 
>   rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>   rcu: rcu_preempt kthread starved for 21001 jiffies! g40229 f0x0 RCU_GP_WAIT_FQS(5)
>   ...
>   Call Trace:
>    badblocks_clear+0x259/0xb10
>    nvdimm_clear_badblocks_region+0x165/0x1e0 [libnvdimm]
>    device_for_each_child+0x11e/0x1a0
>    nd_ioctl+0x1413/0x1750 [libnvdimm]
>    __x64_sys_ioctl+0x18e/0x210
>    do_syscall_64+0x102/0x5a0
> 
> Fix this by properly capturing the return values of round_up()/
> round_down() (the power-of-two variants, since 1 << bb->shift is
> always a power of two -- roundup()/rounddown() use a division/
> modulo internally, which is undesirable here). Also add overflow
> checks (s > ULLONG_MAX - sectors) before the s + sectors addition
> in all three functions, and handle the case where sectors becomes
> zero after rounding.
> 
> The overflow check is done unconditionally, before the bb->shift
> rounding block, rather than inside it. bb->shift == 0 is not just
> an initial state -- __badblocks_init() sets it to 0 by default, and
> drivers/md/md.c explicitly sets rdev->badblocks.shift back to 0 in
> several paths -- so s + sectors needs the same overflow guard
> whether or not rounding happens.
> 
> Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
> ---
> v1-v3 chased individual len==0 symptoms in _badblocks_clear()/
> _badblocks_check() one call site at a time. Jens pointed out that
> approach wasn't finding the actual bug, just papering over spots as
> they were noticed. v4 was a full rewrite around the real root cause
> (roundup()/rounddown() discarding their return values), covering all
> three functions with proper overflow handling.
> 
> Changes in v5:
>  - Switch from roundup()/rounddown() (which use division/modulo on
>    sector_t, a u64) to round_up()/round_down() (bitmask-based, since
>    1 << bb->shift is always a power of two). Fixes the v4 build
>    failure kernel test robot reported on 32-bit (undefined reference
>    to __aeabi_uldivmod on ARM, __umoddi3 on i386).
>  - Move the s > ULLONG_MAX - sectors overflow check so it runs
>    unconditionally in all three functions, instead of only inside
>    the `if (bb->shift)` block. bb->shift == 0 is a real, common
>    state (default init value, and explicitly set by drivers/md/md.c
>    in several paths), so the overflow guard needs to apply there
>    too, not just when rounding is active.
>  - Build-tested locally (x86_64) and confirmed no residual div/mod
>    symbols in the object file.
> 
> Link to v4: https://lore.kernel.org/r/20260427151048.756072-1-adhikari.resume@gmail.com
>

Hi Ramesh,

Thanks for the fix up.
 
>  block/badblocks.c | 40 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/block/badblocks.c b/block/badblocks.c
> index ece64e76fe8..e8484912532 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -853,15 +853,21 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
>  		/* Invalid sectors number */
>  		return false;
>  
> +	if (s > ULLONG_MAX - sectors)
> +		return false;
> +

The original idea was to let caller to handle such overflow stuffs.
If you want to handle these things here, the above lines are not
enough indeed. You need to considering more conditions, I used to
unlike such codes, but now realize maybe such checks should be
added.

Here are some items in my brain,
- s + sectors overflow
- too big bb->shift
- 1 << bb->shift overflow
- the rounddown result even smaller then start s for large bb->shift


>  	if (bb->shift) {
>  		/* round the start down, and the end up */
>  		sector_t next = s + sectors;
>  
> -		rounddown(s, 1 << bb->shift);
> -		roundup(next, 1 << bb->shift);
> +		s = round_down(s, 1 << bb->shift);
> +		next = round_up(next, 1 << bb->shift);
>  		sectors = next - s;

I suggest to divide the patch into two. The first one just contains
the above round_down and round_up fix. Another one check the rested
value ranges.

Also add Fixes tag to my origin badblocks rewrite commit, and add
a CC line to stable@vger.kernel.org

Thanks.

Coly Li


>  	}
>  
> +	if (sectors == 0)
> +		return false;
> +
>  	write_seqlock_irqsave(&bb->lock, flags);
>  
>  	bad.ack = acknowledged;
> @@ -1061,6 +1067,9 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
>  		/* Invalid sectors number */
>  		return false;
>  
> +	if (s > ULLONG_MAX - sectors)
> +		return false;
> +
>  	if (bb->shift) {
>  		sector_t target;
>  
> @@ -1071,11 +1080,17 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
>  		 * isn't than to think a block is not bad when it is.
>  		 */
>  		target = s + sectors;
> -		roundup(s, 1 << bb->shift);
> -		rounddown(target, 1 << bb->shift);
> -		sectors = target - s;
> +		s = round_up(s, 1 << bb->shift);
> +		target = round_down(target, 1 << bb->shift);
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
> @@ -1303,13 +1318,22 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
>  
>  	WARN_ON(bb->shift < 0 || sectors == 0);
>  
> +	if (s > ULLONG_MAX - sectors)
> +		return -EINVAL;
> +
>  	if (bb->shift > 0) {
>  		/* round the start down, and the end up */
>  		sector_t target = s + sectors;
>  
> -		rounddown(s, 1 << bb->shift);
> -		roundup(target, 1 << bb->shift);
> -		sectors = target - s;
> +		s = round_down(s, 1 << bb->shift);
> +		target = round_up(target, 1 << bb->shift);
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
