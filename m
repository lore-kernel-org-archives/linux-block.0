Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D570715BF
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261556; cv=none; b=mc6ST72Oxpkglqh0xLNiDPZ5bLTvfLfECcbjYoUkkErF18LTbu8xem/ao5Ywnf9xDvdHsW4PB9geJYvE45b2LCv45RNp9Zm88/lCAg+U3TAtaq4Ev3g8n80/OD3UXdUqKnCfJVSjMDcAyv+XTu8tTu6Dki7BeFFX1hKJWlNVNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261556; c=relaxed/simple;
	bh=WFffLCZ8i4MRi8huHhIMMgb8D1Fx/rSrU3BqScm3L3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDPpDe/LrbrWrjyXmvDWvZc+ORC4WjPHG/A3wwQcxhTzV7XSedEko0+k9T+3A5G5aCZ10+B9WHjD+X/dcDfBBuGbSWgX6198/wdu0AGG5RviZ+8wPAYKvSw/6jdlBT3ueqCa0cw7KSZas3TJIqOwT3WMxuY7Ohhp24uz+dm93n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxVqCfRP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxVqCfRP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23B6C433F1;
	Tue, 12 Mar 2024 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710261556;
	bh=WFffLCZ8i4MRi8huHhIMMgb8D1Fx/rSrU3BqScm3L3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxVqCfRPIVplYYnhDow29DU6OjizIgLJfQ2zSvIlraVFJCri4Pd5RRF9ADhn5gwgm
	 Oos9HwfXw/xo9xWxTIAMjS9yNMhuM6iKsj+ORVkqZsePBTWMId/NqLYo00EV4t/mNM
	 YqVjEMZzijeQylMggOLr0MdjLP+lsKK87HkiOTA2ogO5puldi1VVSpkqW8JYp3cB+M
	 T9/OGgC4FfY4OZJ9P+8YITTFfhlcG3TmBDnxJ1UOhshgqUM7aSEorsfzRcGDiRW4xc
	 lDjoNq1LpbmoYR4GCiyCm/ODMXXTOtWzLZuEPrmvhO2e9v/FgVqsGwDOeJxzCgYPA2
	 e/1hpzW5FH7aA==
Date: Tue, 12 Mar 2024 10:39:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
Message-ID: <ZfCFMc0cNHvIB0Jz@kbusch-mbp.mynextlight.net>
References: <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk>
 <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
 <Ze-hwnd3ocfJc9xU@redhat.com>
 <Ze-rRvKpux44ueao@infradead.org>
 <07ab62c9-06af-4a4f-bae8-297b3e254ef5@kernel.dk>
 <CAHk-=wjtVMQQbez4ZhXBeu4gbrC+BxUf3gd8ypyR5BzV5ekfnA@mail.gmail.com>
 <01bc0f0d-c754-45af-b5a4-94e92f905f6e@kernel.dk>
 <CAHk-=wh1wS2fvZjWhLSR6t2h1g+PX-fp=zD9e-Fke3FPWtrGXg@mail.gmail.com>
 <9b957380-42c7-42d8-a95e-88ac083e3ffe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b957380-42c7-42d8-a95e-88ac083e3ffe@kernel.dk>

On Mon, Mar 11, 2024 at 07:37:06PM -0600, Jens Axboe wrote:
> Summary is that this is obviously a pretty normal drive, and has the
> 128K transfer limit that's common there. So doesn't really explain
> anything in that regard. The segment size is also a bit odd at 33.

That's "max_segments" at 33, not segment size. Max payload is 128k,
divide by 4k nvme page size = 32 nvme pages. +1 to allow a first segment
offset, so 33 max segments for this device. 
