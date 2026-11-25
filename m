Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582457;
	b=GFtD/cJmPSdYJbtZzcpO1R7v6fULjINReu6G40A0BeLb3FYe287qhzQaHAyS+VZ/pkth
	 ovuCuHjfhmULMKWXy9ltdq/rD5TpoIRwyfv4zpLyX3aILkSYdw4tQXNzAqc9iNU+7+XX3
	 8sEYns1BPhy9FNpfg0KRotELuEx+NjFiJNd/Pj5ZcPVWSXZp8DOmW2COXnTYS7xipury6
	 wwIvczqUuL6PYVC5q9Noae4qTPsVlYr6mBW7Ob92rwM++Hhe3wKzp+QaQpXHfA7O8aAxd
	 mE3nl8FSpfFdg57livJd1/kjuS829P4ZxIfPeU+WJ1l5+eGv0GjAktR9IlCBoqSF6eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582457;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=3QxlALsIg033ZhMqSG8rUlWl5BggUMUW4Fa3243eHd8=;
	b=s7b2CZcK5LlVDL7Mq/5iaP0UvygSVl0BrxwylfXIErDRncZxUrYTThASXGN0qpPiuMT6
	 N1FZ2fTuyk6U/Q/hB8V6AM7GvG5wg9sFwcA6l392/wiA6k0ovbKVV9kqetyPusUeBUPyf
	 EMjHJbuJ7EmE/gKJt8WC/Cse+p2Vlsv678Dr1mjhk24YgORp4E8s+bRu6NqtVJaeJSZ1N
	 p4J3+aM/LNnbqIQiMxMYvRd7QpKfDHsmCl1ECIvNBFfZn/I6mXLY4s2Mg0yoFVzjmLpF+
	 d9JPeaOjsFA/gYEoJ/RbK2O8CvvIgpnWPEQz0AQDZuwckIQVDa1UuVoZ75WoXqQ6n1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wa6pxjhg;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44165606A321
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 04:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44165606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wa6pxjhg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3QxlALsIg033ZhMqSG8rUlWl5BggUMUW4Fa3243eHd8=; b=wa6pxjhgIyOyEJD9FQbPDnq4g+
	/plVDi9etMhWH+fJtEwsmEYfD5/FO9CzR/Z0nou7lU9CJSLEAw4LEJadsYxsCdSRfzFlRMqEH4M7o
	nHwHKaZFQUvhW19Vf/lvbcgdS1jdeoMjsnd4/SyFxLwcoVXPR892g50VJaiUdsSUYglQCuB9e3Fve
	SWSSshG2fLqjTX3W0xgS1RsekACHpr4lnNpKmt0yo0qwvk5XnT2HqZIh1+i09zs1Hfrzvhtg9zReg
	S2swgTBXXqU6etTLB1FEYROuVKT4u8OEXqgJBbw18WV+aB89tSkXvDG2vfx/lZ7FkZUx0A994Gu1G
	jesY4odQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW51M-00000008Qdj-2peb;
	Wed, 25 Nov 2026 04:54:16 +0000
Date: Tue, 24 Nov 2026 20:54:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Nilay Vaish <nilayvaish@google.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] null_blk: use page_private() accessors
Message-ID: <awZp-Ka34pBMWIpH@infradead.org>
References: <20261124033630.832566-1-nilayvaish@google.com>
 <5bc4f7fb-9ce7-4cd6-829c-c178ad884843@acm.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bc4f7fb-9ce7-4cd6-829c-c178ad884843@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 24, 2026 at 10:52:34AM -0800, Bart Van Assche wrote:
> On 11/23/26 7:36 PM, Nilay Vaish wrote:
> > Use page_private() and set_page_private() instead, like the rest of the
> > kernel, so that the driver no longer depends on where struct page keeps
> > the field.
> 
> Has it been considered to store the page index in struct nullb_page
> instead of in page->private? That would remove the dependency of this
> driver on page->private entirely, which seems more future-proof given
> the memdesc work.

I don't even see why the index is needed at all.  At best it is to
work around the somewhat weird radix_tree_gang_lookup API.

So unless there is an urgent need to remove ->private ASAP to unblock
other word, I'd suggest to do this properly:

 1) convert the pages lookup from radix to an xarray, where the
    iteration returns you the index
 2) remove storing the index in the page entirely

