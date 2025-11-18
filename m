Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA9730AAB6
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479336; cv=none; b=GfwKs7M7u/+6UadndAuPbzRj76bAiw8AiRjO/SYbTQloskBH1xU2Dhl8kaa73Hnl1+HAOvwniUpA3vjCxdJCgY/GX37E3sWuyhVAxkn3d6KlisKXqTGE84warnKbLLd3eo+L6o11JOAIelMRSoYQw2xyGELwPXklE6tJu9DaALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479336; c=relaxed/simple;
	bh=r9HuUL+KX0eOb/Gwt4Zbim4GON90H12sPmlgIfbYLJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6INXWi3Ed4Sd8HXMTI9kJLMukDlfsCo8thM3a/l3c4JlRfDXYj90muuF9k+krLCCBfuqosK52WxB+AUH34oZzq65jQHsFP4eDWB+ViYe5fSS044z2sUGAdoPicmi/5EISBOJIEPxcSS219RVr7PEb0OU38NppZGYZGtxReyWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/k3f0pB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/k3f0pB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CE5C4CEF5;
	Tue, 18 Nov 2025 15:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763479335;
	bh=r9HuUL+KX0eOb/Gwt4Zbim4GON90H12sPmlgIfbYLJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/k3f0pBnLnb7awTbgxvn4dYyDuey/ulB7VaQ6IFaWg6/cdVtzgw59ZdtCNhAUJHn
	 pLC6ArE7QjatZPzbaud1YKxiW1s1WytHFv2bQpKq1xZivXtIznNJ3ZXUDGgXKYtqDX
	 ZjpJxEE/HScCeLXZBTmTK6oOx4K4hoHEiBWRT1jK+aUCii0dkVIifXAhRJwBAemNSb
	 53rqeult6FNikjuVDaZRkGd2vBr5hMfNAvbcxgRuQMnmu/VH6e1TrvSWxOHX4GuIOr
	 LSIqTItVC1UZk6mTZ3Os3LGcVosmKxBA4gasoVzY3sHguj6C/sy0HR/ha6fIDFrE4s
	 bigY461GHhxqQ==
Date: Tue, 18 Nov 2025 08:22:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: nvme discard issue
Message-ID: <aRyPJtYJaEVRkBeM@kbusch-mbp>
References: <26acdfdf-de13-430b-8c73-f890c7689a84@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26acdfdf-de13-430b-8c73-f890c7689a84@kernel.dk>

On Tue, Nov 18, 2025 at 07:24:59AM -0700, Jens Axboe wrote:
> commit 2516c246d01c23a5f5310e9ac78d9f8aad9b1d0e
> Author: Keith Busch <kbusch@kernel.org>
> Date:   Fri Nov 14 10:31:45 2025 -0800
> 
>     block: consider discard merge last
> 
> This was just doing an allmodconfig build, using XFS as per the trace
> above. The fs is mounted:

Huh, xfs was the only filesystem I tested, but obviously not enough. So
the segment accounting is off now, I'll take a look.
