Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D998914288
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299972; cv=none; b=BaVHblX4+Iw/BTODDEFmqhlfiTMo0LrXdWbo9e/k2AxzJKRLJjssM7OSyhP59WOUQqhumtdqESngJFfjGHL7QE2x7X7yEYaZM1hJJSDTM0SnOb7nfsuB7lcanXbxYkleqZJ5rRFX9ZWjg4czlZTy42c9vrVWmkPmEiUV3gLWPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299972; c=relaxed/simple;
	bh=VeY1eDvIf5yz4J7SCRnksVjE29sOa0JwOnjv/19TlzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLZj/1bW1H3TNk/4sOOsfY+Pg2k4l88SBJNFeR2yhQrLNLzv0ZA1Dai9xy+vDN7pl8vY0Dy1qZuNGBkt9hjJuamLGvEvXl2DO5ZmzeIH/VQcpMoC7/Myb+h8dI7WXq6JQxogruNHgpNZCzvpHjdachPY2ots2mGpZVe1rPvKDnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E964768D07; Fri,  5 Apr 2024 08:52:47 +0200 (CEST)
Date: Fri, 5 Apr 2024 08:52:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Saranya Muruganandam <saranyamohan@google.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] block/035: test return EIO from BLKRRPART
Message-ID: <20240405065247.GA4023@lst.de>
References: <20240405015657.751659-1-saranyamohan@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405015657.751659-1-saranyamohan@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

this patch looks good to me.

