Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E487C17107C
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481971; cv=none; b=PyeijiXIPAqCsTuDKaKooZK4GbIGQ7q0t7NPfrhpZ7SH2fH0D0uc/tUq12Gf18ysoI0ile2Wg3X0wCmsQ6CDvA2SsNmrqzPn137BOrDBUvFVK/ExhpMy/SMzxljqDxfjqZu6ZX7ydWHWgU+Med2LBG7lH4Y4qY2r8EHQkLPHv7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481971; c=relaxed/simple;
	bh=OYTXBSPbVFJTRAFn26KB4l5CJ4VBaE6hVlie733z3tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EX8RyX6vHD/6MbXK8QXZTh8VuXj8afrwQwypgdhMVZoQH8vUXTcilJ0e2yeXC89yCCstZTXxk4lLBXdCelmYJbRkdaoz1jndLZmbGTMOnzPgdIFTimXQXnuaWg1xj+S4eN/EWnoKi/IvZ4KVXL582S2TxZfaU/DLNCX38Zot/oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NX9JFAgT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NX9JFAgT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gALMyx3eLL80Q6WP6MvAN0ibudbs7Zj5iEU9vNjy75g=; b=NX9JFAgTrh8n/E61yNICMvws4g
	xU9exUzwfwscjo/UtTAxqDOjmcU8yGTejGdNXOSFyj076T7KgQf5gLqB4nHtglLHXm8fABaXi8htt
	HpAPafXtcV2JMQKttfsGqtkp5s79EP8p8gaxNQOi9ZEka9Os9ovDqyXcZ+Dp88LsuTnVqQsnZ4Edy
	sUsGkWqk7Jt5CJJvDphxF8N/wkieeGg2LwhgEkicUkh7IqcoXM83km9Mr5jC0XftM/SkHxXl3mJW+
	0yFYDVX1OvAcjZNgvrgEtcVpkhk4FNFSJ0xcp/BnkPxSP0K72GbdUIm120rKm7AYg0r0zstVk7BBd
	RT4taOzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1n4z-00000006QLJ-2284;
	Tue, 30 Apr 2024 12:59:29 +0000
Date: Tue, 30 Apr 2024 05:59:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Riley Thomasson <riley@purestorage.com>
Subject: Re: [PATCH] ublk: remove segment count and size limits
Message-ID: <ZjDrMWRV1m34x_pa@infradead.org>
References: <20240430005330.2786014-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430005330.2786014-1-ushankar@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 29, 2024 at 06:53:31PM -0600, Uday Shankar wrote:
> +	lim.max_segments = USHRT_MAX;
> +	lim.max_segment_size = UINT_MAX;

Please initialize thes at the top of the function as part of the
declaration for lim, like all the other unconditional limits.

