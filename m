Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BB01DFD98
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454247; cv=none; b=GlAktV01QZlR1YQ4mOObEOa4FLX6z/qdSUSOb7mCuQHaVT66MwHYxRt9ai+xZCgk7Ii5ZuIp4p4RinPVplHfipYAhPeKeWqawocXKjkQ371BZOZePyhgKzGmGSekHYuAAV+9uaP3ih/+THvSiUOoF5QHJtUmd/OTkM2c+BJBeRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454247; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuJnH7IAx8w/99XAzragoyrkxid8aXSUAtzXLLv0s7SlA+bhm/bje1w2oXjXUKNv15ceJTe83cX6wWnZeBih0lPGVb4//S6ETwUuEq54y6UlsFCxYswskwmTaGtSByKrvfX0I6YDLkzh7HrbIjoR+55HppIxY+H5dmJ4U/rD5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L961r46f; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L961r46f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=L961r46f3RhA+372igx8BuP/S4
	krfVczt0cG5zn9XGCaOPnA6ypEkpAQUZaDKqJT6SUr12EUT5xIdttQNcj37WZAVe+mLsDs0UCLttg
	35yegV6r00sDAHkRTGd/MGv+eJGo6fY4GnvCnZC5qOxsclja7j8XX4p5nk3SDxeXzNhJqG7bnOlmp
	pf+SSE8t5lY/ZPrWpRw04bJovFggiSLNzU8Nkd7UBPVgXRn1zPKV31FHk5PTM6h3XLxTlUlcmxiYv
	Pr4XpVYRwZiHrPD3jY9pM2yrAE3wV/J+/6d9Gr1W+ZyhE780ByXDe83plzybhQnc0ndvdCAG7ibdH
	q+Vjxp8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tv9wi-0000000BMYo-2yeD;
	Thu, 20 Mar 2025 07:04:04 +0000
Date: Thu, 20 Mar 2025 00:04:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Milan Broz <gmazyland@gmail.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@infradead.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH] docs: sysfs-block: Clarify integrity sysfs attributes
Message-ID: <Z9u95KtFe1skCkCp@infradead.org>
References: <yq1pliuoqek.fsf@ca-mkp.ca.oracle.com>
 <20250318154447.370786-1-gmazyland@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318154447.370786-1-gmazyland@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

