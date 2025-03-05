Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBED1DB127
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201914; cv=none; b=hSEWHzOQOWO4LZp/rm/WJw+26qODktz+pJ2q6AVNkPRYCFIk1uxInCmEebndrGEXDidP5bMm9IMdufGQw8AkUaYy1WBFh2T7pIPieL8j1mYChq6JhuqRJr8VoI6okQxIpEYD6kR3qNzJev3PMTmVMSHKFVRh0uuz4XLTXVp1S9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201914; c=relaxed/simple;
	bh=3eDQ+kjzvK0TXT7YcWSJHFWFgT5pbm8mNrqzeMm8ku0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RueXQ+eXz2JwLhj6/dmh4RDOGDtkQcb2XF+chX+T5EqMlUsqc/3vFuOGUatWR9BLRPvyG1mD/+1u83F4oLC2RhtjnUuTnq7qwYQ0gXMQWKJdZf7EsoQcwVNo0SYiKUfiKmewg6KUm46w/K9N809wX0fQDb0X0svPNs5kl4TF66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIxBQS6o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIxBQS6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE489C4CED1;
	Wed,  5 Mar 2025 19:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741201914;
	bh=3eDQ+kjzvK0TXT7YcWSJHFWFgT5pbm8mNrqzeMm8ku0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIxBQS6oM5lE8+WVcCBoeIYucOLX0ye22b/YOIGT4XIhWQnT8krXrNdbFObT98ylp
	 0UPZA4/adp1CPm0pD52un3ILmboHL0gjiV1e1hWc98ZWxW3iI4g2DE5yHA+ioTjT0q
	 MWgPM43mWNfGgy0o/Zmmby++pvEKPP0pc0UC66O88q34JWgyZ+VEksdlwi24cxqSYA
	 /sOHLGjeeVkIKDG7gAHl7u36FP9/LoiSXHrTtVtQftNZZybEHCaukM6YHxrxz7Ctfx
	 IUyNamSca9XJGLaSJx6hP35eQ/wW6z3zj5z+5arRTgm9lQOj/phvLBB3NU13H6YFFo
	 ydKKssYsr3wfQ==
Date: Wed, 5 Mar 2025 09:11:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 2/3] blk-throttle: don't take carryover for prioritized
 processing of metadata
Message-ID: <Z8ih-fvhvAMhss_d@slm.duckdns.org>
References: <20250305043123.3938491-1-ming.lei@redhat.com>
 <20250305043123.3938491-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305043123.3938491-3-ming.lei@redhat.com>

On Wed, Mar 05, 2025 at 12:31:20PM +0800, Ming Lei wrote:
> Commit 29390bb5661d ("blk-throttle: support prioritized processing of metadata")
> takes bytes/ios carryover for prioritized processing of metadata. Turns out
> we can support it by charging it directly without trimming slice, and the
> result is same with carryover.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
