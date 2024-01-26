Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC867C47
	for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252953; cv=none; b=HzK40v9IdQ78WQzmQaoVQ5AnGy7p73oKhBZl02vnI/Z9A0iADzah4EbQTBVC1D2yWT+gBkvohrfkiFBkr84pFhUa3mvMlVFeeEAX+nXEmtGbsxxs2iTUoLO8T6aromC6dKnUnjMfK6kGjujUPX41Wh+eo1SqtJ9Gf3Z+tFUaV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252953; c=relaxed/simple;
	bh=cTdXTUJA/3QYCJl4mkRFCs4Trvp1qOlbfbijYebuVxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TdS8Bo8OYPekigTOEIiDoJhfDSxJyLrktlGkQ152C4CEllCWf/4aK08qCVlwSamvDH2yra21z/0BQ3f/8+DX8XPXGhVHjqhc/TkDE2plSInf2KPdUuSw1DoC0M8oGGYlvtJy/tfFCgXk6Po3mNr5KPbRHdMqsi7PWbQ97CPjfhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhYq2GFk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhYq2GFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B20C433F1;
	Fri, 26 Jan 2024 07:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706252953;
	bh=cTdXTUJA/3QYCJl4mkRFCs4Trvp1qOlbfbijYebuVxI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=YhYq2GFkBL3gQ/o3Nx553e4+VA6ccSOK0vtQI9PcLOhrsvmSiOXnBID0dJ9WktF9d
	 7mOoYaiTV2cn93NeBSV8EZQWZbpuIWJlPVNguRTq1XLsfrnzzpwKMJ/YSOCDhki+/2
	 fbV6Cm3ADw8f96FJIcakVB3J5zPGOj7kwAtSzlgowZ53a8fdv2Mku3TaD58gyJx4uQ
	 fsE3hmPcm5wPzgiXiHHCdqOtOJaVLrPPW+WFb7lyzTnWIpPYDPkgLfVEH4K7JsNJJr
	 4rOsidGqWiOHFDDYKBV9LYN2T9TxziDAj7s/m9GqbaiMsG0c999aAfkworQNVo1TUk
	 2Lja3jbianqcQ==
Message-ID: <89fcb470-2e21-43a3-a428-000e1c6ab706@kernel.org>
Date: Fri, 26 Jan 2024 16:09:11 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: Always split BIOs to respect queue limits
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20240126005032.1985245-1-dlemoal@kernel.org>
 <84dce2ee-5d71-47a4-b114-3ca69b3c31fb@suse.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <84dce2ee-5d71-47a4-b114-3ca69b3c31fb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/24 16:05, Hannes Reinecke wrote:
> On 1/26/24 01:50, Damien Le Moal wrote:
>> The function null_submit_bio() used for null_blk devices configured
>> with a BIO-based queue never splits BIOs according to the queue limits
>> set with the various module and configfs parameters that the user can
>> specify.
>>
>> Add a call to bio_split_to_limits() to correctly handle large
>> BIOs that need splitting. Doing so also fixes issues with zoned devices
>> as a large BIO may cross over a zone boundary, which breaks null_blk
>> zone emulation.
>>
> That feels so wrong. Why would we need to apply queue limits to a bio?
> (Yes, I know why. We still shouldn't be doing it.)

Splitting is at least needed for zoned devices. Otherwise, everything breaks
with the zone emulation.
> Maybe indeed time to kill the bio-based path.

I have nothing against that :)

> 
> But until that happens:
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> Cheers,
> 
> Hannes

-- 
Damien Le Moal
Western Digital Research

