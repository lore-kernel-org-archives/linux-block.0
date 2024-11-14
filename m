Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E341F9EDE
	for <linux-block@vger.kernel.org>; Thu, 14 Nov 2024 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731587610; cv=none; b=UrKuwO6mKRViXIP1ZEnxBfKtgEhzUrdIxgqbliVIgtiKqcCLlIDcF2L9qEnGgzadN5e4hmi5ZY3ynDvxN3xkB1obUZglaemqgeq6deWOUG8WxgoT68kAp0IwUfXqui8tjP52cWpyPDG75Nn27Plj6VcEpo5ECQUqhVvdTNFZ9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731587610; c=relaxed/simple;
	bh=R3Z4ywuPR6oZm/HH+UC1cTogKglX54F08Us0Vr7HEPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8NhX1r2x3giW4b4204vV1tsiQqZ1UoPkP/C6Uvyhcc6FtbdpcteT5LDOxuHUWwD7CzXUqHHalnjEGWs7Lbz3EIlO0dZ9uBB6zymQEJ1/4/9fuILcCTyiNGnnrMu1MVO5yG/kwSdSzbt/bVlcfpURW6Ehd86nwV0FVYUE58yfj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4398168C7B; Thu, 14 Nov 2024 13:33:24 +0100 (CET)
Date: Thu, 14 Nov 2024 13:33:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [bug report] block: remove the write_hint field from struct
 request
Message-ID: <20241114123324.GA5936@lst.de>
References: <fff0e493-fc11-4ea1-a75e-454d052d23e5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff0e493-fc11-4ea1-a75e-454d052d23e5@stanley.mountain>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 14, 2024 at 12:04:03PM +0300, Dan Carpenter wrote:
>    994		if (!blk_cgroup_mergeable(rq, bio))
>                                           ^^
> This dereferences rq->bio->
> 
>    995			return false;
>    996	
>    997		/* only merge integrity protected bio into ditto rq */
>    998		if (blk_integrity_merge_bio(rq->q, rq, bio) == false)
>    999			return false;
>   1000	
>   1001		/* Only merge if the crypt contexts are compatible */
>   1002		if (!bio_crypt_rq_ctx_compatible(rq, bio))
>   1003			return false;
>   1004	
>   1005		if (rq->bio) {
>                     ^^^^^^^
> So this check shouldn't be required.

Hmm.  The only requests without bios are flush and passthrough
requests.  I guess we make sure they never end up here even if
it is not entirely obvious from the code.

