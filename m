Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E934EEEE;
	Fri,  8 May 2026 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778274979; cv=none; b=DTfOFX8ADh48VaUsJ8B3vPGiOiWyiU1iFO/mPBqxygXTn9x31UPQxUg/1ofybQBKc/KB/SmxQ9Fwe5wLcAYaKsbCrhO4PQMtPCFokkVLZBL9MLDbt8ARhqdqqIR/UNz72VGUa9dvQQLEDTl8ZTTbPiWncIxLPuscSUkClmggIE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778274979; c=relaxed/simple;
	bh=70OCw1Vkjgg3oNBk6/UUtqGZOBPrd8//tlolMQrk7CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHxaOnxnO94AIo5vkPs9cwDZ8ZcxZrOV4miqHq9xYEAMhqBWGx3uA8Yb4j709ybDbxrbOq3w7R1O3FtFriTXKxYZHdKEWcdNiqDLDL1W39Y6O3WdXUuuFaQIRtun0OsIidINQziboak++Gd+FzWI1s4N8H1zMNLI9BfbmvwV0sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2+CJhfO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2+CJhfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4497C2BCB0;
	Fri,  8 May 2026 21:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778274979;
	bh=70OCw1Vkjgg3oNBk6/UUtqGZOBPrd8//tlolMQrk7CE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p2+CJhfOLKI7D+tdcb1zgUcXi9bmIgau9NrEK0i7p1R9a7M/qnKGiFtPbptErwuKQ
	 SiRwHsj464rZtXXmfoKEsOaA5sqTQq0yG6psHPuitAJZdU5TzMHs2aeyTNWrRKd0Op
	 oO+M2nt7jDQHkqYigcdQg1arrICvBGFeqCsD7/1ZA1nNayE5cNCnmN4LD3WrqQ+Hzu
	 KeiIyftDpyLXrZIATq2flJEWY6hksi3VYORgpP0JvhN0viJv1xuI6OiPOi621JWYbu
	 x7ppUHM/oHfzoyxDfTJ01fz6JhHBAhTUo5EBdBTDb8sTzuMyrUo7uD4++yE8O8W+il
	 zUVsEvgZbeKtQ==
Date: Fri, 8 May 2026 14:16:17 -0700
From: Minchan Kim <minchan@kernel.org>
To: Richard Chang <richardycc@google.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>, bgeffon@google.com,
	liumartin@google.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] zram: fix use-after-free in zram_writeback_endio
Message-ID: <af5SoTVsm2vVhoml@google.com>
References: <af1BNwmyHK6aU_uT@google.com>
 <20260508084933.3730661-1-richardycc@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508084933.3730661-1-richardycc@google.com>

On Fri, May 08, 2026 at 08:49:33AM +0000, Richard Chang wrote:
> A crash was observed in zram_writeback_endio due to a NULL pointer
> dereference in wake_up. The root cause is a race condition between the
> bio completion handler (zram_writeback_endio) and the writeback task.
> 
> In zram_writeback_endio, wake_up() is called on &wb_ctl->done_wait after
> releasing wb_ctl->done_lock. This creates a race window where the
> writeback task can see num_inflight become 0, return, and free wb_ctl
> before zram_writeback_endio calls wake_up().
> 
> CPU 0 (zram_writeback_endio)     CPU 1 (writeback_store)
> ============================     ============================
>                                  zram_writeback_slots
>                                    zram_submit_wb_request
>                                    zram_submit_wb_request
>                                    wait_event(wb_ctl->done_wait)
> spin_lock(&wb_ctl->done_lock);
> list_add(&req->entry, &wb_ctl->done_reqs);
> spin_unlock(&wb_ctl->done_lock);
> wake_up(&wb_ctl->done_wait);
>                                    zram_complete_done_reqs
> spin_lock(&wb_ctl->done_lock);
> list_add(&req->entry, &wb_ctl->done_reqs);
> spin_unlock(&wb_ctl->done_lock);
>                                    while (num_inflight) > 0)
>                                      spin_lock(&wb_ctl->done_lock);
>                                      list_del(&req->entry);
>                                      spin_unlock(&wb_ctl->done_lock);
>                                      // num_inflight becomes 0
>                                      atomic_dec(num_inflight);
> 
>                                  // Leave zram_writeback_slots
>                                  // Free wb_ctl
>                                  release_wb_ctl(wb_ctl);
> // UAF crash!
> wake_up(&wb_ctl->done_wait);
> 
> This patch fixes this race by using RCU. By protecting wb_ctl with
> rcu_read_lock() in zram_writeback_endio and using kfree_rcu() to free
> it, we ensure that wb_ctl remains valid during the execution of
> zram_writeback_endio.
> 
> Fixes: f405066a1f0d ("zram: introduce writeback bio batching")
> Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Suggested-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Richard Chang <richardycc@google.com>
Acked-by: Minchan Kim <minchan@kernel.org>

