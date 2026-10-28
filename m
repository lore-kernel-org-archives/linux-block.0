Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217140;
	b=JYJe32foaVJLZnT5VoVCDVXdPtQoffEtiU6BduT6sdIX4eEE6EjqZNWSpwQN8Y73yts5
	 7JI/8ITGEctYr7TcmymhsX1frxE0TrMP/u5Zg3NOPAjwswIRN173zC+4TvksO/Vf6jcEq
	 1NwRwkm6b0zcWnc0bBMfv6YjqHCwZJf8pJYoT19MrLCjGBmcWEeWf6cPtaGzSK4jsplVB
	 Yp7+QRUbaKGygLycmmFwC3RCD+R07cq6WvJtGB30H93iqBO9ebmpso1dxHbJkfLrR7T8R
	 QO5EvXxEF0oNLvIAgD/8qeKUIDcKYUD+jBOOYDs8XSpQ+Ehy76xtc6XwlmytA3MeJdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217140;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UCTej5ObvMvabAvVup2z9VkizMpBfIaeGWnHcOWpaoY=;
	b=vKKdHzziV5UCDpz20/YW0vjF22Smsiq6by1pQB7aOdhl+Ak4F+w7k48Pi+sn0xisbnjj
	 STh+mmKS3o9yq2IDMMy99D0hzdfk4ylBRqc8Vpm6v0qkZuProIYjqYdEz7ja2WUthf0IL
	 M8oTg7+iB3Fe9UOEtDW13oRa2xrB2xkPgLD7oQJ06YImu+jLKaTag4RnHyQ831U9m/Gfh
	 UkLFRuqEJB0Vw+B/xJseTinprAehXvAROvgpn0kfCzmP7AbNkj7jNsE6xW4ciQP0iFMEx
	 QG6js+vtXKeOcRCmkP2em0P/czXYXhsWBbqF1DPMJbGPPnNHmKUVCvD0IaHs7TqUWgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCAqSWLa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE35E606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCAqSWLa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB5B1F01828;
	Wed, 28 Oct 2026 19:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217139;
	bh=UCTej5ObvMvabAvVup2z9VkizMpBfIaeGWnHcOWpaoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oCAqSWLa5VVlThJv266w6E6dpfvNqREoF6cyBlx9X5NVDUUoezEMeVgs/6D9DBLSK
	 +OR4lCBXVnHOBeEosUPs0OqxiKv3aIl/0jrcbtX8lKSzPAUraX1OB+pmt5e3jn6qGw
	 l8eoJeCawE1OYo+6B3KgLW/BFZA8B6WoMU714OmZbRDITxTl7ySnRg829xN0U2IQ1e
	 ruzT0sTzoE+UCa8tQEdLocjPxB+ezEVAJQW/62zXpSrqLXJCLwImbo6v7OXYky4e1V
	 ckLHQkkB/BKnTBWi/k2QZ0heS+IfaOJvBCvX6zRK7F4UqHdHWBEI5CLFGnK53S6fUE
	 1AozqtlsgiFHg==
Date: Wed, 28 Oct 2026 09:52:18 -1000
Message-ID: <ee64bf49e00718c6c1f71325877e90f1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/98] blk-cgroup: keep the old blkg while reassociating a bio
In-Reply-To: <20261028164415.1262013-2-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-2-axboe@kernel.dk>
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
Content-Transfer-Encoding: 7bit

On Wed, Oct 28, 2026 at 10:41:04AM -0600, Jens Axboe wrote:
> bio_associate_blkg_from_css() drops the bio's old blkg before it looks up
> the new one through the css. The css is pinned by the blkg, not by the
> bio, so if the cgroup is gone the bio may hold the last reference and the
> blkcg can be freed under blkg_tryget_closest(). The rcu_read_lock()
> around the whole thing used to cover that, until commit 457d3c4f0fdd
> dropped it.
>
> Put the old blkg after the new one has been looked up.
>
> Fixes: 457d3c4f0fdd ("blk-cgroup: don't nest queue_lock under rcu in bio_associate_blkg()")
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

--
tejun
