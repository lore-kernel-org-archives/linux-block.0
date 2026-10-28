Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217645;
	b=QMTMW1B2mkLc+8g5LUtIGVtzFibln3EnGXBCTpI0KFW+EFdyDfZ30DwVKW7Se/ZMLCX+
	 /jgbT7UemVlHCIem9/aYTjR4rgBxGN3ZcNrXH6+2BWD2j1oiCMzpy1gdFhd4C2q5NS4HA
	 2L+hXwJCSd4ONYWwDXlucpBqM0Xp878O1aLQlxTneQgbOYUUEVylCEkd9rkFQXtLYiUPd
	 CQITLM7oBt9rsD9uCqgL16pHWxOCjvPBDiLc8CvHVMaVN39LzLHYjr8DstWZXD/X+7Uqi
	 DbiA7ZN6IHaslmuidgmd4o9SKx/TUpS1aHTM4H+oKWrQYkiv0FdgkJxZtxOpalJf0CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217645;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WSx7DuhnCEqIedxRuxQ5y4ASknjDfVWYp60BVwiyUuc=;
	b=BF3LJgu7pe6XrdiOfn9tu9GaZ2yXkp3hxMvTl6qpt2sRGnYabOPrAV11ZlwMShd5eooJ
	 Q0FCwGLmU0+WOh8Q6f/+iuqC9HDF5jpRy+gLeTJ9ge1fs/rSsExR0fTFLh/DDh+IvZ+D1
	 wr5r8pSjQtozorL/rFIjiznOyyStXGehWeWQ8MG1zHfhCM/oJ3QaTNgVn/QsKA6BlbUWv
	 mjGWY7gsNNTXz4FCVLi1bnc08JLeIku2N4r3NVs8WFE3xA8uL3jl4BafNv+I5ZE/CzM2a
	 VkyihufObWCgYY8lVusFBDpqdVEwq8z3Gw/wG15b8ANspjElY8VoWIAl5OAdxY5Pwnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atIYnbrZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5D606A324
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=atIYnbrZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454881F01828;
	Wed, 28 Oct 2026 20:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217644;
	bh=WSx7DuhnCEqIedxRuxQ5y4ASknjDfVWYp60BVwiyUuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=atIYnbrZ/qKLEKWeKs6EpfYPXgZ4AomqLhIc5EFxJ+ssiJMNPMZ9GxUddlkvOFQK7
	 3K2itjx+xPf2BCbvC6CbQEfap3RRCYoD6/35Qtbn9tjJIHM/S8aRy4ZlB819wU/zR4
	 Re4XoE0JrOuJf0s4OCNN0J78nl+bHr4Tpvg/fF/s4XfOCrkeQjHm4yRXKAL+Na3vWK
	 XqjK3FQWXfh3GjdBpQoGnVRrDGmCaxFmvqNzF+sRCesvcBtnlTc0f5Bo1Doada07zS
	 EEnfOKYllhqPhBxekyQmgc8B8DG+kMKZY3vd9WEKanHxRp60bFosN3ikRTlOqXIgLr
	 awujI8hDXXYcw==
Date: Wed, 28 Oct 2026 10:00:43 -1000
Message-ID: <66cdf745455b757dd236824902574430@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 34/98] block: don't enter reclaim under rq_qos_mutex
In-Reply-To: <20261028164415.1262013-35-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-35-axboe@kernel.dk>
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

On Wed, Oct 28, 2026 at 10:41:37AM -0600, Jens Axboe wrote:
> ioc_qos_write() and the wbt_lat_usec writers take rq_qos_mutex with the
> queue frozen, blkcg_deactivate_policy() does the same with blkcg_mutex,
> so nothing holding either may wait for IO. blkg_conf_prep() got
> GFP_NOIO for the blkg in commit 5d726c4dbeed, but the
> radix_tree_preload() right after it, the policy init functions and the
> GFP_KERNEL fallback in blkcg_activate_policy() can still enter reclaim
> there. lockdep reports the cycle on the first write to io.max.
>
> Use GFP_NOIO for all of them.
>
> Fixes: 9730763f4756 ("block: correct locking order for protecting blk-wbt parameters")
> Fixes: 5d726c4dbeed ("blk-cgroup: fix possible deadlock while configuring policy")
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

--
tejun
