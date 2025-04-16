Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E431226D08
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744834555; cv=none; b=bma3pbaqk7C3kEWE2ervz7A/iBT1QS+o8TIXnHi+BVfeX5ENFwLgZGu+7kZY2fKx0bDJ9In9TjE0RfXADj4lqhMgTGnXBR3Uc5BPh5KB1+LsbRM7YQXAfNn0bBE2K7LVLzPuNAqbjyeDsku8AajWQ/a0h363Zvnbx9CFqyqW0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744834555; c=relaxed/simple;
	bh=i2Jzjy9Gs+g72xWFjc1q/qzUm3uQpUmUwLCEYKzIugA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldwEl2ZdHV7iDAE9kTN5QLWQp9DaDQztj7l7R+84rCOkKWbNrlDvCaVsRNFFOJetzMPaOex/bigD3a0QX9w4blgkzuyPaeTatnbhTryzq0EVN/H3FpWuKB4yZjF3m6n6bMM/OlF7KaU/U7Wz26qys3uBWmvONGQWfbRWHoQbjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEepHx8S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEepHx8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F77EC4CEE2;
	Wed, 16 Apr 2025 20:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744834555;
	bh=i2Jzjy9Gs+g72xWFjc1q/qzUm3uQpUmUwLCEYKzIugA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEepHx8Sl6dmfDD8rFfQ5UE//GsDyKmVTxKVsZc4jqQ0HTa5MYuLt7l55OQ5ZSp53
	 H+xwVqg2qosv3r7NpgniQstqs8ihooMTTteEdM17rhbUl/ysaoD+50MiSNsBcglRKh
	 J0P4l8e9pGKh9IwZFOE6pGMZta4epHhuLacGarv0Rk0Scd2Ja54s07F9xfEqr3WCsD
	 CwU0KZiGtcdE5DyptL6DpKRZaot5UFYoUtuiqhUxygJviJ6LgyAoABD4t3HUMHt+wL
	 5C6yS79mMhkBn7wtJyxy3bbSwU9MTM92/GG2gaBJZ9F39tMvQgrK5W/KB4y5aBKOmz
	 pjjjI8mqL/4JA==
Date: Wed, 16 Apr 2025 14:15:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] block: integrity: Do not call set_page_dirty_lock()
Message-ID: <aAAP-Kp5bxWe4ny1@kbusch-mbp.dhcp.thefacebook.com>
References: <yq1v7r3ev9g.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1v7r3ev9g.fsf@ca-mkp.ca.oracle.com>

On Wed, Apr 16, 2025 at 04:04:10PM -0400, Martin K. Petersen wrote:
> 
> Placing multiple protection information buffers inside the same page
> can lead to oopses because set_page_dirty_lock() can't be called from
> interrupt context.
> 
> Since a protection information buffer is not backed by a file there is
> no point in setting its page dirty, there is nothing to synchronize.
> Drop the call to set_page_dirty_lock() and remove the last argument to
> bio_integrity_unpin_bvec().

Thanks! I had just posted a test for this scenario earlier today for
liburing:

  https://lore.kernel.org/io-uring/20250416162802.3614051-1-kbusch@meta.com/T/#u

I was wondering why it didn't blow up.

Anyway, patch makes sense. Looks like I got carried away copying this
from __bio_release_pages.

Reviewed-by: Keith Busch <kbusch@kernel.org>
