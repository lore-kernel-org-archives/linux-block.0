Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5022840A95F;
	Mon,  5 Oct 2026 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190618; cv=none; b=IStvgBSPMPTau+Y3R6U8nssylEqPejqCgRrO8O7OKiJLJyl78qVk5uNHXwmKlfZL9SN0+gKHs1Uc6ELC438fFC/k0VmjhQZAkb+dvruNeMk3Pi7VcZrujfnn3xMO2ykH0k+WPB4hUcqbwkNAfEiIVuefqAdpqcC+k7Eq/YJ2lWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190618; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZJuAQLw0xCG2WvQcByQ7VCeUJ0md/1v5fJ9B4+pDFOLvADV8jxhhhFbyDLME38MMIkvKPnCKrd/KYssvBLZNcY+8CVj8KcatMmNU1thrc3RcLeA+JWuPb8RIctdtfDfKA7gdMruHqbrWTDi/wVA/DaAB7P/Ajmoym3WSd25SMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8593F68BFE; Mon,  5 Oct 2026 10:56:53 +0200 (CEST)
Date: Mon, 5 Oct 2026 10:56:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Md Haris Iqbal <haris.iqbal@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [v3 for-next 3/3] Documentation: block: document error
 injection delay feature
Message-ID: <20261005085653.GC9160@lst.de>
References: <20260928221634.43239-1-haris.iqbal@linux.dev> <20260928221634.43239-4-haris.iqbal@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928221634.43239-4-haris.iqbal@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
