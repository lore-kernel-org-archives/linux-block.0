Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A5326B777
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200216; cv=none; b=d9oR8cThg99nWJa6JUvaELSXvPK17o61kyhYGEiU56upl7n6gvjtBQMnRZZtrQGHBccylOAGyz2O0MOB3dMGFjWeiIKt80hEAMb8P6AE4xXq0AVRYPKsihAaxxv1wCs2twH6ICAxOSyFUPuW4ZW22PT+HL73g7/nF/4Z2H9yBQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200216; c=relaxed/simple;
	bh=1umyAol6qJ52sj688B0QitsfoTQEqbkW4R/EnVJiSfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7mo5BxUYRhno1v7TaJiMs1tASf0MCZIP7Z+bQTs+OgrtvjiuxGNIaF0dOL/HeeXJoDuoi0mR0kq3bocMiYB/RUvmRSe2sYyznMApdQwGITSt4PyXWmBB6AuU2cX1Hb4C1kAABrY2m94SM/x34Ua2hK2GcZxU9UYAvVwMRC1MSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oon1pWuw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oon1pWuw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1umyAol6qJ52sj688B0QitsfoTQEqbkW4R/EnVJiSfk=; b=oon1pWuwQ+n+Ffeo6qWK++dZF+
	LUZuzuaVSvNBJ7dcvbt1xYS027gmDKrWqeHKpwy4uWFDcW8TIH/I3lroIoCbDqj6G0qF8cIsTvGde
	+8JKUV53b5spHDbjqnUUwLXeYDXv6YDrzdhu8foCBrvJ6RtymCNMXe4xzN7DeezciaZquDF4tD9rV
	WRSNGwyjOuh7EUrZP+f0BULKLeCEbR81ic865mAUIs59e2eXi0fTmuCFYKz09pSrJ2W0N4Cx+dnOa
	0vkllCVPBEWqOaYgIxKgo5GbY+VX+9bEbDa4B2sFNbIe+Ne+JHuulX6GJ6Pm93Lqq8c+lbnB2UK0y
	/1y385WQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyER-00000008P7H-1HQS;
	Fri, 27 Feb 2026 13:50:15 +0000
Date: Fri, 27 Feb 2026 05:50:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v4 3/8] block: rename and simplify
 disk_get_and_lock_zone_wplug()
Message-ID: <aaGhF2zR7R_EDKQD@infradead.org>
References: <20260227131951.2464150-1-dlemoal@kernel.org>
 <20260227131951.2464150-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227131951.2464150-4-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Reviewed-by: Christoph Hellwig <hch@lst.de>
