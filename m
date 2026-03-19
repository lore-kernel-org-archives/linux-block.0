Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC0A3D47CF
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943197; cv=none; b=JxL87M6Dzs2CCsCQvjgCZl72PIq6eR+7cl1DwnHKnKv2wMkJe9AULW/B3jtPKP6vQWkmJMFV0HtNzTvu/UjPzi2Vs+LHzV0FyCoELIIn93SPLjGkunnzcRmvvne6Uw7ImJ/YMDoWxFYqBM/0y3WFh9Q5Iy4vVCUzwY1zZKmxodI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943197; c=relaxed/simple;
	bh=29WlG8Dkoh4OctdaHEWHsm1UTwJFX6GFSef9CMqVITA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STAhU6b+qtQZ2mNd1gGe0N2SaDIpkRcwTBb413XF3pj2NoiXAovxxB6a8Hybemu6y58Jdb6XmsWUGyJwNAkUskrPIjYQwtvMr6gwkiuKqxHuWglpgScxds7n9+rlrYblUiCCT0RJ42BgMpkP+PUUalQ54fKF5GbIfksjOvZFGys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5qRRodo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5qRRodo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D562C19425;
	Thu, 19 Mar 2026 17:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773943196;
	bh=29WlG8Dkoh4OctdaHEWHsm1UTwJFX6GFSef9CMqVITA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5qRRodoitaTjP8Oo49cX59bM6/ww2hHBYTb3Av7xMXj+588xDmtzRecYNetDNhFv
	 ai9zk9r3Xzm18NmIbze5e3mQ2pBeKPP8CBLcEfQ/N5+/scOR45Ef7gyJWDMnT7u5Z+
	 RzEd/KqSZq1jO6EgQgwz7TBgc6fpsdBNYnR1aL2lCc/jLP8tAT8VBpMHJulGGAp5LZ
	 dQce4oSOE8yWWuFcdMJX40dA9YUhBlWywlFBBlJx31GKOj6nd834tJWVU2bvwaEvgp
	 PLopseWmR8aLG34tjuSZXAIjmkR9+ib6/8rC7VS+7wI6qRKK2Ap2SZvRO3aYaqzly/
	 a9BqyaBLojGLg==
Date: Thu, 19 Mar 2026 10:59:55 -0700
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Brian Geffon <bgeffon@google.com>,
	Richard Chang <richardycc@google.com>, linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] zram: do not slot_free() written-back slots
Message-ID: <abw5m8Q5fFXGIweh@google.com>
References: <20260319034912.1894770-1-senozhatsky@chromium.org>
 <abt1dsjsT9826Ewy@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abt1dsjsT9826Ewy@google.com>

On Thu, Mar 19, 2026 at 01:05:55PM +0900, Sergey Senozhatsky wrote:
> As a side note:
> 
> On (26/03/19 12:44), Sergey Senozhatsky wrote:
> > -	slot_free(zram, index);
> [..]
> > -		if (huge)
> > -			set_slot_flag(zram, index, ZRAM_HUGE);
> 
> Original code had a bug.  slot_free() would decrement ->huge_pages,
> then writeback completion would restore the HUGE flag, so when slot
> would get freed for real slot_free() would decrement ->huge_pages
> again, leading to underflow.

This should also go into description of the patch.
