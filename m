Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5377C246788
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144081; cv=none; b=uqimfFb/crXwuwNtwhVnX2pyvCo0TDq6078R5qINSZRJNhOrbh7pVdpnAoQgku1INOO0G7rVgLl4+qRkdVodqdw0qpmF21v5zTIlHo3EUIZJGHkmpiL7GRrSnti54yx/9tsQqnP0zCVl4Mpeim25XF/ksR/ffyzSG9Vnq48WQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144081; c=relaxed/simple;
	bh=cGijOxfcvAuQExctYvyOZPULoMBquiLGl14Rs4IE/24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7LimHB3NFEXeimfvEIHJUC2RVm+pfpUh2TIypEUhVskXclpqMPbcsgk5ARwEcRoUyLbZlxgRmgda+myRXUmPNmSsu/Cj3H1Dl3ljCUT2825MoLNRS5InJjzDUkV7keey/8AoPMas4wja4fc77VSnhs9ZErbiEKHmwX+4H2S0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEsCKuGB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEsCKuGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22CEC4CEE3;
	Thu, 10 Jul 2025 10:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752144079;
	bh=cGijOxfcvAuQExctYvyOZPULoMBquiLGl14Rs4IE/24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VEsCKuGBBRmfy4JAtdRDn+/4r9Ze4uYsA7ehV9kSPs+BQT6oZbZ2WIzksR6/uS9kl
	 y2qSRwhR/z0EwjJS2vEWSmixUk2+R2IiB3Kz7Fu935IafsTEY4SvXgr9mH7XoU8EKU
	 d3n+wZyyo1vrsAdL4lNlIa/kwnKjXuuVnYh6oMqxTEZVyLIhq2Ag3ZdWKBPVOfKG/7
	 MFeHBVN6Ts2DxElyHXyRRYMLIYDqQ0XcGqPQL7nwBUDJ1JX34DTphChGZoXOADmLJr
	 bCq9L4WbYHaIp3ES0QZBMfCLQMzFgB7CrF7t0VhffVIN5Ox8QSZ7REY2JfHNFeMkU3
	 qJvVp4GhFV1xg==
Message-ID: <c0f067b1-5919-4ef2-b2ea-7b85b755fb84@kernel.org>
Date: Thu, 10 Jul 2025 19:39:02 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] blktrace: add zoned block commands to blk_fill_rwbs
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: hch <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-2-johannes.thumshirn@wdc.com>
 <41730c5c-33cf-45bd-a0eb-44057da37eaa@kernel.org>
 <8641c74d-e527-4005-b0b6-d2dc41fb9afe@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <8641c74d-e527-4005-b0b6-d2dc41fb9afe@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/25 6:59 PM, Johannes Thumshirn wrote:
>>> +	case REQ_OP_ZONE_APPEND:
>>> +		rwbs[i++] = 'Z';
>>> +		rwbs[i++] = 'A';
>>> +		break;
>>> +	case REQ_OP_ZONE_RESET:
>>> +	case REQ_OP_ZONE_RESET_ALL:
>>> +		rwbs[i++] = 'Z';
>>> +		rwbs[i++] = 'R';
>>
>> I would really prefer the ability to distinguish single zone reset and all
>> zones reset... Are we limited to 2 chars for the operation name ? If not,
>> making REQ_OP_ZONE_RESET_ALL be "ZRA" would be better I think. If you want to
>> preserve the 2 chars for the op name, then maybe ... no goo idea... Naming is
>> hard :)
> 
> Again, I'd prefer the 2 chars version, as a RESET ALL can be 
> distinguished form a plain RESET by the number of sectors (see patch 
> 4/5) and we would need to bump RWBS_LEN.

Hu ? both reset and reset all use 0 sectors for the BIO. Reset all always also
use sector == 0, so that means that you cannot distinguish a reset all from a
single zone reset of the first zone... OK, this is really just that. But still,
given the different op code, a different name would be nice.

> 
> But of cause this as well is personal preference and I can go either 
> way. Whatever is preferred by everyone.


-- 
Damien Le Moal
Western Digital Research
