Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD164C9E1C
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406520; cv=none; b=pUGCMrIqPhGhQIb99nJ6KCu4J655asnTv+wWFnyepo1x2wYKsh+Wk3RwHNn07TlPMKDkvNilbDGr2wjoNWYhzk5fjnWni47S6FD7WgxCMmcL5Kqb27IGm8jc7pSx53qaPMrArVUyXMXMsMHLGWKmgWXVUVRrh8h/09waKG7UOD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406520; c=relaxed/simple;
	bh=hA8nTltvrmLu+x57q1Liw59YJQlDKHY1d+qYowBwCHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=js2ot86BnKz8vej02i74mBfELd+ElnwYwTdkZeidlPP0fO847vq/8Jk+BS7G23x4pYOzsGcNEL/wPiE2HSszKbhggMimSPuliLSbBGYaiR1lYNnT5Sz6PmSOEP8jaD3i+99Ly3KEbTS713S4AMC36Ny6kSlaSm/jjlNsUO7tHQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cne3AP03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cne3AP03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2353D1F000C4;
	Mon, 19 Oct 2026 10:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792406516;
	bh=6+OiTojMjCmVtPLcum/Pz04NXR2IT7e8DznovAPLIbA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cne3AP03UoJ2jsYhpP+nu/049GPkeQZSNyto9wrgNWGzIqEXfjYQXpc5D0rVKdQKG
	 YIB1sX/dj5JmCIAsyJ1OaOnJRLLRTOr+wBwLbZVjcjcepbJOGYGz1TQDKO60y6Jjq2
	 OW8DLcElQuG1GOVIDKHu22saD/QqrFNSDoGNCdetPyMSwkpBkwnBsPr6st6Zpoqhv2
	 Y1ck58vKs0h2EDdsaoVGXnt5mHp0nmafsHFQW/7VZarwIAjrPJEbAv0ym51mWBCirL
	 dEzOz+KC7tdttnHGhADSKLsDDu5QF7xg95hAZWFHK7+LAUbntdb9SIfxCF7YyWjEjI
	 bt2XAxtDw6+wA==
Message-ID: <286f96be-9ddd-4378-a28f-67d736237f64@kernel.org>
Date: Mon, 19 Oct 2026 12:41:54 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/10] Add support for storage element depopulation
To: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org
References: <20261014053337.2328544-1-dlemoal@kernel.org>
 <2c91db255fa527e76f5aa74f020d439a33e89142dc397211579876d34b3db51d@mailrelay.wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <2c91db255fa527e76f5aa74f020d439a33e89142dc397211579876d34b3db51d@mailrelay.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/14 9:18, shinichiro.kawasaki@wdc.com wrote:
> Dear patch submitter,
> 
> Blktests CI has tested the following submission:
> Status:     FAILURE
> Name:       [v7,00/10] Add support for storage element depopulation
> Patchwork:  https://patchwork.kernel.org/series/1185265/&state=*
> Run record: https://github.com/linux-blktests/linux-block/actions/runs/38517856454
> 
> 
> Failed test cases: loop/006

I tracked the failure to:

ioctl(ctl, LOOP_CTL_GET_FREE)

failing in util-linux losetup lib.
No idea why. Running losetup -f works.

Note that I see the failure in block/for-next too without my patches, so this
seems unrelated to my patch series.

-- 
Damien Le Moal
Western Digital Research
