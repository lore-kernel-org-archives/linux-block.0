Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624441114
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732691985; cv=none; b=YY5ahV2pMxfaK5bI5ffrWyQnq3/fYJ1I8KzHWnDzgWaxjVArUhYGHZkFA6lnnMGjOKgJwaCX+8fQF8/pGvG2dS4XqM/yGRNmnhzV0X3VzwQab2oTNvFiYOcXBSrEIn+Ec68JKZWRvyr2sQMAGbndzZKOMBW4paW5YTwFp9+ThCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732691985; c=relaxed/simple;
	bh=YFs3DasXUKMdtTnViD3pL4Dne1ySKSx21CX/K+6OVSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCOeJPkTVl7r1bIeKy0FOiofzShFjd8yX9o7QYzyd1DNylU1VbFar12vLlkBOowaz8tsCh2z6Hy3KYamhskSAlcQ4xNTxxFJG6S2WyOlbpcIH5gzDWnOMEmqf/QTn3GxYbhABhZk4Rek7IjGoNN5TADneP20Gz00WVutPybqTY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OSptFDnr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OSptFDnr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JbD3E0k+M5qdiwBW4R0c1HybXBT7vc9PQdFXrONVwHs=; b=OSptFDnrZjpJdcEYW3dvUS3BJn
	e6R1OOiIfcbcFCuMHHrBagN+D7gqF+46gi1KrTDNha/sHBYgxThgZVVMymjMYO93J7sbLmrD5HcUn
	wlBEvmHLaoYjPkDfdv+zuF2ibtt9LPWNpVKkFbHBhJjp7c7zURRESGcwu4MQMCUXsJptKa7W9mkU3
	w7LtIv2QPsKRVH7LH+975qwVpk/2BUuw1dLX6Mzzqa8JNOEU2TjHUm7wS3isvCMud5ZJq8rcFjf+G
	cucN4FS9qynW7Xbp7bj1T3+QKdZtT41JAVgPoTe+dKMGECxoGDjHOKw/VyQzQqCvGD55rKF9GT48A
	r89sOLFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGCKs-0000000CQDj-2grx;
	Wed, 27 Nov 2024 07:19:42 +0000
Date: Tue, 26 Nov 2024 23:19:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
Message-ID: <Z0bIDopTmAaE_nxQ@infradead.org>
References: <18022e10-6c05-4f7a-af8a-9a82fdb3bbc5@kernel.org>
 <ef0b613a-d692-4b04-b106-0a244bf4bfc1@acm.org>
 <12c5ee53-dcc6-4c78-b027-8c861e147540@kernel.org>
 <Z0a5Mjqhrvw6DxyM@infradead.org>
 <Z0a6ehUQ0tqPPsfn@infradead.org>
 <73fb6bae-a265-43c3-a362-3cece4b42bbe@kernel.org>
 <Z0a9SGalQ5Sypfpf@infradead.org>
 <9d224032-254f-4b4a-a667-d1538cdbf0dc@kernel.org>
 <Z0bAHKD-j49ILtgv@infradead.org>
 <52570aad-c191-4717-b91d-a555d9dfda96@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52570aad-c191-4717-b91d-a555d9dfda96@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 27, 2024 at 04:02:42PM +0900, Damien Le Moal wrote:
> Got something simple and working.
> Will run it through our test suite to make sure it does not regress anything.
> 
> The change is:

This looks reasonable.  Do we also need to do something about
zone reset/finish command with the NOWAIT flag set?  Right now no
caller set NOWAIT, but maybe we should warn about that and clear
the flag?

