Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700411;
	b=Gv1tEdEItmrhm9qqCvWC0LPkHnaTWsDBuzZ/KP5Sac9Kk9r3/VcfCJMEco8Azi644/Ni
	 lR4Bz324yRJd7w3vo/vPYjxq5njwOsDirkLYiE9XJOCXs1AIY73vID8lf9INBNabGcs+m
	 O1COMXtNJLAcsODGFn+IKQMJEfuf2YDRpsA/D3q7o/M8eFcbHzBr8NPVhk5lvWqciIwiC
	 90Az/hfHUZ5sZc3JZDDfkDlbEKvTikG8YNCL6RiYe/LbLujdF2+LX9USwSizgoeWg8X3A
	 /KVL25lpktqwxxTgiYN9SMQY3y3+KAnFWCkmDow1NzAhzvbu74WAS/SrZLgZqN+f6HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700411;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=2WlaXm/h4TCaGY4RA8lSep9SEKfRGGOf4gZ0uWYb+wiLwGYM/JsvHrU1yRNCsUv3md8p
	 SHChHt95rQ2qbLQg+Xx16m4Tm1I2xiFjJ7uG7n6B+SvpfJN83BWiHXPWGAVW+iyERosBK
	 eY4YQOsdoNrdqcrXyOiZq+nOh+qVvMYk9FambtKQo/MPYQJoIuZKffPa1miUBcgbrzGdi
	 EWa/zN/dpxhyy7oMlgwnxpVZ+0W4GPVpeitsZu/ZFntBuD2de4/1R7dDQTj2x6xPMgmzR
	 Hma9QEpyXN1N3MNdFSB7j4ff2AiDaJBOe0FpL8zir0q3uXNJzTYPOJg0PsiVOiMFpjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=celbbb3S;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09850606A80C;
	Tue,  3 Nov 2026 10:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09850606A80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=celbbb3S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=celbbb3SQdzDeHQULauLF6NOO8
	dOnNEA/658tdJ5zfrGQspBmchMkKGo/nm4TR9qqWvUt4X/nMa+l/ICHHRqLwHb5jEnjqvUR3En4so
	72zkqkopWgWXUuOUumzlCCne7wiawsbsdrWDAN/+SR1Wd3rsjpweR2babJRhDou+ZjiLxbPRiejBj
	icGlHyOSy9aqmdtQ8EbFDliXOYef3pMd8+Rk7ncIkUw1wFUTg2a2gVMrEPVpt9v9NSgI+qaUnQoFA
	BaoGKI6o39cWUxjStJzeglpWGe3b1ow8rQAeSMNcmiqFliBuRzrh3oRYsTXM2eDiOQ3efcStGB27V
	SaaUQLwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBPm-00000001siw-2QBB;
	Tue, 03 Nov 2026 10:06:50 +0000
Date: Tue, 3 Nov 2026 02:06:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] null_blk: reset cache state before device setup
Message-ID: <aumyOhGLn5uosCbL@infradead.org>
References: <20261025161133.59344-1-pocj8ur4in@gmail.com>
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
In-Reply-To: <20261025161133.59344-1-pocj8ur4in@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

