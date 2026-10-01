Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18283E008F;
	Thu,  1 Oct 2026 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871028; cv=none; b=a5QicLIfhLAH62OD4BPpAlM4wlG7EbEFsE7CIysZFejjRAOGEjUcWfOe3pY7V6ozMp2JUvQ02PhjA0o6LKkmYNczWhPiJuqaNwpOxx5UJjUjqCLZEA7WmEmD5ORAMzQAjz2B965I4E/k3S4nhHM59Gf2nYqGcIzBlg9i/WbVlGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871028; c=relaxed/simple;
	bh=aVNqZcABgbs32+A95jsE0b3FnF3dktGddMtfUNUgeRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olVtnRPJfZfoNyVViBD8OeBS9dNqc2g5Br52fjS8hBLB2h2PzfKWAKhRKjzDebp0vm/+UAqjbUIsDXrO4NweruwL+HsmYut2y61yBt8pDZx7oE2jvOO+Lgs7+U8a85evw+0TbQP6GAOHiGCn0oCbfLmDzm4+aorGolKkYW1a0l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuCwfIuX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuCwfIuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13E71F000FF;
	Thu,  1 Oct 2026 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790871026;
	bh=jFYKBSXmVrvCCp3cFMi714EVNYh0y7yNdphxelCDcQ8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=LuCwfIuXtzIbh9RHT5ij2NisUVkqoTeViflThr6+UoMreaXTHGvjdcqUQCIivSNVG
	 aV/AdqTTeXgAmPbJkhgO24SpyDUPnv9OOwLYCdBjFraIwKFlAsasIvwSl6xXjbmaoX
	 3Gnj3ItBBhXGrRBjczdxuHzLaGm1/XMEkJvYEpaixndTxwbviARgAfgBYIHUKzYNEC
	 6j+z7nd4/tUK8mykUxE6wdhMUOKR0AcrJr9A+Je2JY6E/wx/nKNDeFivG8H/QuNiFo
	 Tdta/5RAd3h9pLbVvbvQe8bjhn917pYQ8D7eis1PZZMenUIBziR36+grxNHYBXMJJ6
	 V3Uqhe0maOHTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 89FA7CE0CAC; Thu,  1 Oct 2026 09:10:26 -0700 (PDT)
Date: Thu, 1 Oct 2026 09:10:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>,
	Yu Kuai <yukuai@fygo.io>, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] blk-mq: stop waiting for an SRCU grace period when
 freeing a tag set
Message-ID: <3680179e-da3d-4689-96cd-58dce29a96e9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261001-bug-blk-mq-global-tags-srcu-v1-0-e8415da10d1b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-bug-blk-mq-global-tags-srcu-v1-0-e8415da10d1b@gmail.com>

On Thu, Oct 01, 2026 at 05:17:49PM +0800, Qiliang Yuan wrote:
> blk_mq_free_tag_set() calls srcu_barrier() on the tag set's own
> tags_srcu before cleaning it up. That costs a full SRCU grace period,
> 1-3 ms, on every tag set teardown. When the free happens under a lock,
> the cost multiplies. ublk drops its last device reference under the
> global ublk_ctl_mutex, which caps 16-thread deletion of 4000 devices at
> 19 s on 7.3-rc5.
> 
> The SRCU callbacks free only blk-mq-owned memory and never touch the
> tag set, so patch 1 makes the SRCU instance global and drops the
> per-set barrier and cleanup. Patch 2 removes the tag_set argument that
> was added to blk_mq_free_rq_map() and blk_mq_free_tags() only to reach
> the per-set instance.
> 
> With patch 1, 16-thread deletion of 4000 ublk devices takes 2.9 s and
> serial DEL_DEV drops from 3.45 ms to 0.17 ms. Destroying 256 null_blk
> devices from 16 threads goes from 5.15 s to 4.30 s.
> 
> Tested on 7.3-rc5 with ublk and null_blk create/destroy loops. A
> KASAN + lockdep + DEBUG_OBJECTS_RCU_HEAD kernel ran a 10-minute stress
> that raced device creation and destruction, I/O, scheduler and
> nr_requests changes, and CPU hotplug against inflight, debugfs busy and
> tags readers. It produced no reports.
> 
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Looks plausible from an RCU viewpoint.

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> Qiliang Yuan (2):
>       blk-mq: share one tags_srcu instance across all tag sets
>       blk-mq: drop the tag_set argument from blk_mq_free_rq_map/tags
> 
>  block/blk-mq-tag.c     | 19 +++++++++++++------
>  block/blk-mq.c         | 25 +++++++++----------------
>  block/blk-mq.h         |  6 ++++--
>  include/linux/blk-mq.h |  3 ---
>  4 files changed, 26 insertions(+), 27 deletions(-)
> ---
> base-commit: 551c722f40809618230001baccf219193e22fc5a
> change-id: 20261001-bug-blk-mq-global-tags-srcu-811e8d958281
> 
> Best regards,
> -- 
> Qiliang Yuan <odys.yuan@gmail.com>
> 
