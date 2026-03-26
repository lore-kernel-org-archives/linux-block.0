Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7B38BF91
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 06:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506386; cv=none; b=teh3HwmltUcK57ziL851P3TekIMcHkQ/All8K1zRs8R/1/m6cvI7Co8FMuLqI92Pg6flWItzb1+QTr5WK/iwnbWoVVBcn+06zd47l42/QVeI53XxDT81FXxagwMtv/jphBlZVWQ+PU0TaweA0j4Ki3a8uDa95UjbhGnlrFyRC+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506386; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcyjVAy1j8lCGZat5BwFY+YvAU0tg5N7t0YcSMBqt1lKgVgNjMjROZEArDuay7O4Pqn7zmnPCDFsAU4NlQaAUwXWcaXnBDdXnKYQ9zy5vFFu86RmLWULOyWJkeWmJJIFn7j2ukZ2uADvETJ9oKRJTR3vBH2rgD/maAqWLtN9kNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53B4568B05; Thu, 26 Mar 2026 07:26:23 +0100 (CET)
Date: Thu, 26 Mar 2026 07:26:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai@fnnas.com>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 04/26] block/cgroup: Split blkg_conf_exit()
Message-ID: <20260326062623.GE24071@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-5-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-5-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
