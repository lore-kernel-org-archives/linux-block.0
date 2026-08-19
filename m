Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31943AD525
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156440; cv=none; b=KoLSBAniumISUtYywtk9HwadpPX7QzET7D9z3PkVnD2zH4XBfea4Tcl1Kuo8kb418Ze4bJAcs2p4j5u8pUHO1A5/i+YaBmZVZvnEC7MBxfJtyHUhKYjFT/QKBod3JfdH6kjxICJKPlL75FE8iRJve13X22GsrYjHHPS4PmQw3CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156440; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPILBxi9S/AM3DswjCntP9hDtfb3o4msDGLRuIO67aH2o2vXfRq3/iNkMMLq27QBccGnZ2MWFcFSsWxqDc4B9Y9apBDAt9mt6LcUlUX/nwaXihOC1rUWy8JMN3X228DvgoNCNGwisiHhxyvjNAf6aLSukbLubErzr0Kurh2DkE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3F1168C7B; Wed, 19 Aug 2026 18:20:33 +0200 (CEST)
Date: Wed, 19 Aug 2026 18:20:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	Keith Busch <kbusch@kernel.org>, Eric Auger <eauger@redhat.com>
Subject: Re: [PATCHv2] block: save page offset gaps in cloned bio
Message-ID: <20260819162033.GA6892@lst.de>
References: <20260819154937.3903312-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819154937.3903312-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
