Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793217143;
	b=iPCQYpLsdOU9QoXFRkiGZSSbzMUrGLETaTJtdc7flC5UAUFnZRA4wExU12Lx/msN5waY
	 GYyajx9njnLWB+aDXMsmk+QwMNdYymAiCM+eHqOg1eXebcu20U/cyJyOJhhZVxQp4BoCo
	 BTxWpXkCNQYqSCSWgXc8NY5ypkuMVncVMgo4B4+Kppe7NOPQ3FyGdm1NoqdKS1gX7Swoa
	 foTBHKSLXsKL+3HJfQnmV4RwMvPh46XG4VuZi7sxuLtCjPfljLkErdw4sz4VqKe/+IqUN
	 zUppqvYPN3/+NZn6QMBPY3V6cXlHEIas3i+uQv5csmTXxf9HG21XUygRIiXrmeETPfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793217143;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WrLQVvIBF16QctV3AgEdD6+deB0dsd9V1mcd9heBiWs=;
	b=057qH0vKj7MX5z96A16IdEijiF6EXMgGU8rKWjisU+uR4821Ngo2YE6g/8zoP0Q9eMlM
	 eSYnQ416dtIOINKyj0E+mXpVivplb3+lxabhSDZOoKlCnhSDBCezZxDzIY2lgY3m1QK0g
	 42D9VQVNxtf/Ry2PeP5uIM9C3Gaoul5iwCGerwvThWw700sGvEgN1L3yx0nLo2D/6j9/s
	 beLEZyqoqQARI4ISQHTtCll+SmmQYPbOxZHoHScpzbV7wUf4MAWKrW4FiSYTeZ1tDgGpm
	 /oM9iVuPy+oACXKxc2Y4Cz1NKOqEsJo2J3ZjaafugXak6XO+UjxQptGxX9ToiOorSrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPktCOlw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142BC606A324
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPktCOlw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D5A1F01825;
	Wed, 28 Oct 2026 19:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793217142;
	bh=WrLQVvIBF16QctV3AgEdD6+deB0dsd9V1mcd9heBiWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hPktCOlweDSwoh8zCMDCP3/4+NQ6CnRw6b7FM6tTuZzdlRc3u6FJstzJi6xJi+Lji
	 Z8ZNxsQoRkToQYBZ1NSMUyYtNYrK0uvvle0j1b7STwpHyKbtrn8sZyq1aHZ4RIM6E1
	 1C1l2I3Kzt0V25Ntfhi+irgGMq+nf8lIlwJd3/44dfDGVwq7qXzSZ/gDW3R1DxaLIJ
	 ttTKismEdMFwlaWQnIWoP5qF4EfpVGs5fUftUIkvmbrI+j1IHjBbdLx+lBqbBVK6/B
	 RK6+a024IOWEqi1oTslp5i5jwjpihJ9X4cxaY9JOMYuv4CREUwfRCcfxd31eTqoUka
	 XVRKCH3C9iNnQ==
Date: Wed, 28 Oct 2026 09:52:22 -1000
Message-ID: <50a198d5c9b51f32aa052f4603c3cf93@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 23/98] blk-iolatency: flush enable_work after going offline
In-Reply-To: <20261028164415.1262013-24-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk> <20261028164415.1262013-24-axboe@kernel.dk>
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

On Wed, Oct 28, 2026 at 10:41:26AM -0600, Jens Axboe wrote:
> blkcg_iolatency_exit() flushes enable_work before it deactivates the
> policy, but iolatency_pd_offline() schedules it again for the last group
> with a target, so the blk_iolatency is freed with the work queued. Flush
> it after the deactivation.
>
> Fixes: 8a177a36da6c ("blk-iolatency: Fix inflight count imbalances and IO hangs on offline")
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

--
tejun
