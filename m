Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3F98C1E
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 05:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736143129; cv=none; b=eUpazQExShaYlzaKW96ndQ+16tC0RQT5/CLbaKuDBUxsUcBxCu7PhsjanI1rQg9RC2Lu83v3r9SWEJNyT36PK3v8ME5BLcdoUH3AKp4tQjBoNyYGBAeBzsa4eGQBMAcZOBHvDJCs09hhDzKzt7U0dV+gvM43NjzQ567kjA5encw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736143129; c=relaxed/simple;
	bh=CHwwxJEGEB7YeDDC5eEpkQ/58HHJtoXxm7zXn9nhSY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqsfQ1Utsc6BwoMlev8zwEricnsFWE9GvLe2Pjugihl1vL5t+zZy+2BLaz6/pezh07Jy3V+rARYCBD80qcDTqXfg8S0P0miyo6YK2xjoKA+erAzNuJEeC1VSDGIncYl7DX00lAhp/h/U6ocM0sgC7aYUN6mvT2Y2NK6jnhSTFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On4dnNIW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On4dnNIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2E0C4CED2;
	Mon,  6 Jan 2025 05:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736143128;
	bh=CHwwxJEGEB7YeDDC5eEpkQ/58HHJtoXxm7zXn9nhSY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=On4dnNIW9p9QKV/JOMSuJwOH3ikEKT1WOD8ZFXKpqBx39Kul9IeI/vvCTYb839I5w
	 3yJeeLzWXWnLADZfXRv9TEuQLGLsRThyWuEFXasGrutGM0WmkLguf0an4IB3w69gst
	 B8UUAjbByXcZGB4PAnCcmKvobMeZGsX74jAUzuX+16lUemVCCkp3cR5mVC5Gtj8Cev
	 09AQVlba2oybX4fsblEo7a+HmChkxBHsdXdd1Lzp5k2IYUC1pv/fq9TBLO90+xrzBu
	 SHY1F8tchjnRI8LR3AEOg/dgtcy2E+F0k6a9+IbXMUsI/KVNS86ZbHQQlsNjieCuu8
	 aHFA2pFMkL3Hw==
Message-ID: <4d5bd2de-8844-478b-8a3c-6b4e9c5f203e@kernel.org>
Date: Mon, 6 Jan 2025 14:58:04 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 4/4] null_blk: introduce badblocks_once
 parameter
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
References: <20241225100949.930897-1-shinichiro.kawasaki@wdc.com>
 <20241225100949.930897-5-shinichiro.kawasaki@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241225100949.930897-5-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/25/24 7:09 PM, Shin'ichiro Kawasaki wrote:
> When IO errors happen on real storage devices, the IOs repeated to the
> same target range can success by virtue of recovery features by devices,
> such as reserved block assignment. To simulate such IO errors and
> recoveries, introduce the new parameter badblocks_once parameter. When
> this parameter is set to 1, the specified badblocks are cleared after
> the first IO error, so that the next IO to the blocks succeed.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
