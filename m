Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EEF3469F6
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158768; cv=none; b=TB5Cgs/hludatlJlu4QuxrYE5PtHc+/w0a0wEYFXcMAU13FavQSmjDFoK74mqC8FAgYj0/cuNH330d+AiWD+96tXmNcH0m7xKvx/lTQ2ZMM3D/NBE+pQAaB3b/21NLC6+yrRluZr4EtgYIrCEoIYIRWODE10p1uJX4BJLe9topY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158768; c=relaxed/simple;
	bh=m8knM7/obNO7fgMbTos92vtsng+W0RU1LJnSkeeq8rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zy1C23gqjUTs5GGL0LC+H1JxQZ/MON3+71y6I6+nYQREqAh2v5tVb0pY4c0n7KyBjfARPVl1h6K1/Tk9pxbj6u94EhRoeSBCIo5kNlg2TvqknCwOfP4OHXChRI0Gfnow124I3LNjxldrX5PrmO9IlwkLHkZNYoBlldSGqYJsNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTixJYNR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTixJYNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69CCC19425;
	Tue, 14 Apr 2026 09:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776158768;
	bh=m8knM7/obNO7fgMbTos92vtsng+W0RU1LJnSkeeq8rU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iTixJYNRn9czvCSbccbixXAgxIbG07IrzjmoMtg7p1p+rP5QhDpoUAT5yzEjVijLD
	 +8P8qcMbiQkyLAyQ4WizDz/+IYjyXN7MXU6yRsx+BZKFK/o53OXFPWrn/u6xFU4lIm
	 phJmIVKOvzcvhiuO7Y+hEYgpuPNC7LKb/zIwTjwpSm1uZqAoxZ+SIb72g9SDv5j/uK
	 p+317flau5vYJKp7T05+NoSgmKSvAIscMema/5pZUMmIw7+QEalTNPlocomTDlR4h/
	 4b3tmrPU3OD7RfEYgS9WDQwEPib/Tw4HoW/rzYy11QLwQixRv/lYF1RXi6gch5cMAS
	 DFGGROhd1i1pQ==
Message-ID: <5f49393f-a61b-41c4-94bb-aa05390f0307@kernel.org>
Date: Tue, 14 Apr 2026 11:26:06 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] zloop: fix write pointer calculation in
 zloop_forget_cache
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260414081811.549755-1-hch@lst.de>
 <20260414081811.549755-2-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260414081811.549755-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 10:17, Christoph Hellwig wrote:
> The write pointer is absolute and in sector units, so we need to
> convert it to a relative byte address first.
> 
> Fixes: c505448748f7 ("zloop: forget write cache on force removal")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
