Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85BB28682;
	Mon, 24 Nov 2025 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763993130; cv=none; b=GaBDk0kdom4f0GBEvtM0JAWQGmHtMF1Quy/fLNnJ+6tzVyxW7OupjxM8vBIXXTiF42omrwke6TZDsdlVIFK1s58PtV2xiTMSgUg65Z/E99rnKeU55zbRCqAle32rSPRftxp/LhNT6/7QU2DspiNjJxt0riGBK0TXKyARQdQlvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763993130; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3yRLTlouW0qPSPSPFoHRBCnNoPnY2CDP2dzi6luuxcFJ/M3+haQII7CVO9o25TmqXhH4Q1+E3GqBDwV+U0rz0+c3BXY4nON5ZxGt0S83IpL1YDNy2aDg3SISDyrmAC3cGjmbQ6HjCpArNdteNMv0093gfdxfpZonEW29nIOtYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u8f6NxNe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u8f6NxNe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=u8f6NxNe7k2fpxXaLnIte59T2q
	yYxh6dqdsTMNDe7OA2IfIk0mR09MafCshUpMrERV26ejJHMTZk+Hvo8jM0XedbqviQcC+ghl/VpB9
	17K75qHuPh2oLeUiLNtPtyPRrOYVMRpZTmIUCI6XbVFGHofPFvZXE42ebyKI56krMjjpvcO19qbXP
	yJPyg2I2YX7vZ2jLZI7R9OWUY4WsatgZqXo2j4dudLX213YEmR4kbJIez8gHYC7SNQPmrrqqsEjgL
	yPNSxclO++c2BOWbUJwDjsEvZwgxiAbWdzhRtpGReTwW2Ub97v49Uh5o+hac6otw0UpENImIRHz1E
	tpF+E/SQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNXC3-0000000BoFA-2mKR;
	Mon, 24 Nov 2025 14:05:27 +0000
Date: Mon, 24 Nov 2025 06:05:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: shechenglong <shechenglong@xfusion.com>
Cc: axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, kch@nvidia.com,
	stone.xulei@xfusion.com, chenjialong@xfusion.com
Subject: Re: [PATCH v2 1/1] block: fix typos in comments and strings in
 blk-core
Message-ID: <aSRmJwzuKdjN3wcg@infradead.org>
References: <20251104123500.1330-2-shechenglong@xfusion.com>
 <20251124020258.1022-1-shechenglong@xfusion.com>
 <20251124020258.1022-2-shechenglong@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124020258.1022-2-shechenglong@xfusion.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

