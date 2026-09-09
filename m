Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E42E764D
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921873; cv=none; b=keJR0nWavdEAi/GZ40YpDgbpUr+fiTpATum+UTrMVm07gvYUrPvvV7BquWe2k4BQeHPi7biIiond3OUUG/74izD9RxE0KEwzdI5Sw3bkvaLgIonaCDI+c3J3HRCUJLBNWYRtNm0bGzdF3Jf5kxdvSnOtmWjmWY333HSQJ0NXymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921873; c=relaxed/simple;
	bh=w1w0Y2elVgD3An9ulV8iOGtadJuQLtgbzZC7Yz3nPWw=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 MIME-Version:Content-Type; b=dKsOr861gG94AOhU9uPS1i7SwG9cR+4mEU6MpZuKBy6D3qC9jAOyo9q0LKwb7kFblWFAfz2C5FbV/fLqcwShdMxAzpJ4o72e4IlhWlvUM7z5x5f4vMybyDG89thLGDMij6iYSjI7Hz+4QNSK+i73x/WdJa8WSdwWAcDMIuAndEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+bQqrSN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+bQqrSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F181F00A3A;
	Wed,  9 Sep 2026 02:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788921872;
	bh=e6hOEYIMJeoS1nlYZDXALvJdR4C8Rcsdz07QKCIQlIw=;
	h=To:Cc:Subject:From:In-Reply-To:References:Date;
	b=Z+bQqrSNDE6l0TT1zIl4Wh5CUtXVj/ZjX2oLmN2awjkPs+NJJbpQHxUbPEw1C+HQi
	 SntNYWOGhF7LTHXqZ9jXIbRKGIrH7NcJHwKcwWqkJ+YaWYIn9eO3brJIr3JUx76Qyt
	 xgTmnfdFdFp+u4+G9O18KOQZRLpx/ozBjetg8GXvAjIrFzxpttPXc3CGhWFa0YUKCz
	 Udhtjj2meO5eSpsFSk8/8guKODayM9BGSWnKJB7RMvQUteUSerwDhju/Idc4Ji+Jsr
	 R7HrbzaKa4wGMY7LCb34chkl+SbFr2vYMldObYhFZwG6uN6fsB06TyX23YCZljxrap
	 Da3bssTfpHE9w==
To: John Garry <john.garry@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>,  Jens Axboe <axboe@kernel.dk>,  John
 Garry <john.g.garry@oracle.com>,  "Martin K. Petersen" <mkp@kernel.org>,
  linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] block: cap atomic write size by PI buffer size
 constraints
From: "Martin K. Petersen" <mkp@kernel.org>
In-Reply-To: <90f94bcd-813d-48f9-a62c-3c703c4a71e6@linux.dev> (John Garry's
	message of "Mon, 7 Sep 2026 10:19:58 +0100")
Message-ID: <yq11pb3dtzs.fsf@mail.kernel.org>
References: <20260907074111.721054-1-hch@lst.de>
	<20260907074111.721054-3-hch@lst.de>
	<8c16f727-c840-4a8f-94a7-fbe09bc3735a@linux.dev>
	<20260907084621.GA7391@lst.de>
	<90f94bcd-813d-48f9-a62c-3c703c4a71e6@linux.dev>
Date: Tue, 08 Sep 2026 22:44:30 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


John,

> As for atomics on disks with integrity support, we decided not to
> support SCSI WRITE ATOMIC (32) - this one is relevant to PI type 2.
>
> But, overall, I'm not sure on this - should we always disable atomics
> for any disk PI? Is there a use case for the two together? Martin?

I think we were originally just trying limit scope. The two features are
orthogonal, I don't see any particular reason why we shouldn't try to
support them concurrently.

Type 2 is fairly rare at this point. But it should be fairly trivial to
add support given the existing READ(32)/WRITE(32) plumbing...

-- 
Martin K. Petersen
