Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B521448E3
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022770; cv=none; b=KzsGsnGrp8QLeB3SHfi2nzZRSTxZW0g8ay+M4mXZlYn6au6yOTrBsYXr6nH47aLCGudhw2sSXF12gg/l6SiHS5nAxITP1XH5WpxV/awiPrnczYxvE5WwlnJDhjmoSazl3pDY0aj2VSIJ05ZuBFFEvRzO1pSxvf1GbZ0a6pCmK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022770; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOJip6tYN26egD4vLrNqZaSpzckyAj3oX8kwxKjszUa5IuRPBUgwk3JhkFQ2HpY7GuyBSmoIBm/3Ca1Ub52Mz//5uIoLKry4VVDeTJsLudMMIlzCf+AOC0CjNOKV9GbCmxbu3Ejo1MPBH3J56HzLo89qGGIpbLof+GxiqKyPn5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3622067373; Wed, 30 Apr 2025 16:19:25 +0200 (CEST)
Date: Wed, 30 Apr 2025 16:19:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 18/24] block: fail to show/store elevator sysfs
 attribute if elevator is dying
Message-ID: <20250430141925.GH6702@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com> <20250430043529.1950194-19-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430043529.1950194-19-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

