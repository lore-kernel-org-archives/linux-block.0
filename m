Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217641;
	b=KN3A8NsjhSlcjGxHI9n19A2BUBLom0Risr4YBptY6TNW/6F1ainmnIf+90coA3aiC/3L
	 YiiVXa1RodYs4L4zeCZNV+01/5n2Xc9ZZGDqele9W4XWgxsqFb7biJ78TQley/34rdxxi
	 Wm7wISmsJk0/3Gf/o9btZ0+YX92Mk42aU8wz4te/PQofGj1ryY0UKYOxDoWa3U9nqks4i
	 DbLGqsbJ8HGAr6LJwMS9uSIdLNQe6ccMO/qZ6zSjtp+cMLSo/qYeS97oKGblYE9p9hxYe
	 07/1GbuvTo6lXS5cw+bl19/BcCieFaAcSOf1Hvb+UbmE+2FZUh+6XObw2wqprKCxxuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217641;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RVH0rSVmsURQSHOlQKNpNDNK818M3OeEKV/NXStpJsk=;
	b=ifN4FZ/lRI1zaZmkCOgXp+OvgL8EHujOMxBmsYDeMgUcyl96alpctVeZ27CabMj6mZ1m
	 mwu1LrXSR831z+z5d/PDCSEUtslMynLm291aHhTMnjWPbm+o1ClgLBPQLPmWtWQEAr+eG
	 14dtF4RV1O06OwHTKH38tFNQ1SIjfuj5vskjY6T+PlepqdeKJ4uv9jiMcuAHmFuy4xvc9
	 ca4zw+Ai/6yxPoJ0L1x+nim5bvUzLuGDwqRV11W8AynCy3+tvCBPiuuI02PdGHb6wTn7M
	 TSkNcpVNa7kizsTND9B1GV8lWWYPVTdxE14CfRDT4rcAMxupv3d+YlWPNpn23Silp2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iO+W4GQu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E79606A326
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iO+W4GQu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161271F031E0;
	Wed, 28 Oct 2026 20:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217641;
	bh=RVH0rSVmsURQSHOlQKNpNDNK818M3OeEKV/NXStpJsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iO+W4GQuI+jKKteU1jHU/59c9cYuCCZDadxEcqPDAmj/t22Ecrecqpr+M9TQCt2Sa
	 G550/5dCQo0e+XudXrEJ9zD5bdyDnvIahi9a55yuiOiOQYaj+TJIGx0eKLIoURJ9j8
	 sWQ5JCSKffgUfPFmE6xU0OJ71EjHwv/2Br8be5ui/CT7MGnFdu5sVugMdH166/MnU/
	 GTDnUCzXEU9bpYKtIEwK6DTxbEOXhyZuWmFgtonqJ675HOOnyItS+wduFxCXIox7TT
	 VbjbVY+PlvEJ+GKiFxygUOT881gVia72LUcVgbKL3vlmneekBbbSuV8e4E8CNKVwrF
	 Hhnqnf6+7lF3g==
Date: Wed, 28 Oct 2026 10:00:40 -1000
Message-ID: <cf5baa98654f422ddb1cb582cfd30434@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 02/98] blk-iocost: free struct ioc after a grace period
In-Reply-To: <20261028164415.1262013-3-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-3-axboe@kernel.dk>
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

On Wed, Oct 28, 2026 at 10:41:05AM -0600, Jens Axboe wrote:
> ioc_qos_prfill() and ioc_cost_model_prfill() take ioc->lock from
> blkcg_print_blkgs(), which since commit 56cc24f59c14 runs under RCU only.
> That covers the policy data, which is freed after a grace period, but
> not the ioc it points to: ioc_rqos_exit() frees that right away, and a
> concurrent read of io.cost.qos locks freed memory.
>
> Free the ioc with kfree_rcu_mightsleep().
>
> Fixes: 56cc24f59c14 ("blk-cgroup: don't nest queue_lock under rcu in blkcg_print_blkgs()")
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

--
tejun
