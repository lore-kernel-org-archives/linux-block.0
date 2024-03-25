Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553F5174ECB
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711336327; cv=none; b=MV42wayefASmgDMfTfv3fqtd9s3OBZbMGs5uQ4Am1gx/O8YQQV/LLtgti0y2OjIRjZTIy2oLw9yU2ZE/iDfT7eU4z0sy9QXdhwmZoWQlE4slXnJlHJs6ZmzNIJ30XNjLDT2EH9ZezS3k8z2S2rPmhPTHTwus+mvCwt5M3FYgykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711336327; c=relaxed/simple;
	bh=+Sv9On0LOLI9a/jZlNCNjLcUN3EGv6L0eScdhdJdgao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eq0TCfv0UMJs9djqzQlaxI838jYh8jVzd3PZi6Y3QRoTFOFm6T7E9iQVsdAdBmpGbuld/oxqUyuh5Wq+dGfCAtozdBkBfLlirtyyAH9VLnR5HSgCOutxUb1RU1Vb+TT2cePyM8Uvr0Jw9nqkFj+8KoBpao1MGoQuwsX1r5LqiH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r6uYy0JU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r6uYy0JU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g4RFdsoTEgHDIF6UAW21d3E/DZsxWi7txXjZm6+RqJA=; b=r6uYy0JUjg/ch8kB5p2bakZbxW
	NhZfB3i5VxNVbSy+p1XWvexNvYNVHnb21xNUuY8TnGp8H0opdMOF4aB1nEP0C1vTnkI/mFcJDZnm/
	krHZ3dhsCfenyU7OOo5ZSHFlfcqBoUrzvtDGvCumPnHvgz95zGHrkgnQ4pTXxzNWjw+kBYDj/LfI+
	CvOyeL2WsR8gJgBAXkHYS8k0yYriIBr2Nj+b6yEq0JbvYfR1sVgWPaYMETQqsoJR0f3YCJQRLFmxD
	HAfmbYkJ2P74+5/A+fBjqn76860g344vbzX6UDrrnBwQ6YD06SqZFcza/1FaAcvs/Nwxoee1YLyT7
	TEAGA6eQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roakj-0000000Er0n-3sSP;
	Mon, 25 Mar 2024 03:12:02 +0000
Date: Sun, 24 Mar 2024 20:12:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH V2] block: fail unaligned bio from submit_bio_noacct()
Message-ID: <ZgDrgTymGnW3KGuk@infradead.org>
References: <20240324133702.1328237-1-ming.lei@redhat.com>
 <ZgC2UPEBOSLW9Xdz@infradead.org>
 <ZgDpfW8HRHrZgQYv@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgDpfW8HRHrZgQYv@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 25, 2024 at 11:03:25AM +0800, Ming Lei wrote:
> Also only q->limits.logical_block_size is fetched for small BS IO
> fast path, I think log(lbs) can be cached in request_queue for avoiding the
> extra fetch of q.limits. Especially, it could be easier to do so
> with your recent queue limit atomic update changes.

So.  One thing I've been thinking of for a while (and which Bart also
mentioned) is tht queue_limits currently is a bit of a mess between
the actual queue limits, and the gneidks configuration.   The logical
block size is firmly in the latter, and we should probably move it
to the gendisk eventually.  Depending on how converting the SCSI ULDs
to the atomic queue limits API goes that imght happen rather sooner
than later.
