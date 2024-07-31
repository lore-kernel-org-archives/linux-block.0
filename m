Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE143ACB;
	Wed, 31 Jul 2024 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418107; cv=none; b=oK9g9WVJCukk9LMEM5K1/VhmNaNxXNrW2rIOnYaYoLyWADXfKAGx75w/hODQPTF+AmcrC2zAC/VHuUqnadWivdt5TyQli7xnpKo/OPT0wtjNNkxESZTLFytagDyEr56XofU4ZokGsUHmqBJ/iTi19YHFppoOijZaXdBbK+OBUM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418107; c=relaxed/simple;
	bh=ee6gvgisXeK3w70jCFRHuuXJ1Cqj/IDyCSFCexR8Gps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFzEoi23oGQ6KglNlpdn2NPcfD2wHmr6yakC+3xpGse0CcgQknpkbHX4Njf7LEwYfSz/dtdDwEAdBhRjXk2TJshga6WqFWqQHwjaDENaF/l0ifc83xkuA5WoUWM2DV/f83PktyE03MGc09GM2P9VtLausro/dhtl3iAqp8AFd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvSOl3nr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvSOl3nr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253E6C4AF0E;
	Wed, 31 Jul 2024 09:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722418104;
	bh=ee6gvgisXeK3w70jCFRHuuXJ1Cqj/IDyCSFCexR8Gps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LvSOl3nrIP/Nua3+TgvMkIiOTWIpv6wQ/QsKaFhjWJ8x/XTss+pw6F7wi1QYl/O+S
	 y0JBBoMp4E0hPwCPyx76miRNZCWdkC14o8mSRsz0I+sCPMWUVVJNgR/2h94Y8TtyRc
	 CXzdgxZa/0QeYoH8D/B1sYeiZBo1MujmUKsfCJ1u+yHP1faB1suT4rV+F2Y5Twxeto
	 UxZqiZkq0nGiXjwecFQEmzyzYEyQLvLIOcNrSM5ki1aOHwkVBA80WG7iJ0ggz2fwlF
	 iS5XW5bpuASDI9rZtbOtXo+NheXGm5fge2BVL/iZ1uwiTU/eNXEKmZXmzA43+lG32O
	 HxtGlpFTHxNwQ==
Message-ID: <dafe01f5-5f08-4298-b020-7e3c80e4f15d@kernel.org>
Date: Wed, 31 Jul 2024 18:28:22 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] block: uapi: Use unsigned int type for
 IOPRIO_PRIO_MASK
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, axboe@kernel.dk, hch@lst.de
Cc: bvanassche@acm.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 Hao_hao.Wang@unisoc.com
References: <1722409287-12183-1-git-send-email-zhiguo.niu@unisoc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <1722409287-12183-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/31/24 16:01, Zhiguo Niu wrote:
> Generally, the input of IOPRIO_PRIO_DATA has 16 bits, but the output of
> IOPRIO_PRIO_DATA will be expanded to "UL" from IOPRIO_PRIO_MASK.
>  #define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
> This is not reasonable and meaningless, unsigned int is more suitable for it.
> 
> So if use format "%d" to print IOPRIO_PRIO_DATA directly, there will be a
> build warning or error showned as the following, which is from the
> local test when I modify f2fs codes.
> 
> fs/f2fs/sysfs.c:348:31: warning: format ‘%d’ expects argument of type ‘int’,
> but argument 4 has type ‘long unsigned int’ [-Wformat=]
>    return sysfs_emit(buf, "%s,%d\n",
>                               ~^
>                               %ld
> 
> When modules use IOPRIO_PRIO_CLASS & IOPRIO_PRIO_LEVEL get ioprio's class and
> level, their outputs are both unsigned int.
>  IOPRIO_CLASS_MASK is:
>  #define IOPRIO_CLASS_SHIFT	13
>  #define IOPRIO_NR_CLASSES	8
>  #define IOPRIO_CLASS_MASK	(IOPRIO_NR_CLASSES - 1)
>  IOPRIO_LEVEL_MASK is:
>  #define IOPRIO_LEVEL_NR_BITS	3
>  #define IOPRIO_NR_LEVELS	(1 << IOPRIO_LEVEL_NR_BITS)
>  #define IOPRIO_LEVEL_MASK	(IOPRIO_NR_LEVELS - 1)
> 
> Ioprio is passed along as an int internally, so we should not be using an
> unsigned long for IOPRIO_PRIO_MASK to not end up with IOPRIO_PRIO_DATA
> returning an unsigned long as well.

I would write this commit message like this:


An ioprio is passed internally as an int value. When IOPRIO_PRIO_CLASS() and
IOPRIO_PRIO_LEVEL() are used to extract from it the priority class and level,
the values obtained are thus also int.
However, the IOPRIO_PRIO_MASK() macro used to define the IOPRIO_PRIO_DATA()
macro is defined as:

#define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)

that is, the macro gives an unsigned long value, which leads to
IOPRIO_PRIO_DATA() also returning an unsigned long.

Make things consistent between class, level and data and use int everywhere by
removing forced unsigned long from IOPRIO_PRIO_MASK.



-- 
Damien Le Moal
Western Digital Research

