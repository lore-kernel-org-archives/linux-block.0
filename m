Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F670813;
	Mon,  7 Jul 2025 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751867969; cv=none; b=S2DhMYTBYrA0avA6bxQnig5Uq8Z3vTeKrOe4nqGpIBzMdmyKN/2RISFHL6wlm39EdYTPWgOz6bSqbruwOQMrPjvg5tQrvIQnZpMaN/NXMZ87twwZPTN86JsTATizvXFry1/LR9OYIL+gSdS0C7URJALo3m32LonA72zM++sa4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751867969; c=relaxed/simple;
	bh=8g0ar6DF+kofijbjdY0k7eoZW++N+JeAnr+Kd+aZ+e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA/XYeNGbXX7XqMZhCz+4DFDnxYfzp2RvkxxI6G4kdZy0pTjeM7K6uzqtAS/IooLJqWe9y54iOGmxhBR6j5AuLphT8UHARtn4gVtKrQKNLPq5XM+ZJY1gQQrqNuECAQhyh2QRecZ4TPSlcgx1n6gXXm3xNawItAZARDUOHD035I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kFJMCrS/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kFJMCrS/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8g0ar6DF+kofijbjdY0k7eoZW++N+JeAnr+Kd+aZ+e0=; b=kFJMCrS/PkBWqf41JH3xhptgo8
	gQ6EmMAFkBoxe8AIn5gAnCwntJDUY8GWzstylLgdzT4Wz4ZrXEuxHGj/l7K7jokQ6xRhefrNxluNa
	jBAvg6VGQAfsBZkY1/KPSr1G9wWnKXdklZV2hpViikkRr8BYDnx+agsBfka6LzgNszUuXhGyhI1RF
	ihLWkJReqSaFhjpSuEFojEKE4ChVUAk7mxXcgJBaHNPAhNA8odY7dYbR1ZQEMVNGyBl9whAMT+mLq
	fzFrXZOdvgOcYewZZVDy6DLPIYO2a7yaTCh9cGiIwkZA1qyHkEncBwlcUf3vQVQhF7qhbo+JuTkzC
	uAwOR+tA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYesx-00000001V63-2ObU;
	Mon, 07 Jul 2025 05:59:27 +0000
Date: Sun, 6 Jul 2025 22:59:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 77/80] block: pm: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <aGtiP3FKLi92Gral@infradead.org>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
 <20250704075501.3223068-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704075501.3223068-1-sakari.ailus@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Sending a single patch out of many to a list makes it unreviable.

That might not matter as a 80 patch series is basically unreviable
anyway.

