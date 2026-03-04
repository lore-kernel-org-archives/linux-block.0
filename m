Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299052D8DA8
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772655907; cv=none; b=pM+Fp3Z4Ts4EDGMCT13ak+0OSri+NtX//2MJ/hUm5R+yfda9VyQOAylyqxiLlqva96b11vUiemMsAVTIX4hGM2nyeGksRNNuAI3HrfWJ6ooaq/XaB9b1r3X3jARHSvPMIHdXVl1tN8B+2woWXd6ZTyAORubuDNMZ5IF1Pw0EB0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772655907; c=relaxed/simple;
	bh=pOUxmRBpGQP60VOcs1zQ0MqbWgMvFmHVtSB5zL6dgJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jq+epvLL0SUU2oZuPpUz99ZiVN6iG6oh993pceYzd4BGgDLX4Q1usDFlwFirMvew3L5ErJn89ff+zAnD5b4lDV++Wuptp6kxAyZlo7k6XZwQoL1pOY8PzmR2hfsXjl18Mi3ED/p7vXUr6G5izM8UoI7NLHbetIDqjWmoHnBeaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td/i951A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td/i951A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E393C19425;
	Wed,  4 Mar 2026 20:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772655906;
	bh=pOUxmRBpGQP60VOcs1zQ0MqbWgMvFmHVtSB5zL6dgJM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=td/i951AI50+Q7QKfBEjikWRAiSXLQl2xq67L0tQpTDEMXOtacOEds+w4/pOZ32Hz
	 QOMsb98RQuRS33/7YvOI4bpv8FmrRlF7ZxnJ8o79rJoK/sXK8UFwL9vvwgtdhgCf4r
	 xogapVBYeRJkR2mDULPGjWfGeB7nUjjFbjJVX9y6aayPSbfUtExvQ6Xv46IJJF5S43
	 CFoWCPY/A464gd3TVW69DxM2VNHSoexxpIiCqkMamd1jc7+7OtX+Fi3vp8q+iAU0S2
	 WweyZ1PRJ7thIY759IjMoPP2I2AN9ehQrrd25INxXrGBiICbLCRoeibS2//NaLjYLN
	 5SRPRvrOmGKfQ==
Message-ID: <8650044e-595d-4058-9b67-25cc545bc302@kernel.org>
Date: Thu, 5 Mar 2026 05:25:03 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] drbd: Balance RCU calls in drbd_adm_dump_devices()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Marco Elver <elver@google.com>,
 linux-block@vger.kernel.org,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Andreas Gruenbacher <agruen@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Nathan Chancellor <nathan@kernel.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-2-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260304194843.760669-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/5/26 04:48, Bart Van Assche wrote:
> Make drbd_adm_dump_devices() call rcu_read_lock() before
> rcu_read_unlock() is called. This has been detected by the Clang
> thread-safety analyzer. Compile-tested only.
> 
> Tested-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
> Cc: Andreas Gruenbacher <agruen@linbit.com>
> Fixes: a55bbd375d18 ("drbd: Backport the "status" command")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

This probably should be sent independently of this series and immediately as
this look like a serious bug.

-- 
Damien Le Moal
Western Digital Research
