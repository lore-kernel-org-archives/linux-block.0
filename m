Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD815505F1;
	Wed,  9 Sep 2026 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958956; cv=none; b=b1nFO86a4wrCFkG1dpQ6YwHVPML32M2kDKwQHMvIAqS+tTMlvPgN+pY6dSf97fsCp/InUOMKiJyT1w59GOXlE6RkIpQGunKe0EQQmrvpgAgzIduJUVtEDBiYRhlE7JopW7Yzs+sDm2H5ih119WxQgypujXec+hp871LQgsgIqrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958956; c=relaxed/simple;
	bh=QgfrJr1V1CVfezECwZfHky+RtMxC0nH/y1qdGbxh/xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4/R4iPHEszxNJEIPCg9fXjFOzES8WBg6R8xptvoV/sEfTAcDmEhSn4OiI1VQY/Ky8at0Uri/S2NfIk7ViYa5KcB9iw7Fh62sMcCOX2LXn+NOFIGtaTQ1THnYlLNK5uQKOYLRt9WCzz/wfr4OwZ8XLa2FBUKBs9p+Hqkbx1YqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pd31kYr0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pd31kYr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECE81F00A3A;
	Wed,  9 Sep 2026 13:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788958954;
	bh=EAy/mkbUGJKMDjd8R3bx0JO7rOlpjc9D+pq6To0oPS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pd31kYr0PkqflrEwx/4JHgC4MY82oX+TIF43RfbJonEJVafvRH82alDM1r9w7pU/k
	 6OB4w8/uXGGUZ4vfVdwDstAsYSm8FdbyeQGD/ekrdhto3opoeZTAFo0NbqY1OPwBIV
	 Fjv5r/uLmTfg4ARWJQTPDOqy6ZAPpplAHAQ4fJl9ldeCIBF+3Vqky1Em8n4b1R+FQK
	 CWLoNjMhJJIthFcrLL3KLuhWqpwk7kGCx1P2DpPZwzN823CY1z23V64KUCj719ci1j
	 1LCBQNkWn+oN41rxCbY8lBGOM7RSMOv8kz02q4a7vx7VuNTIhnT2oH7QhSLQYksnCX
	 FnbnzO2Aw0sQQ==
Date: Wed, 9 Sep 2026 14:02:32 +0100
From: Harry Yoo <harry@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 1/3] mm: make mempool_alloc_from_pool() return bool
Message-ID: <aqFXHT546O-ay4W6@thinkstation>
References: <20260806221031.79050-1-ebiggers@kernel.org>
 <20260806221031.79050-2-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806221031.79050-2-ebiggers@kernel.org>

On Thu, Aug 06, 2026 at 03:10:29PM -0700, Eric Biggers wrote:
> mempool_alloc_from_pool() is intentionally all-or-nothing, so make it
> return a bool rather than the number of elements allocated.
> 
> Then make mempool_alloc_bulk() return right away if
> mempool_alloc_from_pool() succeeds, rather than jumping back to the
> retry_alloc label to allocate nothing and then returning.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
