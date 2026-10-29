Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278796;
	b=5rTpYFtIVe/tFvVgxSxW0XeBTU/49du9eQQgZUP2c7yXbGSgUQ+AuUEzzw2i13GVTJRy
	 FXl4kQ00+wXg4mMKIfKUaG9X1NeTbE/RyRXOgKVvizx2GGAtJ6lfKP3CXcj0/9mgo/an+
	 Z3eo4PU/RsRy08y9xa7K5/d7Vi+ZEijKWInGHlv3cibdebHwmkwxyrZ1KC3o6C3TQ/lPT
	 yEcFFu0sYPIK1tLCL/QoJJxTfNJROxB21T1o2DPFaq9xxqgJY8gd9mTVf/tcavftR4Uy6
	 PTsQxYYwxxU/gXAfeGesax/Le5ZyQc2al1VhVzk8MY0jc+HTKhwbOZgtZKMBmNgkT0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278796;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=Mlj3eUOdNPmHL0FNy8rpRZ9geD4eBzMb3fe/ZXumVxE=;
	b=gShWX4ZA/G+5gLihkgppERjHYEhD3s0DGU2dePqo3VvlZa2iPCY+DChDVDNC3FdWdW6K
	 8vAjQi/lRKEaj0mq9zNEbDK+DF8G/Ayr4In04fym655KfCDVChjo4qg0jWplIBcb5eISl
	 R2hiNq4Av/ORE4O6sUbJIXeFuTYMSGjdgPoBw2n+gfBMkpa7bJ2IZpt5zMa7GqdzlI9Pz
	 xHYA3fGHHQvLGGn7bFby3ii9CqRl8I04nbXjpxm4KNs3TB9Ku8teCmkMTG7ojvb8NYG7S
	 TgeS+FIA1oxi3SIYmhGy5Vnm5B+MHL+F/QjZ/r9IVh1/sAb8KMhJU1Uyq073eR/V7Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b="bw5B/tGq";
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE89606A31C
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 12:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BE89606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bw5B/tGq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mlj3eUOdNPmHL0FNy8rpRZ9geD4eBzMb3fe/ZXumVxE=; b=bw5B/tGqQ/lsTKsdxvY+J1+tZ5
	pQgZFerZ6H18QeyIeGt1NzOizmq1QUBfxmLSgr3mvRSeSsjXVOGVSwu10vAfLODTeDZ7JN6Q5r8GA
	ra2CFZngzKDL7uK4BJmeFJ+mvczVWu1RLVMbNULMW+ZH8FRhUP1IEcTAbKhKGUfyBGi2l5LK1x1nh
	pi74Oh4Vlt9rah1Ld2LsOA4It2e21ApkdfFNhp2Sjnkl4tbOjtiWunQ2eR9JIe+3pQEmAlXR7Z1tI
	WH1Jqlicd3ZlaFvN+iy/0W3/MwRCEjRmO9k3nKWPgIxgU3rBSB7zLh8mo7XEObXwxGRq8eY03dr4A
	vKbgrT+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPjY-00000009GOC-0HuM;
	Thu, 29 Oct 2026 12:59:56 +0000
Date: Thu, 29 Oct 2026 05:59:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 31/98] blk-mq: don't forget a timer the driver has
 restarted
Message-ID: <auNDTJjSCUGQ5_MC@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-32-axboe@kernel.dk>
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
In-Reply-To: <20261028164415.1262013-32-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 28, 2026 at 10:41:34AM -0600, Jens Axboe wrote:
> +	if (blk_mq_req_expired(rq, expired)) {
>  		blk_mq_rq_timed_out(rq);
> +		/* If its timer has been started again, count the new deadline */

Comment nit: if you capitalize the first word, it is a sentence and
needs to end with a period.  Also an overly long line.

Otherwise looks good.

