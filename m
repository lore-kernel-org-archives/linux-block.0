Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038198;
	b=GnofaNj265tfcJ4dGAuzCvSYEcz+wVWwZLwPCSNrScQthTW2HFmilvLqqId1QzuzP9hb
	 EzpM2BOxY2/Dy6xhpVUnI4m+th/szLAH63fTipZzv2xPyZ1OujTWItyUaAAU5/Iq6He0z
	 udPqo7nlmRUifPcVz+NZgXdFA0WQz18452LrCK7BH+qJWyeumxLgXTayd2xkzfIaa4N1R
	 fbLBoWYwenyOFDC0DQu0BP+jb5ftNWsHoBrJADhTG8tDBjLkbyD75Jjk3yVywk5OxOVUa
	 nIk4rUJ8I0dySFxNVLVFzTkGs1ZVFQ8GJlBYZNJSMRrnY2NAE5+duOh+9xrX/nskwRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038198;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iw/ywNpB1BSsldr9vUW+pB0jshll186b2SSenoSl1Jo=;
	b=GUOjEIhHWyetly6I+ub59R2/r7vqkddCPBfDIG2gf8no1C8EEVYMi464Mda+3ESVpk7O
	 8t4Gbdhu6pi5e65d63uDFcxon/s0OcMlofl8U6yJHPcGccczWRcD9uI7/NSFyZSVGvjxf
	 ErXB0vPoA+JnYCYUDbLYqHFPw97KKCXg86veZnCBk3yEBeedvWUxixsA5WeynnGsHj9R5
	 bbn8TU7UEu3YMtyfjT+o2MkVf2D4rNSWhX945/ydf/cmB69FEundUgmYMxcA2RE0BNbMY
	 pMyUbMF+BarlaxeKe8d8vN9ESgLzZ7O9C7udpX9/e8/isaGMvhlPH0BUGnbO4F7SlvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=je13eXEE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203CF606A31C;
	Wed, 18 Nov 2026 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=je13eXEE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E70A1F000C4;
	Wed, 18 Nov 2026 21:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795038197;
	bh=iw/ywNpB1BSsldr9vUW+pB0jshll186b2SSenoSl1Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=je13eXEEkDZyNrdMU2VwsUFV47/il5K6CHjjTuTcUmsKyO6+rcz/fkrmEpk6sWWnA
	 mYijnDbWmWGr24G326O6ZMv6SNvU1IBl3BeeiWkuEnQmeeLz8II5jNzP/H4CmnJ1ay
	 Vogwt1/Ec7TTWeyKoiqm6nXRPyF5xOYz4e0MlSVOtf4r5WEqHl89+naKp6X2fxcAjF
	 FUcxpAyB4GsBEbRM1UhboQzH0O99pCxI+2A5X45JXn0zJE6UUj/ofdo8p9tSs5lOV1
	 DMGnKEZAUgSIAx+15PLPHqtzZmu1YmDBh9wxCvxcMILqb5iw11wAV/TeMq7vBJ0dDj
	 CkXv7dAivHQjQ==
Date: Wed, 18 Nov 2026 14:43:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: "Srivatsa S. Bhat (Microsoft)" <srivatsa@csail.mit.edu>,
	Jens Axboe <axboe@kernel.dk>, Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] block: Fix NULL pointer dereference in
 blk_mq_complete_request_remote
Message-ID: <av4b9EN8n9t0jjeC@kbusch-mbp>
References: <20261119-fix-blk-mq-null-ptr-deref-v1-1-9bcbcfcfaff8@csail.mit.edu>
 <av4QS4NK1qL1QPCt@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <av4QS4NK1qL1QPCt@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Wed, Nov 18, 2026 at 03:53:31PM -0500, Hamza Mahfooz wrote:
> On Thu, Nov 19, 2026 at 12:58:44AM +0530, Srivatsa S. Bhat (Microsoft) wrote:
> > Add NULL pointer validation in blk_mq_complete_request_remote() to
> > prevent kernel crashes when block drivers pass freed request structures.
> > 
> 
> This looks a lot like a driver bug, so it's probably best to hunt that
> down instead of trying to work around it here.

It would be better to go another level lower and fix the broken
hardware. The "bug" is describing device behavior too far outside
protocol to be usable.
