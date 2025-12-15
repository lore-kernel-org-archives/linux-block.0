Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB06131D74B;
	Mon, 15 Dec 2025 05:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765776846; cv=none; b=ZfIK02DOiiYcR375Rp+Gn2fZ94aU7voPSqzRNdxgli/DBiHo3yE2UTqYuDxWw+b4q3zThwphV8iVNOsIHRE85oz8AHCayNGNE/i/uRt8xFXMyF8pwrZO9OZ8mNfj+vFmjj2SpFwgqcJJ7+1VJ974An3WHyT0l8DmlGe1L10qA8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765776846; c=relaxed/simple;
	bh=wy8mYR4fgmLU/RfTYbX889MAYjchfDZJSXicBbYlUDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dH+YAqBw4puuPmAwzkp8LVFQ6ALzxDAmZYcO/B3XtoC6WQO0S6+Jz5VA0HNHdnMMEVN/f2N5E5m5ff6fUwXtD9Ie4GbH/up6zne5JWvVt4I/g+Zsib8/JRZFuPtpzD1nj4BmcIMdsF0E1uj+XMgk6tp2zOqwBqiyq+J59cWLtKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ylxlys4r; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ylxlys4r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/MiKCo1d5JD94ILN3fuvo+k1z8x6OlL7EvWcu+gmeV4=; b=Ylxlys4rRjpqHRfjxou2Qz81G5
	ZWncDAkFOYcpbDdb07J8M87AilmkV4XksOwxZ0RKoej3vKrGgbnAMYzSgnogr3wOpsC/j4VnSl5gi
	ZFdHyObJz9xC30Z2V/P6oQM7SRQzqOPQY+Id8PYVE6cZwUISnXEPi6MWN5DgOYQ0LTiphaoShJSxJ
	LyKOiHcqj345fF1UabBpF/CSHFp8L/YszgNPfPw2HTlamWWS1ey8Xqd9u7RRnJ/84Fop83cOjEDI4
	ppJzeJDUw/UJo10XI9SVlvTLD6hsba7asleN95IJNK4LJKHZ3F2igZB0Tht1gEdxlNeE7tf/QatbV
	nmnhOb7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV1Db-000000037Mx-1dW8;
	Mon, 15 Dec 2025 05:33:59 +0000
Date: Sun, 14 Dec 2025 21:33:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	stefanha@redhat.com, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: add allocation size check in blkdev_pr_read_keys()
Message-ID: <aT-dxw-VSqXMQR_h@infradead.org>
References: <20251212013510.3576091-1-kartikey406@gmail.com>
 <aTuzVdo8cuxXhUxB@infradead.org>
 <CADhLXY57aFmNB1v4TG2YxhOQL1+_02KkWpB3fEsn8t1GiFqdrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADhLXY57aFmNB1v4TG2YxhOQL1+_02KkWpB3fEsn8t1GiFqdrg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Dec 12, 2025 at 08:17:43PM +0530, Deepanshu Kartikey wrote:
> How about limiting num_keys to 64K (1u << 16)? In practice, PR keys
> are used for shared storage coordination and typical deployments have
> only a handful of hosts, so this should be more than enough for any
> realistic use case.
> 
> With a bounded num_keys, the SIZE_MAX check becomes unnecessary, so
> I've removed it. Also switched to kvzalloc/kvfree to handle larger
> allocations gracefully.
> 
> Something like below:
> 
> +/* Limit the number of keys to prevent excessive memory allocation */
> +#define PR_KEYS_MAX_NUM (1u << 16)

Looks reasonable to me.  Stefan?
