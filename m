Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131D42DFF5;
	Fri,  5 Jun 2026 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646062; cv=none; b=i2PqnBKbxNJMPPWaQDtgGzXg95D521nLtabKeohwBlZ6Rjzk3lfvNh8eJJafJhyWJdddjapM8/wnv0WLeJRqQ/nRp4ZcHUUzBUEfUU7BiGX+DnFxTWsZ2+Wf2WwmdYzegCMhPuALAHmHA96bcUVII8RbpL6aGj7EKPePc6b1zow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646062; c=relaxed/simple;
	bh=MoXaDMrJhDz4mKgR919Mu6x0gYey4sFYzq9SjQYNLjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uNUCKYNVUgybtEKYOuEV4tk1jZDQq61kvvJ7jRjchF5JnIiah3mvwIHh26HIEw4UMNUmA6/7Gt5K+1d253s/FfXP39i3lH/wisRVU0jyKJHu1hJGacFzvrUXu+UkFb282a/2k1czquhqmkikXQW5rvzyucJSJWKEILY/gh6sxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hr1UpMit; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hr1UpMit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76ED1F00893;
	Fri,  5 Jun 2026 07:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780646060;
	bh=MoXaDMrJhDz4mKgR919Mu6x0gYey4sFYzq9SjQYNLjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=hr1UpMit4SuClwmwgQ+uvhn/wYmO91sakeYXyuZcTZ0uV29luYsLsfakkc/85vqBH
	 jR1fUwuAyLM8HfGIdt9EWwPCqiPqhW+BQJagfszXikQAXkHjxIj4XAZLq8fJLyb+8O
	 Ik5lXtcC5Xp/y3zwnJ035v6vebALY52Oz8iQQVV3oFB+CUxA8uEdk+XsXR24oENMko
	 UctFD9yLwOixJ2c9rfkK7L6h6ucVnJKWgzfZaOXzocsL15Jj0inaeQXSTyNCXLnrB0
	 loEkCmcOyH1WpmobiIVagKsbCKDYW40gQoCXT3R0hDf8Ra7Rl2F144+LI1Mzl9sL3B
	 J8gpm/pXY1c4g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Christoph Hellwig
 <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>, Jens Axboe
 <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Ming Lei <tom.leiming@gmail.com>, Damien Le Moal <dlemoal@kernel.org>, Qu
 Wenruo <wqu@suse.com>, Hillf Danton <hdanton@sina.com>, Miguel Ojeda
 <ojeda@kernel.org>
Subject: Re: [PATCH v3] block: assign caller-specific lockdep class to
 disk->open_mutex
In-Reply-To: <226152a3-1e4c-4eec-9a17-1d40426a7b18@I-love.SAKURA.ne.jp>
References: <147ed056-03d9-4214-b925-0f10fc00cf27@I-love.SAKURA.ne.jp>
 <4cf7ecc7-932c-4589-9d0f-3e025e83e27c@acm.org>
 <20260601071113.GB7468@lst.de>
 <420f723a-8168-4f56-b84a-2a36ecd87fea@I-love.SAKURA.ne.jp>
 <226152a3-1e4c-4eec-9a17-1d40426a7b18@I-love.SAKURA.ne.jp>
Date: Fri, 05 Jun 2026 09:54:12 +0200
Message-ID: <87wlwdifrv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> The block core currently allocates a single monolithic lockdep key for
> disk->open_mutex across all callers. This single key conflates locking
> hierarchies between independent block streams. For example, if a stacked
> driver like loop flushes its internal workqueues inside lo_release() while
> holding its own open_mutex, lockdep views this as a potential ABBA deadlock
> against the underlying storage stack, leading to numerous circular
> dependency splats.
>
> To structurally reduce false positives, this patch splits the global
> monolithic lock class into distinct, per-caller instances during disk
> allocation. This is done by replacing "struct lock_class_key" with
> "struct gendisk_lkclass", which contains two instances of
> "struct lock_class_key" for the legacy "(bio completion)" map and
> disk->open_mutex respectively.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

For the Rust part, we have existing infrastructure for lock class keys
[1]. Please take a look how we generate lock class keys elsewhere [2].

Best regards,
Andreas Hindborg

[1] https://rust.docs.kernel.org/kernel/sync/struct.LockClassKey.html
[2] https://github.com/torvalds/linux/blob/ddd664bbff63e09e7a7f9acae9c43605d4cf185f/rust/kernel/sync/lock/mutex.rs#L12

