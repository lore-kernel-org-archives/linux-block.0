Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C62410D24
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642268; cv=none; b=oSfLglxXxRzkJ49JcMbq9Lb83wNsg7tUTKEImaaDN6tHT4A18RN4M6SUxFTNAwpoTZR0xb4yYjye5jhnI7f6sG+EdsLvEBh/OOqNLPNgtAGw6p9MVWeNt4+nRzfjorPaDFGSTkpWdHhlml8ibjJ3qdqLhJZWV58e0Rzd0TlZ+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642268; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeNclwkSUS8k1clKbJceKaF8cNiFTMueg2sZ6hQgmu35gCa/Z41Irte22Mk2LcSqHHFzvzlav8MmfdU9tUHlE4eYJBdbttfz35DBUx+vuvikUbW1q/hm6J2ywnOIKMBxBILcIKMX6tHAHczFB3PKWmdJP2mAlwVIJs9IpZYGaJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 153B768AFE; Fri,  5 Jun 2026 08:51:01 +0200 (CEST)
Date: Fri, 5 Jun 2026 08:51:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v6 11/14] block/blk-mq-debugfs: Improve lock context
 annotations
Message-ID: <20260605065100.GE26230@lst.de>
References: <cover.1780419600.git.bvanassche@acm.org> <66eff9a5e488fbe0b79db3a54518fe5d181a31ec.1780419600.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66eff9a5e488fbe0b79db3a54518fe5d181a31ec.1780419600.git.bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

