Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880CE331222;
	Wed, 24 Jun 2026 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319708; cv=none; b=L0ZgyeggbxAy3t2BJlB8Mx8vexZbSDyt7zriadhW4akRTB4+eXRh9+qwzLhUmspDVhO8K/gyqGV2qPVc8GmGMnVy6YLNV07SLe8Ru8H8ShOexn2Spak2klRwSd0CCkKng/QMQ//eWUjPDwM/0Q7gY1P2Ci2MrBR4kgcVT9eORRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319708; c=relaxed/simple;
	bh=Uv5/QtnyjKFS5pm8wVoqgPFb1q4pdjYCx+GZ8pGu2Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6evwOmYBNa+TmzO4lHdRI6alwrFnqL8jGfZuR/raHtN7lRX8v6SmUjda2I2IxPe0TtT7wdEV14Vsf9xwziTsJ2TK3eEgYeMKgpgRJbqCE7KNLoeUJ3EleLuZMjqV4FlzzW28NaWUKcBD1hqHjpwj+Dlmd7shJaRi937J6fUxus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1oU9AAB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1oU9AAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B8A1F000E9;
	Wed, 24 Jun 2026 16:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782319707;
	bh=j897Z+KujcYJw29t4R5QYY3mPjEoYrjcEUTq/tuxyO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V1oU9AABnNlFIxWSMQcPFctRkqUpHDWxwyLGjYe+Y2o/JsYQB4ugLJkbH7zgqeZOO
	 HWE0puX42yTzo6pS9Fe8FeWFwM0d4UOsRKiU3GBsHYJwdq/khAYiMxZXi5rRX8rTBR
	 7QUMvQcHtoe8qwbU1bIMtAIpmXlDIqxvrGrb/vDnvAvUSdpVAlFXFSMZerylYnLMKI
	 G1EDBLltQN8PdyAd78qYq41gvnhPfV9CSZSXz5GGVHGSth5jX95hIDmzIlIugEKnWI
	 bqisbFAM5BaS4I/JfiXI+9F2h0lt+Ph9rlvcERjSyQq1mqjRLODgBoNL0tLlY/kAKO
	 5HRsyb9ExOIZg==
Date: Wed, 24 Jun 2026 06:48:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] blkcg: update iocost_coef_gen.py to use io_uring
Message-ID: <ajwKWhuKCTeXOPw6@slm.duckdns.org>
References: <20260624-iocost-v1-1-2d53f3c026a2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-iocost-v1-1-2d53f3c026a2@kernel.org>

On Wed, Jun 24, 2026 at 10:50:34AM -0400, Jeff Layton wrote:
> Recently I found myself having to benchmark some rather fast disks for
> iocost, but the old iocost_coef_gen.py script couldn't generate enough
> throughput to saturate it. Make it use io_uring instead.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
