Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D511CBD;
	Fri,  4 Oct 2024 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052752; cv=none; b=tZdX7lyt9uCmetiF72SXogQmCu4FvQCxsIb0z+HZtH3baJsYauE4u11wI1uBgUjfDHEhDaasnO61O6pMb7SfQKKFhbTcLiIwTwjS7YNMaKPBM+klIXmTycql7aOY88oKsREySBm5wHwmChyPNjtLZKjtaGQLFL7NLNT0+yeE6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052752; c=relaxed/simple;
	bh=lSKEwz3eJ09fAHhzmbT/6yjNaP8DpxmU7eU++KWHZ7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHuScUNGFY7zulrjOLJxp2lVG02QVAQ7AMu39ElAHasxA/C6r4gd80/l2bSqBxYoYDCpbyI+3Bk/ue7ix2XgUtAl9TIXadgTJvo5Dcuh9vaGybg3Wl5BMzYD8rdbBcJugNkwd0Uls3tm9r6m63lzHRmoJ2TntRbY+IbjAl5vQAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C51WR0xu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C51WR0xu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A72C4CEC6;
	Fri,  4 Oct 2024 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728052751;
	bh=lSKEwz3eJ09fAHhzmbT/6yjNaP8DpxmU7eU++KWHZ7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C51WR0xuoETuRSx5Lt+Cu8IywECzaROFNAE0jjDneTB9eoK56rrXI/ULXolzTt6YA
	 MJuv6d0isDmc5JkatJUKrj+W4aNnqv3QnGFeWidovDlQdTK5Af0rbCdWUZgUZxhfyf
	 2lHTRobBEniJQ7C5rFJJIXYXvgZbEnEunkKHs8i7brOkqrlxQ/fhNqKvg6Qa0rtZc1
	 GLsT8C0l0Q1uOX7B6W6JQ5NUOzuMZk58iHkGJ58rGKLHnEyUrBX4AiLEKWFEz/eBKx
	 fwzhT/DS1Zxi8SexKXofcQ0UceYeFQbg5iq5IFmDihKQnXvIH3+OSM1fSNBTtR9iKE
	 cV/HFymvkmkeQ==
Date: Fri, 4 Oct 2024 08:39:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: SurajSonawane2415 <surajsonawane0215@gmail.com>
Cc: hch@infradead.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Explanation on Uninitialized Variable bio in blk_rq_prep_clone
Message-ID: <Zv_-DSM2NhuiX3o2@kbusch-mbp>
References: <Zv_eFIjstVns-ebG@infradead.org>
 <20241004141037.43277-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004141037.43277-1-surajsonawane0215@gmail.com>

On Fri, Oct 04, 2024 at 07:40:37PM +0530, SurajSonawane2415 wrote:
> In the function blk_rq_prep_clone, the variable bio is declared but can remain uninitialized 
> if the allocation with bio_alloc_clone fails. This can lead to undefined behavior when the 
> function attempts to free bio in the error handling section using bio_put(bio). 
> By initializing bio to NULL at declaration, we ensure that the cleanup code will only 
> interact with bio if it has been successfully allocated.

I don't think your explanation makes sense. The line where
bio_alloc_clone happens:

	bio = bio_alloc_clone(rq->q->disk->part0, bio_src, gfp_mask, bs);

If it fails, then bio is initialized to NULL.
