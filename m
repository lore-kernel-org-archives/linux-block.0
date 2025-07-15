Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CB6EC2
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557604; cv=none; b=raaWp+iABqvwW1er7cLTXVQHE+gVeq4teE5xmpsRRYcktPrlSezTFsSsVoL88J4hHvfITW8NjUPcI9WeRJtWPqEHykaOdT7XUIdAk4v2TE7Tlc3pg+FsdcmG4K/yE1qDtK28aBvmgf9QqU8sxsEGifc2zRf71Fbf0trvgkCuXaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557604; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0NCwhcnABWn9ShA8arpFOVnHHsdu7T5xwO53a+DgzO5Bq6chHgoRrCLPTKSCF+slDWv+885j2zDrvfH7/rol+LNrxViCbLFAEPR3N6goRNy5nhmRIleu6+kX3E1o/oslJsA/mDefuyJFcGRjzKPM4DqJrDH6MOPAwdNvf88zWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC2E7227AAC; Tue, 15 Jul 2025 07:33:19 +0200 (CEST)
Date: Tue, 15 Jul 2025 07:33:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 3/5] block: add tracepoint for
 blk_zone_update_request_bio
Message-ID: <20250715053319.GB18074@lst.de>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com> <20250714143825.3575-4-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714143825.3575-4-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

