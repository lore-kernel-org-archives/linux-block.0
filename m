Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4503E5592
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694717; cv=none; b=LdJvyu1w+SfTDSA+FRhtwaA1AMDia6FxIpSVXLi21s0NCbhp1M54Vt4ArJbTLNm44c9pTsR/bPCDLa+mQS0yC4RqkzfUoDSig5iScKPzudcULRIH3M1X8l6PNL0aQ7KbpeXEA6B6GlpoONEx6XQTGdCka0HHxdlOV6B42sC7ku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694717; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojX1Kinm3HeAa51pugdw3Vh6ZH3v02hQYmvsuEmBA8V+yxJHghAqg8kK3L1YaH3P1IrH4IRBlUEnvO75GCJn9prtmN2Oqc/gu+aF9t6dQ52nWXC4ooEpBpIzZnkMH0cBXFEp7u0anoVAtCXtOWbcySghbst92vd1mrPvkLG/LJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1B3F968B05; Fri, 14 Aug 2026 10:05:12 +0200 (CEST)
Date: Fri, 14 Aug 2026 10:05:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v4 07/13] block: drop all zone write plugs on capacity
 changes
Message-ID: <20260814080511.GB12566@lst.de>
References: <20260814063201.1762743-1-dlemoal@kernel.org> <20260814063201.1762743-8-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814063201.1762743-8-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

