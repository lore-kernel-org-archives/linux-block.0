Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DF71E766F;
	Thu,  8 May 2025 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746693139; cv=none; b=ha5mj4a9RqPpYrXQ2YEtZXvwRklz5lkuaJTaK/ik+4ZVBex3RjeW+3IMDb3Mm6Z71Sqws9eUkq8gC7qpxpcho7fqwedW/GRDcsLuaW/JVoMDpQTYKrbCaRPkW0nhB+I1yEFKJzCMmOnv+IxV4Fgdrs7qojw+IPXUj9Vuwd928Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746693139; c=relaxed/simple;
	bh=102dWPlN2kj8XOwnlIapHIcHx4zXt93iroIAqQMq6dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4s1HS3l+Vf4SLTOjhh5tnwM1xP5B2NWlLE2RyYTwaLkgNLIop/yDKp3kgymvZUv2GEv18Z/3jBEAJDvGnm1gZ/emsJjHFg/ksx79Crfc7ZtE0P1r2SPa0c1b/nXmN5YoDqh9wpw2DdPNxeQ9y5D2RpONl1n3FEYT0nrvEJE4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRZLWYiK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRZLWYiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4D8C4CEE7;
	Thu,  8 May 2025 08:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746693137;
	bh=102dWPlN2kj8XOwnlIapHIcHx4zXt93iroIAqQMq6dE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NRZLWYiKoqxd3cQR7kImQdlVIcOCyFVpMA68DIHfwHNIVVfpt4fPsETpTqyPiFmP/
	 Epnhb6YN3RPNe8xbmrYAzwKyFFBrKA7sxLsYiKeTG7Emed3Dr9+TnMwFthl2ty1Lio
	 AGKtLdDoyGswrN5Z2mUJQtfl2Xz67Es4rzELkzQg52sU4gb/2RrLDnImpE9/ELYVkN
	 N/1zaHEbJRja66e6IIkW8BxI5VYOL111nKFdLEMgbQHZZv5oUWWKHRxlGO+O2dyCiR
	 7AfK/9k7z7/xXxywhdRDXk7a0NYyMFsEiQrH1RGTGnzP+FQy4MQ0WllNyXJYyHNIud
	 IyhNtPv281xiA==
Message-ID: <e00151ee-8579-4763-838c-7b4c894fc95b@kernel.org>
Date: Thu, 8 May 2025 17:31:05 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: remove test of incorrect io priority level
To: Aaron Lu <ziqianlu@bytedance.com>, Jens Axboe <axboe@kernel.dk>
Cc: Kexin Wei <ys.weikexin@h3c.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250508083018.GA769554@bytedance>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250508083018.GA769554@bytedance>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 5:30 PM, Aaron Lu wrote:
> Ever since commit eca2040972b4("scsi: block: ioprio: Clean up interface
> definition"), the macro IOPRIO_PRIO_LEVEL() will mask the level value to
> something between 0 and 7 so necessarily, level will always be lower than
> IOPRIO_NR_LEVELS(8).
> 
> Remove this obsolete check.
> 
> Reported-by: Kexin Wei <ys.weikexin@h3c.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
