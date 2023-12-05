Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAF7675A6
	for <linux-block@vger.kernel.org>; Tue,  5 Dec 2023 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkJSyTYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31DEC433C8;
	Tue,  5 Dec 2023 16:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701793782;
	bh=YKcFC6CfRUzKdQwNoelHCJB7wxHKjhYspDtQrRBLwQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkJSyTYFHTYbi81ZKKQhnkz5KAFSFTnegFF6xs4+kXHpYnwMGiQDAKm60m1B8sRXy
	 EgtrlhFwzUXkB5NpGBPE+4hP7w2ZlVhDOXLIKd2Kwktb/KieuQwMuZqBFIzaJ+pLAo
	 gQerDLJaSEP8KgyBfQyHuBdYfDBXeSci4IZBA9bDmM//RbbmRLSlP6r57cwoWQPTvt
	 +1LOV3RzN6tBx+GtjJjlET0ioi94ZECbliw/bT3HuTXP/GBun3lqKi+aiMOT9EHjJf
	 fo8zAfCySew6cC1saPThtUze5rekV6DO7euzqxrVNy832TKi8Ne9IrG6CEV9D2QrcJ
	 Q0RD07FwDa1Ow==
Date: Tue, 5 Dec 2023 09:29:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-block@vger.kernel.org
Subject: Re: [bug report] block: bio-integrity: directly map user buffers
Message-ID: <ZW9P8w_Gp9IS8022@kbusch-mbp>
References: <1177558a-9dcd-432f-89b1-4ac9cbd9cd25@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1177558a-9dcd-432f-89b1-4ac9cbd9cd25@moroto.mountain>

On Tue, Dec 05, 2023 at 12:35:30PM +0300, Dan Carpenter wrote:
> Hello Keith Busch,
> 
> The patch 492c5d455969: "block: bio-integrity: directly map user
> buffers" from Nov 30, 2023 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	block/bio-integrity.c:350 bio_integrity_map_user()
> 	error: uninitialized symbol 'offset'.
> 
> block/bio-integrity.c
>     340                 if (!bvec)
>     341                         return -ENOMEM;
>     342                 pages = NULL;
>     343         }
>     344 
>     345         copy = !iov_iter_is_aligned(&iter, align, align);
>     346         ret = iov_iter_extract_pages(&iter, &pages, bytes, nr_vecs, 0, &offset);
> 
> Smatch is concerned about the first "return 0;" if bytes or iter.count
> is zero.  In that situation then offset is uninitialized.
>
>     347         if (unlikely(ret < 0))
>     348                 goto free_bvec;
>     349 
> --> 350         nr_bvecs = bvec_from_pages(bvec, pages, nr_vecs, bytes, offset);
>                                                                         ^^^^^^

Thanks for the report! I don't think there's any scenario where someone
would purposefully request a 0 length metadata mapping, so I'll have it
return EINVAL for that condition.

But ... bvec_from_pages() only reads 'offset' if nr_vecs > 0. nr_vecs
would have to be 0 in this case, so it's not really accessing an
uninitialized variable. Everything in fact appears to "work" if you do
request 0 length, though again, I don't think there's a legit reason to
ever do that.
