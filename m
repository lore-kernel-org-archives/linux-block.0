Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB2146D42
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906205; cv=none; b=WQdvpXGy283XAZui8azCCNFLyNdz1TZHhj3z002sVSsp6i6f8D1oFHpbxA4HeSdW10cejUTK8IzbmO2ohjAsATGoMsg7FqbDLR2+xuFt2nEHzL4Cd33A0nslxgJXMH9xmeZMXGHLZb6Geaxhm6j9pm84Fl7MydawNkaHz/4ufQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906205; c=relaxed/simple;
	bh=tkermrtBRfkjsNAY8hUktlHlZvuGT0+ZY+Q8DY/+VMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s68SVirUh/AhrNHGSeBVYSgc3yVGot4VJG73SC5ywzftfdLvB4Bf1US1ixwUQTXZoz6xM26UoQvXijP+pMRQjdgSX52uQqKlKPBukQv/jpHEZk253qKSbS6c1Zuv+XJeMB1f5D1QGsI/57TibDHvtV2szwldKcsjrYEwWJRh/AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ppy24Zwe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ppy24Zwe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tkermrtBRfkjsNAY8hUktlHlZvuGT0+ZY+Q8DY/+VMM=; b=Ppy24ZwedMXrr6xvIPcAg5gH7k
	ZPe4YtH1poA/YbPiWgaflAbGRObheoWHzBa1QcUDhi07qtgXA0CGfkxGjCjRCbfElX8Orl7j6y6y+
	TGI3oaIEcLE2S8kowDycXM4o8OGy3CfBqR0TJvXUvXiBom60kVSfwIDvzR3DSqfZOeTMlOw5EMCg/
	yLCSjrYC5tzMBhPLnJKEg7ytBP4dB2uRV/LbQ3L2UBAHGj6sc6fCx4bvzRfdXVEOwXsXY/pxADu7r
	kCHSHVZq9UV2MaMuFsKCEEgUdbxWgoPY5s976UD/3E5cCAWfe04CneJvbPApAbyLSfG55tcy40Z/h
	ZTLgDd1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOYAe-00000005tdT-02DB;
	Tue, 02 Jul 2024 07:43:24 +0000
Date: Tue, 2 Jul 2024 00:43:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] null_blk: Fix description of the fua parameter
Message-ID: <ZoOvmwjmp2Bpq_km@infradead.org>
References: <20240702073234.206458-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702073234.206458-1-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 02, 2024 at 04:32:34PM +0900, Damien Le Moal wrote:
> The description of the fua module parameter is defined using
> MODULE_PARM_DESC() with the first argument passed being "zoned". That is
> the wrong name, obviously. Fix that by using the correct "fua" parameter
> name so that "modinfo null_blk" displays correct information.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

