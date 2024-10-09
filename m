Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2987191F89;
	Wed,  9 Oct 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728473832; cv=none; b=EL5I0UHZTGjB2Cx8DM8glgQaxQ7BZD0Jl/5zUCnTFLjuU5CSUQhzgqfAUlI1X2U4nwdbn0smnhIL3vN4aGixYa+b3Uk+VpQH18GCpW5/32KY5E7iSUjneuUoTBFq6qMV4+78DJks4X5w2rqxOzulge5IjWtLoe6VoFlT2YbjJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728473832; c=relaxed/simple;
	bh=Rho3rFXpbK+cEsaIjikHsw+oQVoZZV8d6YiDgDH7Rsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITQHMSWKCvvz7sv25wJJpAVBY4HWxCf+dMyvaGRbTZ8lQ8EJbbIZfqvk0yds/s5ZA/U/cxyeeuBFaDpTO6OoYGNZwzG/5LgLt3QzvEMwYtaW8r0UlkPLrQkc00CvZ0FnRKvhiE+pHDdNDGUVxyTAyHXkGjUNXSiEtumyD6Ewo6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pZnZkX/z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pZnZkX/z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1EiTVLSlj4Cq86TlBOOJj7bBQhU7XUCwisc8VqcnPiI=; b=pZnZkX/zpoWSx0mfIMnL+oFtIm
	uUBqkO81MXcUZUAF6+R4jW/910wfSgF42qxzNc8raqeyYnhZvZVeo+2/XJwlTrwXVjdLiIZzVQyf6
	2TJNL1YHLyQmEL8WNHOWfkadCS8u096fJnNeNf6v2htTOltA2Pwh94uDVcUwFtXNu3OqChTS0uvlf
	9boc/HmtXuSy/MVawyqRRCihKBCi9sWUbmQCzgZxxzsXC2P5TG86DFl2QPfrW+3yH4LSuJsUr/0yx
	WdYz3RRYBWIa2qUqvtLgzxjSenk338EuIBpUROAdzfZaFvZ6K3zv84LrxrJrE/OBUVPEp+P1EY+2z
	kDfenvWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1syV0A-0000000959i-23EO;
	Wed, 09 Oct 2024 11:37:10 +0000
Date: Wed, 9 Oct 2024 04:37:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] block: Fix uninitialized symbol 'bio' in
 blk_rq_prep_clone
Message-ID: <ZwZq5hIJSmQW1Sxa@infradead.org>
References: <20241004100842.9052-1-surajsonawane0215@gmail.com>
 <20241008175215.23975-1-surajsonawane0215@gmail.com>
 <ZwYxA1sfQdaj0Hy3@infradead.org>
 <6e290cc3-0be1-4ee9-8e13-351f8cd9f658@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e290cc3-0be1-4ee9-8e13-351f8cd9f658@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 09, 2024 at 04:30:56PM +0530, Suraj Sonawane wrote:
> Should I submit a new version with the added empty line and explanation
> about the tool and function issues?

Let's wait for Jens if he wants a resend or not.  In the meantime
just tell us what tool you are using.

