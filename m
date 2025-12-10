Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C726FDBB
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765344477; cv=none; b=nF5P2Hq4VwoWktcG/DbCsrQTUahuKfdrBJFC1QBXRr3oLlGJ6tm+EPtMb3k2JNEj6FWuS9fpz2hIvwQT4kjKiVQhabXtVSJf/QmpCsm9GFND96YiKoUHEFkjTur1ddTsfVBJ5HmGFK99LTbCCpdlTg7jiw4osprD7m62hnDqOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765344477; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0Y68NtsM7dH4BwlTytSI/hsMEUQxP5OizdGxSLQK6/gHEq2xfAhsuzcv0bRSOFujaTpos/joMNj/MZ9+EFrssS+b+3YOcOzrZK6bnBv2wvHk0QCO54uSGvhQqGYtOuHilXvDpB77mpCRIps0a0Rloo/G6+nuXm6RqhQTLqbPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eVmOFdNl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eVmOFdNl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=eVmOFdNlQ+y0EHMlW6JTJlia6v
	mkhGMrFTP51zzwn5siY1S0vn2ecsoP9BARsA0ywh+odLsIJynCGXmtLvsBAhNeIC6SyNEc6SCgRO/
	SfkMFd+mJkoHPzohqS5pC+GFtBS1/ZILGYP6yq/nTb+3WZcEDjMfKPz4BtVywwDZD89nmIn6rAvNx
	hmf7rpp1tt87JHApgXNRCL0iQNcnMlCdXbcqlnnglHO63MkUcX/Mr3nxJOTJigKxf5syioDDenzpD
	sofVhQN8/xs1tLtfQJNE6qlTZfFT323/0Owz9aGwMgSL3VCo0KoQL3YkxZ34mR+g9+uCqaO/iBs48
	nP2HzZsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTCjy-0000000F8NR-3o9e;
	Wed, 10 Dec 2025 05:27:54 +0000
Date: Tue, 9 Dec 2025 21:27:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] block: fix cached zone reports on devices with native
 zone append
Message-ID: <aTkE2vtsgvonULM6@infradead.org>
References: <20251210021037.10106-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210021037.10106-1-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
