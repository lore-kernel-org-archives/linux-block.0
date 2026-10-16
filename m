Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C754244781E
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136900; cv=none; b=Uy8jguKJVbMEsOvpoo3o1HVHQdXakeV6e/TMrMiZ6M6hOdi0VaTzCDzMaqt9te6eIZdSA2senWnbLbAlV78gOj28EUcVKtiV6izMH1nH6dtNqIOTKQA+5t3J8JZ/mZibZTzeSsiGpEqdYeGraeRSjAcPh7tr6EEGRSw9MncS0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136900; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ982VC8iKcfcnEbuZIllY+u56GCXeN8+PkhAX7Cg33Ekd2FbLT1Zb8mYKSYGnEZXVlhQYR8b3a67N9p83T1zVnxCLnYXtIjFvTU4IWgT6mPiVO+nGIraf/TS3AcwvW5RvIBasHZhBrkUjAC2n1Rom7RvZKOaGPQR/Gggncs/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E28EC68BFE; Fri, 16 Oct 2026 09:48:06 +0200 (CEST)
Date: Fri, 16 Oct 2026 09:48:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] zloop: print device that had errors
Message-ID: <20261016074806.GA15981@lst.de>
References: <20261016073043.1164325-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016073043.1164325-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

