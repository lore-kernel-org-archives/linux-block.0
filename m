Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217142;
	b=Hvfs3VMHtTWKKPb6+RpUTIKPmk8GW8kJo4/cOvTGrYbVP/WnZVdh0YkXQfX16WotaG5D
	 xsoGTGT37/uXbqYGvNzpsyThvjvVfW94up6WCAZRm90UYsSghgKEZyPimAwKCnWQLsyrX
	 wwQv1E8mQHKRyfVSyDBdHmeCc3mF/ODHcVdYkfJP0vk/bsmQuiQ0iNFZLuGWegl91dCXp
	 qlUIDwCiGiT7p3S0+xH05WLZ0vuVPPM7WnRLB3wu2LJvKeTlXEZiTL9Alaycsj71BLnKV
	 GRl3K2j+9eZ56etp83SM/ljl1e5nso9mxDCJM+URIOflBzx1zlzyfQIld9RinGGDjdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217142;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AtF8gwqEDOtZI6obv958lG6gGxSzDFJL4G5waOARj2s=;
	b=DnjZYjsCOeF794tdkgxtztIYADJSqk3PrdlBpG7R4oU4XyYKZkvGhTpKCS+UYHJydrRr
	 WGi30Tdfao4QSJgD0aSUtdMhRSICzTGXisMKGzZ2WPMOcdGvInz2lJLt9Q+5Lv0PDbcqt
	 7Ypd0ueFgXMv6lGdvfibspHcDGO0Ljm7BMPuAUkpkLWX+eD/dNSI+3r60l/kcNgUgqAVP
	 bnGsUZENlyySvL7kN1CDFmSyugZcPRzZ9t0VXxCcwIIKu5ZxuAs5hRbRqp4gAJp0vS7Q+
	 b2iwxd+VwZdwTLChU41jdG9fWtM9eDNL4e6aHqrV0YtGeNBy4+nY5gtJIjOvkUpR/dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqyEJLK6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE1606A329
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bqyEJLK6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939701F01825;
	Wed, 28 Oct 2026 19:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217141;
	bh=AtF8gwqEDOtZI6obv958lG6gGxSzDFJL4G5waOARj2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bqyEJLK6pbj2o9OFvu7Y0o5T6jHQ2Gbt6IhKqNgkGNiOEtfv3DBxsQ2uQaB+46NSj
	 EMXXoK7yXlVxBIZND/qgobFoMWQoRS64iFj0tNCKLpdQgU+VzsJvDB/81Rbu0sVD3R
	 BD6nLLJsnvIZW1a99TnK8p/bXIVd06/DM8uoKxn95nXJJuBJFKmE0aE3B8JbiEtgp8
	 vo/mxdyTm9sagR27lNT6ZJkPtKOwscLf+KgOKQodbemb1cLOAOLvAqrxZNkejH2f3T
	 2oinxig1QAFf+rXVnYxZUK+1pfJZxwc7mfAFQVwCA4qJtrnEUgPaIrI6lmUbHxYdfB
	 65n79qrSNSjFA==
Date: Wed, 28 Oct 2026 09:52:20 -1000
Message-ID: <83384c0b3d8483de8c179acb727da0ae@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 19/98] blk-cgroup: don't free a blkg with its punt work queued
In-Reply-To: <20261028164415.1262013-20-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-20-axboe@kernel.dk>
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

On Wed, Oct 28, 2026 at 10:41:22AM -0600, Jens Axboe wrote:
> blkg_async_bio_workfn() relies on the bios on the list pinning the blkg.
> But blkcg_punt_bio_submit() can call queue_work() after a running
> instance already took and completed the bio, and queue_work() succeeds
> on an empty list for the same reason. Nothing holds the blkg then, and
> free_work shares its memory with async_bio_work on top of that.
>
> Hold a reference across blkcg_punt_bio_submit(), give the two works
> memory of their own, and cancel async_bio_work in blkg_free_workfn().
>
> Fixes: d3f77dfdc718 ("blkcg: implement REQ_CGROUP_PUNT")
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

--
tejun
