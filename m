Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77463597A
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751867897; cv=none; b=B21BAwHzaS2pHpDwhusZTb13K8axLbZ/UQtw2JwM7vsRwZ1VAodcZp4xN+cMSFf84W7vj2Oh/y13oGCQJQsBc2SAIdsTEqnqap1CNHM1kl5m2ElriQ3rREfbDvHYoeA39NlGRCdWQpiQXrdx6FsxphHRjA+UTFKHyvBh8FjXzC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751867897; c=relaxed/simple;
	bh=PH2sqhT7qeJrq8dD2MiIz8VmB9QdzQSeLSgxtiVUWR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRwiVLPwlux2V0ZaTIt8ZV7Ay8XGIeVbGIXSejqrmcQGzPCR4y+4ud5N+cp6JN2j9hP0DOFor3u1EUqWuNDV4/Zq0yPMWpv8AnCNiJKWjiOUMe4SuFsAG4cukcJw8pwBWpVW76/aKdAmlYihM1pWuz5mdFvMRWmPbreTnnFRC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bLgz4MeS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bLgz4MeS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xt4I4YUFQM9EwnPEKGgxPkY0dEeu1vbLZcvwuIWh9oA=; b=bLgz4MeSNabCpLYjWxkn7a+q2v
	hb6idk5Txb4zHl8Zy1umOwZoWAmau0nmGqE6w4eSIWkyfeJeTUNOl06ptyn8S6Du1huRLrTBVX0qO
	XgPnrJyy3aQ9UdUfNokxE5fMMRq5/VmF3te5KB8mCf0pas012ebl5kFe6OZqdaiWtoeGQvDKHv3GM
	tY61FDLwf3I0Tt83AlZsfKUSoHSlJf1F3ofW7/Gu2F4a2WlXPHF6rl56B16Dg95XKKs7savUf+Z7H
	KKwNSHYcxh2gaTeJSa5ki/GuJH3rFOe4c0t65PNCPp46WFFCkPK8EN31LhJLtOstMZ4ORlf3EdlQ8
	hPnFpkKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYero-00000001UtH-0dJh;
	Mon, 07 Jul 2025 05:58:16 +0000
Date: Sun, 6 Jul 2025 22:58:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH] block/partitions: detect LUKS-formatted disks
Message-ID: <aGth-G3oYNF39WJQ@infradead.org>
References: <20250704182853.3857-1-robbat2@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704182853.3857-1-robbat2@gentoo.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I'm not sure this is the best way to approach it, as what you add
is not really a partition format.

I'd suggest checking for the LUKS signature in the atari partition
parser instead - that way the code is automatically built when the
atari partition parser is built in, and not built when not needed.

Minor nitpick:

> +	if (memcmp(data, LUKS_MAGIC_1ST_V1, 8) == 0
> +		|| memcmp(data, LUKS_MAGIC_2ND_V1, 8) == 0) {

The || goes at the end of the line for the linux coding style, and the
continuing line is indented either after the opening brace or by an
extra tab vs the following code:

	if (memcmp(data, LUKS_MAGIC_1ST_V1, 8) == 0 ||
	    memcmp(data, LUKS_MAGIC_2ND_V1, 8) == 0) {

