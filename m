Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA52264609;
	Mon, 10 Feb 2025 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739221659; cv=none; b=RbDPlSt3iVzUAz7+yT7z+Zz7600s9p93HDUT/Hmla7GB28zYfz7+tEx6Iq2fTU/0dy5p/offOG6pWICL93bYUio1rByUfn6zo1QLheLkDNM9DM19LKA2RR0fcTadve4PcgIWDQUArEuBlkg1adgLv6+7/ZvsuvQZ/l8ijVhBG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739221659; c=relaxed/simple;
	bh=uKMytDm65WfpuM3ht5iNiO+Sdb/xC69jq1paxJhZ2TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HC0ca8gLPDvfmqxxjX7+UMGxWmMO5zndrel1/nY0vJdVPE05Ceb/iZW5u6gS+/gP5IuGEuCx48SEv+eURX4V9YZv7xOlVz9kmxELOacnCsxjShnAp/q38nGGTY3G5IBnssLITztixOsFIfutZ0GPEPBypoxY3muggqt61BdMRzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivfXUAaW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivfXUAaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D309C4CED1;
	Mon, 10 Feb 2025 21:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739221659;
	bh=uKMytDm65WfpuM3ht5iNiO+Sdb/xC69jq1paxJhZ2TE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivfXUAaWwaV/H2tvqoHdQPA7LbaEFLw0uLuLcyGsoJBK+Jic7c0gM+9955tdgDocx
	 UonqXOXykQMH0F5n0YOuLFTbwwsyHKNdYSZdyuuU6pQk0LGO1JEZa7K3jZshOOLe7N
	 58zV8e0pMF7nP4Hhz3bq4rQt1mTLAw/Z3RdbLKUAwhqkaGPvS3L2jNwWpisL5fvx5m
	 LYMQSnNcdBHkeOOiUz+0ILZmwDM+oC8oeFLJX4Ys6NCot4muN+orGktxmvOrJPap6S
	 mHRmg/4+XYDtpOrVjmma9FzezyE1S1OHs/qB31cE6gtrArS4zwZ3BpcFk30fBM0vuk
	 qAAouRyb9ZvSg==
Date: Mon, 10 Feb 2025 11:07:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: axboe@kernel.dk, yukuai1@huaweicloud.com, chengming.zhou@linux.dev,
	muchun.song@linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RESEND v2 1/2] block: introduce init_wait_func()
Message-ID: <Z6pqmrc8stUHBJHS@slm.duckdns.org>
References: <20250208090416.38642-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208090416.38642-1-songmuchun@bytedance.com>

On Sat, Feb 08, 2025 at 05:04:15PM +0800, Muchun Song wrote:
> There is already a macro DEFINE_WAIT_FUNC() to declare a wait_queue_entry
> with a specified waking function. But there is not a counterpart for
> initializing one wait_queue_entry with a specified waking function. So
> introducing init_wait_func() for this, which also could be used in iocost
> and rq-qos. Using default_wake_function() in rq_qos_wait() to wake up
> waiters, which could remove ->task field from rq_qos_wait_data.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

For rq-qos / blk-iocost part:

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
