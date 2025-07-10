Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A32206F27
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 04:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121340; cv=none; b=d95UJGfFLRa7Hst8eeaQDVxx1PJf3xEzr6veplYedItiGlUy+giV0QUUyVDb7B18kQ7F81FLonJK0aT5OiNqwFYOwOgwuX1PH3PlRfDnoymwC8uJ9yZOIzWjZK+FfJLqqt65SPVvVuzi5DhmEHMadg8CbOfbRUbULDT0BwzrWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121340; c=relaxed/simple;
	bh=sXQnCXWVyJ/Tqrig275DUQUW4l6aM8YZfF9ZMJLyHsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCo8teuiM6Hge0X15Nm252Q6fZTfq1hopTYaeC8KCoNGnEgEEK5D8UAELqVEO6A4Ip/uF4lFp08yvrgRXqt4R7C0zFaUO9GXZrxWeLPDOJuqyJ5Iil/SZFEDkzbXaSGjDXz9+maI5SUIpTmxI7dqcS4WLqrAWwO07Qm3q+gCE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDwjt5Zp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDwjt5Zp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF36C4CEE3;
	Thu, 10 Jul 2025 04:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752121340;
	bh=sXQnCXWVyJ/Tqrig275DUQUW4l6aM8YZfF9ZMJLyHsY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DDwjt5ZptXfRiJbNtED7lfKIjPm62Ix2Lp2csRdP3ZDu+35tbMVzPuPXHs5iod9o0
	 5apurDz5isVpwqpRpgUNMRLo+jn+qRMQbZ8XW09D7lozSeUKgx/MfJ4hV+R3HQTlQ1
	 ejoUR6tdYBDUyd/lEQ1LCIl51IT5VDo/dYw9m1IwcBZtTdLrZvldEsYEzqMal+1oBh
	 qJOPxNb6lzMK2AtZoNIpyLAfqEjomaPeCZLc+FRmZ+byo+1bjt85JMldj0KerG9AyL
	 xziCHF2j5hTL09r5fRc8ExdmEWMS4bnH7vBLiWkz4hnY+gD3dz6RKMCiR2dH/cmyLs
	 u1F+LsI5Ylbjg==
Message-ID: <21e78973-ec44-4792-9ce5-cc086ff6aa33@kernel.org>
Date: Thu, 10 Jul 2025 13:20:03 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] block: add tracepoint for blkdev_zone_mgmt
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-5-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250709114704.70831-5-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 8:47 PM, Johannes Thumshirn wrote:
> Add a tracepoint for blkdev_zone_mgmt to trace zone management commands
> submitted by higher layers like file systems or user space.
> 
> An example output for this tracepoint is as follows:
> 
>  mkfs.btrfs-210 [000] .....   116.727190: blkdev_zone_mgmt: 259,6 ZRS 524288 + 0
> 
> This example output shows a REQ_OP_ZONE_RESET_ALL operation submitted by
> mkfs.btrfs.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Modulo the remark about zone reset all op name in the trace, this looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
