Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32F727CB38
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746532785; cv=none; b=tX+Zam1tmJYbNTUI1DkP+fiN0COAlhi4bZRr3kDsURfYJhN0ksfj9QWEKvutPlwOQ5FJgUioZAVXemhig78Tvkg7KCtbv5RBmbRUTmQ/H6PLZ6IeIHDjkwPoXaURg2VKFTDai3hoajr/KLBnluTkelZdWy+nD3PM7KcMjHu0n4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746532785; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HROsLph2xuXxUTm5gYu0qLCirHCj1VcB4XJXbPAmtXKbaco42Ek1+4U68C1fg0O7MrtsPAl6GVJRH3I890Twpux11N3hdvsrFdCRxwgCoEuDSpBO7NFPwjzh9KAGQOeHorfSMzjSab4oskAqgg/pZaTKXWesqOLuuEon1ijaJH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CD40868AA6; Tue,  6 May 2025 13:59:37 +0200 (CEST)
Date: Tue, 6 May 2025 13:59:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] block: only update request sector if needed
Message-ID: <20250506115937.GA20817@lst.de>
References: <dea089581cb6b777c1cd1500b38ac0b61df4b2d1.1746530748.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dea089581cb6b777c1cd1500b38ac0b61df4b2d1.1746530748.git.jth@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

