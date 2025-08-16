Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE39225D7
	for <linux-block@vger.kernel.org>; Sat, 16 Aug 2025 01:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755306150; cv=none; b=KMcc6vQXxeNzhYfl6WOw7e0pOkgZhDlejAzC0svqXL8fk/kR4+jPV3xi1vj51yY/SRomiVdH2g37E7RaPAyxDGCvm3XmbwPKp/EaBslKKuu9CWSVTUty5I+Fc95zCWNXwIVyf4yDF5KFyM/r+cxKAveqTpl11/YfiVrhpiaov8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755306150; c=relaxed/simple;
	bh=IGaNBt81eGLNzfcnIqCcOjNOROpEiln42gdAT0hcf9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyzLidy5anjdBZedkcwCkl/oiIfbiVXpczfAmZVLx2jFZY+QqPwbWDXjwIamULFTBdp16CoTKLTwRAVaeDbuKFAUsL+T+2nz8TeZnz0JfZv5zT//ULsyh0EvZGNJ7MktaLbY1cU009dAiEP20MtylsKpLP+T9mbxm4nfbPwzs8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuhXUZ/W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuhXUZ/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE34C4CEEB;
	Sat, 16 Aug 2025 01:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755306150;
	bh=IGaNBt81eGLNzfcnIqCcOjNOROpEiln42gdAT0hcf9I=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SuhXUZ/WuoVRJekdRydZ/SAu8hUVjtvPa5Ey0+OSW+wHPQVEdQWDnoEKZepwEgiWx
	 50OPXbQTbOyDFVv5zGeMpsfmtVPvIRpKsp/nmVAj4e7TGRii2brGr07UwaXYhxnOSe
	 l+IDX8uomjR+6Df1/zQAAQaAiKpYN380Z++Mw7MPnlC8+CwrGHd898aqmC8zyLCcZp
	 SyvpEOd+QJcG14qtRtXVk4HiyQ1B5rvAnL6oAXtQUGzCidjvTU6jPJzw7kyV9zvbM6
	 jtE7LuFkxjhXViXErO/ZaFuHPkRtnYMxUCfa7lk4MkomN6TCrjon5rAG0WwJtbr4kp
	 4mlsuJDRTO7Xg==
Message-ID: <67582b2d-1dc5-4b3f-b9f2-d911c2845580@kernel.org>
Date: Sat, 16 Aug 2025 09:02:27 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH V2] blk-mq: fix lockdep warning in
 __blk_mq_update_nr_hw_queues
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai3@huawei.com>
References: <20250815131737.331692-1-ming.lei@redhat.com>
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <20250815131737.331692-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/8/15 21:17, Ming Lei 写道:

> Commit 5989bfe6ac6b ("block: restore two stage elevator switch while
> running nr_hw_queue update") reintroduced a lockdep warning by calling
> blk_mq_freeze_queue_nomemsave() before switching the I/O scheduler.
>
> The function blk_mq_elv_switch_none() calls elevator_change_done().
> Running this while the queue is frozen causes a lockdep warning.
>
> Fix this by reordering the operations: first, switch the I/O scheduler
> to 'none', and then freeze the queue. This ensures that elevator_change_done()
> is not called on an already frozen queue. And this way is safe because
> elevator_set_none() does freeze queue before switching to none.
>
> Also we still have to rely on blk_mq_elv_switch_back() for switching
> back, and it has to cover unfrozen queue case.
>
> Cc: Nilay Shroff<nilay@linux.ibm.com>
> Cc: Yu Kuai<yukuai3@huawei.com>
> Fixes: 5989bfe6ac6b ("block: restore two stage elevator switch while running nr_hw_queue update")
> Signed-off-by: Ming Lei<ming.lei@redhat.com>
> ---
> V2:
> 	- fix the issue locally, so patch is simplified
>
>   block/blk-mq.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)

LGTM

Reviewed-by: Yu Kuai <yukuai3@huawei.com>


