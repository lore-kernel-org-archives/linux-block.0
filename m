Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3961D9A49
	for <linux-block@vger.kernel.org>; Fri, 17 Jan 2025 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154375; cv=none; b=MszcuUwY5e/TJGklwNhP8PDPq7hX4jaN3tJ55DyHwf7jYkrz41ek5V2bOg/PSwkR9LfgeTpkSJwtZuFcS0HEjczyOGYoOtcuKjejlQH5icjxCxqR+Xns1kfGjUAt9SdZnWJZFe3LG7YHLVt1TKqSLNyODhh30PjEhK2DgGgQOtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154375; c=relaxed/simple;
	bh=3l64EK8hFV6ILpGFcLF6HRYbymecwT55SuJN2J9hN1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0DzaX1zFP5T6Qq0rOLzUovNX3l8lHCktD4dm5p/W3IPZOVst/+gPiO9kAhQ7hqlWNMVF1+WKGaMPlC0cJA8AiDEP2Aa5zrNXINPmDU64b9a/HT3gHb/zZoxk1Zw8AIIE+Eswp1Q6AJX+Ys4ZCru7t8WISMWhBr1CG4vqCXvDK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfChBHHI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfChBHHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83BBC4CEE3;
	Fri, 17 Jan 2025 22:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737154374;
	bh=3l64EK8hFV6ILpGFcLF6HRYbymecwT55SuJN2J9hN1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VfChBHHI80Dnq9oIErWHc1N2UNisamre9/2wVWMb5urfSaOPnqwFKlHDc9j+gJ6Aa
	 TRR0k4n8zbRA15+ADtDK0m9iMUNG7OB15lb6yV89V53rXjXLl9zMwS0ov7p6dc/5/7
	 h2m09LZEGo/BVBPicR5rP2lFrtUTM7ULE6LKsFMwnh4nx+wkzi4O8xrbbci13GoBo9
	 X3XMke/DDqmjbYaBKzBdD0/HfKnHklRQGARLyw2R1lFpgokzB8bEvOgIAdeVY6nlrb
	 WGzSY9hmQ/U7WyB/MZQsklUdN6QT06+BXEb52fC/2L0YJhfbP98zIq7IN50yYdKiat
	 O5weK+MvA4tmQ==
Message-ID: <adc95349-c682-49b5-9f48-238a06b4aafd@kernel.org>
Date: Sat, 18 Jan 2025 07:52:51 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 2/5] null_blk: introduce badblocks_once
 parameter
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
References: <20250115042910.1149966-1-shinichiro.kawasaki@wdc.com>
 <20250115042910.1149966-3-shinichiro.kawasaki@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250115042910.1149966-3-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 1:29 PM, Shin'ichiro Kawasaki wrote:
> When IO errors happen on real storage devices, the IOs repeated to the
> same target range can success by virtue of recovery features by devices,
> such as reserved block assignment. To simulate such IO errors and
> recoveries, introduce the new parameter badblocks_once parameter. When
> this parameter is set to 1, the specified badblocks are cleared after
> the first IO error, so that the next IO to the blocks succeed.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
