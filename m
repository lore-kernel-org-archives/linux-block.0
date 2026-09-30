Received: from sg-3-41.ptr.tlmpb.com (sg-3-41.ptr.tlmpb.com [101.45.255.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1094734FD
	for <linux-block@vger.kernel.org>; Wed, 30 Sep 2026 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759858; cv=none; b=Langs7MKg0Eo/sd27aVLxpOLTIlGgTBFzJ+c14Wuvy9iUQog8w9QBjyln32L1EzXcEn+t98zngh7sG3N8x/Ecti63gcYPmikgN3bw7MBZr4q57bby0Ea5pIbAzsPEoFsfoyfEBoWMtfFgSQyZ1kf/TqV1PwwDjChd+MV8gug7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759858; c=relaxed/simple;
	bh=p62j2EYDaaYSdF7DHISswhJVcc7AieHTa03F+I5gn9E=;
	h=Cc:References:From:Subject:In-Reply-To:To:Mime-Version:Date:
	 Message-Id:Content-Type; b=kokWBxyIx465mkhPo/nhZW2yXPYwjG3Qc5oxg/+ldkF+zpDjuoYndBi84xb2lvMPMlZCrkNWee3j1NyrkRS934xFEsdj6MnN+cF8Zp/rSGlC+Nr+nC+Ps8S33YGrC+tFsxSmbMHfUwJiHY/udzfArwUOiTfQ/+fUX41S4NK9Oyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=b5ZuwlGs; arc=none smtp.client-ip=101.45.255.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="b5ZuwlGs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1790759712;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=3uO3HCAA9LAZZwSCTq4O6lCw21LTl7WlK3Z92yYHjeE=;
 b=b5ZuwlGsRthfzvHhqt6tXECy5TzslsUcBMKcQM6ML4N9VZnOXIj7TehtJ+9bBaIlDPTxpr
 hZO5VIA3bJfyoSIxvH1CJMJcQWn8qm2/GMgsx7sNpRRJylkyHCuYFnqXLdcfMcvl+G3qyi
 7/Cs7IsJMFUp6NjX5xmZlIMSul8VFcuKue06hHTz7ga1KPCSWAlntdfITLTA5bWJpk+/zg
 7wTZl2vrWNigu3BzZPODeFbzLM9K39I2bPQLH9CyyNPV5tMj5b/yjqY7XZ6oUZJaX5Gd9e
 HMBUGqjN/Wyz8AnOdAbwdM0zl1LSCrSR3vB91UTOWw0D4xWU6w26P3sHADPp0g==
Cc: "Xiao Ni" <xni@redhat.com>, "Geliang Tang" <geliang@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
References: <20260930034941.1814-1-lirongqing@baidu.com>
Received: from [192.168.40.139] ([46.207.48.51]) by smtp.larksuite.com with ESMTPS; Wed, 30 Sep 2026 09:15:11 +0000
Content-Language: en-US
X-Lms-Return-Path: <lba+26abcd31f+bc8e74+vger.kernel.org+colyli@fygo.io>
User-Agent: Mozilla Thunderbird
From: "Coly Li" <colyli@fygo.io>
Subject: Re: [PATCH] badblocks: actually round to block boundaries in set/clear/check
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260930034941.1814-1-lirongqing@baidu.com>
To: "lirongqing" <lirongqing@baidu.com>, "Jens Axboe" <axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Coly Li <colyli@fygo.io>
Date: Wed, 30 Sep 2026 17:15:04 +0800
Message-Id: <f07b2405-9c9f-461e-88e8-63e108a68e1d@fygo.io>
Content-Type: text/plain; charset=UTF-8

Hi Rongqing,

On 9/30/26 11:49 AM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
>
> _badblocks_set(), _badblocks_clear() and badblocks_check() intend to
> round the start/end of a range to the bb->shift block boundary before
> operating on the bad-blocks table. They call rounddown()/roundup() as
> bare statements:
>
> 	rounddown(s, 1 << bb->shift);
> 	roundup(next, 1 << bb->shift);
> 	sectors = next - s;
>
> But rounddown()/roundup() (include/linux/math.h) are value-returning
> statement-expression macros; they do not modify their argument in
> place. The results were discarded, so s and next/target were never
> rounded and "sectors = next - s" collapsed back to the original
> length. The whole "if (bb->shift)" block was a no-op, and ranges on
> devices with bb->shift > 0 were stored/queried at raw sector
> granularity instead of being block-aligned -- exactly the "think a
> block is not bad when it is" hazard the _badblocks_clear() comment
> warns about.
>
> Assign the rounded values back so the alignment takes effect.
>
> Fixes: 3ea3354cb9f0 ("badblocks: improve badblocks_check() for multiple ranges handling")
> Fixes: db448eb68629 ("badblocks: improve badblocks_clear() for multiple ranges handling")
> Fixes: 1726c7746783 ("badblocks: improve badblocks_set() for multiple ranges handling")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>


This is fixed and the patches were waiting for merge IIRC.

Just FYI.


Coly Li


> ---
>   block/badblocks.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/block/badblocks.c b/block/badblocks.c
> index ece64e7..eafdb6a 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -857,8 +857,8 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
>   		/* round the start down, and the end up */
>   		sector_t next = s + sectors;
>   
> -		rounddown(s, 1 << bb->shift);
> -		roundup(next, 1 << bb->shift);
> +		s = rounddown(s, 1 << bb->shift);
> +		next = roundup(next, 1 << bb->shift);
>   		sectors = next - s;
>   	}
>   
> @@ -1071,8 +1071,8 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
>   		 * isn't than to think a block is not bad when it is.
>   		 */
>   		target = s + sectors;
> -		roundup(s, 1 << bb->shift);
> -		rounddown(target, 1 << bb->shift);
> +		s = roundup(s, 1 << bb->shift);
> +		target = rounddown(target, 1 << bb->shift);
>   		sectors = target - s;
>   	}
>   
> @@ -1307,8 +1307,8 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
>   		/* round the start down, and the end up */
>   		sector_t target = s + sectors;
>   
> -		rounddown(s, 1 << bb->shift);
> -		roundup(target, 1 << bb->shift);
> +		s = rounddown(s, 1 << bb->shift);
> +		target = roundup(target, 1 << bb->shift);
>   		sectors = target - s;
>   	}
