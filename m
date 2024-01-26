Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5D21DFED
	for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279251; cv=none; b=bqJDOhQ9Q34MAqo3DBwq13XkllybHkbhrEhh7JS1klqL78N6UuzwOdza0YFPvJmhNbhrIsN4woS/9OH+EUm4QtmoZSEGJxWRvbvjfZZJTstThSThy7vfX7nS9yy1rLYB/V7EBeZRVt+DYbuJ41+1lxcNDnzhVWcLVemknHBdDzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279251; c=relaxed/simple;
	bh=9J7ZnHQwVtLZUgl5e1iKAl1KwZVGp07AxNsLfROdmN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxqc7nHnafhO55i+BgiIBEF584akCgxZ54/R8F5P3G4TbN5bA4Vzdcl+SJJKgEAcazXpOP6ciF5lVzpoC0PGGEKohuWw6VPnvSqnTZu8PSq0K3it+5vyCmVIaw/uGcyRGKw8Ou4PcufLydTxrDXq4j0OIX1vqbaGKHJe8p95FMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R+kY5Ha4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R+kY5Ha4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZN2YnUJrp3qMh6mKwaRoSrB5jt+h3BuIMtx6+7Ae6Zk=; b=R+kY5Ha4+KY3CAjvUGxpjwLINv
	ix+AYlT641Bs7UcK8h8IpFwslqWctK698Vm8iyg8JvnB6xibbCaUqVCEJ64F6fCZzywG8mZg05Z15
	2wzoV3Z4aaa7lU9y7qT+3iOP3fNq0oqDRYBBN/OT5i8QOTqt6MmZO9NJIx+f6fGz2rz7KUUlZkItr
	xFelGLVysdrjuQTPmHJnfilQ+FDs2mucjZQIbPFDUjeMq81T6TH53t/6UaV+FGQrtnkwBlA+Rmx59
	MDbn87xeiwjXoZbBNmKZ8hXGp70ue+z+lva9Yuz9hwyBKTZWNsJGrm3zg23m/In56YoTcCDeXr8HD
	vjazLIBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTNB1-00000004Krh-49V0;
	Fri, 26 Jan 2024 14:27:29 +0000
Date: Fri, 26 Jan 2024 06:27:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] null_blk: Always split BIOs to respect queue limits
Message-ID: <ZbPBTzxu-NWTU7Q8@infradead.org>
References: <20240126005032.1985245-1-dlemoal@kernel.org>
 <84dce2ee-5d71-47a4-b114-3ca69b3c31fb@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84dce2ee-5d71-47a4-b114-3ca69b3c31fb@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 26, 2024 at 08:05:21AM +0100, Hannes Reinecke wrote:
> > BIOs that need splitting. Doing so also fixes issues with zoned devices
> > as a large BIO may cross over a zone boundary, which breaks null_blk
> > zone emulation.
> > 
> That feels so wrong. Why would we need to apply queue limits to a bio?
> (Yes, I know why. We still shouldn't be doing it.)

Because a driver that has limits should enforce them.  Your hardware
doesn't suddenly use limits because you're using a bio based driver,
and null_blk shouldn't suddenly ignore the configured limits just
because you're using it in bio mode.

The patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But yeah, I'd rather kill the bio mode.  Jens, are you attached
to the bio mode?  Otherwise I'll cook up a patch over the weekend.
