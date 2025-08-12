Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E82E716C;
	Tue, 12 Aug 2025 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987961; cv=none; b=qxnO0Gl0c7N333SOTxrsEXkyxZmdY4wVPbheel3/0dE+mee2xyRaMe+UX+xJrvTGBAFWU0oCWUsy15PEDZcZ+Cbmd8v3ZzVLREwFBIBXqHXQwXG9fjmjw3eSkFgTZPNRxCnub6bFZBjAqfKjtDoA9Wd9anoDzXUarRJwsjT3nvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987961; c=relaxed/simple;
	bh=qacs+o34cQCJNyzw0QcpjS1MDhjR4dG88iKVb7XNr80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIJEPg+QO0DgQdxcF5ty9c2NJlZyKxFakccsBu6dxMONP7/mi6rDs5AODgbEZRZc7TTLjEoOj0FowJ7uDhP0NRJ1BZqFfUkD5YmjMViuNwGmFjJnKD3Y8aumwEGkBJdFWO2TWjLVrsOR1w+Y3X0XqaYfKHIub1pXzHtZ5fDoK1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eE7tbJEX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eE7tbJEX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xmNXxISfCldAEkP8HJAJqFFVvj/onMh6JZBO6WMDatg=; b=eE7tbJEXq2WVNGJsx4WmPY+QT0
	ShRQTlpyJ85oeMoUfMUwaI8S0UEwX6w52OcLqQnEp1SvfLqmG5pDnfJBzz18IXsI+Z3OhHBDAsFPQ
	K4Cx8C9guQlrcEAb4J5ZvG3HJVbGcfHfys+vrsfUCOuXUcrUD50TLVLqeuajYCIZrTFm5Ge8O2gV3
	iugcKlaAkTTSzVGACHHM8a8YWMgPiDgVqZS+G99U37k0OCXXi2HMDA8f9EVSI+SZKomVaHhBuBQYe
	CcJAO1qoJWRBW7uFt6zsTejXtREKwr7nmgWjtTTuT5l2XgXlfYa7gg2W+qzkdd9ce8LjEQ7NdA9ba
	hq9tArPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulkXO-0000000AGed-2ndv;
	Tue, 12 Aug 2025 08:39:18 +0000
Date: Tue, 12 Aug 2025 01:39:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Rajeev Mishra <rajeevm@hpe.com>, axboe@kernel.dk,
	yukuai1@huaweicloud.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] loop: use vfs_getattr_nosec() for accurate file size
Message-ID: <aJr9tpeqaLcDKnhB@infradead.org>
References: <a8041180-03f2-3342-b568-867b3f295239@huaweicloud.com>
 <20250812033201.225425-1-rajeevm@hpe.com>
 <34624336-331d-4047-822f-8091098eeebc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34624336-331d-4047-822f-8091098eeebc@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 12, 2025 at 12:42:44PM +0900, Damien Le Moal wrote:
> Since loff_t is "long long", so a signed type, I would keep this interface and
> add a negative error check in the 2 call sites for get_size(). That is simpler.

Not ethat the existing code already treats 0 as error for the
offset smaller than size case.  I'm not arguing against and error
return, but that would require auditing all the call chains.  And I'd
rather not multiplex it into the loff_t as that means people will forget
to handle it way too easily.

