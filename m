Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8AE1EEA3C
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 04:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762836655; cv=none; b=gsVuXoqH+eIngmIioKFCFlYbiLfx8BXGGy45LWS6osjE4SgtAa0ic9Kj6ViyHe97cG9qA7wIFiBj+isGq7sRKJe1y9qgN4FqDvLk6ycCZvdn+K5V0paF4ljwBfB3pACgr4GD+Zn2QgFVgKtrWHDmTrSStf5H6hx8tKVukl0D9IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762836655; c=relaxed/simple;
	bh=GwhluCzd7NFAbXWHpH2DlLLp6l4eXOs5QJjqkbrcNaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js7psUe5qE2WteRon8p2YKJSykqVu98V4iklgS4UqJRZRVIT5uCv1ZIojlnfxRBI2kwwpbj4vs4mUhStQ8nPKDtzCg6I/H7cAd7EL4HqnUy4mj4xORmxI1XvdRqV+zLXCcskk1e6piZHPFEV8klGU0SJP4XrkpvmqS4xkrRPUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnMyhNL9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnMyhNL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BC6C113D0;
	Tue, 11 Nov 2025 04:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762836655;
	bh=GwhluCzd7NFAbXWHpH2DlLLp6l4eXOs5QJjqkbrcNaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnMyhNL9DrMkTNxgA3gnVp2C5b46w+Z8MPFLuIWtwkOO7BZ7l3WA/ZQYvdrnVgdTf
	 cwTGNOb1WMGrbqGc5peKNzoD/N8M4M6kqN7atv+Ttu85NeDII7wvMFMDIJrQSRXT1e
	 vwx32Okyw6GEcRfnbCg2srksuF/hG62Affm//y/mrGnPORmeSC2eYxUUGiEiDBXDw2
	 /v6vZlBp1c+EQIhkukAyjTXA3olczD9VgGqNiw9TH2dSg3lycjaLVTZnpvr/RpISQM
	 K/c4EWTAdkVXOWt5eEwrQ7/CIB8YGSNGNWQL/pkAiSwBykebOsAbhkOCkWGzdhzgL5
	 z29lvg8wpu+tg==
Date: Mon, 10 Nov 2025 23:50:51 -0500
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <aRLAqyRBY6k4pT2M@kbusch-mbp>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
 <aRK67ahJn15u5OGC@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRK67ahJn15u5OGC@casper.infradead.org>

On Tue, Nov 11, 2025 at 04:26:21AM +0000, Matthew Wilcox wrote:
> On Tue, Oct 14, 2025 at 08:04:55AM -0700, Keith Busch wrote:
> > device's virtual boundary, but the code had been depending on that queue
> > limit to know ahead of time if the request is guaranteed to align to
> > that optimization.
> > 
> > Rather than rely on that queue limit, which many devices may not report,
> > save the lowest set bit of any boundary gap between each segment in the
> > bio while checking the segments. The request stores the value for
> > merging and quickly checking per io if the request can use iova
> > optimizations.
> 
> Hi Keith,
> 
> I just hit this bug:

...
 
> RIP: 0010:bio_get_last_bvec+0x20/0xe0
> Code: 90 90 90 90 90 90 90 90 90 90 55 49 89 f2 48 89 f9 48 89 e5 53 8b 77 2c 8b 47 30 44 8b 4f 28 49 89 f0 49 c1 e0 04 4c 03 47 50 <41> 8b 78 08 41 8b 58 0c 4d 8b 18 29 c7 44 39 cf 4d 89 1a 41 0f 47
> RSP: 0018:ffff88814d1ef8d8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff8881044b5500 RCX: ffff88811fd23d78
> RDX: ffff88811fd235f8 RSI: 0000000000000000 RDI: ffff88811fd23d78
> RBP: ffff88814d1ef8e0 R08: 0000000000000000 R09: 0000000000020000
> R10: ffff88814d1ef8f0 R11: 0000000000000200 R12: 0000000000000000
> R13: ffff88811fd235f8 R14: 0000000000000000 R15: ffff8881044b5500
> FS:  0000000000000000(0000) GS:ffff8881f6ac9000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 000000000263a000 CR4: 0000000000750eb0
> PKRU: 55555554
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: disabled
> ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> I'm not saying it's definitely your patch; after all, there's 17 of
> my slab patches on top of next-20251110, but when I looked on lore for
> 'bio_get_last_bvec' this was the only patch since 2021 that mentioned it,
> so I thought I'd drop you a note in case you see the bug immediately.
> I'm heading to bed, and will be out tomorrow, so my opportunities to be
> helpful will be limited.

Thanks for the heads up. This is in the path I'd been modifying lately,
so sounds plausible that I introduced the bug. The information here
should be enough for me to make progress: it looks like req->bio is NULL
in your trace, which I did not expect would happen. But it's late here
too, so look with fresh eyes in the morning.
